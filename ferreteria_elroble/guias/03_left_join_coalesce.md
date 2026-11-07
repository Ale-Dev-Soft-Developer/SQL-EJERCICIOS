# Guía 03 — LEFT JOIN, IS NULL, COALESCE y fechas

**Base requerida:** `scripts/01_base.sql` + `scripts/02_ampliacion_sucursal_cliente.sql`.
**Solución:** [`soluciones/03_left_join_coalesce.sql`](../soluciones/03_left_join_coalesce.sql)

## Resumen de `LEFT JOIN`

- `INNER JOIN` devuelve solo las filas con pareja en ambas tablas.
- `LEFT JOIN` devuelve **todas** las filas de la tabla del `FROM`; si no hay pareja, las columnas de la derecha quedan en `NULL`.
- Para encontrar "los que no tienen": `LEFT JOIN` + `WHERE tabla_derecha.id IS NULL`.
- Para contar con ceros: `COUNT(tabla_derecha.id)` (no `COUNT(*)`) y `COALESCE(SUM(...), 0)`.
- Errores comunes: invertir el orden de las tablas, filtrar la tabla derecha en el `WHERE`, y encadenar un `INNER JOIN` después de un `LEFT JOIN`.

## 🟢 Nivel básico

### Ejercicio 1: Sucursales y su personal
Lista todas las sucursales con su ciudad y cada empleado asignado, incluidas las sucursales sin empleados. Ordena por sucursal y empleado.

| sucursal | ciudad | empleado |
|---|---|---|
| Casa Matriz | Osorno | Fernanda Sepúlveda |
| Casa Matriz | Osorno | Marcelo Huenchullán |
| Casa Matriz | Osorno | Ricardo Painemal |
| Sucursal Puerto Montt | Puerto Montt | Carla Yévenes |
| Sucursal Puerto Montt | Puerto Montt | Joaquín Catrilaf |
| Sucursal Puerto Montt | Puerto Montt | Valentina Oyarzún |
| Sucursal Valdivia | Valdivia | NULL |

### Ejercicio 2: Ventas sin cliente
Muestra id, fecha, empleado, producto y total de las ventas sin cliente registrado. Ordena por fecha.

| id | fecha_venta | empleado | producto | total |
|---|---|---|---|---|
| 6 | 2025-06-04 | Fernanda Sepúlveda | Destornillador Set 6 piezas | 26970.00 |
| 8 | 2025-06-05 | Carla Yévenes | Martillo Carpintero 16oz | 13980.00 |
| 12 | 2025-08-02 | Carla Yévenes | Pintura Látex Interior 4GL | 32990.00 |

## 🟡 Nivel medio

### Ejercicio 3: Productos que nunca se vendieron
Muestra nombre, categoría y precio de los productos que no aparecen en ninguna venta. Ordena por precio descendente.

| producto | categoria | precio |
|---|---|---|
| Esmeril Angular 115mm | Herramientas Eléctricas | 39990.00 |
| Diluyente Duco 1L | Pinturas y Barnices | 4290.00 |

### Ejercicio 4: Ranking completo de empleados
Muestra todos los empleados, incluidos los que no han vendido, con número de ventas y total vendido (0 en vez de `NULL`). Ordena por total descendente y luego por nombre.

| empleado | num_ventas | total_vendido |
|---|---|---|
| Carla Yévenes | 5 | 239740.00 |
| Marcelo Huenchullán | 5 | 214400.00 |
| Fernanda Sepúlveda | 2 | 81870.00 |
| Ricardo Painemal | 1 | 39900.00 |
| Joaquín Catrilaf | 0 | 0.00 |
| Valentina Oyarzún | 0 | 0.00 |

## 🔴 Nivel avanzado

### Ejercicio 5: Ventas por mes y sucursal — `MONTH()`
Muestra mes, sucursal, número de ventas y total vendido, agrupando por mes y sucursal. Ordena por mes ascendente y total descendente.

| mes | sucursal | num_ventas | total_vendido |
|---|---|---|---|
| 6 | Casa Matriz | 5 | 173300.00 |
| 6 | Sucursal Puerto Montt | 3 | 114950.00 |
| 7 | Casa Matriz | 2 | 146880.00 |
| 7 | Sucursal Puerto Montt | 1 | 91800.00 |
| 8 | Sucursal Puerto Montt | 1 | 32990.00 |
| 8 | Casa Matriz | 1 | 15990.00 |

### Ejercicio 6: Ficha de clientes — `MAX()` + `DATEDIFF()`
Por cada cliente, incluidos los que no han comprado: nombre, tipo, número de compras, total comprado (0 si no compró), fecha de la última compra y días sin comprar hasta el `'2025-08-31'`. Ordena por total descendente.

| cliente | tipo | num_compras | total_comprado | ultima_compra | dias_sin_comprar |
|---|---|---|---|---|---|
| Constructora Los Alerces Ltda. | Empresa | 4 | 214230.00 | 2025-07-15 | 47 |
| Inmobiliaria Sur Austral SpA | Empresa | 2 | 160790.00 | 2025-07-03 | 59 |
| Juan Carrasco | Particular | 2 | 78980.00 | 2025-06-05 | 87 |
| María Antilef | Particular | 2 | 47970.00 | 2025-08-05 | 26 |
| Pedro Vidal | Particular | 0 | 0.00 | NULL | NULL |
