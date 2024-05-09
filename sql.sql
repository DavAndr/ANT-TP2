drop database if exists veterinaria;
CREATE DATABASE IF NOT EXISTS veterinaria;

USE veterinaria;

CREATE TABLE IF NOT EXISTS tamano (
    id_tamano INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS especie (
    id_especie INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS raza (
    id_raza INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    id_especie_fk INT,
    CONSTRAINT fk_especie FOREIGN KEY (id_especie_fk) REFERENCES especie(id_especie)
);

CREATE TABLE IF NOT EXISTS tratamiento (
    id_tratamiento INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    descripcion TEXT
);

CREATE TABLE IF NOT EXISTS vacuna (
    id_vacuna INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    descripcion TEXT
);

CREATE TABLE IF NOT EXISTS cirugia (
    id_cirugia INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    descripcion TEXT
);

CREATE TABLE IF NOT EXISTS salud (
    id_salud INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    descripcion TEXT
);

CREATE TABLE IF NOT EXISTS estado_mascotas (
    id_estado_mascotas INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    descripcion TEXT
);

CREATE TABLE IF NOT EXISTS tipo_vivienda (
    id_tipo_vivienda INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    descripcion TEXT
);

CREATE TABLE IF NOT EXISTS vivienda (
    id_vivienda INT AUTO_INCREMENT PRIMARY KEY,
    id_tipo_vivienda_fk INT,
    mt2_interior DECIMAL(10,2),
    mt2_exterior DECIMAL(10,2),
    CONSTRAINT fk_tipo_vivienda FOREIGN KEY (id_tipo_vivienda_fk) REFERENCES tipo_vivienda(id_tipo_vivienda)
);

CREATE TABLE IF NOT EXISTS adoptantes (
    id_adoptantes INT AUTO_INCREMENT PRIMARY KEY,
    id_vivienda_fk INT,
    nombre VARCHAR(100),
    direccion VARCHAR(255),
    telefono VARCHAR(20),
    email VARCHAR(100),
    CONSTRAINT fk_vivienda FOREIGN KEY (id_vivienda_fk) REFERENCES vivienda(id_vivienda)
);

CREATE TABLE IF NOT EXISTS preferencias (
    id_preferencia INT AUTO_INCREMENT PRIMARY KEY,
    id_adoptante_fk INT,
    id_tamano_fk INT,
    id_raza_fk INT,
    nacimiento DATE,
    CONSTRAINT fk_adoptante_1 FOREIGN KEY (id_adoptante_fk) REFERENCES adoptantes(id_adoptantes),
    CONSTRAINT fk_tamano FOREIGN KEY (id_tamano_fk) REFERENCES tamano(id_tamano),
    CONSTRAINT fk_raza_1 FOREIGN KEY (id_raza_fk) REFERENCES raza(id_raza)
);

CREATE TABLE IF NOT EXISTS mascotas (
    id_mascotas INT AUTO_INCREMENT PRIMARY KEY,
    id_estado_mascotas_fk INT,
    id_raza_fk INT,
    id_salud_fk INT,
    nombre VARCHAR(100),
    edad INT,
    genero VARCHAR(10),
    CONSTRAINT fk_estado_mascotas FOREIGN KEY (id_estado_mascotas_fk) REFERENCES estado_mascotas(id_estado_mascotas),
    CONSTRAINT fk_raza_2 FOREIGN KEY (id_raza_fk) REFERENCES raza(id_raza),
    CONSTRAINT fk_salud FOREIGN KEY (id_salud_fk) REFERENCES salud(id_salud)
);

CREATE TABLE IF NOT EXISTS historial(
    id_historial int AUTO_INCREMENT PRIMARY KEY,
    id_tratamiento_fk int,
    id_vacuna_fk int,
    id_cirugia_fk int,
    id_mascotas_fk INT,
    CONSTRAINT fk_tratamiento FOREIGN KEY (id_tratamiento_fk) REFERENCES tratamiento(id_tratamiento),
    CONSTRAINT fk_vacuna FOREIGN KEY (id_vacuna_fk) REFERENCES vacuna(id_vacuna),
    CONSTRAINT fk_cirugia FOREIGN KEY (id_cirugia_fk) REFERENCES cirugia(id_cirugia),
    CONSTRAINT fk_mascotas_1 FOREIGN KEY (id_mascotas_fk) REFERENCES mascotas(id_mascotas),
    fecha DATE
);

CREATE TABLE IF NOT EXISTS estado (
    id_estado INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS adopcion (
    id_adopcion INT AUTO_INCREMENT PRIMARY KEY,
    id_adoptante_fk INT,
    id_mascotas_fk INT,
    id_estado_fk INT,
    fecha DATE,
    CONSTRAINT fk_adoptante_2 FOREIGN KEY (id_adoptante_fk) REFERENCES adoptantes(id_adoptantes),
    CONSTRAINT fk_mascotas_2 FOREIGN KEY (id_mascotas_fk) REFERENCES mascotas(id_mascotas),
    CONSTRAINT fk_estado FOREIGN KEY (id_estado_fk) REFERENCES estado(id_estado)
);

CREATE TABLE IF NOT EXISTS trabajo (
    id_trabajo INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    descripcion TEXT,
    requisitos TEXT
);

CREATE TABLE IF NOT EXISTS voluntario (
    id_voluntario INT AUTO_INCREMENT PRIMARY KEY,
    direccion VARCHAR(255),
    telefono VARCHAR(20),
    email VARCHAR(100),
    nacimiento DATE,
    genero VARCHAR(10)
);

CREATE TABLE IF NOT EXISTS trabajo_voluntario (
    id_trabajo_voluntario INT AUTO_INCREMENT PRIMARY KEY,
    id_voluntario_fk INT,
    id_trabajo_fk INT,
    fecha_inicio DATE,
    fecha_fin DATE,
    CONSTRAINT fk_voluntario FOREIGN KEY (id_voluntario_fk) REFERENCES voluntario(id_voluntario),
    CONSTRAINT fk_trabajo FOREIGN KEY (id_trabajo_fk) REFERENCES trabajo(id_trabajo)
);

CREATE TABLE IF NOT EXISTS detalle_vol (
    id_detalle_vol INT AUTO_INCREMENT PRIMARY KEY,
    id_voluntario_fk INT,
    CONSTRAINT fk_voluntario_fk FOREIGN KEY (id_voluntario_fk) REFERENCES voluntario(id_voluntario)
);

CREATE TABLE IF NOT EXISTS clase (
    id_clase INT AUTO_INCREMENT PRIMARY KEY,
    id_detalles_vol_fk INT,
    nombre VARCHAR(100),
    objetivos TEXT,
    fecha DATE,
    hora TIME,
    CONSTRAINT fk_detalles_vol_fk FOREIGN KEY (id_detalles_vol_fk) REFERENCES detalle_vol(id_detalle_vol)
);

CREATE TABLE IF NOT EXISTS asistencia_clase (
    id_asistencia_clase INT AUTO_INCREMENT PRIMARY KEY,
    id_clase_fk INT,
    id_adopcion_fk INT,
    Asistencia VARCHAR(50),
    Detalles TEXT,
    CONSTRAINT fk_clase_1 FOREIGN KEY (id_clase_fk) REFERENCES clase(id_clase),
    CONSTRAINT fk_adopcion FOREIGN KEY (id_adopcion_fk) REFERENCES adopcion(id_adopcion)
);

CREATE TABLE IF NOT EXISTS patrocinadores (
    id_patrocinadores INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS detalle_pat (
    id_detalle_pat INT AUTO_INCREMENT PRIMARY KEY,
    id_patrocinadores_fk INT,
    CONSTRAINT fk_patrocinadores_fk FOREIGN KEY (id_patrocinadores_fk) REFERENCES patrocinadores(id_patrocinadores)
);

CREATE TABLE IF NOT EXISTS eventos (
    id_evento INT AUTO_INCREMENT PRIMARY KEY,
    id_detalle_vol_fk INT,
    id_detalle_pat_fk INT,
    Nombre VARCHAR(100),
    descripcion TEXT,
    CONSTRAINT fk_detalle_vol FOREIGN KEY (id_detalle_vol_fk) REFERENCES detalle_vol(id_detalle_vol),
    CONSTRAINT fk_detalle_pat FOREIGN KEY (id_detalle_pat_fk) REFERENCES detalle_pat(id_detalle_pat)
);

INSERT INTO tamano (nombre) VALUES('pequeño');
INSERT INTO tamano (nombre) VALUES('mediano');
INSERT INTO tamano (nombre) VALUES('grande');
INSERT INTO tamano (nombre) VALUES('extra grande');
INSERT INTO tamano (nombre) VALUES('gigante');

INSERT INTO especie (nombre) VALUES('perro');
INSERT INTO especie (nombre) VALUES('gato');
INSERT INTO especie (nombre) VALUES('pez');
INSERT INTO especie (nombre) VALUES('cobayo');
INSERT INTO especie (nombre) VALUES('caracol');

INSERT INTO raza (nombre,id_especie_fk) VALUES('dogo argentino',1);
INSERT INTO raza (nombre,id_especie_fk) VALUES('siames',2);
INSERT INTO raza (nombre,id_especie_fk) VALUES('merluza',3);
INSERT INTO raza (nombre,id_especie_fk) VALUES('rex',4);
INSERT INTO raza (nombre,id_especie_fk) VALUES('helix aspersa',5);

INSERT INTO tratamiento (nombre,descripcion) VALUES('tratamiento contra garrapatas','tratamiento para quitar garrapatas');
INSERT INTO tratamiento (nombre,descripcion) VALUES('tratamiento contra pulgas','tratamiento para quitar pulgas');
INSERT INTO tratamiento (nombre,descripcion) VALUES('analisis general','veterinario hace analisis general de mascota');
INSERT INTO tratamiento (nombre,descripcion) VALUES('enyesado','se pone un yeso en la mascota');
INSERT INTO tratamiento (nombre,descripcion) VALUES('recetamiento de medicacion','se receta medicacion');

INSERT INTO vacuna (nombre,descripcion) VALUES('vacuna contra la rabia','vacuna que toma efecto contra la rabia');
INSERT INTO vacuna (nombre,descripcion) VALUES('vacuna contra la sarna','vacuna que toma efecto contra la sarna');
INSERT INTO vacuna (nombre,descripcion) VALUES('vacuna contra el VIF','vacuna que toma efecto contra el Virus de Inmunodeficiencia Felina');
INSERT INTO vacuna (nombre,descripcion) VALUES('vacuna contra el FHV','vacuna que toma efecto contra el Herpesvirus Felina');
INSERT INTO vacuna (nombre,descripcion) VALUES('vacuna contra la Esquistosomiasis','vacuna que toma efecto contra la Esquistosomiasis de caracoles');

INSERT INTO cirugia (nombre,descripcion) VALUES('cirugia de riñon','Se hace una operacion sobre el riñon');
INSERT INTO cirugia (nombre,descripcion) VALUES('cirugia de corazon','Se hace una operacion sobre el corazon');
INSERT INTO cirugia (nombre,descripcion) VALUES('cirugia de estomago','Se hace una operacion sobre el estomago');
INSERT INTO cirugia (nombre,descripcion) VALUES('cirugia de intestino','Se hace una operacion sobre el intestino');
INSERT INTO cirugia (nombre,descripcion) VALUES('cirugia de pancreas','Se hace una operacion sobre el pancreas');

INSERT INTO salud (nombre,descripcion) VALUES('extremadamente saludable','esta mascota esta en mejor estado fisico que la media');
INSERT INTO salud (nombre,descripcion) VALUES('saludable','esta mascota esta saludable');
INSERT INTO salud (nombre,descripcion) VALUES('no saludable','esta mascota no esta saludable, pero no esta enferma');
INSERT INTO salud (nombre,descripcion) VALUES('enferma','esta mascota esta enferma');
INSERT INTO salud (nombre,descripcion) VALUES('muerta','esta mascota esta muerta');

INSERT INTO estado_mascotas (nombre,descripcion) VALUES('disponible','esta mascota esta disponible');
INSERT INTO estado_mascotas (nombre,descripcion) VALUES('no disponible','esta mascota no esta disponible');

INSERT INTO tipo_vivienda (nombre,descripcion) VALUES('monoambiente','la vivienda es un monoambiente');
INSERT INTO tipo_vivienda (nombre,descripcion) VALUES('campo','la vivienda es un campo');
INSERT INTO tipo_vivienda (nombre,descripcion) VALUES('casa','la vivienda es una casa residencial');
INSERT INTO tipo_vivienda (nombre,descripcion) VALUES('sin vivienda fija','la familia no tiene una vivienda fija');
INSERT INTO tipo_vivienda (nombre,descripcion) VALUES('otro','si la vivienda no entra en ninguna otra categoria');

INSERT INTO vivienda (id_tipo_vivienda_fk,mt2_interior,mt2_exterior) VALUES(1,20.5,0);
INSERT INTO vivienda (id_tipo_vivienda_fk,mt2_interior,mt2_exterior) VALUES(2,50,10000);
INSERT INTO vivienda (id_tipo_vivienda_fk,mt2_interior,mt2_exterior) VALUES(3,50,10.1);
INSERT INTO vivienda (id_tipo_vivienda_fk,mt2_interior,mt2_exterior) VALUES(4,0,0);
INSERT INTO vivienda (id_tipo_vivienda_fk,mt2_interior,mt2_exterior) VALUES(5,0,99999999.99);

INSERT INTO adoptantes (id_vivienda_fk, nombre, direccion, telefono, email) VALUES
(1, 'Juan Pérez', 'Calle 123', '123456789', 'juan@example.com'),
(2, 'María González', 'Av. Principal', '987654321', 'maria@example.com'),
(3, 'Pedro Rodríguez', 'Calle Secundaria', '456789123', 'pedro@example.com'),
(4, 'Ana Martínez', 'Av. Central', '654321987', 'ana@example.com'),
(5, 'Luisa García', 'Calle Peatonal', '321654987', 'luisa@example.com');

INSERT INTO preferencias (id_adoptante_fk, id_tamano_fk, id_raza_fk, nacimiento) VALUES
(1, 1, 1, '2010-05-15'),
(2, 2, 2, '2015-08-20'),
(3, 3, 3, '2020-01-10'),
(4, 4, 4, '2018-11-30'),
(5, 5, 5, '0001-01-01');

INSERT INTO mascotas (id_estado_mascotas_fk, id_raza_fk, id_salud_fk, nombre, edad, genero) VALUES
(1, 5, 1, 'Fido', 5, 'Macho'),
(2, 4, 2, 'Luna', 3, 'Hembra'),
(1, 3, 3, 'Max', 2, 'Macho'),
(2, 2, 4, 'Mimi', 4, 'Hembra'),
(1, 1, 5, 'Rocky', 6, 'Macho');


INSERT INTO historial (id_cirugia_fk,id_mascotas_fk, fecha) VALUES (1,5, '2022-02-10');
INSERT INTO historial (id_vacuna_fk,id_mascotas_fk, fecha) VALUES (2,2, '2021-07-15');
INSERT INTO historial (id_tratamiento_fk,id_mascotas_fk, fecha) VALUES (3,1, '2020-11-20');
INSERT INTO historial (id_vacuna_fk,id_mascotas_fk, fecha) VALUES (4,3, '2019-04-05');
INSERT INTO historial (id_cirugia_fk,id_mascotas_fk, fecha) VALUES (5,4, '2018-09-30');

INSERT INTO estado (nombre) VALUES ('iniciado'), ('terminado'), ('En proceso de adopción');

INSERT INTO adopcion (id_adoptante_fk, id_mascotas_fk, id_estado_fk, fecha) VALUES 
(1, 1, 1, '2024-02-20'),
(2, 2, 2, '2024-03-01'), 
(3, 3, 3, '2024-3-01'), 
(4, 4, 1, '2024-03-01'), 
(5, 5, 2, '2024-3-01');

INSERT INTO voluntario (direccion, telefono, email, nacimiento, genero) VALUES
('123 Main St', '555-1234', 'johndoe@example.com', '1990-01-15', 'Hombre'),
('456 Elm St', '555-5678', 'janedoe@example.com', '1985-07-25', 'Mujer'),
('789 Oak St', '555-9876', 'alexsmith@example.com', '1995-03-10', 'Hombre'),
('321 Pine St', '555-4321', 'sarahjones@example.com', '1980-11-30', 'Mujer'),
('654 Maple St', '555-8765', 'mikebrown@example.com', '1992-09-20', 'Hombre');