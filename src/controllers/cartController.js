const Cart = require("../models/Cart");

// Add Item
const addItem = async (req, res) => {
  try {
    const item = await Cart.addItem(req.body);

    res.status(201).json({
      success: true,
      message: "Item added successfully",
      data: item,
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: error.message,
    });
  }
};

// Get Items by entity id
const getItems = async (req, res) => {
  try {
    const { entity_type, entity_id } = req.query;

    // GET ALL CARTS
    if (!entity_type && !entity_id) {
      const items = await Cart.getAllItems();

      return res.json({
        success: true,
        count: items.length,
        data: items,
      });
    }

    // GET CART BY ENTITY
    const items = await Cart.getItems(entity_type, entity_id);

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
//get one item
const getItemById = async (req, res) => {
  try {
    const item = await Cart.getItemById(req.params.id);

    if (!item) {
      return res.status(404).json({
        success: false,
        message: "Item not found",
      });
    }

    res.json({
      success: true,
      data: item,
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: error.message,
    });
  }
};

// Update Item
const updateItem = async (req, res) => {
  try {
    const item = await Cart.updateItem(req.params.id, req.body.quantity);

    if (!item) {
      return res.status(404).json({
        success: false,
        message: "Item not found",
      });
    }

    res.json({
      success: true,
      message: "Item updated successfully",
      data: item,
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: error.message,
    });
  }
};

// Delete Item
const deleteItem = async (req, res) => {
  try {
    const item = await Cart.deleteItem(req.params.id);

    if (!item) {
      return res.status(404).json({
        success: false,
        message: "Item not found",
      });
    }

    res.json({
      success: true,
      message: "Item deleted successfully",
      data: item,
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: error.message,
    });
  }
};

module.exports = {
  addItem,
  getItems,
  getItemById,
  updateItem,
  deleteItem,
};
