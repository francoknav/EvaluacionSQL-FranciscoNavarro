CREATE schema IF NOT EXISTS negocio_navarro;
-- comienzo creando mi schema

CREATE table `negocio_navarro`.`tipoDeProductos` (
`tipoDeProductos_id` int NOT NULL auto_increment,
`nombreCategoria` varchar(15) NOT NULL,
PRIMARY KEY (`tipoDeProductos_id`)
);

CREATE table `negocio_navarro`.`producto` (
`producto_id` int NOT NULL auto_increment,
`nombreProducto` varchar(25) NOT NULL,
`precio` int NOT NULL,
`stock` int NOT NULL,
primary key (`producto_id`) 
);

CREATE TABLE `negocio_navarro`.`proveedores` (
`proveedores_id` int NOT NULL auto_increment,
`nombreProveedor` varchar(20) NOT NULL,
`nombrePersonaProveedor` varchar(20) NOT NULL,
`teléfono` int NOT NULL,
`correo` varchar(25) NOT NULL,
`precioProveedor` int NOT NULL,
primary key (`proveedores_id`)
);

CREATE TABLE negocio_navarro.efectivoODigital (
efectivoODigital_id int NOT NULL auto_increment,
nombre varchar(20) NOT NULL,
otrosDetalles varchar(20) NOT NULL,
primary key (efectivoODigital_id)
);

CREATE TABLE negocio_navarro.boletaCarroCompra (
boletaCarroCompra_id int NOT NULL auto_increment,
fecha date NOT NULL,
nombre varchar(20) NOT NULL,
primary key (boletaCarroCompra_id)
);

-- Aquí haremos la foreign key de tipo de producto que va dentro de la tabla producto
ALTER TABLE negocio_navarro.producto ADD tipoDeProductos_id INT NOT NULL;
ALTER TABLE negocio_navarro.producto ADD CONSTRAINT productoCategoria foreign key (tipoDeProductos_id) references negocio_navarro.tipodeproductos(tipoDeProductos_id);
-- -------------------------------------------------------------------------------

-- Aquí haremos la foreign key de producto_id que va dentro de proveedores
ALTER TABLE negocio_navarro.proveedores ADD producto_id INT NOT NULL;
ALTER TABLE negocio_navarro.proveedores ADD CONSTRAINT productoProveedores foreign key (producto_id) references negocio_navarro.producto(producto_id);
-- --------------------------------------------------------------------------------

-- Aquí haremos la foreign key de efectivoODigital_id que va dentor de la tabla boletaCarroCompra
ALTER TABLE negocio_navarro.boletacarrocompra ADD efectivoODigital_id INT NOT NULL;
ALTER TABLE negocio_navarro.boletacarrocompra ADD constraint boletatipodepago foreign key (efectivoODigital_id) references negocio_navarro.efectivoodigital(efectivoODigital_id);
-- ----------------------------------------------------------------

-- Aquí crearemos una tabla relacional, pero que tiene una primary key compuesta (incluye una fk), además se crea todo de un viaje las foreign key con sus contraints, no se editan posteriormente con el alter table
CREATE TABLE negocio_navarro.detalleCantidad (
detalleCantidad_id int NOT NULL auto_increment,
boletaCarroCompra_id int,
producto_id int,
cantidad int NOT NULL,
precio int NOT NULL,
PRIMARY KEY (detalleCantidad_id, boletaCarroCompra_id),
CONSTRAINT boletaDetalle FOREIGN KEY (boletaCarroCompra_id) REFERENCES negocio_navarro.boletacarrocompra(boletaCarroCompra_id),
constraint productoDetalle foreign key (producto_id) references negocio_navarro.producto(producto_id)
);

-- AÑADIR VALORES EN TIPO DE PRODUCTOS -----------------------------------------
USE negocio_navarro; 

INSERT INTO tipodeproductos (nombreCategoria)
VALUES ('Bebidas'), ('Chocolates'), ('Cigarros'), ('Casero');
SELECT * FROM negocio_navarro.tipodeproductos;

-- AÑADIR VALORES EN PRODUCTOS -----------------------------------------
INSERT INTO producto (nombreProducto,precio,stock,tipoDeProductos_id)
VALUES ('CocaCola 3L', 2500, 50, 1 ), ('CocaCola 1.5L', 1500, 80, 1 ), ('Malboro Ice', 2500, 50, 1 ), ('Sahne Nuss 250gr', 5500, 10, 2 ), ('Trozo Queque', 500, 15, 4 );
UPDATE producto SET tipoDeProductos_id = 3
  WHERE producto_id = 3;
SELECT * FROM negocio_navarro.producto;

-- AÑADIR VALORES A LAS OTRAS TABLAS -----------------------------------
INSERT INTO efectivoodigital (nombre,otrosdetalles)
VALUES ('efectivo', '-' ), ('débito', 'transback' ), ('transferencia', 'cuenta jaime' );
SELECT * FROM negocio_navarro.efectivoodigital;

INSERT INTO boletacarrocompra (fecha,nombre,efectivoodigital_id)
-- aquí añadimos una compra realizada en 2021 para poder ocupar el llamado de datos con filtro de fecha BETWEEN
VALUES (20221111, 'compra2cocas', 3 ), ('20220101', '5cocas', 1 ), ('20211229', '1coca', 2 )
SELECT * FROM negocio_navarro.boletacarrocompra;
