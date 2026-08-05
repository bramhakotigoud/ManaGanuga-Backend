const express = require("express");
const router = express.Router();

const {
  getCustomers,
} = require("../controllers/vendorController");

router.get(
  "/customers",
  getCustomers,
    getOrders,
);
router.get(
  "/orders",
  getOrders
);

module.exports = router;