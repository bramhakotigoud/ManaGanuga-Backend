const pool = require("../../db");

const UserLogin = {

  async findByUserId(userId) {
    const result = await pool.query(
      "SELECT * FROM user_login WHERE user_id = $1",
      [userId]
    );

    return result.rows[0];
  },


  async findByMobile(mobile) {
  const result = await pool.query(
    `
    SELECT *
    FROM user_login
    WHERE mobile_no = $1
      AND is_active = true
    LIMIT 1
    `,
    [mobile]
  );

  return result.rows[0];
},
    async updateFcmToken(userId, fcmToken) {
    const result = await pool.query(
      `
      UPDATE user_login
      SET fcm_token = $1
      WHERE user_id = $2
      RETURNING user_id, username, mobile_no, role, fcm_token
      `,
      [fcmToken, userId]
    );

    return result.rows[0];
  },


  async create(user, password, createdBy) {

    const result = await pool.query(
      `
      INSERT INTO user_login
      (
        user_id,
        username,
        mobile_no,
        password,
        role,
        created_by,
        is_active
      )
      VALUES
      ($1,$2,$3,$4,$5,$6,true)
      RETURNING *
      `,
      [
        user.id,
        user.mobile,
        user.mobile,
        password,
        "USER",
        createdBy
      ]
    );

    return result.rows[0];
  },
  async updatePassword(userId, newPassword) {
  const result = await pool.query(
    `
    UPDATE user_login
    SET password = $1
    WHERE user_id = $2
    RETURNING *
    `,
    [newPassword, userId]
  );

  return result.rows[0];
},
async updateUsername(userId, username) {
  const result = await pool.query(
    `
    UPDATE user_login
    SET username = $1
    WHERE user_id = $2
    RETURNING user_id, username, mobile_no, role
    `,
    [username, userId]
  );

  return result.rows[0];
},
async clearFcmToken(userId) {
  const result = await pool.query(
    `
    UPDATE user_login
    SET fcm_token = NULL
    WHERE user_id = $1
    RETURNING user_id, fcm_token
    `,
    [userId]
  );

  return result.rows[0];
},
async deactivateAccount(userId) {
  const result = await pool.query(
    `
    UPDATE user_login
    SET is_active = false
    WHERE user_id = $1
    RETURNING user_id, mobile_no, is_active
    `,
    [userId]
  );

  return result.rows[0];
},
};


module.exports = UserLogin;