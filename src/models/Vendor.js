const pool = require("../../db");

const getCustomers = async (vendorId) => {

  const result = await pool.query(
    `
    SELECT

      ul.user_id,

      ul.username,

      ul.mobile_no,

      COUNT(o.id) AS total_orders

    FROM user_login ul

    LEFT JOIN orders o
      ON o.user_id = ul.user_id

    WHERE

      ul.created_by = $1

      AND ul.role IN ('USER','CUSTOMER')

    GROUP BY

      ul.user_id,
      ul.username,
      ul.mobile_no

    ORDER BY

      ul.username ASC;
    `,
    [vendorId]
  );

  return result.rows;

};

module.exports = {
  getCustomers,
};