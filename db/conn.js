const mysql2 = require('mysql2/promise');

try {
    const pool = mysql2.createPool({
        connectionLimit: 10,
        host: '162.144.233.243',
        user: 'tilabc78_sistema',
        password: 'Qf{Q%4+$Yg49',
        database: 'tilabc78_sistema'
    });

    module.exports = pool;
} catch (err) {
    console.log(err);
}
