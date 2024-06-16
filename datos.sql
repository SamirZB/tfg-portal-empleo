-- Base de datos: `empleos`
CREATE DATABASE IF NOT EXISTS `empleos` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `empleos`;
CREATE TABLE usuarios (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `codigo` VARCHAR(15) NOT NULL,
    `nombre` VARCHAR(100) NOT NULL,
    `apellidos` VARCHAR(100) NOT NULL,
    `email` VARCHAR(50) UNIQUE,
    `password` VARCHAR(20) UNIQUE,
    `rol`  VARCHAR(50) NOT NULL
);

INSERT INTO `usuarios`(`id`,`codigo`,`nombre`,`apellidos`,`email`,`password`,`rol`) VALUES  
    (1, 'ADM-01', 'admin', 'Gomez Sanchez', 'admin@lidl.com', '$2a$10$bJ6','admin'),
    (2, 'EMP-01', 'Juan David','Montoya Caceres','Juand15@lidl.com', '$2a$102510','emp'),
    (3, 'EMP-02', 'Jesus Francisco','Cordova Salazar','Jesusf11@lidl.com', '$2a$103452','emp'),
    (4, 'EMP-03', 'Jose Angel','Rivas Carvajal','Josea29@lidl.com', '$2a$145634','emp'),
    (5, 'EMP-04', 'Felipe Sandro','Mendoza Vargas','Felipes46@lidl.com', '$2a$144431','emp'),
    (6, 'EMP-05', 'Luis Raul','Lopez Becerra','Luisr33@lidl.com', '$2a$144521','emp');



CREATE TABLE ubicaciones (
    `id` INT PRIMARY KEY,
    `nombre` VARCHAR(30) NOT NULL
);

INSERT INTO `ubicaciones` (`id`, `nombre`) VALUES
 (1,'Alicante'),
 (2,'Barcelona'),
 (3,'Belmonte'),
 (4,'Bilbao'),
 (5,'Cuenca'),
 (6,'Santander'),
 (7,'Santiago de Compostela'),
 (8,'Madrid'),
 (9,'Zaragoza');



CREATE TABLE tiendas (
    `id` INT  PRIMARY KEY,
    `nombre` VARCHAR(50) NOT NULL,
    `id_ubicacion` INT NOT NULL,
    FOREIGN KEY (`id_ubicacion`) REFERENCES `ubicaciones`(`id`)
);


INSERT INTO `tiendas` (`id`, `nombre`, `id_ubicacion`) VALUES
(1,'Albericia',6),
(2 ,'Herrera Oria',6),
(3 ,'Peña Castillo',6),
(4,'Tienda Centro',8),
(5,'Vicente Berdusan',9),
(6,'Rua da Volta',7),
(7,'Telleria Kalea',4),
(8,'Gran Vía',2),
(9,'Av de la Aviacion',8),
(10,'Calle del Maestro Alonso',1),
(11,'R.de Eslovenia',7),
(12,'C.de Balbino Orensanz',9),
(13,'C/ Dr.Sapena',1),
(14,'Carrer de Casanova',2),
(15,'C.de Pedro Almodovar',5);



CREATE TABLE categorias (
    `id` INT  PRIMARY KEY,
    `nombre` VARCHAR(30) NOT NULL
);


INSERT INTO `categorias` (`id`, `nombre`) VALUES
(1,'Cajero/a Reponedor/a'),
(2,'Asistente de Tienda'),
(3,'Responsable de Turno'),
(4,'Jefe de Ventas'),
(5,'Gerente de Tienda');




CREATE TABLE jornadas (
    `id` INT  PRIMARY KEY,
    `nombre` VARCHAR(30) NOT NULL
);

INSERT INTO `jornadas` (`id`, `nombre`) VALUES
(1,'Tiempo completo'),
(2,'Tiempo parcial');




CREATE TABLE contratos (
     `id` INT  PRIMARY KEY,
    `nombre` VARCHAR(30) NOT NULL

);

INSERT INTO `contratos` (`id`, `nombre`) VALUES
(1,'Indefinido'),
(2,'Prácticas'),
(3,'Temporal');



CREATE TABLE empleos (
    `id` INT  PRIMARY KEY,
    `titulo` VARCHAR(30) NOT NULL, 
    `descripcion` TEXT NOT NULL,
    `categoria` INT NOT NULL,
    `ubicacion` INT NOT NULL,
    `tienda` INT NOT NULL,
    `jornada` INT NOT NULL,
    `tipo_contrato` INT NOT NULL,
    `fecha_publicacion`DATE NOT NULL,
    `id_admin` INT NOT NULL,
    FOREIGN KEY (`id_admin`) REFERENCES `usuarios`(`id`),
    FOREIGN KEY (`categoria`) REFERENCES `categorias`(`id`),
    FOREIGN KEY (`jornada`) REFERENCES `jornadas`(`id`),
    FOREIGN KEY (`tipo_contrato`) REFERENCES `contratos`(`id`),
    FOREIGN KEY (`tienda`) REFERENCES `tiendas`(`id`),
    FOREIGN KEY (`ubicacion`) REFERENCES `ubicaciones`(`id`)

);

INSERT INTO `empleos`(`id`,`titulo`,`descripcion`,`categoria`,`ubicacion`,`tienda`,`jornada`,`tipo_contrato`,`fecha_publicacion`,`id_admin`) VALUES  
(1, 'CAJERO/A - REPONEDOR/A 25HRS/SEM ALBERICIA', 'Tus tareas:\n- Cobrar en caja y atención al cliente.\n
- Gestionar la disponibilidad de los productos en la sala de ventas', 1, 6,3,2, 3, '2024-06-01',1 ),
(2, 'RESPONSABLE DE TURNO TIENDA 40HRS/SEM HERRERA ORIA','Tus tareas:\n- Preparar inventarios de tienda y realizar pedidos de mercancías con el 
objetivo de asegurar la disponibilidad de los artículos y ajustar las cantidades al consumo real, mediante las herramientas de apoyo.', 3,6, 2, 1, 1,'2024-06-02',1 ),
(3, 'RESPONSABLE DE TURNO TIENDA 40HRS/SEM HERRERA ORIA','Tus tareas:\n- Preparar inventarios de tienda y realizar pedidos de mercancías con el 
objetivo de asegurar la disponibilidad de los artículos y ajustar las cantidades al consumo real, mediante las herramientas de apoyo.', 3,6, 2, 1, 1, '2024-06-03',1 ),
(4, 'ASISTENTE DE TIENDA 20HRS/SEM MADRID', 'Tus tareas:\n- Reposición de productos en estantes.\n- Atención al cliente y caja.', 2, 8,4, 2, 3, '2024-06-01', 1 ),
(5, 'JEFE DE VENTAS ZARAGOZA', 'Tus tareas:\n- Coordinar el equipo de ventas.\n- Gestionar el stock y la exposición de productos.', 4, 9,5, 1, 1, '2024-06-01', 1 ),
(6, 'GERENTE DE TIENDA SANTIAGO', 'Tus tareas:\n- Gestión completa de la tienda.\n- Supervisar al equipo y alcanzar objetivos de ventas.', 5, 7,6, 1, 1, '2024-06-01', 1 ),
(7, 'CAJERO/A - REPONEDOR/A 20HRS/SEM BILBAO', 'Tus tareas:\n- Cobrar en caja y atención al cliente.\n- Gestionar la disponibilidad de los productos en la sala de ventas.', 1,4,7, 2, 3, '2024-06-04', 1),
(8, 'ASISTENTE DE TIENDA 30HRS/SEM BARCELONA', 'Tus tareas:\n- Reposición de productos en estantes.\n- Atención al cliente y caja.', 2, 2,8, 2, 3, '2024-06-04', 1),
(9, 'JEFE DE VENTAS MADRID', 'Tus tareas:\n- Coordinar el equipo de ventas.\n- Gestionar el stock y la exposición de productos.', 4, 8, 9, 1, 1, '2024-06-05', 1),
(10, 'GERENTE DE TIENDA ALICANTE', 'Tus tareas:\n- Gestión completa de la tienda.\n- Supervisar al equipo y alcanzar objetivos de ventas.', 5, 1, 10, 1, 1, '2024-06-05', 1),
(11, 'CAJERO/A - REPONEDOR/A 30HRS/SEM SANTIAGO', 'Tus tareas:\n- Cobrar en caja y atención al cliente.\n- Gestionar la disponibilidad de los productos en la sala de ventas.', 1,7,11, 2, 3, '2024-06-06', 1),
(12, 'ASISTENTE DE TIENDA 25HRS/SEM ZARAGOZA', 'Tus tareas:\n- Reposición de productos en estantes.\n- Atención al cliente y caja.', 2, 9,12, 2, 3, '2024-06-06', 1),
(13, 'RESPONSABLE DE TURNO TIENDA 40HRS/SEM ALICANTE', 'Tus tareas:\n- Preparar inventarios de tienda y realizar pedidos de mercancías con el objetivo de asegurar la disponibilidad de los artículos y ajustar las cantidades al consumo real, mediante las herramientas de apoyo.', 3,1,13, 1, 1, '2024-06-07', 1),
(14, 'JEFE DE VENTAS SANTANDER', 'Tus tareas:\n- Coordinar el equipo de ventas.\n- Gestionar el stock y la exposición de productos.', 4, 6,3, 1, 1, '2024-06-07', 1),
(15, 'GERENTE DE TIENDA BARCELONA', 'Tus tareas:\n- Gestión completa de la tienda.\n- Supervisar al equipo y alcanzar objetivos de ventas.', 5, 2, 12, 1, 1, '2024-06-08', 1),
(16, 'CAJERO/A - REPONEDOR/A 25HRS/SEM CUENCA', 'Tus tareas:\n- Cobrar en caja y atención al cliente.\n- Gestionar la disponibilidad de los productos en la sala de ventas.', 1, 5,13, 2, 3, '2024-06-08', 1);


CREATE TABLE postulaciones (
    `id` INT  PRIMARY KEY,
    `id_usuario` INT NOT NULL,
    `id_empleo` INT NOT NULL,
    `fecha_postulacion`  DATE NOT NULL,
    FOREIGN KEY (`id_usuario`) REFERENCES `usuarios`(`id`),
    FOREIGN KEY (`id_empleo`) REFERENCES `empleos`(`id`)
);

INSERT INTO `postulaciones` (`id` ,`id_usuario`, `id_empleo`,`fecha_postulacion`) VALUES
(1, 5, 2, '2024-06-01'),
(2, 4, 1, '2024-06-02'),
(3, 6, 3, '2024-06-03');

