  const Order = require("../models/Order");
  const Payment = require("../models/Payment");
  const razorpayService = require("../services/razorpayService");
  const Membership = require("../models/Membership");
  const pool = require("../../db");
  const xpressbeesService = require("../services/xpressbeesService");
  const Address = require("../models/Address");
  const Cart = require("../models/Cart");
const {
  calculateMembershipBenefits,
} = require("../services/membershipCheckoutService");
 
  /* CREATE ORDER */
  const createOrder = async (req, res) => {
  try {

    console.log("CREATE ORDER HIT");
    console.log("BODY:", req.body);

    const {
      order_id,
      amount,
      entity_id,
      paymentType,
      membershipPlanId,
    } = req.body;
    const paymentTypeUpper =
  (paymentType || "ORDER").toUpperCase();

    let finalAmount = amount;

    // Membership discount only for normal product orders
    if (paymentTypeUpper !== "MEMBERSHIP") {

      const cartItems = await Cart.getItems(
        "USER",
        entity_id,
      );

      const benefits =
        await calculateMembershipBenefits(
          entity_id,
          cartItems,
        );

      if (benefits) {

        finalAmount =
          benefits.payableAmount;

        console.log(
          "Membership Benefits:",
          benefits,
        );

      }

    }

    console.log(
      "Final Amount:",
      finalAmount,
    );

    const razorpayAmount =
  paymentTypeUpper === "MEMBERSHIP"
    ? 1
    : finalAmount;

const razorpayOrder =
  await razorpayService.createRazorpayOrder(
    razorpayAmount,
  );

    const payment =
      await Payment.createPayment({

        order_id,

        payment_gateway: "RAZORPAY",

        amount: finalAmount,

        status: "PENDING",

        gateway_order_id:
          razorpayOrder.id,

        payment_type:
        paymentTypeUpper,

        membership_plan_id:
          membershipPlanId || null,

      });

    return res.status(201).json({

      success: true,

      data: {

        payment,

        razorpayOrder,

        key:
          process.env.RAZORPAY_KEY_ID,

        payableAmount:
          finalAmount,

      },

    });

  } catch (err) {

    console.log(
      "CREATE ORDER ERROR:",
      err,
    );

    return res.status(500).json({

      success: false,

      message: err.message,

      stack: err.stack,

    });

  }
};

  /* VERIFY PAYMENT */
  const verifyPayment = async (req, res) => {
    try {
      const { 
        razorpay_order_id,
        razorpay_payment_id,
        razorpay_signature,
        paymentType,
        membershipPlanId,
        userId,
        } =req.body;

      const isValid = razorpayService.verifyPaymentSignature(
        razorpay_order_id,
        razorpay_payment_id,
        razorpay_signature,
      );

      if (!isValid) {
        return res
          .status(400)
          .json({ success: false, message: "Invalid signature" });
      }

      const payment = await Payment.updateByGatewayOrderId(razorpay_order_id, {
        status: "PAID",
        gateway_payment_id: razorpay_payment_id,
      });

      await Membership.checkAndResetMonthlyBenefits(
  userId,
);
      let membershipBenefits = null;

if ((paymentType || "").toUpperCase() !== "MEMBERSHIP") {

  const cartItems = await Cart.getItems(
    "USER",
    userId,
  );

  membershipBenefits =
    await calculateMembershipBenefits(
      userId,
      cartItems,
    );

}
      let order;

  if ((paymentType || "").toUpperCase() === "MEMBERSHIP") {

    const planResult = await pool.query(
      `
      SELECT *
      FROM subscription_plans
      WHERE id = $1
      `,
      [membershipPlanId]
    );

    const plan = planResult.rows[0];

    if (!plan) {
      return res.status(404).json({
        success: false,
        message: "Membership plan not found",
      });
    }

    const expiryDate = new Date();
    expiryDate.setFullYear(expiryDate.getFullYear() + 1);

    const membership = await Membership.createMembership({
      userId,
      planId: plan.id,
      paymentId: payment.id,
      walletBalance: plan.wallet_bonus,
      discountPercent: plan.discount_percentage,
      monthlyClaim: plan.monthly_claim,
      expiryDate,
      termsAndConditions: true,
    });

    return res.json({
      success: true,
      payment,
      membership,
      message: "Membership activated successfully.",
    });

  }

  if (req.body.buyNow) {

    order = await Order.createBuyNowOrder(
      "USER",
      1,
      req.body.productId,
      req.body.quantity || 1,
    );

  } else {

    order = await Order.createOrder(
      "USER",
      1,
    );
    console.log("ORDER RETURNED:", order);

if (!order) {
  return res.status(400).json({
    success: false,
    message: "Order.createOrder() returned null",
  });
}

  }
  const address = await Address.getDefaultAddress("USER", 1);

  if (!address) {
    return res.status(400).json({
      success: false,
      message: "Default delivery address not found.",
    });
  }

  let shipment;

  try {
    console.log("========== XPRESSBEES PAYLOAD ==========");
    console.log(JSON.stringify({
      order_number: String(order.id),
      payment_type: "prepaid",
      order_amount: Number(order.total_amount),
      collectable_amount: 0,
    }, null, 2));
    console.log("========================================");

  const warehouseResult = await pool.query(
  `
  SELECT *
  FROM warehouses
  WHERE id = 1
  `
);

const warehouse = warehouseResult.rows[0];
if (
  membershipBenefits
) {

  await Membership.updateMembershipUsage({

    userId,

    litresUsed:
      membershipBenefits.totalLitres,

    walletUsed:
      membershipBenefits.walletClaim,

  });

}
shipment = await xpressbeesService.createShipment({
  order,
  address,
  warehouse,
});

    console.log(
      "XPRESSBEES RESPONSE:",
      JSON.stringify(shipment, null, 2),
    );
    if (!shipment) {
    return res.status(500).json({
      success: false,
      message: "Shipment creation failed.",
    });
  }

  const trackingNumber =
    shipment.data?.awb_number ||
    shipment.awb_number ||
    shipment.awb ||
    null;

  if (trackingNumber) {
    await Order.shipOrder(
      order.id,
      trackingNumber,
      "Xpressbees",
    );
  } else {
    console.log("AWB number not found in Xpressbees response.");
  }
  } catch (e) {
    console.error("========== XPRESSBEES ERROR ==========");
    console.error("Status:", e.response?.status);
    console.error(
      "Response:",
      JSON.stringify(e.response?.data, null, 2),
    );
    console.error("Message:", e.message);
    console.error("======================================");
  }

      res.json({ 
        success: true,
        data: {
          payment,
          order,
          shipment,
        },
        });
    } catch (err) {
    console.error("VERIFY PAYMENT ERROR:", err);

    res.status(500).json({
      success: false,
      message: err.message,
    });
    } 
  };

  /* GET PAYMENTS */
  const getPayments = async (req, res) => {
    try {
      const payments = await Payment.getPayments();
      res.json({
        success: true,
        data:payments,
        });
    } catch (err) {
      res.status(500).json({ success: false, message: err.message });
    }
  };
  const checkoutSummary = async (req, res) => {

  try {

    const { entity_id } = req.body;

    const cartItems =
      await Cart.getItems(
        "USER",
        entity_id,
      );

    const benefits =
      await calculateMembershipBenefits(
        entity_id,
        cartItems,
      );

    return res.json({

      success: true,

        cartItems,

      membershipBenefits: benefits,


    });

  } catch (err) {

    return res.status(500).json({

      success: false,

      message: err.message,

    });

  }

};

  module.exports = {
    createOrder,
    verifyPayment,
    getPayments,
    checkoutSummary,

  };
