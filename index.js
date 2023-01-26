const express = require('express');
const app = express();

const emailRoute = require('./routes/Email');
const pessoaRoute = require('./routes/Pessoa');
const telefoneRoute = require('./routes/Telefone');

app.use(express.urlencoded({
    extended: true
}));

app.use(express.json());

app.use('/email', emailRoute);
app.use('/pessoa', pessoaRoute);
app.use('/telefone', telefoneRoute);

app.listen(3000, () => {
    console.log("Conectado");
});