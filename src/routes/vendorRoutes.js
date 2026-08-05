const express = require("express");

const router = express.Router();

const {
  getCustomers,
  getOrders,
} = require("../controllers/vendorController");

router.get(
  "/customers",
  getCustomers
);

router.get(
  "/orders",
  getOrders
);

module.exports = router;