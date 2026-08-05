const Vendor = require("../models/Vendor");

const getCustomers = async (req, res) => {

  try {

    // Temporary Vendor ID
    // Later this will come from JWT token
    const vendorId = "100";

    const customers =
      await Vendor.getCustomers(vendorId);

    res.json(customers);

  } catch (err) {

    console.log(err);

    res.status(500).json({
      message: err.message,
    });

  }

};

module.exports = {
  getCustomers,
};