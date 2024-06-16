const express = require('express');
const mysql = require('mysql');
const bodyParser = require('body-parser');
const path = require('path');
const db = require('./db');  

const app = express();

// Middleware
app.use(bodyParser.urlencoded({ extended: true }));

// Motor de vistas
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));

// Archivos estáticos
app.use(express.static(path.join(__dirname, 'public')));

// Rutas
app.use('/', require('./routes/index'));
app.use('/auth', require('./routes/auth'));
app.use('/admin', require('./routes/admin'));


// Ruta para manejar la lógica de inicio de sesión
app.post('/login', (req, res) => {
    const { email, password } = req.body;
    const query = 'SELECT * FROM usuarios WHERE email = ? AND password = ? AND rol = ?';
    db.query(query, [email, password, 'admin'], (err, results) => {
        if (err) throw err;
        if (results.length > 0) {
    // Redirige al panel de administración
            res.redirect('/admin'); 
        } else {
            res.send('Correo o contraseña incorrectos');
        }
    });
});

// Iniciar el servidor
const PORT = process.env.PORT || 3001;
app.listen(PORT, () => {
    console.log(`Servidor corriendo en el puerto ${PORT}`);
});
