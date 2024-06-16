const express = require('express');
const router = express.Router();
const db = require('../db');


/*Extrae los parámetros de consulta como ubicacion, categoria, tienda, jornada y contrato del objeto req.query
estos parámetros se utilizan para filtrar la búsqueda de empleos en la base de datos. */
router.get('/', (req, res) => {
    const { ubicacion, categoria, tienda, jornada, contrato } = req.query;

    let query = `
        SELECT 
            empleos.*, 
            categorias.nombre AS categoria_nombre,
            jornadas.nombre AS jornada_nombre,
            contratos.nombre AS contrato_nombre,
            ubicaciones.nombre AS ubicacion_nombre,
            tiendas.nombre AS tienda_nombre
        FROM empleos 
        JOIN categorias ON empleos.categoria = categorias.id
        JOIN jornadas ON empleos.jornada = jornadas.id
        JOIN contratos ON empleos.tipo_contrato = contratos.id
        JOIN ubicaciones ON empleos.ubicacion = ubicaciones.id
        JOIN tiendas ON empleos.tienda = tiendas.id
    `;

    let filters = [];
    if (ubicacion) filters.push(`empleos.ubicacion = ${db.escape(ubicacion)}`);
    if (categoria) filters.push(`empleos.categoria = ${db.escape(categoria)}`);
    if (tienda) filters.push(`empleos.tienda = ${db.escape(tienda)}`);
    if (jornada) filters.push(`empleos.jornada = ${db.escape(jornada)}`);
    if (contrato) filters.push(`empleos.tipo_contrato = ${db.escape(contrato)}`);

    if (filters.length > 0) {
        query += " WHERE " + filters.join(" AND ");
    }

    db.query(query, (err, empleos) => {
        if (err) {
            return res.send(err);
        } else {
            db.query('SELECT * FROM ubicaciones', (error, ubicaciones) => {
                if (error) {
                    console.error('Error al obtener ubicaciones:', error);
                    return res.status(500).send('Error interno del servidor');
                }
                db.query('SELECT * FROM tiendas', (error, tiendas) => {
                    if (error) {
                        console.error('Error al obtener tiendas:', error);
                        return res.status(500).send('Error interno del servidor');
                    }
                    db.query('SELECT * FROM categorias', (error, categorias) => {
                        if (error) {
                            console.error('Error al obtener categorías:', error);
                            return res.status(500).send('Error interno del servidor');
                        }
                        db.query('SELECT * FROM jornadas', (error, jornadas) => {
                            if (error) {
                                console.error('Error al obtener jornadas:', error);
                                return res.status(500).send('Error interno del servidor');
                            }
                            db.query('SELECT * FROM contratos', (error, contratos) => {
                                if (error) {
                                    console.error('Error al obtener contratos:', error);
                                    return res.status(500).send('Error interno del servidor');
                                }
                                res.render('index', { empleos, categorias, ubicaciones, tiendas, jornadas, contratos,query: req.query });

                               
                            });
                        });
                    });
                });
            });
        }
    });
});




module.exports = router;
