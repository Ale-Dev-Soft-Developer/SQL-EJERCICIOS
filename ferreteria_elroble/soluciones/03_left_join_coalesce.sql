-- =====================================================
-- Guía 03 — LEFT JOIN, IS NULL, COALESCE y fechas (soluciones)
-- Base requerida: scripts/01_base.sql + scripts/02_ampliacion_sucursal_cliente.sql
-- Las notas "CORRECCIÓN" explican errores que cometí y cómo se arreglaron.
--
-- Regla del ON: la FK (algo_id) se empareja con el id de la tabla a la que
-- apunta, con alias distintos a cada lado.
-- =====================================================
USE ferreteria_elroble;

-- 1. Sucursales y su personal (incluye sucursales sin empleados)
-- CORRECCIÓN 1: escribí ON empleado.sucursal_id = empleado.id
--   (ambos lados de la misma tabla). Debe conectar FK con PK de la otra tabla.
-- CORRECCIÓN 2: ORDER BY sucursal.nombre AND empleado.nombre no ordena nada:
--   AND evalúa una expresión lógica. Varias columnas se separan con coma.
SELECT
    sucursal.nombre AS sucursal,
    sucursal.ciudad AS ciudad,
    empleado.nombre AS empleado
FROM t_sucursal AS sucursal
LEFT JOIN t_empleado AS empleado
    ON empleado.sucursal_id = sucursal.id
ORDER BY sucursal.nombre, empleado.nombre;

-- 2. Ventas sin cliente
-- CORRECCIÓN: escribí ON empleado.sucursal_id = sucursal_id; sin alias,
--   MySQL lo leyó como empleado.sucursal_id = empleado.sucursal_id (siempre
--   verdadero) y cada venta se unió con todos los empleados (18 filas).
-- Además, aquí basta INNER JOIN: toda venta tiene empleado y producto.
SELECT
    venta.id AS id,
    venta.fecha_venta AS fecha_venta,
    empleado.nombre AS empleado,
    producto.nombre AS producto,
    venta.total AS total
FROM t_venta AS venta
INNER JOIN t_empleado AS empleado ON venta.empleado_id = empleado.id
INNER JOIN t_producto AS producto ON venta.producto_id = producto.id
WHERE venta.cliente_id IS NULL
ORDER BY venta.fecha_venta;

-- 3. Productos que nunca se vendieron
-- CORRECCIÓN 1: partí desde t_venta; un producto sin ventas no existe ahí.
--   Hay que partir de la tabla de la que se quieren conservar TODAS las filas.
-- CORRECCIÓN 2: usé venta.cliente_id IS NULL (ventas sin cliente).
--   "No existe ninguna venta" se detecta con la PK: venta.id IS NULL.
SELECT
    producto.nombre AS producto,
    categoria.nombre AS categoria,
    producto.precio AS precio
FROM t_producto AS producto
LEFT JOIN t_venta AS venta ON venta.producto_id = producto.id
INNER JOIN t_categoria AS categoria ON producto.categoria_id = categoria.id
WHERE venta.id IS NULL
ORDER BY producto.precio DESC;

-- 4. Ranking completo de empleados (correcta al primer intento)
-- COUNT(venta.id) ignora NULL -> 0; COUNT(*) habría dado 1.
-- COALESCE(SUM(...), 0) reemplaza el NULL de SUM por 0.
SELECT
    empleado.nombre AS empleado_nombre,
    COUNT(venta.id) AS num_ventas,
    COALESCE(SUM(venta.total), 0) AS total_vendido
FROM t_empleado AS empleado
LEFT JOIN t_venta AS venta ON empleado.id = venta.empleado_id
GROUP BY empleado.id, empleado.nombre
ORDER BY total_vendido DESC, empleado.nombre ASC;

-- 5. Ventas por mes y sucursal (correcta; mejoras de estilo aplicadas)
-- Mejoras: agrupar también por la PK (sucursal.id) y usar alias en
-- GROUP BY / ORDER BY para no repetir expresiones.
SELECT
    MONTH(venta.fecha_venta) AS mes,
    sucursal.nombre AS nombre_sucursal,
    COUNT(venta.id) AS num_ventas,
    SUM(venta.total) AS total_vendido
FROM t_venta AS venta
INNER JOIN t_empleado AS empleado ON venta.empleado_id = empleado.id
INNER JOIN t_sucursal AS sucursal ON empleado.sucursal_id = sucursal.id
GROUP BY mes, sucursal.id, nombre_sucursal
ORDER BY mes ASC, total_vendido DESC;

-- 6. Ficha de clientes
-- CORRECCIÓN 1: faltaba el ORDER BY pedido; sin él MySQL no garantiza orden.
-- CORRECCIÓN 2: MAX(fecha_venta) sin alias funciona, pero es riesgoso si otra
--   tabla unida tiene una columna con el mismo nombre. Siempre usar alias.
-- Nota: 'N/A' convierte esas columnas en texto (sirve para presentar,
--   pero ya no se puede calcular ni ordenar como fecha/número).
SELECT
    cliente.nombre AS nombre_cliente,
    cliente.tipo AS tipo_cliente,
    COUNT(venta.id) AS num_compras,
    COALESCE(SUM(venta.total), 0) AS total_comprado,
    COALESCE(MAX(venta.fecha_venta), 'N/A') AS ultima_compra,
    COALESCE(DATEDIFF('2025-08-31', MAX(venta.fecha_venta)), 'N/A') AS dias_sin_comprar
FROM t_cliente AS cliente
LEFT JOIN t_venta AS venta ON cliente.id = venta.cliente_id
GROUP BY cliente.id, cliente.nombre, cliente.tipo
ORDER BY total_comprado DESC;
