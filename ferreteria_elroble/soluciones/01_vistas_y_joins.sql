-- =====================================================
-- Guía 01 — Vistas y JOINs (soluciones)
-- Base requerida: scripts/01_base.sql
-- Las notas "CORRECCIÓN" explican errores que cometí y cómo se arreglaron.
-- =====================================================
USE ferreteria_elroble;

-- ===================== VISTAS SIMPLES =====================

-- 1. v_stock_critico: productos con stock inferior a 10
CREATE VIEW v_stock_critico AS
SELECT id, nombre, stock
FROM t_producto
WHERE stock < 10;

SELECT * FROM v_stock_critico;

-- 2. v_proveedores_activos
CREATE VIEW v_proveedores_activos AS
SELECT razon_social, telefono, email
FROM t_proveedor
WHERE activo = 1;

SELECT * FROM v_proveedores_activos;

-- 3. v_empleados_vendedores: cargo que COMIENZA con 'Vendedor'
-- CORRECCIÓN: usé LIKE '%Vendedor%', que también aceptaría
-- "Supervisor de Vendedores". "Comienza con" se escribe 'Vendedor%'.
CREATE VIEW v_empleados_vendedores AS
SELECT id, nombre, fecha_contrato
FROM t_empleado
WHERE cargo LIKE 'Vendedor%';

SELECT * FROM v_empleados_vendedores;

-- 4. UPDATE a través de la vista: +15 de stock al producto id = 5
SELECT id, nombre, stock FROM t_producto WHERE id = 5;

-- CORRECCIÓN: primero ejecuté el UPDATE SIN WHERE:
--     UPDATE v_stock_critico SET stock = stock + 15;
-- No afectó a todos los productos, solo a los visibles en la vista
-- (stock < 10: ids 2, 4, 5, 6 y 8).
-- Después de eso el producto 5 quedó con stock 18 y SALIÓ de la vista,
-- así que el UPDATE correcto (con WHERE id = 5) afectó 0 filas:
-- una vista solo puede modificar las filas que ella misma ve.
-- Para deshacer el error resté 15 a los productos que no correspondían:
--     UPDATE t_producto SET stock = stock - 15 WHERE id IN (2, 4, 6, 8);

-- Forma correcta (sobre la base original):
UPDATE v_stock_critico
SET stock = stock + 15
WHERE id = 5;

SELECT * FROM t_producto;


-- ===================== VISTAS COMPLEJAS =====================

-- 1. v_detalle_ventas
CREATE VIEW v_detalle_ventas AS
SELECT
    empleado.nombre AS nombre_vendedor,
    producto.nombre AS nombre_producto,
    venta.cantidad,
    venta.total
FROM t_venta AS venta
INNER JOIN t_empleado AS empleado ON venta.empleado_id = empleado.id
INNER JOIN t_producto AS producto ON venta.producto_id = producto.id;

SELECT * FROM v_detalle_ventas;

-- 2. v_resumen_ventas_producto
CREATE VIEW v_resumen_ventas_producto AS
SELECT
    producto.nombre AS nombre_producto,
    producto.precio AS precio_producto,
    SUM(venta.cantidad) AS cantidad_total_vendida,
    SUM(venta.total) AS total_facturado
FROM t_venta AS venta
INNER JOIN t_producto AS producto ON venta.producto_id = producto.id
GROUP BY producto.id, producto.nombre, producto.precio;

SELECT * FROM v_resumen_ventas_producto;

-- 3. v_catalogo_completo
CREATE VIEW v_catalogo_completo AS
SELECT
    producto.nombre AS nombre_producto,
    categoria.nombre AS nombre_categoria,
    proveedor.razon_social AS nombre_empresa
FROM t_producto AS producto
INNER JOIN t_categoria AS categoria ON producto.categoria_id = categoria.id
INNER JOIN t_proveedor AS proveedor ON producto.proveedor_id = proveedor.id;

SELECT * FROM v_catalogo_completo;


-- ===================== CONSULTAS CON JOIN =====================

-- 1. Producto, precio y categoría
SELECT
    producto.nombre AS nombre_producto,
    producto.precio AS precio,
    categoria.nombre AS nombre_categoria
FROM t_producto AS producto
INNER JOIN t_categoria AS categoria ON producto.categoria_id = categoria.id;

-- 2. Ventas de vendedores/as
SELECT
    venta.fecha_venta AS fecha_venta,
    venta.cantidad AS cantidad_vendida,
    empleado.nombre AS nombre_empleado
FROM t_venta AS venta
INNER JOIN t_empleado AS empleado ON venta.empleado_id = empleado.id
WHERE empleado.cargo IN ('Vendedor', 'Vendedora');
-- Equivalente: WHERE empleado.cargo = 'Vendedor' OR empleado.cargo = 'Vendedora'

-- 3. Producto, proveedor y estado
SELECT
    producto.nombre AS nombre_producto,
    proveedor.razon_social AS nombre_empresa,
    proveedor.activo AS activo
FROM t_producto AS producto
INNER JOIN t_proveedor AS proveedor ON producto.proveedor_id = proveedor.id;

-- 4. Catálogo de proveedores activos
SELECT
    producto.nombre AS nombre_producto,
    categoria.nombre AS nombre_categoria,
    proveedor.razon_social AS nombre_empresa
FROM t_producto AS producto
INNER JOIN t_categoria AS categoria ON producto.categoria_id = categoria.id
INNER JOIN t_proveedor AS proveedor ON producto.proveedor_id = proveedor.id
WHERE proveedor.activo = 1;

-- 5. Total recaudado por empleado
-- CORRECCIÓN: por error había pegado la consulta de proveedores/stock.
SELECT
    empleado.nombre AS nombre_empleado,
    SUM(venta.total) AS total_recaudado
FROM t_venta AS venta
INNER JOIN t_empleado AS empleado ON venta.empleado_id = empleado.id
GROUP BY empleado.id, empleado.nombre;

-- 6. Stock total por proveedor con HAVING
-- CORRECCIÓN: agrupé por producto.id, lo que crea un grupo por PRODUCTO
-- y hace que HAVING filtre productos en vez de proveedores.
-- Regla: se agrupa por la entidad del reporte -> "por proveedor" = GROUP BY proveedor.id
SELECT
    proveedor.razon_social AS nombre_empresa,
    SUM(producto.stock) AS stock_total
FROM t_producto AS producto
INNER JOIN t_proveedor AS proveedor ON producto.proveedor_id = proveedor.id
GROUP BY proveedor.id, proveedor.razon_social
HAVING SUM(producto.stock) > 10;
-- HAVING filtra grupos DESPUÉS del GROUP BY; se usa con funciones de agregación.

-- 7. Reporte de ventas con categoría (4 tablas)
SELECT
    venta.fecha_venta AS fecha_venta,
    empleado.nombre AS nombre_empleado,
    producto.nombre AS nombre_producto,
    categoria.nombre AS nombre_categoria,
    venta.cantidad AS cantidad
FROM t_venta AS venta
INNER JOIN t_producto AS producto ON venta.producto_id = producto.id
INNER JOIN t_empleado AS empleado ON venta.empleado_id = empleado.id
INNER JOIN t_categoria AS categoria ON producto.categoria_id = categoria.id;

-- 8. Las 5 tablas, ventas desde el 2025-06-03
SELECT
    venta.fecha_venta AS fecha_venta,
    empleado.nombre AS nombre_empleado,
    proveedor.razon_social AS nombre_empresa,
    producto.nombre AS nombre_producto,
    categoria.nombre AS nombre_categoria,
    venta.total AS total_facturado
FROM t_venta AS venta
INNER JOIN t_empleado AS empleado ON venta.empleado_id = empleado.id
INNER JOIN t_producto AS producto ON venta.producto_id = producto.id
INNER JOIN t_proveedor AS proveedor ON producto.proveedor_id = proveedor.id
INNER JOIN t_categoria AS categoria ON producto.categoria_id = categoria.id
WHERE venta.fecha_venta >= '2025-06-03'
ORDER BY venta.fecha_venta ASC;

-- 9. Ventas y recaudación por categoría
SELECT
    categoria.nombre AS nombre_categoria,
    COUNT(venta.id) AS cantidad_ventas,
    SUM(venta.total) AS recaudacion_total
FROM t_venta AS venta
INNER JOIN t_producto AS producto ON venta.producto_id = producto.id
INNER JOIN t_categoria AS categoria ON producto.categoria_id = categoria.id
GROUP BY categoria.id, categoria.nombre
ORDER BY recaudacion_total DESC;
