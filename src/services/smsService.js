const axios = require("axios");

const sendSMS = async (mobile, message, templateId) => {
  try {
    const response = await axios.get(process.env.SMS_BASE_URL, {
      params: {
        username: process.env.SMS_USERNAME,
        apikey: process.env.SMS_API_KEY,
        senderid: process.env.SMS_SENDER_ID,
        mobile,
        message,
        templateid: templateId,
      },
    });

    console.log("SMS RESPONSE:");
    console.log(response.data);

    return response.data;
  } catch (error) {
    console.log("SMS ERROR:");
    console.log(error.response?.data || error.message);

    throw new Error("SMS sending failed");
  }
};

module.exports = { sendSMS };