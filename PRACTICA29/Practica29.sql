CREATE TABLE equipos (
  id_equipo NUMBER(2)
    CONSTRAINT equipos_pk PRIMARY KEY ,
  nombre VARCHAR2(50)
    CONSTRAINT equipos_uk1 UNIQUE
    CONSTRAINT equipos_nn1 NOT NULL ,
  estadio VARCHAR2(50)
    CONSTRAINT equipos_uk2 UNIQUE ,
  aforo NUMBER(6),
  ano_fundacion NUMBER(4),
  ciudad VARCHAR2(50)
    CONSTRAINT equipos_nn2 NOT NULL
);

CREATE TABLE jugadores (
  id_jugador NUMBER(3)
    CONSTRAINT jugadores_pk PRIMARY KEY ,
  nombre VARCHAR2(50)
    CONSTRAINT jugadores_nn1 NOT NULL ,
  fecha_nac DATE,
  id_equipo NUMBER(2)
    CONSTRAINT jugadores_fk REFERENCES equipos(id_equipo) ON DELETE SET NULL
);

CREATE TABLE partidos (
  id_equipo_casa NUMBER(2)
    CONSTRAINT partidos_fk1 REFERENCES equipos(id_equipo) ON DELETE CASCADE,
  id_equipo_fuera NUMBER(2)
    CONSTRAINT partidos_fk2 REFERENCES equipos(id_equipo) ON DELETE CASCADE ,
  fecha TIMESTAMP,
  goles_casa NUMBER(2),
  goles_fuera NUMBER(2),
  observaciones VARCHAR2(1000),
  CONSTRAINT partidos_pk PRIMARY KEY (id_equipo_casa,id_equipo_fuera),
  CONSTRAINT partidos_ck CHECK (id_equipo_casa!=id_equipo_fuera)
);

CREATE TABLE goles (
  id_equipo_casa  NUMBER(2),
  id_equipo_fuera NUMBER(2),
  minuto          INTERVAL DAY TO SECOND,
  descripcion     VARCHAR2(2000),
  id_jugador      NUMBER(3)
    CONSTRAINT goles_fk2 REFERENCES jugadores (id_jugador)  ON DELETE CASCADE,
  CONSTRAINT goles_pk PRIMARY KEY (id_equipo_fuera, id_equipo_casa, minuto),
  CONSTRAINT goles_fk1 FOREIGN KEY(id_equipo_casa,id_equipo_fuera) REFERENCES partidos ON DELETE CASCADE
);

ALTER TABLE equipos MODIFY (
  estadio VARCHAR2(50) CONSTRAINT equipos_nn3 NOT NULL,
  aforo NUMBER(6)
    CONSTRAINT equipos_nn4 NOT NULL
  );

ALTER TABLE equipos MODIFY (ano_fundacion DATE);
ALTER TABLE jugadores DROP CONSTRAINT jugadores_nn1;

INSERT INTO equipos VALUES (1,'Cascorro F.C','La Arenera',4000,'1/1/1961','Cascorro de Arriba');
INSERT INTO equipos VALUES (2,'Athletico Matalasleñas','Cerro Gálvez',1200,'12/3/1970','Matalasleñas');
INSERT INTO jugadores VALUES (1,'Amoribia','20/1/90',1);
INSERT INTO jugadores VALUES (2,'Garcia',NULL,2);
INSERT INTO jugadores VALUES (3,'Pedrosa','12/9/93',1);
INSERT INTO partidos VALUES (1,2,TO_DATE ('5/11/2016 18:00:00','dd/mm/yyyy hh24:mi:ss'),2,1,'Partido entretenido');
INSERT INTO goles VALUES (1,2,INTERVAL '23' MINUTE,'Falta directa',1);
INSERT INTO goles VALUES (1,2,INTERVAL '40' MINUTE,'Penalti',2);
INSERT INTO goles VALUES (1,2,INTERVAL '1:10' HOUR TO MINUTE,'Gran jugada personal',3);

UPDATE equipos SET nombre='Real Cascorro' WHERE nombre='Cascorro F.C';

SELECT * FROM equipos;

COMMIT;

UPDATE equipos SET aforo=aforo+500;
SELECT * from equipos;
COMMIT;
DELETE equipos;
SELECT * FROM jugadores;
SELECT * FROM goles;
SELECT * FROM partidos;
ROLLBACK ;
ALTER TABLE equipos ADD  provincia VARCHAR2(40);
SELECT * FROM equipos;
COMMIT;
UPDATE equipos set provincia='Zamora' WHERE nombre='Real Cascorro';
UPDATE equipos set provincia='Valladolid' WHERE nombre='Athletico Matalasleñas';
SELECT * FROM equipos;
COMMIT;