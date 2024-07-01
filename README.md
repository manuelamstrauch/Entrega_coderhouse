## CREACIÓN BASE DE UN NEGOCIO DE VENTAS DE ARTÍCULOS TECNOLÓGICOS Y SMART PARA HOGARES - EMPRESA BGREAT

### Problema:

Bgreat es una empresa especializada en la venta de artículos tecnológicos y dispositivos smart para el hogar, con una trayectoria de cuatro años en el sector. A medida que la empresa ha acumulado una vasta cantidad de datos, se ha enfrentado a limitaciones significativas en la gestión y explotación efectiva de los mismos. En este contexto, el objetivo principal de este proyecto es  desarrollar una estructura robusta y eficiente que soporte sus operaciones en constante evolución.

### Descripción del Problema:

1. **Gestión de Clientes**: Necesitamos una base de datos para llevar un registro sobre lo clientes y poder llegar a calcular distintos KPI, que permitan clasificarlos en disitintas categorías en posteriores estapas del desarrollo y de esta manera agrupar y fidelizar.
2. **Gestión de Stock**: Este negocio cuenta con distintas posibilidades en donde poder hacer las compras, por lo tanto es necesario llevar una base de datos que pueda registrar las distintas disponibilidades de los productos para hacer el seguimiento correcto.
3. **Regsitro y trazabilidad del negocio**:  que registre y trace todas las transacciones y actividades operativas de la empresa para poder generar informes de calidad e identificar áreas de mejora.

### Objetivo:

Desarrollar una base de datos integral y eficiente que permita una estrucutra robusta que logre centralizar, organizar y gestionar el core del negocio en Bgreat.

### Tablas:
1. **CLIENTE**:
![image](https://github.com/manuelamstrauch/Entrega_coderhouse/assets/174389228/c0dae6a4-2be2-4446-8dc6-fed80d7b2da0)

La tabla de clientes se clasifica como dimensional. Esta  almacena a todos los clientes que se hayan hecho alguna compra.

Atributos:
- ID_CLIENTE: número de documento como identificador único. 
- NOMBRE
- APELLIDO
- CELULAR: número de contacto.
- DIRECCIÓN: registro de dirección en caso de realizarse la compra con envío. 
- EMAIL: correo de contacto.

2. **TIENDA**:
![image](https://github.com/manuelamstrauch/Entrega_coderhouse/assets/174389228/aae78c13-9941-4467-92c7-9172215a745b)

La tabla es dimensional y registra la identificación de los distintos tipos de lugares donde se puede realizar la compra. 

Atributos:
- ID_TIENDA: identificador único. 
- NOMBRE: ejemplo ("Bgreat tienda", "Mercado Libre" ...)
- DESCRIPCIÓN: ejemplo (página web, local físico,...)

3. **PROVEEDORES**:
![image](https://github.com/manuelamstrauch/Entrega_coderhouse/assets/174389228/ddca20d0-0e4f-45ca-ab5e-6fb262a5c78a)

En esta tabla dimensional se registran los proveedores de productos.

Atributos:
- ID_PROVEEDOR: identificador único. 
- NOMBRE
- EMAIL: correo de contacto. 

4. **PRODUCTOS**:
![image](https://github.com/manuelamstrauch/Entrega_coderhouse/assets/174389228/eb593b3b-f71a-4f96-9ab6-b1619d3b5878)
La tabla Productos es dimensional y lleva el registro de todos los productos que se ofrecen en Bgreat. 

Atributos:
- ID_PRODUCTO: identificador único. 
- NOMBRE
- DESCRIPCION: breve comentario o detalle del producto
- PRECIO
- DISPONIBILIDAD:TRUE si hay stock del producto, FALSE en caso contrario
- ID_PROVEEDOR: FK, identifica al proveedor del producto. 

5. **COMPRA**:
![image](https://github.com/manuelamstrauch/Entrega_coderhouse/assets/174389228/73a2e863-1455-4a39-8fc0-28766ee32671)

Esta es una tabla de hechos ya que definen el modelo de negocios. Además captura las transacciones que se realizan en la empresa en un momento específico. 
 
Atributos:
- ID_COMPRA: identificador único. 
- FECHA: fecha de la compra, formato (YYYY-MM-DD)
- ID_CLIENTE: FK,  identificador del cliente
- ID_TIENDA: FK, identificador para el lugar de compra
- ID_PRODUCTO: FK, identificador de producto
- ID_PROVEEDOR: FK, identifica al proveedor del producto. 
- CANTIDAD: cantidad de unidades del producto.


#### DER
![image](https://github.com/manuelamstrauch/Entrega_coderhouse/assets/174389228/090215d4-6190-49a5-81ea-244889c294e9)













