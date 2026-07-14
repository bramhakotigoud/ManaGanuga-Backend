const Order = require("../models/Order");

const createOrder = async (req, res) => {
  console.log("ORDER BODY:", req.body);
  try {
    const {
      entity_type,
      entity_id,
      buyNow,
      productId,
      quantity,
      } = req.body;
    const order = await Order.createOrder(
      entity_type,
      entity_id,
      buyNow,
      productId,
      quantity
    );
    if (!order) {
      return res.status(404).json({
        success: false,
        message: "Cart is empty",
      });
    }

    res.status(201).json({
      success: true,
      message: "Order created successfully",
      data: order,
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: error.message,
    });
  }
};

const getOrders = async (req, res) => {
  try {
    const { entity_type, entity_id } = req.query;

    let orders;

    if (entity_type && entity_id) {
      orders = await Order.getOrdersByEntity(entity_type, entity_id);
    } else {
      orders = await Order.getOrders();
    }

    res.json({
      success: true,
      count: orders.length,
      data: orders,
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: error.message,
    });
  }
};

const getOrderById = async (req, res) => {
  try {
    const order = await Order.getOrderById(req.params.id);

    if (!order) {
      return res.status(404).json({
        success: false,
        message: "Order not found",
      });
    }

    res.json({
      success: true,
      data: order,
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: error.message,
    });
  }
};

const getOrderItems = async (req, res) => {
  try {
    const items = await Order.getOrderItems(req.params.id);

    res.json({
      success: true,
      count: items.length,
      data: items,
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: error.message,
    });
  }
};

const updateOrder = async (req, res) => {
  try {
    const order = await Order.updateOrder(req.params.id, req.body.status);

    res.json({
      success: true,
      message: "Order updated successfully",
      data: order,
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: error.message,
    });
  }
};

const deleteOrder = async (req, res) => {
  try {
    const order = await Order.deleteOrder(req.params.id);

    res.json({
      success: true,
      message: "Order deleted successfully",
      data: order,
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: error.message,
    });
  }
};

module.exports = {
  createOrder,
  getOrders,
  getOrderById,
  getOrderItems,
  updateOrder,
  deleteOrder,
};
