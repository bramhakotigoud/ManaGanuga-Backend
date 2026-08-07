const express = require("express");
const router = express.Router();

const {
  getSubscriptionPlans,
  getMyMembership,
  acceptMembershipTerms,
} = require("../controllers/subscriptionController");

router.get("/plans", getSubscriptionPlans);

router.get("/my-membership", getMyMembership);

router.post("/accept-terms", acceptMembershipTerms);

module.exports = router;