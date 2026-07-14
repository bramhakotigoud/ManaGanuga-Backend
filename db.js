const { Pool } = require("pg");

const pool = new Pool({
  user: "postgres",
  host: "postgres.railway.internal",
  database: "railway",
  password: "KmdmiOsUvmIinKBWFpfChsubtwdlmTeV",
  port: 5342,
  ssl: false,
});

module.exports = pool;