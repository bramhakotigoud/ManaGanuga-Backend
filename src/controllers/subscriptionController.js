const pool = require("../config/db");

const getSubscriptionPlans = async (req, res) => {
  try {
    const result = await pool.query(`
      SELECT *
      FROM subscription_plans
      WHERE is_active = TRUE
      ORDER BY display_order ASC
    `);

    res.status(200).json({
      success: true,
      plans: result.rows,
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