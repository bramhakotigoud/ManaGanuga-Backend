const Subscription = require("../models/Subscription");

const getSubscriptionPlans = async (req, res) => {
  try {
    const plans = await Subscription.getPlans();

    res.status(200).json({
      success: true,
      plans,
    });
  } catch (error) {
    console.error("Subscription Plans Error:", error);

    res.status(500).json({
      success: false,
      message: "Failed to fetch subscription plans",
    });
  }
};

module.exports = {
  getSubscriptionPlans,
};