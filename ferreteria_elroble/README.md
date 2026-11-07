# Ferretería "El Roble" — Práctica de SQL (MySQL)

Ejercicios de práctica guiada sobre una base de datos de una ferretería, resueltos en MySQL Workbench.

## Cómo preparar la base

Ejecutar los scripts en orden:

1. `scripts/01_base.sql` — crea la base y las 5 tablas originales (categoría, proveedor, producto, empleado, venta).
2. `scripts/02_ampliacion_sucursal_cliente.sql` — agrega sucursales, clientes, claves foráneas y datos con casos `NULL`.
3. `scripts/03_ampliacion_compra_devolucion.sql` — agrega compras a proveedores y devoluciones.

> ⚠️ Los resultados esperados de cada guía dependen de qué scripts estaban ejecutados en ese momento. Cada guía lo indica al inicio.

El diagrama de la base está en [`MER.md`](MER.md).

## Contenido

| Guía | Temas | Estado |
|---|---|---|
| [01 Vistas y JOINs](guias/01_vistas_y_joins.md) | `CREATE VIEW`, `UPDATE` vía vista, `INNER JOIN` multitabla, `GROUP BY`, `HAVING` | ✅ Resuelta |
| [02 Agregaciones, subconsultas y CASE](guias/02_agregaciones_subconsultas_case.md) | `AVG`, `MAX`, subconsultas, `CASE` | ⏳ Pendiente |
| [03 LEFT JOIN y COALESCE](guias/03_left_join_coalesce.md) | `LEFT JOIN`, `IS NULL`, `COALESCE`, `MONTH`, `DATEDIFF` | ✅ Resuelta |
| [04 Guía integradora](guias/04_guia_integradora.md) | Todo lo anterior + compras y devoluciones | ⏳ Pendiente |

Las soluciones están en `soluciones/`, con comentarios sobre los errores cometidos y su corrección.
