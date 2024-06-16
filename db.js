const mysql = require('mysql');

const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'empleos'
});

db.connect((err) => {
    if (err) {
        console.log('Error de conexion a la base de datos', err);
    } else {
        console.log('Conectado a la base de datos');
    }
});

module.exports = db;
