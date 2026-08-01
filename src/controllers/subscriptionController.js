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
const Membership = require("../models/Membership");

const getMyMembership = async (req, res) => {
  try {
    const { userId } = req.query;

    const membership =
      await Membership.getActiveMembership(userId);

    res.status(200).json({
      success: true,
      membership,
    });

  } catch (error) {
    console.error("Get Membership Error:", error);

    res.status(500).json({
      success: false,
      message: error.message,
    });
  }
};

module.exports = {
  getSubscriptionPlans,
  getMyMembership,
};