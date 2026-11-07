# Guía 02 — Agregaciones, subconsultas y CASE

**Base requerida:** solo `scripts/01_base.sql` (sin ampliaciones). Con las ampliaciones, los resultados esperados cambian.
**Estado:** ⏳ pendiente.

## 🟢 Nivel básico

### Ejercicio 1: Ventas por volumen
Muestra el nombre del empleado, el nombre del producto, la cantidad y el total de las ventas donde se vendieron 2 o más unidades. Ordena por total de mayor a menor.

| empleado | producto | cantidad | total |
|---|---|---|---|
| Ricardo Painemal | Caja Tornillos Autorroscantes | 10 | 39900.00 |
| Carla Yévenes | Esmalte Sintético Blanco 1GL | 2 | 31980.00 |
| Marcelo Huenchullán | Saco Cemento 25kg | 5 | 27450.00 |
| Fernanda Sepúlveda | Destornillador Set 6 piezas | 3 | 26970.00 |
| Carla Yévenes | Martillo Carpintero 16oz | 2 | 13980.00 |

### Ejercicio 2: Catálogo de proveedores activos
Lista el producto, su categoría, su proveedor y su precio, solo para productos de proveedores activos con precio mayor a $10.000. Ordena por precio ascendente.

| producto | categoria | proveedor | precio |
|---|---|---|---|
| Esmalte Sintético Blanco 1GL | Pinturas y Barnices | Distribuidora Sodimac Pro | 15990.00 |
| Pintura Látex Interior 4GL | Pinturas y Barnices | Cementos Melón S.A. | 32990.00 |
| Taladro Percutor 650W | Herramientas Eléctricas | Comercial Bosch Chile Ltda. | 45990.00 |
| Sierra Circular 1200W | Herramientas Eléctricas | Comercial Bosch Chile Ltda. | 68990.00 |

## 🟡 Nivel medio

### Ejercicio 3: Resumen por categoría — `AVG()`
Por cada categoría, muestra la cantidad de productos, el stock total y el precio promedio redondeado a 0 decimales con `ROUND()`. Solo categorías con 2 o más productos. Ordena por precio promedio descendente.

| categoria | cant_productos | stock_total | precio_promedio |
|---|---|---|---|
| Herramientas Eléctricas | 2 | 18 | 57490 |
| Pinturas y Barnices | 2 | 10 | 24490 |
| Herramientas Manuales | 2 | 25 | 7990 |

> Nota: `stock_total` asume el stock original. Si ejecutaste el `UPDATE` de la guía 01 puede variar.

### Ejercicio 4: Rendimiento de la primera semana — `MAX()`
Por empleado, muestra el número de ventas, el total vendido y la venta más alta, considerando solo ventas entre el 1 y el 4 de junio de 2025 (inclusive). Solo quienes vendieron más de $40.000 en ese periodo. Ordena por total descendente.

| empleado | num_ventas | total_vendido | venta_maxima |
|---|---|---|---|
| Carla Yévenes | 2 | 100970.00 | 68990.00 |
| Marcelo Huenchullán | 2 | 73440.00 | 45990.00 |

## 🔴 Nivel avanzado

### Ejercicio 5: Productos sobre el promedio — subconsulta
Muestra nombre, categoría y precio de los productos cuyo precio supera el precio promedio de todos los productos. Agrega una columna `promedio_general` con ese promedio redondeado a 1 decimal. Ordena por precio descendente.

| producto | categoria | precio | promedio_general |
|---|---|---|---|
| Sierra Circular 1200W | Herramientas Eléctricas | 68990.00 | 23677.5 |
| Taladro Percutor 650W | Herramientas Eléctricas | 45990.00 | 23677.5 |
| Pintura Látex Interior 4GL | Pinturas y Barnices | 32990.00 | 23677.5 |

### Ejercicio 6: Clasificación de proveedores — `CASE`
Por proveedor, muestra el número de ventas, las unidades vendidas y el total vendido. Agrega una columna `nivel`: `'Alto'` si el total es ≥ 100.000, `'Medio'` si es ≥ 60.000, `'Bajo'` en otro caso. Solo proveedores cuyo total supere 1,5 veces el total promedio por venta (calculado con subconsulta sobre `t_venta`). Ordena por total descendente.

| proveedor | num_ventas | unidades | total_vendido | nivel |
|---|---|---|---|---|
| Comercial Bosch Chile Ltda. | 2 | 2 | 114980.00 | Alto |
| Distribuidora Sodimac Pro | 3 | 7 | 72930.00 | Medio |
| Cementos Melón S.A. | 2 | 6 | 60440.00 | Medio |
