# Guía 04 — Guía integradora

**Base requerida:** los tres scripts de `scripts/`.
**Estado:** ⏳ pendiente.

Mezcla todo lo visto: `INNER` y `LEFT JOIN`, `WHERE`/`HAVING`, agregaciones, `COALESCE`, `IS NULL`/`IS NOT NULL`, funciones de fecha y vistas.

## 🟢 Nivel básico

### Ejercicio 1: Pedidos pendientes
Muestra id de la compra, producto, proveedor, cantidad y fecha de pedido de las compras que aún no se reciben. Ordena por fecha de pedido.

| id | producto | proveedor | cantidad | fecha_pedido |
|---|---|---|---|---|
| 6 | Pintura Látex Interior 4GL | Cementos Melón S.A. | 6 | 2025-07-20 |
| 8 | Saco Cemento 25kg | Cementos Melón S.A. | 80 | 2025-08-10 |

### Ejercicio 2: Detalle de devoluciones
Muestra fecha de devolución, cliente, producto, cantidad devuelta y motivo. Ordena por fecha de devolución.

| fecha_devolucion | cliente | producto | cantidad | motivo |
|---|---|---|---|---|
| 2025-06-05 | María Antilef | Esmalte Sintético Blanco 1GL | 1 | Producto dañado |
| 2025-07-06 | Inmobiliaria Sur Austral SpA | Fierro Estriado 8mm x 6m | 5 | Exceso de pedido |
| 2025-07-18 | Constructora Los Alerces Ltda. | Taladro Percutor 650W | 1 | Falla de fábrica |

### Ejercicio 3: Vista de compras
Crea la vista `v_compras_detalle` con id de compra, producto, empleado que la recibió, cantidad, costo unitario, costo total (cantidad × costo unitario), fecha de pedido y fecha de recepción. Consúltala con `SELECT *`.

| id | producto | recibido_por | cantidad | costo_unitario | costo_total | fecha_pedido | fecha_recepcion |
|---|---|---|---|---|---|---|---|
| 1 | Taladro Percutor 650W | Ricardo Painemal | 10 | 32000.00 | 320000.00 | 2025-05-20 | 2025-05-27 |
| 2 | Saco Cemento 25kg | Ricardo Painemal | 100 | 3800.00 | 380000.00 | 2025-05-25 | 2025-05-28 |
| 3 | Sierra Circular 1200W | Ricardo Painemal | 5 | 49000.00 | 245000.00 | 2025-06-10 | 2025-06-24 |
| 4 | Fierro Estriado 8mm x 6m | Joaquín Catrilaf | 150 | 3100.00 | 465000.00 | 2025-06-12 | 2025-06-15 |
| 5 | Esmalte Sintético Blanco 1GL | Valentina Oyarzún | 20 | 10500.00 | 210000.00 | 2025-07-01 | 2025-07-09 |
| 6 | Pintura Látex Interior 4GL | Ricardo Painemal | 6 | 22000.00 | 132000.00 | 2025-07-20 | NULL |
| 7 | Destornillador Set 6 piezas | Joaquín Catrilaf | 30 | 5200.00 | 156000.00 | 2025-08-01 | 2025-08-04 |
| 8 | Saco Cemento 25kg | Ricardo Painemal | 80 | 3900.00 | 312000.00 | 2025-08-10 | NULL |

## 🟡 Nivel medio

### Ejercicio 4: Proveedores lentos
Muestra producto, proveedor, fecha de pedido, fecha de recepción y días de demora de las compras que tardaron más de 5 días. Ordena por demora descendente.

| producto | proveedor | fecha_pedido | fecha_recepcion | dias_demora |
|---|---|---|---|---|
| Sierra Circular 1200W | Comercial Bosch Chile Ltda. | 2025-06-10 | 2025-06-24 | 14 |
| Esmalte Sintético Blanco 1GL | Distribuidora Sodimac Pro | 2025-07-01 | 2025-07-09 | 8 |
| Taladro Percutor 650W | Comercial Bosch Chile Ltda. | 2025-05-20 | 2025-05-27 | 7 |

### Ejercicio 5: Compras por proveedor
Muestra todos los proveedores, incluidos los sin compras, con número de órdenes, unidades compradas y monto total comprado (0 si no hay). Ordena por monto descendente y luego por razón social.

| proveedor | num_ordenes | unidades | monto_comprado |
|---|---|---|---|
| Cementos Melón S.A. | 4 | 336 | 1289000.00 |
| Comercial Bosch Chile Ltda. | 2 | 15 | 565000.00 |
| Distribuidora Sodimac Pro | 2 | 50 | 366000.00 |
| Ferretería Mayorista del Sur | 0 | 0 | 0.00 |
| Importadora Stanley SPA | 0 | 0 | 0.00 |

### Ejercicio 6: Recepciones por empleado — `IS NOT NULL`
Por empleado que haya recibido mercadería: número de recepciones, unidades recibidas y fecha de la última recepción. Solo compras ya recibidas y solo empleados con 2 o más recepciones. Ordena por unidades descendente.

| empleado | num_recepciones | unidades_recibidas | ultima_recepcion |
|---|---|---|---|
| Joaquín Catrilaf | 2 | 180 | 2025-08-04 |
| Ricardo Painemal | 3 | 115 | 2025-06-24 |

## 🔴 Nivel avanzado

### Ejercicio 7: Unidades netas por producto
Por cada producto vendido: unidades vendidas, unidades devueltas (0 si no hubo) y unidades netas. Ordena por unidades netas descendente y luego por nombre.

| producto | unidades_vendidas | unidades_devueltas | unidades_netas |
|---|---|---|---|
| Fierro Estriado 8mm x 6m | 20 | 5 | 15 |
| Saco Cemento 25kg | 15 | 0 | 15 |
| Caja Tornillos Autorroscantes | 10 | 0 | 10 |
| Destornillador Set 6 piezas | 3 | 0 | 3 |
| Esmalte Sintético Blanco 1GL | 3 | 1 | 2 |
| Martillo Carpintero 16oz | 2 | 0 | 2 |
| Pintura Látex Interior 4GL | 2 | 0 | 2 |
| Taladro Percutor 650W | 3 | 1 | 2 |
| Sierra Circular 1200W | 1 | 0 | 1 |

### Ejercicio 8: Balance por sucursal
Todas las sucursales, incluida Valdivia, con número de ventas, venta bruta, monto devuelto (unidades devueltas × precio del producto) y venta neta. Sin movimiento = 0. Ordena por venta neta descendente.

| sucursal | num_ventas | venta_bruta | monto_devuelto | venta_neta |
|---|---|---|---|---|
| Casa Matriz | 8 | 336170.00 | 45990.00 | 290180.00 |
| Sucursal Puerto Montt | 5 | 239740.00 | 38940.00 | 200800.00 |
| Sucursal Valdivia | 0 | 0.00 | 0.00 | 0.00 |
