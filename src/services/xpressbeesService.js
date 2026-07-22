const axios = require("axios");

console.log("EMAIL:", process.env.XPRESSBEES_EMAIL);
console.log("PASSWORD LOADED:", !!process.env.XPRESSBEES_PASSWORD);


const getToken = async () => {
  try {
    const response = await axios.post(
      `${process.env.XPRESSBEES_BASE_URL}/api/users/login`,
      {
        email: process.env.XPRESSBEES_EMAIL,
        password: process.env.XPRESSBEES_PASSWORD,
      }
    );

    console.log("LOGIN RESPONSE:");
    console.log(JSON.stringify(response.data, null, 2));

    return response.data.data;
  } catch (err) {
    console.error("XPRESSBEES LOGIN FAILED");
    console.error("Status:", err.response?.status);
    console.error("Response:", err.response?.data);
    throw err;
  }
};

const createShipment = async (orderData) => {
  const token = await getToken();

  console.log("TOKEN:");
  console.log(token);

  const response = await axios.post(
    `${process.env.XPRESSBEES_BASE_URL}/api/shipments2`,
    orderData,
    {
      headers: {
        Authorization: `Bearer ${token}`,
        "Content-Type": "application/json",
      },
    },
  );

  console.log("SHIPMENT RESPONSE:");
  console.log(JSON.stringify(response.data, null, 2));

  return response.data;
};

module.exports = {
  createShipment,
};