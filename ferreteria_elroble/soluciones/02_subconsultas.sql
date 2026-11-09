-- Ejercicio 1: Ventas por volumen
SELECT 
empleado.nombre AS nombre_empleado,
producto.nombre AS nombre_producto,
venta.cantidad AS cantidad_vendida,
venta.total AS total_vendido
FROM t_venta AS venta
INNER JOIN t_empleado AS empleado 
	ON venta.empleado_id = empleado.id
INNER JOIN t_producto AS producto 
	ON venta.producto_id = producto.id
WHERE venta.cantidad >= 2
ORDER BY venta.total DESC;


-- Ejercicio 2: Catálogo de proveedores activos
SELECT
producto.nombre AS nombre_producto,
categoria.nombre AS nombre_categoria,
proveedor.razon_social AS nombre_proveedor,
producto.precio AS precio
FROM t_producto AS producto
INNER JOIN t_categoria AS categoria
	ON producto.categoria_id = categoria.id
INNER JOIN t_proveedor AS proveedor 
	ON producto.proveedor_id = proveedor.id
WHERE proveedor.activo = 1 AND producto.precio > 10000
ORDER BY producto.precio ASC;

-- Ejercicio 3: Resumen por categoría — `AVG()`