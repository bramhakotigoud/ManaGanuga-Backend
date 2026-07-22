const axios = require("axios");

const BASE_URL = "https://shipment.xpressbees.com/api";

let token = null;
let tokenExpiry = null;

const login = async () => {
  if (token && tokenExpiry && Date.now() < tokenExpiry) {
    return token;
  }

  const response = await axios.post(
    `${BASE_URL}/users/login`,
    {
      email: process.env.XPRESSBEES_EMAIL,
      password: process.env.XPRESSBEES_PASSWORD,
    },
    {
      headers: {
        "Content-Type": "application/json",
      },
    }
  );

  if (!response.data.status) {
    throw new Error("Xpressbees login failed");
  }

  token = response.data.data;

  // Token cache for 2 hours
  tokenExpiry = Date.now() + 2 * 60 * 60 * 1000;

  console.log("✅ XPRESSBEES LOGIN SUCCESS");

  return token;
};
const createShipment = async (shipmentPayload) => {
  const jwt = await login();

  const response = await axios.post(
    `${BASE_URL}/shipments2`,
    shipmentPayload,
    {
      headers: {
        Authorization: `Bearer ${jwt}`,
        "Content-Type": "application/json",
      },
    }
  );

  console.log("========== XPRESSBEES RESPONSE ==========");
  console.log(JSON.stringify(response.data, null, 2));
  console.log("=========================================");

  return response.data;
};
module.exports = {
  login,
  createShipment,
};
