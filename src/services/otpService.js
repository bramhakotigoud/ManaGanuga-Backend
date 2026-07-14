const { sendSMS } = require("./smsService");

// simple in-memory store (for testing only)
const otpStore = new Map();

const generateOTP = () => {
  return Math.floor(100000 + Math.random() * 900000).toString();
};

const sendOtp = async (mobile) => {
  const otp = generateOTP();
  console.log("GENERATED OTP:", otp);

  otpStore.set(mobile, {
    otp,
    expiresAt: Date.now() + 5 * 60 * 1000, // 5 min
  });

  const message = `Use OTP ${otp} to complete your login to ManaGanuga. Do not share this code.`;
  await sendSMS(mobile, message);

  return true;
};

const verifyOtp = (mobile, otp) => {
  const record = otpStore.get(mobile);

  if (!record) return { success: false, message: "OTP not found" };

  if (Date.now() > record.expiresAt) {
    otpStore.delete(mobile);
    return { success: false, message: "OTP expired" };
  }

  if (record.otp !== otp) {
    return { success: false, message: "Invalid OTP" };
  }

  otpStore.delete(mobile);
  return { success: true };
};

module.exports = { sendOtp, verifyOtp };
