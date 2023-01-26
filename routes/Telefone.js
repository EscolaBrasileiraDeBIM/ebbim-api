const express = require('express');
const router = express.Router();

const Telefone = require('../Controllers/Telefone');

router.get('/:id', Telefone.getTelefoneById);
router.get('/aa/:id', Telefone.getTelefonesByAA);
router.post('/deleteOne', Telefone.deleteById);
router.post('/deleteAll', Telefone.deleteByAa);
router.post('/create', Telefone.create);
router.patch('/update', Telefone.update);

module.exports = router;