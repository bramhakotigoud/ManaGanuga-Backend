// // const axios = require("axios");

// // const sendSMS = async (mobile, message) => {
// //   try {
// //     const url = `${process.env.SMS_BASE_URL}index.php`;

// //     const response = await axios.get(url, {
// //       params: {
// //         key: process.env.SMS_API_KEY,
// //         sender: process.env.SMS_SENDER_ID,
// //         mobile: mobile,
// //         message: message,
// //       },
// //     });

// //     return response.data;
// //   } catch (error) {
// //     console.log("SMS Error:", error.message);
// //     throw new Error("SMS sending failed");
// //   }
// // };

// // module.exports = { sendSMS };
// // const axios = require("axios");

// // const sendSMS = async (mobile, message) => {
// //   try {
// //     console.log("👉 RAW SMS_BASE_URL:", process.env.SMS_BASE_URL);

// //     const url = process.env.SMS_BASE_URL;

// //     console.log("👉 FINAL URL TYPE:", typeof url);
// //     console.log("👉 FINAL URL VALUE:", url);

// //     if (!url) {
// //       throw new Error("SMS_BASE_URL is missing or undefined");
// //     }

// //     const response = await axios.get(url, {
// //       params: {
// //         key: process.env.SMS_API_KEY,
// //         sender: process.env.SMS_SENDER_ID,
// //         mobile,
// //         message,
// //       },
// //     });

// //     return response.data;
// //   } catch (error) {
// //     console.log("SMS ERROR:", error.message);
// //     throw new Error("SMS sending failed");
// //   }
// // };

// // module.exports = { sendSMS };
// // const axios = require("axios");

// // const sendSMS = async (mobile, message) => {
// //   try {
// //     const url = `${process.env.SMS_BASE_URL}index.php`;

// //     const response = await axios.get(url, {
// //       params: {
// //         key: process.env.SMS_API_KEY,
// //         sender: process.env.SMS_SENDER_ID,
// //         mobile: mobile,
// //         message: message,
// //       },
// //     });

// //     return response.data;
// //   } catch (error) {
// //     console.log("SMS Error:", error.message);
// //     throw new Error("SMS sending failed");
// //   }
// // };

// // module.exports = { sendSMS };
// // const axios = require("axios");

// // const sendSMS = async (mobile, message) => {
// //   try {
// //     console.log("👉 RAW SMS_BASE_URL:", process.env.SMS_BASE_URL);

// //     const url = process.env.SMS_BASE_URL;

// //     console.log("👉 FINAL URL TYPE:", typeof url);
// //     console.log("👉 FINAL URL VALUE:", url);

// //     if (!url) {
// //       throw new Error("SMS_BASE_URL is missing or undefined");
// //     }

// //     console.log("👉 BEFORE AXIOS");

// //     const response = await axios.get(url, {
// //       params: {
// //         key: process.env.SMS_API_KEY,
// //         sender: process.env.SMS_SENDER_ID,
// //         mobile,
// //         message,
// //       },
// //     });

// //     console.log("👉 AFTER AXIOS");
// //     console.log("👉 SMS RESPONSE:");
// //     console.log(response.data);

// //     return response.data;
// //   } catch (error) {
// //     console.log("👉 SMS ERROR:");
// //     console.log(error.response?.data || error.message);

// //     throw new Error("SMS sending failed");
// //   }
// // };

// // module.exports = { sendSMS };
// const axios = require("axios");

// const sendSMS = async (mobile, message) => {
//   try {
//     console.log("👉 RAW SMS_BASE_URL:", process.env.SMS_BASE_URL);

//     const url = process.env.SMS_BASE_URL;

//     console.log("👉 FINAL URL TYPE:", typeof url);
//     console.log("👉 FINAL URL VALUE:", url);

//     if (!url) {
//       throw new Error("SMS_BASE_URL is missing or undefined");
//     }

//     console.log("👉 PARAMS BEING SENT:");
//     console.log({
//       key: process.env.SMS_API_KEY ? "AVAILABLE" : "MISSING",
//       sender: process.env.SMS_SENDER_ID,
//       mobile,
//       message,
//     });

//     console.log("👉 BEFORE AXIOS");

//     const response = await axios.get(url, {
//       params: {
//         key: process.env.SMS_API_KEY,
//         sender: process.env.SMS_SENDER_ID,
//         mobile: mobile,
//         message: message,
//       },
//       timeout: 10000,
//     });

//     console.log("👉 AFTER AXIOS");
//     console.log("👉 SMS RESPONSE:");
//     console.log(response.data);

//     return response.data;
//   } catch (error) {
//     console.log("👉 SMS ERROR:");

//     if (error.response) {
//       console.log("Status:", error.response.status);
//       console.log("Data:", error.response.data);
//     } else {
//       console.log(error.message);
//     }

//     throw new Error("SMS sending failed");
//   }
// };

// module.exports = { sendSMS };
const axios = require("axios");

const sendSMS = async (mobile, message) => {
  try {
    const response = await axios.get(process.env.SMS_BASE_URL, {
      params: {
        username: process.env.SMS_USERNAME,
        apikey: process.env.SMS_API_KEY,
        senderid: process.env.SMS_SENDER_ID,
        mobile: mobile,
        message: message,
        templateid: process.env.SMS_TEMPLATE_ID,
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
