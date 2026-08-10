const { sendOtp, verifyOtp } = require("../services/otpService");
const User = require("../models/User");
const UserLogin = require("../models/UserLogin");
const generateToken = require("../utils/generateToken");
const { sendSMS } = require("../services/smsService");

// SEND OTP
exports.sendOtp = async (req, res) => {
  console.log("SEND OTP ROUTE HIT");
  console.log("BODY:", req.body);

  try {
    const { mobile } = req.body;
    const loginUser = await UserLogin.findByMobile(mobile);

if (loginUser) {
  return res.status(200).json({
    success: true,
    existingUser: true,
    message: "Please login with your password.",
  });
}

    if (!mobile) {
      return res.status(400).json({ message: "Mobile required" });
    }

    await sendOtp(mobile);

    res.json({ message: "OTP sent successfully" });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};

/// VERIFY OTP + LOGIN
exports.verifyOtp = async (req, res) => {
  console.log("VERIFY OTP ROUTE HIT");
  console.log("BODY:", req.body);

  try {
   const {
  mobile,
  otp,
  vendorId,
} = req.body;

    const result = verifyOtp(mobile, otp);

    console.log("VERIFY RESULT:", result);

    if (!result.success) {
      return res.status(400).json({ message: result.message });
    }

    let user = await User.findOne({ mobile });

   if (!user) {
  user = await User.create({ mobile });
}

const loginUser = await UserLogin.findByUserId(user.id);
console.log("LOGIN USER CHECK:", loginUser);

// if (!loginUser) {

//   // Generate 8-character password
//   const randomPassword = Math.random().toString(36).slice(-8).toUpperCase();

//   await UserLogin.create(
//   user,
//   randomPassword,
//   vendorId
// );

//   // Send password SMS (only if template ID is configured)
//   const passwordMessage = `Welcome to Mana Ganuga.
// Your login password is ${randomPassword}.
// Please keep it secure.`;

//   if (process.env.SMS_PASSWORD_TEMPLATE_ID) {
//     await sendSMS(
//       mobile,
//       passwordMessage,
//       process.env.SMS_PASSWORD_TEMPLATE_ID
//     );
//   } else {
//     console.log("SMS_PASSWORD_TEMPLATE_ID not configured. Skipping password SMS.");
//   }
// }
if (!loginUser) {

  // Generate 8-character initial password
  const randomPassword = Math.random()
    .toString(36)
    .slice(-8)
    .toUpperCase();

  // Save user login with generated password
  await UserLogin.create(
    user,
    randomPassword,
    vendorId
  );

  // Send initial password SMS using registered SMS template
  const passwordMessage =
    `We are delighted to have you with us. Your account for managanuga has been created successfully.\n` +
    `User ID: ${user.id}\n` +
    `Password: ${randomPassword}\n` +
    `For your peace of mind, we recommend updating your password after your first login.\n` +
    `managanuga`;
    console.log("PASSWORD SMS TEMPLATE:", process.env.SMS_PASSWORD_TEMPLATE_ID);
console.log("PASSWORD SMS MOBILE:", mobile);
console.log("PASSWORD SMS USER ID:", user.id);
console.log("PASSWORD SMS PASSWORD:", randomPassword);

  await sendSMS(
    mobile,
    passwordMessage,
    process.env.SMS_PASSWORD_TEMPLATE_ID
  );
}
    const token = generateToken(user);

    res.json({
      message: "Login successful",
      token,
      user,
    });
  } catch (err) {
    console.log("VERIFY ERROR:", err);
    res.status(500).json({ message: err.message });
  }
};
// LOGIN WITH PASSWORD
exports.loginWithPassword = async (req, res) => {
  console.log("PASSWORD LOGIN ROUTE HIT");
  console.log("BODY:", req.body);

  try {
    const { mobile, password } = req.body;

if (!mobile || !password) {
  return res.status(400).json({
    message: "Mobile and password are required",
  });
}

// Remove only accidental spaces at the beginning/end.
// DO NOT change uppercase/lowercase.
const cleanPassword = password.trim();

console.log(
  "PASSWORD FROM APP:",
  JSON.stringify(password)
);

console.log(
  "CLEAN PASSWORD:",
  JSON.stringify(cleanPassword)
);

// Find login record
const loginUser = await UserLogin.findByMobile(mobile);

if (!loginUser) {
  return res.status(404).json({
    message: "User not found",
  });
}

console.log(
  "PASSWORD FROM DATABASE:",
  JSON.stringify(loginUser.password)
);

console.log(
  "PASSWORD MATCH:",
  loginUser.password === cleanPassword
);

// Verify password
if (loginUser.password !== cleanPassword) {
  return res.status(401).json({
    message: "Invalid password",
  });
}///changed 
    // const { mobile, password } = req.body;

    // if (!mobile || !password) {
    //   return res.status(400).json({
    //     message: "Mobile and password are required",
    //   });
    // }

    // // Find login record
    // const loginUser = await UserLogin.findByMobile(mobile);

    // if (!loginUser) {
    //   return res.status(404).json({
    //     message: "User not found",
    //   });
    // }

    // // Verify password
    // if (loginUser.password !== password) {
    //   return res.status(401).json({
    //     message: "Invalid password",
    //   });
    // }

    // Find user
    const user = await User.findOne({ mobile });

    if (!user) {
      return res.status(404).json({
        message: "User not found",
      });
    }
    user.role = loginUser.role;

    // Generate token
    const token = generateToken(user);

    res.json({
  message: "Login successful",
  token,
  user: {
    ...user,
    role: loginUser.role,
  },
});
  } catch (err) {
    console.log("PASSWORD LOGIN ERROR:", err);
    res.status(500).json({
      message: err.message,
    });
  }
};
// SAVE FCM TOKEN
exports.updateFcmToken = async (req, res) => {
  console.log("FCM TOKEN ROUTE HIT");
  console.log("BODY:", req.body);

  try {
    const { userId, fcmToken } = req.body;

    if (!userId || !fcmToken) {
      return res.status(400).json({
        success: false,
        message: "userId and fcmToken are required",
      });
    }

    const user = await User.updateFcmToken(userId, fcmToken);

    if (!user) {
      return res.status(404).json({
        success: false,
        message: "User not found",
      });
    }

    res.json({
      success: true,
      message: "FCM token saved successfully",
      user,
    });

  } catch (err) {
    console.error("FCM TOKEN ERROR:", err);

    res.status(500).json({
      success: false,
      message: err.message,
    });
  }
};
