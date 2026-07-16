const pool = require("../../db");

const getPlans = async () => {
  const result = await pool.query(`
    SELECT *
    FROM subscription_plans
    WHERE is_active = TRUE
    ORDER BY display_order ASC
  `);

  return result.rows;
};

module.exports = {
  getPlans,
};
