const express = require("express");
const router = express.Router();
const authController = require("../controllers/authController");
router.get("/test", (req, res) => {
  console.log("TEST ROUTE HIT");
  res.json({ message: "Backend working" });
});

router.post("/send-otp", authController.sendOtp);
router.post("/verify-otp", authController.verifyOtp);

module.exports = router;
