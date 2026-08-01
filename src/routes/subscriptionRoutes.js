const express = require("express");
const router = express.Router();

const {
  getSubscriptionPlans,
  getMyMembership,
} = require("../controllers/subscriptionController");

router.get("/plans", getSubscriptionPlans);

router.get("/my-membership", getMyMembership);

module.exports = router;