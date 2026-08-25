const express = require("express");
const multer = require("multer");

const {
  uploadProfileImage,
  getProfileImage,
} = require("../controllers/userDocumentController");

const router = express.Router();

const upload = multer({
  storage: multer.memoryStorage(),
  limits: {
    fileSize: 5 * 1024 * 1024,
  },
});

router.post(
  "/profile",
  upload.single("profile_image"),
  uploadProfileImage
);

router.get(
  "/profile/:userId",
  getProfileImage
);

module.exports = router;