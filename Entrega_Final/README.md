![image](https://github.com/user-attachments/assets/8aeb8b25-0cfe-449c-b6d4-34730b89775a)


## ENTREGA FINAL - BGREAT

**Alumna: Manuela Strauch**

**Comisión: 57190**

**Tutor: Ariel Annone**

**Docente: Anderson Michel TORRES**


### Problema:

Bgreat, una empresa con cuatro años de experiencia en la venta de artículos tecnológicos y dispositivos inteligentes para el hogar, ha enfrentado crecientes desafíos en la gestión y aprovechamiento de la gran cantidad de datos acumulados. A medida que la empresa ha expandido su base de clientes y su inventario, las limitaciones en la organización y análisis de estos datos han comenzado a afectar la eficiencia operativa y la toma de decisiones estratégicas. Este desafío ha sido el foco del proyecto durante el curso, donde se buscó desarrollar una solución robusta y escalable para optimizar la gestión de datos y mejorar la toma de decisiones.

### Descripción del Problema:

1. **Gestión de Clientes**: Necesitamos una base de datos para llevar un registro sobre lo clientes y poder llegar a calcular distintos KPI, que permitan clasificarlos en distintas categorías en posteriores etapas del desarrollo y de esta manera agrupar y fidelizar.
2. **Gestión de Stock**: Este negocio cuenta con distintas posibilidades en donde poder hacer las compras por lo tanto, es necesario lograr una base de datos que pueda registrar las distintas disponibilidades de los productos para hacer el seguimiento correcto.
3. **Registro y trazabilidad del negocio**:  que registre y trace todas las transacciones y actividades operativas de la empresa para poder generar informes de calidad e identificar áreas de mejora.

### Objetivo:

En este contexto, el principal objetivo es desarrollar una base de datos integral y eficiente que permita una estrucutra robusta que centralice, organice y gestione el core del negocio en Bgreat.

## BGREAT
Descripcion de los tipos de datos

![image](https://github.com/user-attachments/assets/18cf6cb0-242d-4255-88b5-37a0bc6a2189)

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

### 8. EVALUACION_POST_COMPRA

| Tabla                | Columna         | Tipo de Datos                  |
| -------------------- | ---------------- | ------------------------------  |
| evaluacion_post_compra | id_evaluacion  | INT NOT NULL AUTO_INCREMENT     |
|                      | id_compra       | INT NOT NULL                    |
|                      | calificacion    | INT CHECK (calificacion BETWEEN 1 AND 5) |
|                      | comentarios     | TEXT                            |
|                      | fecha_evaluacion| DATETIME DEFAULT CURRENT_TIMESTAMP |

### 9. COMUNICACIONES

| Tabla           | Columna           | Tipo de Datos                      |
| --------------- | ------------------ | ---------------------------------  |
| comunicaciones   | id_comunicacion    | INT NOT NULL AUTO_INCREMENT        |
|                 | id_cliente         | INT                                |
|                 | tipo_comunicacion  | VARCHAR(50)                        |
|                 | motivo             | TEXT                               |
|                 | fecha_comunicacion | DATETIME DEFAULT CURRENT_TIMESTAMP |

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

### Claves Foráneas en evaluacion_post_compra

| Columna    | Referencia          |
| ---------- | --------------------|
| id_compra  | compra(id_compra)   |

### Claves Foráneas en comunicaciones

| Columna    | Referencia          |
| ---------- | --------------------|
| id_cliente | clientes(id_cliente) |

-- 
## Documentación de Vistas
### Vista: Ranking Proveedores

**Descripción:** Esta vista muestra el ranking de proveedores basado en la cantidad total de productos vendidos. De esta manera, Bgreat puede identificar a los proveedores que venden más productos y negociar mejores precios o condiciones favorables, basándose en su alto volumen de ventas.

**Columnas:**

* **Proveedor:** nombre del proveedor
* **Total Ventas:** cantidad total de artículos vendidos de ese proveedor

**Ejemplo de consulta:**

```sql
SELECT * FROM RankingProveedores
```
### Vista: FacturacionMensual

**Descripción:** Esta vista muestra la facturación por mes de la empresa. Conociendo los meses de mayor y menor facturación, se pueden ajustar las campañas de marketing y promociones para maximizar las ventas en períodos de baja actividad y aprovechar los períodos de alta demanda.

**Columnas:**

* **AAAAMM:** Año y mes
* **Facturación mensual:** monto en $ facturado 

**Ejemplo de consulta:**

```sql
SELECT * FROM FacturacionMensual;
```

### Vista: ClientesLoyal

**Descripción:** Esta vista muestra los clientes que han realizado 2 o más compras en los últimos 3 meses. Es una manera de tener un registro sobre los clientes frecuentes y ofrecerles beneficios.

**Columnas:**

* **id_cliente:** identificador del cliente
* **Nombre Completo:**  nombre y apellido
* **Cantidad de compras:** cantidad de compras que hizo en el último trimestre

**Ejemplo de consulta:**

```sql
SELECT * FROM ClientesLoyal;
```

### Vista: EvaluacionesPorProducto

**Descripción:** Esta vista muestra la satisfacción de los clientes respecto a los productos comprados. Se usa con el objetivo de mejorar la oferta de productos.

**Columnas:**

* **Nombre del producto** 
* **Promedio de calificaciones:**  el promedio de las calificaciones de determinado producto.
* **Cantidad de evaluaciones:** se tiene en cuenta la cantidad de evaluaciones que se le hizo al producto en cuestión. 

**Ejemplo de consulta:**

```sql
SELECT *
FROM EvaluacionesPorProducto
WHERE `evaluacionesporproducto`.`Nombre del Producto`='Smart TV 55"';
```

### Vista: HistoricoComunicaciones

**Descripción:** Esta vista muestra el historial de comunicación con los clientes. Es necesario en caso de querer mandarle un beneficio, o simplemente poder tener un seguimiento sobre el cliente. 

**Columnas:**

* **id_cliente:** identificador del cliente
* **Nombre completo:** Nombre y apellido 
* **tipo_comunicacion:**  a través de que canal se realizó la comunicación
* **motivo:** razón por la cual se tuvo comunicación con el cliente
* **fecha_comunicacion:** cuando se tuvo la comunicación 

**Ejemplo de consulta:**

```sql
SELECT *
FROM HistoricoComunicaciones;
```

-- 
## Documentación de Funciones 

### Función: tarifa_envio

**Descripción:** Los días de feriado nacional, la empresa tiene mayores costos en los envíos. Esta función calcula una nueva tarifa.

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

**Descripción:** Este procedimiento almacena una compra en la base de datos, asegurándose de que el producto esté disponible en el inventario antes de registrar la transacción. Si el producto no está disponible o no hay suficiente cantidad, el procedimiento genera un error. Si todo está en orden, el procedimiento inserta la compra en la tabla compra y actualiza la cantidad disponible del producto en la tabla inventario.

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

## Documentación de Roles
Se genera 2 roles:
1. **rol_mkt**: Rol de marketing, que solo permite hacer SELECT a las vistas.
2. **rol_admin**: Rol de administración que permite al usuario todos los privilegios sobre 4 tablas relacionadas al core del negocio (COMPRA, INVENTARIO, PRODUCTOS, PROVEEDORES).

Además, se crea un superusuario con todos los privilegios sobre la base de datos.
