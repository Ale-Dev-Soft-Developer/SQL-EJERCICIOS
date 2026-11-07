-- Ferretería Industrial "El Roble"
-- Script de preparación del entorno
DROP DATABASE IF EXISTS ferreteria_elroble;
CREATE DATABASE ferreteria_elroble;
USE ferreteria_elroble;

CREATE TABLE t_categoria
 (
 id INT AUTO_INCREMENT PRIMARY KEY,
 nombre VARCHAR(50) NOT NULL,
 descripcion VARCHAR(200)
 );

CREATE TABLE t_proveedor
 (
 id INT AUTO_INCREMENT PRIMARY KEY,
 razon_social VARCHAR(100) NOT NULL,
 telefono VARCHAR(20),
 email VARCHAR(100),
 activo TINYINT(1) DEFAULT 1
 );

CREATE TABLE t_producto
 (
 id INT AUTO_INCREMENT PRIMARY KEY,
 nombre VARCHAR(100) NOT NULL,
 categoria_id INT,
 proveedor_id INT,
 precio DECIMAL(10,2) NOT NULL,
 stock INT DEFAULT 0,
 fecha_ingreso DATE
 );

CREATE TABLE t_empleado
 (
 id INT AUTO_INCREMENT PRIMARY KEY,
 nombre VARCHAR(100) NOT NULL,
 cargo VARCHAR(50),
 sueldo DECIMAL(10,2),
 fecha_contrato DATE
 );

CREATE TABLE t_venta
 (
 id INT AUTO_INCREMENT PRIMARY KEY,
 empleado_id INT,
 producto_id INT,
 cantidad INT NOT NULL,
 fecha_venta DATE,
 total DECIMAL(10,2)
 );

 INSERT INTO t_categoria (nombre, descripcion) VALUES
('Herramientas Manuales', 'Martillos, destornilladores, llaves'),
('Herramientas Eléctricas', 'Taladros, sierras, esmeriles'),
('Materiales de Construcción', 'Cemento, arena, fierros'),
('Pinturas y Barnices', 'Pinturas, esmaltes, diluyentes'),
('Ferretería General', 'Tornillos, clavos, pernos');
INSERT INTO t_proveedor (razon_social, telefono, email, activo) VALUES
('Comercial Bosch Chile Ltda.', '+56221234567', 'contacto@boschchile.cl', 1),
('Distribuidora Sodimac Pro', '+56229876543', 'ventas@sodimacpro.cl', 1),
('Importadora Stanley SPA', '+56225551234', 'info@stanleyspa.cl', 0),
('Cementos Melón S.A.', '+56227778888', 'contacto@cementosmelon.cl', 1);
INSERT INTO t_producto (nombre, categoria_id, proveedor_id, precio, stock, fecha_ingreso) VALUES
('Taladro Percutor 650W', 2, 1, 45990, 12, '2025-03-10'),
('Martillo Carpintero 16oz', 1, 2, 6990, 5, '2025-02-15'),
('Saco Cemento 25kg', 3, 4, 5490, 40, '2025-01-20'),
('Esmalte Sintético Blanco 1GL', 4, 2, 15990, 8, '2025-04-05'),
('Caja Tornillos Autorroscantes', 5, 3, 3990, 3, '2025-03-28'),
('Sierra Circular 1200W', 2, 1, 68990, 6, '2025-02-01'),
('Destornillador Set 6 piezas', 1, 2, 8990, 20, '2025-05-12'),
('Pintura Látex Interior 4GL', 4, 4, 32990, 2, '2025-01-30');

INSERT INTO t_empleado (nombre, cargo, sueldo, fecha_contrato) VALUES
('Marcelo Huenchullán', 'Vendedor', 520000, '2024-11-01'),
('Carla Yévenes', 'Vendedora', 520000, '2025-02-14'),
('Ricardo Painemal', 'Bodeguero', 480000, '2023-06-20'),
('Fernanda Sepúlveda', 'Jefa de Local', 850000, '2022-09-01');
INSERT INTO t_venta (empleado_id, producto_id, cantidad, fecha_venta, total) VALUES
(1, 1, 1, '2025-06-01', 45990),
(1, 3, 5, '2025-06-01', 27450),
(2, 4, 2, '2025-06-02', 31980),
(2, 6, 1, '2025-06-03', 68990),
(3, 5, 10, '2025-06-03', 39900),
(4, 7, 3, '2025-06-04', 26970),
(1, 8, 1, '2025-06-05', 32990),
(2, 2, 2, '2025-06-05', 13980);
