const pool = require("../config/db");

const UserLogin = {
  async findByUserId(userId) {
    const result = await pool.query(
      "SELECT * FROM user_login WHERE user_id = $1",
      [userId]
    );
    return result.rows[0];
  },

  async create(user) {
    const result = await pool.query(
      `
      INSERT INTO user_login
      (
        user_id,
        username,
        mobile_no,
        password,
        role,
        is_active
      )
      VALUES
      ($1,$2,$3,$4,$5,true)
      RETURNING *
      `,
      [
        user.id,
        user.mobile,
        user.mobile,
        "",
        "USER",
      ]
    );

    return result.rows[0];
  },
};

module.exports = UserLogin;