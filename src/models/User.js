const pool = require("../../db");

const findOne = async ({ mobile }) => {
  const result = await pool.query(
    "SELECT * FROM users WHERE mobile = $1",
    [mobile]
  );

  return result.rows[0];
};

const create = async ({ mobile }) => {
  const result = await pool.query(
    "INSERT INTO users (mobile) VALUES ($1) RETURNING *",
    [mobile]
  );

  return result.rows[0];
};

module.exports = {
  findOne,
  create,
};