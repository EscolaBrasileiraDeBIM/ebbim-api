const express = require('express');
const router = express.Router();

const EmailController = require('../Controllers/Email');

router.get('/:id', EmailController.getEmailById);
router.get('/aa/:id', EmailController.getEmailsByAA);
router.post('/delete', EmailController.delete);
router.post('/create', EmailController.create);
router.patch('/update', EmailController.update);

module.exports = router;