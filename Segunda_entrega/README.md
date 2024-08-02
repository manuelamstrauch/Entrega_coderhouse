## SEGUNDA ENTREGA - BGREAT

**Alumna: Manuela Strauch**

**Comisión: 57190**

**Tutor: Ariel Annone**

**Docente: Anderson Michel TORRES**


### Problema:

Bgreat es una empresa especializada en la venta de artículos tecnológicos y dispositivos smart para el hogar, con una trayectoria de cuatro años en el sector. A medida que la empresa ha acumulado una vasta cantidad de datos, se ha enfrentado a limitaciones significativas en la gestión y explotación efectiva de los mismos. 

### Descripción del Problema:

1. **Gestión de Clientes**: Necesitamos una base de datos para llevar un registro sobre lo clientes y poder llegar a calcular distintos KPI, que permitan clasificarlos en disitintas categorías en posteriores etapas del desarrollo y de esta manera agrupar y fidelizar.
2. **Gestión de Stock**: Este negocio cuenta con distintas posibilidades en donde poder hacer las compras por lo tanto, es necesario lograr una base de datos que pueda registrar las distintas disponibilidades de los productos para hacer el seguimiento correcto.
3. **Registro y trazabilidad del negocio**:  que registre y trace todas las transacciones y actividades operativas de la empresa para poder generar informes de calidad e identificar áreas de mejora.

### Objetivo:

En este contexto, el principal objetivo es desarrollar una base de datos integral y eficiente que permita una estrucutra robusta que centralice, organice y gestione el core del negocio en Bgreat.

## BGREAT
Descripcion de los tipos de datos

![image](https://github.com/user-attachments/assets/dace8edd-af80-4844-a919-eaf3628f2f88)

---
## Documentación de Tablas

### 1. ZONA

| Tabla | Columna       | Tipo de Datos                  |
| ----- | --------------| ------------------------------  |
| zona  | id_zona       | INT NOT NULL AUTO_INCREMENT     |
|       | nombre        | VARCHAR(100) NOT NULL          |
|       | precio_envio  | INT DEFAULT '200'              |

### 2. CLIENTES

| Tabla    | Columna     | Tipo de Datos                  |
| -------- | ------------| ------------------------------  |
| clientes | id_cliente  | INT NOT NULL AUTO_INCREMENT     |
|          | nombre      | VARCHAR(100) DEFAULT 'NOMBRE X' |
|          | apellido    | VARCHAR(100) DEFAULT 'APELLIDO X' |
|          | celular     | VARCHAR(20) NOT NULL            |
|          | direccion   | VARCHAR(255)                    |
|          | email       | VARCHAR(100) UNIQUE NOT NULL    |
|          | id_zona     | INT                             |

### 3. TIENDA

| Tabla  | Columna      | Tipo de Datos                  |
| ------ | -------------| ------------------------------  |
| tienda | id_tienda    | INT NOT NULL AUTO_INCREMENT     |
|        | nombre       | VARCHAR(60) NOT NULL           |
|        | descripcion  | VARCHAR(100)                   |

### 4. PROVEEDORES

| Tabla      | Columna      | Tipo de Datos                  |
| ---------- | -------------| ------------------------------  |
| proveedores| id_proveedor | INT NOT NULL AUTO_INCREMENT     |
|            | nombre       | VARCHAR(100) NOT NULL          |
|            | email        | VARCHAR(100) UNIQUE NOT NULL    |

### 5. PRODUCTOS

| Tabla     | Columna      | Tipo de Datos                  |
| --------- | -------------| ------------------------------  |
| productos | id_producto  | INT NOT NULL AUTO_INCREMENT     |
|           | nombre       | VARCHAR(100) NOT NULL          |
|           | descripcion  | VARCHAR(200)                   |
|           | precio       | INT                            |
|           | id_proveedor | INT                            |

### 6. INVENTARIO

| Tabla      | Columna            | Tipo de Datos                  |
| ---------- | ------------------- | ------------------------------  |
| inventario | id_producto        | INT NOT NULL                   |
|            | id_proveedor       | INT                            |
|            | cantidad_disponible| INT                            |
|            | disponibilidad     | BOOLEAN                        |

### 7. COMPRA

| Tabla   | Columna        | Tipo de Datos                      |
| ------- | ---------------| ---------------------------------  |
| compra  | id_compra       | INT NOT NULL AUTO_INCREMENT        |
|         | fecha           | DATETIME DEFAULT CURRENT_DATE       |
|         | id_cliente      | INT                                |
|         | id_tienda       | INT                                |
|         | id_producto     | INT                                |
|         | cantidad        | INT                                |
|         | envio           | BOOLEAN                            |

## Relaciones y Claves Foráneas

### Claves Foráneas en clientes

| Columna   | Referencia        |
| --------- | ------------------|
| id_zona   | zona(id_zona)    |

### Claves Foráneas en inventario

| Columna      | Referencia               |
| ------------ | ------------------------- |
| id_producto  | productos(id_producto)   |
| id_proveedor | proveedores(id_proveedor)|

### Claves Foráneas en compra

| Columna      | Referencia             |
| ------------ | ----------------------- |
| id_cliente   | clientes(id_cliente)   |
| id_tienda    | tienda(id_tienda)       |
| id_producto  | productos(id_producto) |



# SEGUNDA PARTE DE LA ENTREGA

## Documentación de Vistas
### Vista: Ranking Proveedores

**Descripción:** Esta vista muestra el ranking de proveedores basado en la cantidad total de productos vendidos. De esta manera en Bgreat lograría identificar a los proveedores que venden más productos y puede negociar mejores precios o condiciones favorables, basándose en su alto volumen de ventas.

**Columnas:**

* **Proveedor:** nombre del proveedor
* **Total Ventas:** cantidad total de artículos vendidos de ese proveedor

**Ejemplo de consulta:**

```sql
SELECT * FROM RangkingProveedores
```
### Vista: FacturacionMensual

**Descripción:** Esta vista muestra la facturación por mes de la empresa. Conociendo los meses de mayor y menor facturación, se pueden ajustar las campañas de marketing y promociones para maximizar las ventas en períodos de baja actividad y aprovechar los períodos de alta demanda, entre otras cosas ya que permite permite evaluar rápidamente el impacto la empresa. 

**Columnas:**

* **AAAAMM:** IAño mes
* **Facturación mensual:** monto en $ facturado 

**Ejemplo de consulta:**

```sql
SELECT * FROM FacturacionMensual;
```

### Vista: ClientesLoyal

**Descripción:** Esta vista muestra los clientes que han realizado 2 o más compras en los últimos 3 meses. Es una manera de tener registro sobre los clientes frecuentes y podes ofrecerles beneficios.

**Columnas:**

* **id_cliente:** identificador del cliente
* **Nombre Completo:**  nombre y apellido
* **Cantidad de compras:** cantidad de compras que hizo en el último trimestre

**Ejemplo de consulta:**

```sql
SELECT * FROM ClientesLoyal;
```

## Documentación de Funciones 

### Función: tarifa_envio

**Descripción:** Los días de feriado nacional, la empresa tiene mayores costos en los envíos, por lo tanto se le calcula una nueva tarifa.

**Parámetros:**

* **precio:** precio actual
* **aumento_tarifa:** valor que aumenta la tarifa

**Retorno:**

* Columan con nuevo valor de la tarifa

**Ejemplo de uso:**

```sql
SELECT id_zona,
nombre,
bgreat_db.tarifa_envio(zona.precio_envio, 50) AS 'NUEVA TARIFA'
FROM zona;
```

### Función: valor_total_compra

**Descripción:** Actualmente, en la tabla copra, se genera un id por cada carticulo que el cliente compre. Por lo tanto se crea esta funcion para poder conocer el monto total del cliente en una sola compra, combinando la fecha, id_cliente, id_tienda. 

**Parámetros:**

* **fecha:** fecha que se realizo la compra (formato YYYY-MM-DD)
* **id_cliente:** identificador cliente
* **id_tienda:** identificador de la tienda

**Retorno:**

* Para ese cliente específico cual fue el monto total de su compra en ese día. 

**Ejemplo de uso:**

```sql

SELECT distinct id_cliente,
bgreat_db.valor_total_compra('2024-07-21', 1, 2) AS 'Monto Total'
FROM compra
WHERE id_cliente=1;
```

## Documentación de Triggers 

### Trigger: logger_cambio_precio

**Descripción:** Este trigger registra los cambios de precios en la tabla logs_historial_precios cuando se actualiza un precio en la tabla productos.

**Detalles:**

* **Tabla afectada:** PRODUCTOS
* **Acción:** UPDATE
* **Información registrada:** id_producto,precio_anterior, precio_nuevo, fecha_cambio

**Ejemplo:**

* Se actualiza el precio de un producto.
* El trigger registra la acción en la tabla LOGGER_CAMBIO_PRECIO con los detalles correspondientes.

### Trigger: trigger_disponibilidad

**Descripción:** Verifica la disponibilidad del producto antes de insertar una compra. Si el producto no está disponible, se genera un error.

**Detalles:**

* **Tabla afectada:** COMPRA
* **Acción:** INSERT
* **Información registrada:** Fecha, ID del cliente (si se conoce), Usuario

**Ejemplo:**

* Se registra una compra.
* Si el producto no está diponible, no deja que se registre y muestra un error. De lo contrario, se completa la insercion de forma correcta.

## Documentación de Procedimientos Almacenados

### Procedimiento: aplicar_descuento

**Descripción:** Aplica un descuento a los productos que no se han vendido en los últimos 3 meses.

**Parámetros:**

* **porcentaje_descuento:** porcentaje de descuento que se le quiere hacer a los productos. 

**Retorno:**

* Mensaje de éxito.

**Ejemplo de uso:**

```sql
CALL aplicar_descuento(10);
```

### Procedimiento: realizar_compra

**Descripción:** Este procedimiento almacena una compra en la base de datos, asegurándose de que el producto esté disponible en el inventario antes de registrar la transacción. Si el producto no está disponible o no hay suficiente cantidad, el procedimiento genera un error. Si todo está en orden, el procedimiento inserta la compra en la tabla compra y actualiza la cantidad disponible del producto en la tabla inventario

**Parámetros:**

* **fecha_compra:** fecha en la que se realiza la compra 
* **id_cliente_compra:** identificador del cliente
* **id_ctienda_compra:** identificador de la tienda
* **id_producto_compra:** identificador del producto
* **cantidad_compra:** cantidad del producto que se quiere comprar
* **envio_compra:** TRUE/FALSE del envio. 

**Retorno:**

* Mensaje de error

**Ejemplo de uso:**

```sql
CALL realizar_compra(1, 2, 1, 2, TRUE);
```



