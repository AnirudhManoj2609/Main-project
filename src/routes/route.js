const express = require('express');
const router = express.Router();
const userController = require('../controllers/userController');

// Define the route
router.get('/welcome', userController.getWelcomeMessage);

module.exports = router;