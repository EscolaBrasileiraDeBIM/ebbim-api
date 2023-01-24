const express = require('express');
const router = express.Router();

const PessoaController = require('../Controllers/Pessoa');

router.get('/:id', PessoaController.getPessoaById);
router.post('/delete', PessoaController.delete);
router.post('/create', PessoaController.create);
router.patch('/update', PessoaController.update);
router.post('/login', PessoaController.login);

module.exports = router;