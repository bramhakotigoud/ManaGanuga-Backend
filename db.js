const { Pool } = require("pg");

const pool = new Pool({
  user: "apfdcllp",
  host: "localhost",
  database: "ManaGanugaApp",
  password: "",
  port: 5432,
});

module.exports = pool;
