# Modelo Entidad-Relación — `ferreteria_elroble`

Estado de la base después de ejecutar los tres scripts de `scripts/`.

```mermaid
erDiagram
  t_sucursal ||--o{ t_empleado : "tiene"
  t_empleado ||--o{ t_venta : "realiza"
  t_cliente |o--o{ t_venta : "compra"
  t_producto ||--o{ t_venta : "se vende en"
  t_categoria ||--o{ t_producto : "clasifica"
  t_proveedor ||--o{ t_producto : "suministra"
  t_producto ||--o{ t_compra : "se repone en"
  t_empleado ||--o{ t_compra : "recibe"
  t_venta ||--o{ t_devolucion : "se devuelve en"
  t_sucursal {
    int id PK
    varchar nombre
    varchar ciudad
  }
  t_empleado {
    int id PK
    varchar nombre
    varchar cargo
    decimal sueldo "puede ser NULL"
    date fecha_contrato
    int sucursal_id FK
  }
  t_cliente {
    int id PK
    varchar nombre
    varchar tipo "Particular o Empresa"
    varchar ciudad
    date fecha_registro
  }
  t_venta {
    int id PK
    int empleado_id FK
    int producto_id FK
    int cliente_id FK "puede ser NULL"
    int cantidad
    date fecha_venta
    decimal total
  }
  t_producto {
    int id PK
    varchar nombre
    int categoria_id FK
    int proveedor_id FK
    decimal precio
    int stock
    date fecha_ingreso
  }
  t_categoria {
    int id PK
    varchar nombre
    varchar descripcion
  }
  t_proveedor {
    int id PK
    varchar razon_social
    varchar telefono
    varchar email
    tinyint activo
  }
  t_compra {
    int id PK
    int producto_id FK
    int empleado_id FK
    int cantidad
    decimal costo_unitario
    date fecha_pedido
    date fecha_recepcion "NULL = pendiente"
  }
  t_devolucion {
    int id PK
    int venta_id FK
    int cantidad
    varchar motivo
    date fecha_devolucion
  }
```

## Torpedo de `ON`

Regla: la FK (`algo_id`) se empareja con el `id` de la tabla a la que apunta, con alias distintos a cada lado.

| Unir… | ON |
|---|---|
| venta ↔ empleado | `venta.empleado_id = empleado.id` |
| venta ↔ producto | `venta.producto_id = producto.id` |
| venta ↔ cliente | `venta.cliente_id = cliente.id` |
| producto ↔ categoría | `producto.categoria_id = categoria.id` |
| producto ↔ proveedor | `producto.proveedor_id = proveedor.id` |
| empleado ↔ sucursal | `empleado.sucursal_id = sucursal.id` |
| compra ↔ producto | `compra.producto_id = producto.id` |
| compra ↔ empleado | `compra.empleado_id = empleado.id` |
| devolución ↔ venta | `devolucion.venta_id = venta.id` |
