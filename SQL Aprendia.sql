
-- Base de Datos 
CREATE DATABASE Plataforma_Cursos_Aprendia;
use Plataforma_Cursos_Aprendia;
-- 1. Tabla Plan
CREATE TABLE Plan (
Id_plan BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
Nombre VARCHAR(100) NOT NULL,
Descripcion TEXT NOT NULL,
Precio DECIMAL(10,2) NOT NULL,
Moneda VARCHAR(3) NOT NULL DEFAULT 'USD',
Duracion_dias INT NOT NULL,
Max_cursos INT,
Activo  BOOLEAN NOT NULL DEFAULT TRUE,
Fecha_creacion DATETIME NOT NULL,
PRIMARY KEY (Id_plan)
);

-- 2. Tabla Usuario 
CREATE TABLE Usuario (
Id_usuario BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
Nombre VARCHAR(100) NOT NULL,
Apellido VARCHAR(100) NOT NULL,
Correo VARCHAR(255) NOT NULL UNIQUE,
Rol ENUM('profesor', 'estudiante') NOT NULL,
Pais VARCHAR(100) NOT NULL,
Ciudad VARCHAR(100) NOT NULL,
Telefono VARCHAR(50),
Fecha_Creacion DATETIME NOT NULL,
PRIMARY KEY (Id_usuario)
);

-- 3. Tabla Curso
CREATE TABLE Curso (
Id_curso BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
Profesor_id  BIGINT UNSIGNED NOT NULL,
Titulo VARCHAR(300),
Descripcion TEXT NOT NULL,
Categoria VARCHAR(100) NOT NULL,
Nivel ENUM('Principiante', 'Intermedio', 'Avanzado') NOT NULL,
Fecha_creacion DATETIME NOT NULL,
Idioma VARCHAR(50) NOT NULL,
Imagen_url VARCHAR(500),
Publicado BOOLEAN NOT NULL DEFAULT FALSE,
Fecha_publicacion DATETIME,
PRIMARY KEY (Id_curso),
FOREIGN KEY (Profesor_id) REFERENCES Usuario(Id_usuario)
);

-- 4. Tabla Modulo
CREATE TABLE Modulo (
Id_modulo BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
Curso_id BIGINT UNSIGNED NOT NULL,
Titulo VARCHAR(300) NOT NULL,
Descripcion TEXT NOT NULL,
Orden INT NOT NULL,
Fecha_creacion DATETIME NOT NULL,
PRIMARY KEY (Id_modulo),
FOREIGN KEY (Curso_id) REFERENCES Curso(Id_curso)
);

-- 5. Tabla Leccion
CREATE TABLE Leccion (
Id_leccion BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
Modulo_id BIGINT UNSIGNED NOT NULL,
Titulo VARCHAR(300) NOT NULL,
Descripcion TEXT NOT NULL, 
Duracion_minutos INT NOT NULL,
Orden INT NOT NULL,
Fecha_creacion DATETIME NOT NULL,
PRIMARY KEY (Id_leccion),
FOREIGN KEY (Modulo_id) REFERENCES Modulo(Id_modulo)
);

-- 6. Tabla Material_Leccion
CREATE TABLE Material_leccion (
Id_material BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
Leccion_id BIGINT UNSIGNED NOT NULL,
Tipo ENUM('video', 'document', 'quiz', 'link') NOT NULL,
Titulo VARCHAR(300) NOT NULL,
Url_contenido VARCHAR(500) NOT NULL,
Orden INT NOT NULL,
Fecha_creacion DATETIME NOT NULL,
PRIMARY KEY (Id_material),
FOREIGN KEY (Leccion_id) REFERENCES Leccion(Id_leccion)
);

-- 7. Tabla Inscripcion
CREATE TABLE Inscripcion (
Id_Inscripcion BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
Usuario_id BIGINT UNSIGNED NOT NULL,
Curso_id BIGINT UNSIGNED NOT NULL,
Porcentaje_progreso DECIMAL(5,2) NOT NULL DEFAULT 0.00,
Estado ENUM('activo', 'completado', 'abandonado') NOT NULL,
Fecha_inscripcion DATETIME NOT NULL,
Fecha_finalizacion DATETIME,
Fecha_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (Id_Inscripcion),
	UNIQUE (Usuario_id, Curso_id),
    
    FOREIGN KEY (Usuario_id) REFERENCES Usuario(Id_usuario),
    FOREIGN KEY (Curso_id) REFERENCES Curso(Id_curso)
);

-- 8. Tabla Suscripcion
CREATE TABLE Suscripcion (
Id_suscripcion BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
Usuario_id BIGINT UNSIGNED NOT NULL,
Plan_id BIGINT UNSIGNED NOT NULL,
Estado ENUM('activo', 'expirado', 'cancelado') NOT NULL,
Fecha_inicio DATE NOT NULL,
Fecha_fin DATE NOT NULL,
Renovacion_automatica  BOOLEAN NOT NULL DEFAULT TRUE,
Fecha_creacion DATETIME NOT NULL,
PRIMARY KEY (Id_suscripcion),
FOREIGN KEY (Usuario_id) REFERENCES Usuario(Id_usuario),
FOREIGN KEY (Plan_id) REFERENCES Plan(Id_plan)
);

-- 9. Tabla Pago 
CREATE TABLE Pago (
Id_pago BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
Suscripcion_id BIGINT UNSIGNED NOT NULL,
Monto DECIMAL(10,2) NOT NULL,
Moneda VARCHAR(3) NOT NULL DEFAULT 'USD',
Metodo_pago VARCHAR(50) NOT NULL,
Estado ENUM('completado','pendiente','fallido','reembolsado') NOT NULL,
Referencia_transaccion VARCHAR(100) NOT NULL,
Fecha_pago DATETIME NOT NULL,
Fecha_creacion DATETIME NOT NULL,
PRIMARY KEY (Id_pago),
FOREIGN KEY (Suscripcion_id) REFERENCES Suscripcion(Id_suscripcion) 
);

-- 10. Tabla Detalle_Estudiante
CREATE TABLE Detalle_estudiante (
Id_detalle_estudiante BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
Usuario_id BIGINT UNSIGNED NOT NULL UNIQUE,
Nivel_educativo VARCHAR(100) NOT NULL,
Intereses TEXT NOT NULL,
Ocupacion VARCHAR(200) NOT NULL,
Fecha_nacimiento DATE NOT NULL,
Fecha_creacion DATETIME NOT NULL,
PRIMARY KEY (Id_detalle_estudiante),
FOREIGN KEY (Usuario_id) REFERENCES Usuario(Id_usuario)
);

-- 11. Tabla Detalle Profesor 
CREATE TABLE Detalle_Profesor (
Id_detalle_profesor BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
Usuario_id BIGINT UNSIGNED NOT NULL UNIQUE,
Biografia TEXT NOT NULL,
Especialidad VARCHAR(200) NOT NULL,
Linkedin_url VARCHAR(500),
Anios_experiencia INT NOT NULL,
Fecha_creacion DATETIME NOT NULL,
PRIMARY KEY (Id_detalle_profesor),
FOREIGN KEY (Usuario_id) REFERENCES Usuario(Id_usuario)
);

-- 12. Tabla Certificado 
CREATE TABLE Certificado (
Id_certificado BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
Usuario_id BIGINT UNSIGNED NOT NULL,
Curso_id BIGINT UNSIGNED NOT NULL,
Codigo_certificado VARCHAR(50) NOT NULL UNIQUE,
Fecha_emision DATETIME NOT NULL,
Fecha_creacion DATETIME NOT NULL,
PRIMARY KEY (Id_certificado),
UNIQUE (Usuario_id, Curso_id),
FOREIGN KEY (Usuario_id) REFERENCES Usuario(Id_usuario),
FOREIGN KEY (Curso_id) REFERENCES Curso(Id_curso)
);

ALTER TABLE leccion
ADD COLUMN Descripcion TEXT NOT NULL;
