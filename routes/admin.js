const express = require('express');
const router = express.Router();
const db = require('../db');

// Ruta para mostrar la vista de administración de usuarios
router.get('/', (req, res) => {
    // Obtener usuarios de la base de datos
    db.query('SELECT * FROM usuarios', (err, result) => {
        if (err) {
            console.error(err);
            res.status(500).send('Error obteniendo usuarios');
            return;
        }

        // Renderizar la vista admin.ejs y pasar los usuarios como datos
        res.render('admin', { users: result });
    });
});


// Agregar un nuevo usuario
router.post('/add', (req, res) => {
    const { codigo,nombre, apellidos, email, password, rol } = req.body;
    const query = 'INSERT INTO usuarios (codigo,nombre, apellidos, email, password, rol) VALUES (?, ?, ?, ?, ?,?)';
    db.query(query, [codigo,nombre, apellidos, email, password, rol], (err, result) => {
        if (err) {
            console.error('Error al agregar usuario:', err);
            res.status(500).send('Error al agregar usuario');
            return;
        }
        res.redirect('/admin');
    });
});


// Eliminar un usuario
router.post('/delete/:id', (req, res) => {
    const { id } = req.params;
    const query = 'DELETE FROM usuarios WHERE id = ?';
    db.query(query, [id], (err, result) => {
        if (err) throw err;
    });
    res.redirect('/admin');

});



// Ruta para mostrar el formulario de edición de usuario
router.get('/edit/:id', (req, res) => {
    const { id } = req.params;
    const query = 'SELECT * FROM usuarios WHERE id = ?';
    db.query(query, [id], (err, result) => {
        if (err) {
            console.error(err);
            res.status(500).send('Error obteniendo usuario');
            return;
        }

      
        res.render('edit', { user: result[0] });
    });
});




// Editar un usuario
router.post('/edit/:id', (req, res) => {
    const { id } = req.params;
    const { nombre, apellidos, email, codigo, rol } = req.body;
    const query = 'UPDATE usuarios SET nombre = ?, apellidos = ?, email = ?, codigo = ?, rol = ? WHERE id = ?';
    db.query(query, [nombre, apellidos, email, codigo, rol, id], (err, result) => {
        if (err) throw err;
        res.redirect('/admin');
    });
});

module.exports = router;
