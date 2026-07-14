const { sendOtp, verifyOtp } = require("../services/otpService");
const User = require("../models/User");
const generateToken = require("../utils/generateToken");

// SEND OTP
exports.sendOtp = async (req, res) => {
  console.log("SEND OTP ROUTE HIT");
  console.log("BODY:", req.body);

  try {
    const { mobile } = req.body;

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
    const { mobile, otp } = req.body;

    const result = verifyOtp(mobile, otp);

    console.log("VERIFY RESULT:", result);

    if (!result.success) {
      return res.status(400).json({ message: result.message });
    }

    let user = await User.findOne({ mobile });

    if (!user) {
      user = await User.create({ mobile });
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
