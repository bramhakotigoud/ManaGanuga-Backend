const Order = require("../models/Order");
const Payment = require("../models/Payment");
const razorpayService = require("../services/razorpayService");
const Membership = require("../models/Membership");
const pool = require("../../db");
const xpressbeesService = require("../services/xpressbeesService");
const Address = require("../models/Address");

/* CREATE ORDER */
const createOrder = async (req, res) => {
  try {
    console.log("CREATE ORDER HIT");
    console.log("BODY:", req.body);

    const {
      order_id,
      amount,
      paymentType,
      membershipPlanId,
      } = req.body;

    console.log("AMOUNT:", amount);

    const razorpayOrder = await razorpayService.createRazorpayOrder(amount);

    const payment = await Payment.createPayment({
      order_id,
      payment_gateway: "RAZORPAY",
      amount,
      status: "PENDING",
      gateway_order_id: razorpayOrder.id,
      payment_type: paymentType || "ORDER",
     membership_plan_id: membershipPlanId || null,
    });


    return res.status(201).json({
      success: true,
      data: { 
        payment,
        razorpayOrder,
        key: process.env.RAZORPAY_KEY_ID,
      },
    });
  } catch (err) {
    console.log("CREATE ORDER ERROR:", err);

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
    let order;

if (paymentType === "MEMBERSHIP") {

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
    userId: 1, // Replace with logged-in user later
    planId: plan.id,
    paymentId: payment.id,
    walletBalance: plan.wallet_bonus,
    discountPercent: plan.discount_percentage,
    monthlyClaim: plan.monthly_claim,
    expiryDate,
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
    2,
    req.body.productId,
    req.body.quantity || 1,
  );

} else {

  order = await Order.createOrder(
    "USER",
    2,
  );

}
const address = await Address.getDefaultAddress("USER", 2);

if (!address) {
  return res.status(400).json({
    success: false,
    message: "Default delivery address not found.",
  });
}

let shipment;

try {
  shipment = await xpressbeesService.createShipment({
    order_number: order.id,
    payment_type: "Prepaid",
    amount: order.total_amount,

    customer_name: address.full_name,
    customer_phone: address.phone,
    address: `${address.address_line1} ${address.address_line2 || ""}`,
    city: address.city,
    state: address.state,
    pincode: address.postal_code,
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

module.exports = {
  createOrder,
  verifyPayment,
  getPayments,
};
