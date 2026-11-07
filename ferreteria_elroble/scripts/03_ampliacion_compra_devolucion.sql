-- Ferretería "El Roble" - Ampliación 2: compras a proveedores y devoluciones
-- Ejecutar DESPUÉS de 02_ampliacion_sucursal_cliente.sql
USE ferreteria_elroble;

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
