const app = require("./src/app");

const PORT = 5001;

console.log("SERVER FILE LOADED");

const productRoutes = require("./src/routes/productRoutes");
const cartRoutes = require("./src/routes/cartRoutes");
const paymentRoutes = require("./src/routes/paymentRoutes"); // ADD THIS
const authRoutes = require("./src/routes/authRoutes"); // ADD THIS

/* -------------------------
   CLEAN ROUTE PREFIXES
-------------------------- */
app.use("/api/products", productRoutes);
app.use("/api/cart", cartRoutes);
app.use("/api/payments", paymentRoutes);
app.use("/api/auth", authRoutes);


app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});

console.log("LISTEN CALLED");
