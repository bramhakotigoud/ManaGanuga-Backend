const Reseller = require("../models/Reseller");

const getCustomers = async (req, res) => {
  try {

    // Temporary reseller ID
    // Later this will come from JWT
    const resellerId = "001";

    const customers = await Reseller.getCustomers(resellerId);

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