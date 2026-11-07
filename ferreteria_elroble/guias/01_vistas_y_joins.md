# Guía 01 — Vistas y JOINs

**Base requerida:** solo `scripts/01_base.sql`.
**Solución:** [`soluciones/01_vistas_y_joins.sql`](../soluciones/01_vistas_y_joins.sql)

## Vistas simples

1. Cree una vista simple llamada `v_stock_critico` que muestre el id, nombre y stock de los productos con stock inferior a 10 unidades.
2. Cree una vista simple llamada `v_proveedores_activos` que muestre razón social, teléfono y email de los proveedores con `activo = 1`.
3. Cree una vista simple llamada `v_empleados_vendedores` que muestre id, nombre y fecha de contrato de los empleados cuyo cargo comience con `'Vendedor'`.
4. A través de la vista `v_stock_critico`, ejecute una sentencia `UPDATE` que incremente en 15 unidades el stock del producto con id = 5. Luego consulte `t_producto` directamente para verificar que el cambio se aplicó sobre la tabla base.

## Vistas complejas

1. Cree una vista llamada `v_detalle_ventas` que muestre, para cada venta, el nombre del empleado, el nombre del producto, la cantidad y el total, usando `INNER JOIN` entre `t_venta`, `t_empleado` y `t_producto`.
2. Cree una vista llamada `v_resumen_ventas_producto` que muestre, por cada producto, su nombre, su precio unitario, la cantidad total de unidades vendidas y la suma total facturada, usando funciones de grupo y `GROUP BY`.
3. Cree una vista llamada `v_catalogo_completo` que muestre el nombre del producto, el nombre de su categoría y la razón social de su proveedor, integrando `t_producto`, `t_categoria` y `t_proveedor`.

## Consultas con JOIN

1. Muestre el nombre del producto, su precio y el nombre de su categoría uniendo `t_producto` y `t_categoria`.
2. Muestre la fecha de la venta, la cantidad vendida y el nombre del empleado que realizó la venta, uniendo `t_venta` y `t_empleado`, solo para empleados con cargo `'Vendedor'` o `'Vendedora'`.
3. Muestre el nombre del producto, la razón social del proveedor y su estado (`activo`), uniendo `t_producto` y `t_proveedor`.
4. Muestre el nombre del producto, su categoría y la razón social del proveedor, uniendo las tres tablas. Solo productos de proveedores activos.
5. Muestre el nombre de cada empleado y el monto total recaudado por sus ventas (`SUM(total)`), agrupando por empleado.
6. Muestre la razón social del proveedor y el stock total de los productos que suministra (`SUM(stock)`). Use `HAVING` para mostrar solo proveedores con stock total superior a 10.
7. Muestre la fecha de venta, el empleado, el producto, la categoría del producto y la cantidad vendida, uniendo `t_venta`, `t_empleado`, `t_producto` y `t_categoria`.
8. Muestre la fecha de venta, el empleado, el proveedor, el producto, la categoría y el total facturado, uniendo las 5 tablas. Solo ventas desde el `'2025-06-03'`, ordenadas por fecha ascendente.
9. Muestre el nombre de la categoría, el número de ventas de esa categoría (`COUNT`) y su recaudación total (`SUM`), ordenado de mayor a menor recaudación.
