const express = require('express');
const router = express.Router();

const EmailController = require('../Controllers/Email');

router.get('/:id', EmailController.getEmailById);
router.get('/aa/:id', EmailController.getEmailsByAA);
router.post('/deleteOne', EmailController.deleteById);
router.post('/deleteAll', EmailController.deleteByAa);
router.post('/create', EmailController.create);
router.patch('/update', EmailController.update);

module.exports = router;