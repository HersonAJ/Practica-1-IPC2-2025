-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS Salon_De_Belleza;
USE Salon_De_Belleza;

-- Crear la tabla Usuarios
CREATE TABLE IF NOT EXISTS Usuarios (
    ID_Usuario INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(255) NOT NULL,
    DPI VARCHAR(20) NOT NULL,
    Telefono VARCHAR(15) NOT NULL,
    Direccion VARCHAR(255),
    Correo VARCHAR(255) UNIQUE NOT NULL, -- UNIQUE para que un correo solo tenga una cuenta
    Contraseña VARCHAR(255) NOT NULL,
    Foto_Perfil VARCHAR(255),
    Hobbies TEXT,
    Descripción TEXT,
    Rol ENUM('Cliente', 'Empleado', 'Administrador', 'Marketing', 'Servicios') NOT NULL,
    Estado ENUM('Activo', 'Inactivo') NOT NULL
);

-- Crear la tabla Servicios
CREATE TABLE IF NOT EXISTS Servicios (
    ID_Servicio INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_Servicio VARCHAR(255) NOT NULL,
    Descripción TEXT,
    Duración INT NOT NULL,
    Precio DECIMAL(10,2) NOT NULL,
    Estado ENUM('Visible', 'Oculto') NOT NULL,
    ID_Encargado INT,
    FOREIGN KEY (ID_Encargado) REFERENCES Usuarios(ID_Usuario)
);

-- Crear la tabla Citas
CREATE TABLE IF NOT EXISTS Citas (
    ID_Cita INT AUTO_INCREMENT PRIMARY KEY,
    ID_Servicio INT,
    ID_Cliente INT,
    ID_Empleado INT,
    Fecha_Cita DATE NOT NULL,
    Hora_Cita TIME NOT NULL,
    Estado ENUM('Pendiente', 'Atendida', 'Cancelada', 'No Presentado') NOT NULL,
    Factura_Generada BOOLEAN NOT NULL DEFAULT 0,
    FOREIGN KEY (ID_Servicio) REFERENCES Servicios(ID_Servicio),
    FOREIGN KEY (ID_Cliente) REFERENCES Usuarios(ID_Usuario),
    FOREIGN KEY (ID_Empleado) REFERENCES Usuarios(ID_Usuario)
);

-- Crear la tabla Facturas
CREATE TABLE IF NOT EXISTS Facturas (
    ID_Factura INT AUTO_INCREMENT PRIMARY KEY,
    ID_Cita INT,
    Total DECIMAL(10,2) NOT NULL,
    Fecha_Factura DATE NOT NULL,
    Detalles TEXT,
    URL_PDF VARCHAR(255), -- Ruta del archivo PDF de la factura
    FOREIGN KEY (ID_Cita) REFERENCES Citas(ID_Cita)
);

-- Crear la tabla Anuncios
CREATE TABLE IF NOT EXISTS Anuncios (
    ID_Anuncio INT AUTO_INCREMENT PRIMARY KEY,
    Tipo_Anuncio ENUM('Texto', 'Imagen', 'Video') NOT NULL,
    Contenido_Anuncio TEXT NOT NULL,
    Tiempo_Duración INT NOT NULL,
    Fecha_Creacion DATE NOT NULL, 
    Estado ENUM('Activo', 'Inactivo', 'Caducado') NOT NULL,
    ID_Marketing INT,
    Precio_Diario DECIMAL(10,2),
    FOREIGN KEY (ID_Marketing) REFERENCES Usuarios(ID_Usuario)
);

-- Crear la tabla Historial_Anuncios
CREATE TABLE IF NOT EXISTS Historial_Anuncios (
    ID_Historial INT AUTO_INCREMENT PRIMARY KEY,
    ID_Anuncio INT,
    Veces_Mostrado INT NOT NULL,
    Intervalo VARCHAR(255),
    URL VARCHAR(255),
    FOREIGN KEY (ID_Anuncio) REFERENCES Anuncios(ID_Anuncio)
);

-- Crear la tabla Lista_Negra
CREATE TABLE IF NOT EXISTS Lista_Negra (
    ID_Lista INT AUTO_INCREMENT PRIMARY KEY,
    ID_Cliente INT,
    ID_Cita INT, 
    Motivo TEXT,
    Estado ENUM('En Lista', 'Permitido') NOT NULL,
    FOREIGN KEY (ID_Cliente) REFERENCES Usuarios(ID_Usuario),
    FOREIGN KEY (ID_Cita) REFERENCES Citas(ID_Cita)
);

-- Crear la tabla Horarios
CREATE TABLE IF NOT EXISTS Horarios (
    ID_Horario INT AUTO_INCREMENT PRIMARY KEY,
    Hora_Apertura TIME NOT NULL,
    Hora_Cierre TIME NOT NULL,
    Día_Semana TINYINT NOT NULL, 
    ID_Empleado INT NULL, 
    FOREIGN KEY (ID_Empleado) REFERENCES Usuarios(ID_Usuario)
);

-- Crear la tabla Pagos_Anuncios
CREATE TABLE IF NOT EXISTS Pagos_Anuncios (
    ID_Pago INT AUTO_INCREMENT PRIMARY KEY,
    ID_Anuncio INT,
    Monto DECIMAL(10,2) NOT NULL,
    Fecha_Pago DATE NOT NULL,
    Comprador VARCHAR(255) NOT NULL, 
    FOREIGN KEY (ID_Anuncio) REFERENCES Anuncios(ID_Anuncio)
);
