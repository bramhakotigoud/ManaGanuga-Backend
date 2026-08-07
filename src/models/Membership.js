const pool = require("../../db")

const createMembership = async ({
  userId,
  planId,
  paymentId,
  walletBalance,
  discountPercent,
  monthlyClaim,
  expiryDate,
  termsAndConditions = false,
}) => {
  await pool.query(
  `
  UPDATE user_memberships

  SET
    status = 'EXPIRED',
    updated_at = NOW()

  WHERE
    user_id = $1
    AND status = 'ACTIVE'
  `,
  [userId]
);
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
  expiry_date,
  terms_and_conditions
)
VALUES
($1,$2,$3,$4,$5,$6,$7,$8)
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
  termsAndConditions,
]
  );

  return result.rows[0];
};

const getActiveMembership = async (userId) => {
  const result = await pool.query(
    `
    SELECT
      um.*,
      sp.plan_name,
      sp.plan_price,
      sp.wallet_bonus,
      sp.discount_percentage,
      sp.monthly_claim,
      sp.monthly_limit_litres,
      sp.validity_months
    FROM user_memberships um

    INNER JOIN subscription_plans sp
      ON sp.id = um.plan_id

    WHERE
      um.user_id = $1
      AND um.status = 'ACTIVE'

    ORDER BY um.id DESC

    LIMIT 1
    `,
    [userId]
  );

  return result.rows[0];
};
const updateMembershipUsage = async ({
  userId,
  litresUsed,
  walletUsed,
}) => {

  const result = await pool.query(
    `
    UPDATE user_memberships

    SET

      used_litres =
        used_litres + $1,

      monthly_claim_used =
        monthly_claim_used + $2,

      wallet_balance =
        wallet_balance - $2,

      updated_at = NOW()

    WHERE

      user_id = $3

      AND status='ACTIVE'

    RETURNING *;
    `,
    [
      litresUsed,
      walletUsed,
      userId,
    ]
  );

  return result.rows[0];

};
const resetMonthlyBenefits = async (
  membershipId,
) => {

  const result = await pool.query(
    `
    UPDATE user_memberships

    SET

      used_litres = 0,

      monthly_claim_used = 0,

      last_reset_date = CURRENT_DATE,

      updated_at = NOW()

    WHERE id = $1

    RETURNING *;
    `,
    [membershipId]
  );

  return result.rows[0];

};
  const checkAndResetMonthlyBenefits =
async (userId) => {

  const membership =
    await getActiveMembership(userId);

  if (!membership) {
    return null;
  }

  const today = new Date();

  const lastReset =
    new Date(membership.last_reset_date);

  const monthChanged =

    today.getMonth() !== lastReset.getMonth()

    ||

    today.getFullYear() !== lastReset.getFullYear();

  if (!monthChanged) {
    return membership;
  }

  return await resetMonthlyBenefits(
    membership.id,
  );

};


const acceptTerms = async (userId) => {
  const result = await pool.query(
    `
    UPDATE user_memberships
    SET terms_and_conditions = TRUE
    WHERE user_id = $1
    RETURNING *
    `,
    [userId]
  );

  if (result.rows.length === 0) {
    throw new Error("Membership record not found");
  }

  return result.rows[0];
};

module.exports = {
  createMembership,
  getActiveMembership,
  updateMembershipUsage,
  acceptTerms,
  resetMonthlyBenefits,
  checkAndResetMonthlyBenefits,
};