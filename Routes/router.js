const express = require('express');
const router = express.Router();

const EmailController = require('../Controllers/Email');

router.get('/', EmailController.get);
router.get('/a/:id', EmailController.getA);

module.exports = router;