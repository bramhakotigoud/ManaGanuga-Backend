const express = require("express");
const router = express.Router();

const {
  createOrder,
  verifyPayment,
  getPayments,
} = require("../controllers/paymentController");

router.post("/create-order", createOrder);
router.post("/verify", verifyPayment);
router.get("/", getPayments);

module.exports = router;
