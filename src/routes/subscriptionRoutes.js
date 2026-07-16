const express = require("express");
const router = express.Router();

const {
  getSubscriptionPlans,
} = require("../controllers/subscriptionController");

router.get("/plans", getSubscriptionPlans);

module.exports = router;