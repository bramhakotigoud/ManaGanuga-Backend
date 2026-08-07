// const pool = require("../../db");

// const UserLogin = {
//   async findByUserId(userId) {
//     const result = await pool.query(
//       "SELECT * FROM user_login WHERE user_id = $1",
//       [userId]
//     );
//     return result.rows[0];
//   },

//   async findByMobile(mobile) {
//   const result = await pool.query(
//     `SELECT * FROM user_login WHERE mobile_no = $1 LIMIT 1`,
//     [mobile]
//   );

//   return result.rows[0];
// },

//   async create(user, password, vendorId) {
//     const result = await pool.query(
//       `
//       INSERT INTO user_login
// (
//   user_id,
//   username,
//   mobile_no,
//   password,
//   role,
//   created_by,
//   is_active
// )
// VALUES
// ($1,$2,$3,$4,$5,$6,true)
//       RETURNING *
//       `,
//       [
//   user.id,
//   user.mobile,
//   user.mobile,
//   password,
//   "USER",
//   vendorId,
// ]
//     );

//     return result.rows[0];
//   },
// };

// module.exports = UserLogin;
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
      `SELECT * FROM user_login WHERE mobile_no = $1 LIMIT 1`,
      [mobile]
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

};

module.exports = UserLogin;