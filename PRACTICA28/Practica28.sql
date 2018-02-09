CREATE TABLE articulos (
  cod_art CHAR(7)
    CONSTRAINT articulos_pk PRIMARY KEY ,
  nombre VARCHAR2(40)
    CONSTRAINT articulos_nn1 NOT NULL ,
  marca VARCHAR2(20)
    CONSTRAINT articulos_nn2 NOT NULL ,
  modelo VARCHAR2(15)
    CONSTRAINT articulos_nn3 NOT NULL
);

CREATE TABLE PRECIOS (
  fecha_inicio DATE,
  fecha_fin DATE,
  cod_art CHAR(7)
    CONSTRAINT precios_fk1 REFERENCES articulos(cod_art) ON DELETE CASCADE ,
  precio NUMBER(7,2),
  CONSTRAINT precios_pk PRIMARY KEY(fecha_inicio,cod_art)
);



ALTER TABLE PRECIOS ADD CONSTRAINT precios_fk1 FOREIGN KEY(cod_art) REFERENCES articulos(cod_art);
ALTER TABLE PRECIOS ADD CONSTRAINT precios_pk PRIMARY KEY(fecha_inicio,cod_art);
