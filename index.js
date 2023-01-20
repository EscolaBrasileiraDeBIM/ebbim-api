const express = require('express');
const app = express();

const Email = require('./Models/Email');
const emailRoute = require('./Routes/router');

app.use(express.urlencoded({
    extended: true
}));

app.use(express.json());

app.use('/email', emailRoute);

app.listen(3000, () => {
    console.log("Conectado");
});