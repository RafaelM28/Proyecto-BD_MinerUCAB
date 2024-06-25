INSERT INTO Empleado (empleado_codigo, empleado_cedula, empleado_RIF, empleado_primer_nombre, empleado_segundo_nombre, empleado_primer_apellido, empleado_segundo_apellido, empleado_fecha_nacimiento, empleado_detalle_direccion, fk_lugar, fk_cliente, fk_aliado_1, fk_aliado_2)
VALUES
	(52, '43987324', 'J-43987324', 'Juan', 'Pablo', 'Gonzalez', 'Rodriguez', '1990-02-15', 'Calle 1', 361, NULL, NULL, 49);
  
INSERT INTO pedido_compra (pedido_compra_numero, fk_aliado, pedido_compra_fecha_emision, pedido_compra_monto_subtil, pedido_compra_monto_total)
VALUES
	(51, 40, '2022-09-30', 1200.00, 1392.00);

Delete From Mineral 
Where mineral_codigo =1;

Delete From Rol 
Where rol_codigo =1;

INSERT INTO inventario_producto (inventario_producto_codigo, fk_mineral, inventario_producto_cantidad_total, inventario_producto_operacion, inventario_producto_tipo_operacion, inventario_producto_fecha_movimiento)
VALUES
	(64, 1, 10, 10, 'Ingreso', '2010-01-15');

INSERT INTO detalle_pedido_compra (detalle_pedido_compra_codigo, fk_pedido_compra_1, fk_pedido_compra_2, fk_inventario_producto_1, fk_inventario_producto_2, detalle_compra_cantidad_mineral, detalle_compra_precio_unitario)
VALUES
	(51, 51, 40, 64, 1, 20, 1200.00);

INSERT INTO pago_compra (pago_compra_codigo, fk_tarjeta_debito, fk_tarjeta_credito, fk_efectivo, fk_cheque, fk_pedido_compra_1, fk_pedido_compra_2, pago_compra_monto, pago_compra_fecha_emision)
VALUES
	(50,NULL,10,NULL,NULL,51,40,1392.00,'2024-06-21');

CALL sp_crear_cliente (CAST('leandroinc' AS Varchar) ,CAST('J18472399' AS Varchar),CAST('leandro' AS Varchar),20000000,CAST('calle 2' AS Varchar),CAST('Calle 3' AS Varchar),CAST('Distrito Capital' AS Varchar),CAST('Libertador' AS Varchar),CAST('Candelaria' AS Varchar),CAST('Distrito Capital' AS Varchar),CAST('Libertador' AS Varchar),CAST('Candelaria' AS Varchar),CAST('leo@gmail.com' AS Varchar),'0414','0987654',CAST('leo' AS Varchar),CAST('12345678' AS Varchar),CAST('12345678' AS Varchar))
