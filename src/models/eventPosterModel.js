const pool = require("../../db");

const getActiveEventPoster = async () => {
  // Permanently deactivate expired posters
  await pool.query(`
    UPDATE event_posters
    SET is_active = 0
    WHERE ended_date <= NOW()
      AND is_active = 1
  `);

  // Get the latest active poster
  const result = await pool.query(`
    SELECT
      id,
      image,
      created_date,
      ended_date,
      is_active
    FROM event_posters
    WHERE is_active = 1
      AND created_date <= NOW()
      AND ended_date > NOW()
    ORDER BY created_date DESC
    LIMIT 1
  `);

  return result.rows[0] || null;
};
const createEventPoster = async (image, ended_date) => {
  const result = await pool.query(
    `INSERT INTO event_posters
      (image, created_date, ended_date, is_active)
     VALUES
      ($1, NOW(), $2, 1)
     RETURNING
      id,
      image,
      created_date,
      ended_date,
      is_active`,
    [image, ended_date],
  );

  return result.rows[0];
};

module.exports = {
  getActiveEventPoster,
  createEventPoster,
};
