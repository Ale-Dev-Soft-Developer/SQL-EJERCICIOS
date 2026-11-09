-- =====================================================
-- Ferretería "El Roble" — REINICIO COMPLETO
-- Borra la base y la recrea con: base + ampliación 1 + ampliación 2
-- Ejecutar completo (rayo sin cursor / Cmd+Shift+Enter)
-- =====================================================

-- ################ PARTE 1: BASE ORIGINAL ################
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


-- ################ PARTE 2: AMPLIACIÓN 1 ################
-- Ferretería "El Roble" - Ampliación 1: sucursales y clientes
-- Ejecutar DESPUÉS de 01_base.sql
-- Incluye datos pensados para practicar LEFT JOIN, IS NULL y COALESCE:
-- sucursal sin empleados, empleado sin ventas, cliente sin compras,
-- ventas sin cliente (NULL), productos nunca vendidos, categoría y proveedor sin productos.

-- ===== NUEVAS TABLAS =====
CREATE TABLE t_sucursal (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    ciudad VARCHAR(50) NOT NULL
);

CREATE TABLE t_cliente (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    tipo VARCHAR(20) NOT NULL,          -- 'Particular' o 'Empresa'
    ciudad VARCHAR(50),
    fecha_registro DATE
);

INSERT INTO t_sucursal (nombre, ciudad) VALUES
('Casa Matriz', 'Osorno'),
('Sucursal Puerto Montt', 'Puerto Montt'),
('Sucursal Valdivia', 'Valdivia');

INSERT INTO t_cliente (nombre, tipo, ciudad, fecha_registro) VALUES
('Constructora Los Alerces Ltda.', 'Empresa', 'Osorno', '2024-05-10'),
('Juan Carrasco', 'Particular', 'Osorno', '2025-01-15'),
('María Antilef', 'Particular', 'Puerto Montt', '2025-03-02'),
('Inmobiliaria Sur Austral SpA', 'Empresa', 'Puerto Montt', '2024-11-20'),
('Pedro Vidal', 'Particular', 'Valdivia', '2025-06-18');

-- ===== NUEVAS COLUMNAS + CLAVES FORÁNEAS =====
ALTER TABLE t_empleado
    ADD sucursal_id INT,
    ADD CONSTRAINT fk_empleado_sucursal FOREIGN KEY (sucursal_id) REFERENCES t_sucursal(id);

ALTER TABLE t_venta
    ADD cliente_id INT NULL,
    ADD CONSTRAINT fk_venta_cliente FOREIGN KEY (cliente_id) REFERENCES t_cliente(id);

-- Asignar sucursal a empleados existentes
UPDATE t_empleado SET sucursal_id = 1 WHERE id IN (1, 3, 4);
UPDATE t_empleado SET sucursal_id = 2 WHERE id = 2;

-- Asignar cliente a ventas existentes (ventas 6 y 8 quedan sin cliente = NULL)
UPDATE t_venta SET cliente_id = 1 WHERE id IN (2, 5);
UPDATE t_venta SET cliente_id = 2 WHERE id IN (1, 7);
UPDATE t_venta SET cliente_id = 3 WHERE id = 3;
UPDATE t_venta SET cliente_id = 4 WHERE id = 4;

-- ===== DATOS NUEVOS EN TABLAS EXISTENTES =====
INSERT INTO t_categoria (nombre, descripcion) VALUES
('Jardinería', 'Mangueras, palas, tijeras de podar');           -- sin productos

INSERT INTO t_proveedor (razon_social, telefono, email, activo) VALUES
('Ferretería Mayorista del Sur', NULL, 'ventas@mayoristasur.cl', 1);  -- sin productos

INSERT INTO t_empleado (nombre, cargo, sueldo, fecha_contrato, sucursal_id) VALUES
('Joaquín Catrilaf', 'Vendedor', 520000, '2025-07-01', 2),     -- sin ventas
('Valentina Oyarzún', 'Cajera', NULL, '2025-08-01', 2);        -- sueldo NULL

INSERT INTO t_producto (nombre, categoria_id, proveedor_id, precio, stock, fecha_ingreso) VALUES
('Esmeril Angular 115mm', 2, 1, 39990, 7, '2025-07-15'),       -- nunca vendido
('Fierro Estriado 8mm x 6m', 3, 4, 4590, 100, '2025-06-20'),
('Diluyente Duco 1L', 4, 2, 4290, 15, '2025-07-02');           -- nunca vendido

INSERT INTO t_venta (empleado_id, producto_id, cantidad, fecha_venta, total, cliente_id) VALUES
(2, 10, 20, '2025-07-03', 91800, 4),
(1, 1, 2, '2025-07-10', 91980, 1),
(4, 3, 10, '2025-07-15', 54900, 1),
(2, 8, 1, '2025-08-02', 32990, NULL),
(1, 4, 1, '2025-08-05', 15990, 3);

-- ################ PARTE 3: AMPLIACIÓN 2 ################
-- Ferretería "El Roble" - Ampliación 2: compras a proveedores y devoluciones
-- Ejecutar DESPUÉS de 02_ampliacion_sucursal_cliente.sql

CREATE TABLE t_compra (
    id INT AUTO_INCREMENT PRIMARY KEY,
    producto_id INT NOT NULL,
    empleado_id INT NOT NULL,              -- quién recibe la mercadería
    cantidad INT NOT NULL,
    costo_unitario DECIMAL(10,2) NOT NULL, -- lo que pagó la ferretería
    fecha_pedido DATE NOT NULL,
    fecha_recepcion DATE NULL,             -- NULL = pedido pendiente
    CONSTRAINT fk_compra_producto FOREIGN KEY (producto_id) REFERENCES t_producto(id),
    CONSTRAINT fk_compra_empleado FOREIGN KEY (empleado_id) REFERENCES t_empleado(id)
);

CREATE TABLE t_devolucion (
    id INT AUTO_INCREMENT PRIMARY KEY,
    venta_id INT NOT NULL,
    cantidad INT NOT NULL,
    motivo VARCHAR(100),
    fecha_devolucion DATE NOT NULL,
    CONSTRAINT fk_devolucion_venta FOREIGN KEY (venta_id) REFERENCES t_venta(id)
);

INSERT INTO t_compra (producto_id, empleado_id, cantidad, costo_unitario, fecha_pedido, fecha_recepcion) VALUES
(1, 3, 10, 32000, '2025-05-20', '2025-05-27'),
(3, 3, 100, 3800, '2025-05-25', '2025-05-28'),
(6, 3, 5, 49000, '2025-06-10', '2025-06-24'),
(10, 5, 150, 3100, '2025-06-12', '2025-06-15'),
(4, 6, 20, 10500, '2025-07-01', '2025-07-09'),
(8, 3, 6, 22000, '2025-07-20', NULL),
(7, 5, 30, 5200, '2025-08-01', '2025-08-04'),
(3, 3, 80, 3900, '2025-08-10', NULL);

INSERT INTO t_devolucion (venta_id, cantidad, motivo, fecha_devolucion) VALUES
(3, 1, 'Producto dañado', '2025-06-05'),
(10, 1, 'Falla de fábrica', '2025-07-18'),
(9, 5, 'Exceso de pedido', '2025-07-06');