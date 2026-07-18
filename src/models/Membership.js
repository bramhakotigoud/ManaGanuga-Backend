const pool = require("../config/db");

const createMembership = async ({
  userId,
  planId,
  paymentId,
  walletBalance,
  discountPercent,
  monthlyClaim,
  expiryDate,
}) => {
  const result = await pool.query(
    `
    INSERT INTO user_memberships
    (
      user_id,
      plan_id,
      payment_id,
      wallet_balance,
      discount_percent,
      monthly_claim,
      expiry_date
    )
    VALUES
    ($1,$2,$3,$4,$5,$6,$7)
    RETURNING *;
    `,
    [
      userId,
      planId,
      paymentId,
      walletBalance,
      discountPercent,
      monthlyClaim,
      expiryDate,
    ]
  );

  return result.rows[0];
};

const getActiveMembership = async (userId) => {
  const result = await pool.query(
    `
    SELECT *
    FROM user_memberships
    WHERE user_id=$1
    AND status='ACTIVE'
    LIMIT 1
    `,
    [userId]
  );

  return result.rows[0];
};

module.exports = {
  createMembership,
  getActiveMembership,
};