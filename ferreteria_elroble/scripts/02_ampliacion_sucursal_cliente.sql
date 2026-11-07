-- Ferretería "El Roble" - Ampliación 1: sucursales y clientes
-- Ejecutar DESPUÉS de 01_base.sql
-- Incluye datos pensados para practicar LEFT JOIN, IS NULL y COALESCE:
-- sucursal sin empleados, empleado sin ventas, cliente sin compras,
-- ventas sin cliente (NULL), productos nunca vendidos, categoría y proveedor sin productos.
USE ferreteria_elroble;

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
