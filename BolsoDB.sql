USE BolsoDB;

-- Eliminar tablas si ya existen
DROP TABLE IF EXISTS Productos, MateriaPrima, Proveedores, InventarioProductos, InventarioMateriasPrimas, Empleados, Clientes, Ventas, Finanzas, Producción, Envíos, Logística, Reseñas;

-- Crear la tabla Proveedores
CREATE TABLE Proveedores (
    ID_Proveedor INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_Proveedor VARCHAR(255) NOT NULL,
    Teléfono VARCHAR(15),
    Email VARCHAR(255),
    País VARCHAR(100),
    Dirección TEXT
);

-- Crear la tabla Productos
CREATE TABLE Productos (
    ID_Producto INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(255) NOT NULL,
    Descripción TEXT,
    Precio DECIMAL(10, 2) NOT NULL,
    Stock INT NOT NULL,
    FechaCreación DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Crear la tabla MateriaPrima
CREATE TABLE MateriaPrima (
    ID_Material INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_Material VARCHAR(255) NOT NULL,
    Tipo_Material VARCHAR(100) NOT NULL,
    Cantidad_Disponible INT NOT NULL,
    Costo_Unitario DECIMAL(10, 2) NOT NULL,
    Unidad VARCHAR(50) NOT NULL,
    ID_Proveedor INT,
    FOREIGN KEY (ID_Proveedor) REFERENCES Proveedores(ID_Proveedor)
);

-- Crear la tabla InventarioProductos
CREATE TABLE InventarioProductos (
    ID_InventarioProducto INT AUTO_INCREMENT PRIMARY KEY,
    ID_Producto INT NOT NULL,
    Cantidad INT NOT NULL,
    ÚltimaActualización TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (ID_Producto) REFERENCES Productos(ID_Producto)
);


-- Crear la tabla Empleados
CREATE TABLE IF NOT EXISTS Empleados (
    ID_Empleado INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(255) NOT NULL,
    Apellido VARCHAR(255) NOT NULL,
    Puesto VARCHAR(100) NOT NULL,
    Salario DECIMAL(10, 2) NOT NULL,
    FechaContratación DATETIME DEFAULT CURRENT_TIMESTAMP,
    Departamento VARCHAR(100) NOT NULL
);

-- Crear la tabla Clientes
CREATE TABLE Clientes (
    ID_Cliente INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(255) NOT NULL,
    Apellido VARCHAR(255) NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    Teléfono VARCHAR(15),
    Preferencias TEXT,
    FechaRegistro DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Crear la tabla Ventas
CREATE TABLE Ventas (
    ID_Venta INT AUTO_INCREMENT PRIMARY KEY,
    ID_Cliente INT,
    FechaVenta DATETIME DEFAULT CURRENT_TIMESTAMP,
    Total DECIMAL(10, 2) NOT NULL,
    Estado ENUM('Pendiente', 'Completada', 'Cancelada') DEFAULT 'Pendiente',
    FOREIGN KEY (ID_Cliente) REFERENCES Clientes(ID_Cliente)
);


-- Crear la tabla Producción
CREATE TABLE Producción (
    ID_Producción INT AUTO_INCREMENT PRIMARY KEY,
    ID_Producto INT,
    Cantidad_Producida INT NOT NULL,
    Fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
    Costo_Producción DECIMAL(10, 2) NOT NULL,
    FechaProducción DATETIME DEFAULT CURRENT_TIMESTAMP,  -- Columna añadida
    FOREIGN KEY (ID_Producto) REFERENCES Productos(ID_Producto)
);

-- Crear la tabla Envíos
CREATE TABLE Envíos (
    ID_Envío INT AUTO_INCREMENT PRIMARY KEY,
    ID_Venta INT,
    Dirección TEXT NOT NULL,
    FechaEnvío DATETIME DEFAULT CURRENT_TIMESTAMP,
    FechaEntrega DATETIME,
    Estado ENUM('En tránsito', 'Entregado', 'Devuelto') DEFAULT 'En tránsito',
    CostoEnvío DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (ID_Venta) REFERENCES Ventas(ID_Venta)
);

-- Crear la tabla Logística
CREATE TABLE Logística (
    ID_Logística INT AUTO_INCREMENT PRIMARY KEY,
    Tipo ENUM('Transporte', 'Almacenamiento') NOT NULL,
    Costo DECIMAL(10, 2) NOT NULL,
    ID_Proveedor INT,
    FechaInicio DATETIME,
    FechaFin DATETIME,
    FOREIGN KEY (ID_Proveedor) REFERENCES Proveedores(ID_Proveedor)
);

-- Crear la tabla Reseñas
CREATE TABLE Reseñas (
    ID_Reseña INT AUTO_INCREMENT PRIMARY KEY,
    ID_Producto INT,
    ID_Cliente INT,
    Calificación TINYINT CHECK (Calificación BETWEEN 1 AND 5),
    Comentario TEXT,
    Fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ID_Producto) REFERENCES Productos(ID_Producto),
    FOREIGN KEY (ID_Cliente) REFERENCES Clientes(ID_Cliente)
);

-- Insertar datos en la tabla Productos
INSERT INTO Productos (Nombre, Descripción, Precio, Stock) VALUES
('Bolso Convertible Rojo', 'Bolso convertible en suéter de color rojo, material sintético.', 999.00, 50),
('Bolso Convertible Azul', 'Bolso convertible en suéter de color azul, material sintético.', 999.00, 45),
('Bolso Convertible Verde', 'Bolso convertible en suéter de color verde, material sintético.', 999.00, 60),
('Bolso Convertible Negro', 'Bolso convertible en suéter de color negro, material sintético.', 999.00, 70),
('Bolso Convertible Amarillo', 'Bolso convertible en suéter de color amarillo, material sintético.', 999.00, 55),
('Bolso Convertible Gris', 'Bolso convertible en suéter de color gris, material sintético.', 999.00, 65),
('Bolso Convertible Blanco', 'Bolso convertible en suéter de color blanco, material sintético.', 999.00, 40),
('Bolso Convertible Rosa', 'Bolso convertible en suéter de color rosa, material sintético.', 999.00, 50),
('Bolso Convertible Morado', 'Bolso convertible en suéter de color morado, material sintético.', 999.00, 45),
('Bolso Convertible Naranja', 'Bolso convertible en suéter de color naranja, material sintético.', 999.00, 60),
('Bolso Convertible Marrón', 'Bolso convertible en suéter de color marrón, material sintético.', 999.00, 70),
('Bolso Convertible Turquesa', 'Bolso convertible en suéter de color turquesa, material sintético.', 999.00, 55),
('Bolso Convertible Violeta', 'Bolso convertible en suéter de color violeta, material sintético.', 999.00, 65),
('Bolso Convertible Celeste', 'Bolso convertible en suéter de color celeste, material sintético.', 999.00, 40),
('Bolso Convertible Beige', 'Bolso convertible en suéter de color beige, material sintético.', 999.00, 50),
('Bolso Convertible Coral', 'Bolso convertible en suéter de color coral, material sintético.', 999.00, 45),
('Bolso Convertible Lila', 'Bolso convertible en suéter de color lila, material sintético.', 999.00, 60),
('Bolso Convertible Oliva', 'Bolso convertible en suéter de color oliva, material sintético.', 999.00, 70),
('Bolso Convertible Mostaza', 'Bolso convertible en suéter de color mostaza, material sintético.', 999.00, 55),
('Bolso Convertible Azul Marino', 'Bolso convertible en suéter de color azul marino, material sintético.', 999.00, 65),
('Bolso Convertible Verde Lima', 'Bolso convertible en suéter de color verde lima, material sintético.', 999.00, 40),
('Bolso Convertible Azul Cielo', 'Bolso convertible en suéter de color azul cielo, material sintético.', 999.00, 45),
('Bolso Convertible Verde Menta', 'Bolso convertible en suéter de color verde menta, material sintético.', 999.00, 60),
('Bolso Convertible Marrón Oscuro', 'Bolso convertible en suéter de color marrón oscuro, material sintético.', 999.00, 70),
('Bolso Convertible Gris Claro', 'Bolso convertible en suéter de color gris claro, material sintético.', 999.00, 55),
('Bolso Convertible Blanco Perla', 'Bolso convertible en suéter de color blanco perla, material sintético.', 999.00, 65),
('Bolso Convertible Rosa Pastel', 'Bolso convertible en suéter de color rosa pastel, material sintético.', 999.00, 40),
('Bolso Convertible Morado Oscuro', 'Bolso convertible en suéter de color morado oscuro, material sintético.', 999.00, 50),
('Bolso Convertible Gris Oscuro', 'Bolso convertible en suéter de color gris oscuro, material sintético.', 999.00, 30),
('Bolso Convertible Marrón Claro', 'Bolso convertible en suéter de color marrón claro, material sintético.', 999.00, 55),
('Bolso Convertible Champagne', 'Bolso convertible en suéter de color champagne, material sintético.', 999.00, 45);

-- Insertar datos en la tabla Proveedores
INSERT INTO Proveedores (Nombre_Proveedor, Teléfono, Email, País, Dirección) VALUES
('Textiles México', '555-1234', 'contacto@textilesmexico.com', 'México', 'Calle Principal 123, CDMX'),
('Hilos y Telas', '555-5678', 'ventas@hilosytelas.com', 'México', 'Avenida Revolución 456, Guadalajara'),
('Accesorios Globales', '555-9876', 'info@accesoriosglobales.com', 'China', 'Zona Industrial 78, Shenzhen');

-- Insertar datos en la tabla MateriaPrima
INSERT INTO MateriaPrima (Nombre_Material, Tipo_Material, Cantidad_Disponible, Costo_Unitario, Unidad, ID_Proveedor) VALUES
('Tela Roja', 'Sintético', 200, 15.50, 'metros', 1),
('Tela Azul', 'Sintético', 180, 16.00, 'metros', 2),
('Tela Verde', 'Sintético', 220, 14.75, 'metros', 3),
('Tela Negra', 'Sintético', 250, 15.25, 'metros', 1),
('Tela Amarilla', 'Sintético', 190, 16.50, 'metros', 2),
('Tela Gris', 'Sintético', 210, 15.00, 'metros', 3),
('Tela Blanca', 'Sintético', 170, 14.80, 'metros', 1),
('Tela Rosa', 'Sintético', 200, 15.60, 'metros', 2),
('Tela Morada', 'Sintético', 180, 14.90, 'metros', 3),
('Tela Naranja', 'Sintético', 220, 16.10, 'metros', 1),
('Tela Marrón', 'Sintético', 250, 15.40, 'metros', 2),
('Tela Turquesa', 'Sintético', 190, 15.30, 'metros', 3),
('Tela Violeta', 'Sintético', 210, 15.20, 'metros', 1),
('Tela Celeste', 'Sintético', 170, 14.60, 'metros', 2),
('Tela Beige', 'Sintético', 200, 15.00, 'metros', 3),
('Tela Coral', 'Sintético', 180, 15.10, 'metros', 1),
('Tela Lila', 'Sintético', 220, 16.00, 'metros', 2),
('Tela Oliva', 'Sintético', 250, 15.50, 'metros', 3),
('Tela Mostaza', 'Sintético', 170, 14.80, 'metros', 1),
('Tela Azul Marino', 'Sintético', 200, 15.30, 'metros', 2),
('Tela Verde Lima', 'Sintético', 180, 14.90, 'metros', 3),
('Tela Azul Cielo', 'Sintético', 220, 15.10, 'metros', 1),
('Tela Verde Menta', 'Sintético', 250, 15.60, 'metros', 2),
('Tela Marrón Oscuro', 'Sintético', 190, 15.25, 'metros', 3),
('Tela Gris Claro', 'Sintético', 210, 15.20, 'metros', 1),
('Tela Blanco Perla', 'Sintético', 170, 14.75, 'metros', 2),
('Tela Rosa Pastel', 'Sintético', 200, 15.40, 'metros', 3),
('Tela Morado Oscuro', 'Sintético', 180, 14.60, 'metros', 1);


-- Insertar datos en la tabla InventarioProductos
INSERT INTO InventarioProductos (ID_Producto, Cantidad) VALUES
(1, 50),  -- Bolso Convertible Rojo
(2, 45),  -- Bolso Convertible Azul
(3, 60),  -- Bolso Convertible Verde
(4, 70),  -- Bolso Convertible Negro
(5, 55),  -- Bolso Convertible Amarillo
(6, 65),  -- Bolso Convertible Gris
(7, 40),  -- Bolso Convertible Blanco
(8, 50),  -- Bolso Convertible Rosa
(9, 45),  -- Bolso Convertible Morado
(10, 60), -- Bolso Convertible Naranja
(11, 70), -- Bolso Convertible Marrón
(12, 55), -- Bolso Convertible Turquesa
(13, 65), -- Bolso Convertible Violeta
(14, 40), -- Bolso Convertible Celeste
(15, 50), -- Bolso Convertible Beige
(16, 45), -- Bolso Convertible Coral
(17, 60), -- Bolso Convertible Lila
(18, 70), -- Bolso Convertible Oliva
(19, 55), -- Bolso Convertible Mostaza
(20, 65), -- Bolso Convertible Azul Marino
(21, 40), -- Bolso Convertible Verde Lima
(22, 45), -- Bolso Convertible Azul Cielo
(23, 60), -- Bolso Convertible Verde Menta
(24, 70), -- Bolso Convertible Marrón Oscuro
(25, 55), -- Bolso Convertible Gris Claro
(26, 65), -- Bolso Convertible Blanco Perla
(27, 40), -- Bolso Convertible Rosa Pastel
(28, 50); -- Bolso Convertible Morado Oscuro

-- Insertar datos en la tabla Empleados
INSERT INTO Empleados (Nombre, Apellido, Puesto, Salario, Departamento) VALUES
('Daniel', 'Gómez', 'Gerente', 3000.00, 'Ventas'),
('Laura', 'Pérez', 'Vendedora', 2000.00, 'Ventas'),
('Carlos', 'López', 'Vendedor', 2000.00, 'Ventas'),
('Ana', 'Martínez', 'Administrativa', 2500.00, 'Administración'),
('Luis', 'Sánchez', 'Vendedor', 2200.00, 'Ventas'),
('María', 'García', 'Vendedora', 2200.00, 'Ventas'),
('Pedro', 'Hernández', 'Vendedor', 2000.00, 'Ventas'),
('Lucía', 'Ramírez', 'Vendedora', 2000.00, 'Ventas'),
('Javier', 'Rodríguez', 'Gerente', 3500.00, 'Ventas'),
('Sara', 'Torres', 'Vendedora', 2000.00, 'Ventas');

-- Insertar datos en la tabla Clientes
INSERT INTO Clientes (Nombre, Apellido, Email, Teléfono, Preferencias, FechaRegistro) VALUES
('Daniel', 'Manrique', 'danielb@ejemplo.com', '555-1234', 'Colores vivos', '2024-01-01'),
('Laura', 'Pérez', 'laura_perez@ejemplo.com', '555-5678', 'Diseños clásicos', '2024-01-02'),
('Carlos', 'Sánchez', 'carlos_s@ejemplo.com', '555-9876', 'Resistencia al agua', '2024-01-03'),
('Ana', 'Gómez', 'ana_g@ejemplo.com', '555-1122', 'Compactos y ligeros', '2024-01-04'),
('Luis', 'Ramírez', 'luis_r@ejemplo.com', '555-3344', 'Moda sostenible', '2024-01-05'),
('María', 'Martínez', 'maria_m@ejemplo.com', '555-7788', 'Accesorios elegantes', '2024-01-06'),
('Pedro', 'González', 'pedro_g@ejemplo.com', '555-9911', 'Diseños modernos', '2024-01-07'),
('Lucía', 'Fernández', 'lucia_f@ejemplo.com', '555-2233', 'Comodidad y estilo', '2024-01-08'),
('Javier', 'López', 'javier_l@ejemplo.com', '555-4455', 'Materiales resistentes', '2024-01-09'),
('Sara', 'Jiménez', 'sara_j@ejemplo.com', '555-5566', 'Practicidad', '2024-01-10'),
('Sofía', 'Castro', 'sofia_c@ejemplo.com', '555-7788', 'Colores pastel', '2024-01-11'),
('Fernando', 'Morales', 'fernando_m@ejemplo.com', '555-6677', 'Estilo casual', '2024-01-12'),
('Adriana', 'Luna', 'adriana_l@ejemplo.com', '555-8899', 'Estilo ejecutivo', '2024-01-13'),
('Gabriel', 'Hernández', 'gabriel_h@ejemplo.com', '555-3345', 'Diseños juveniles', '2024-01-14'),
('Elena', 'Flores', 'elena_f@ejemplo.com', '555-2234', 'Resistentes y ligeros', '2024-01-15'),
('Jorge', 'Ríos', 'jorge_r@ejemplo.com', '555-4456', 'Compactos y resistentes', '2024-01-16'),
('Valeria', 'Cruz', 'valeria_c@ejemplo.com', '555-6678', 'Diseños exclusivos', '2024-01-17'),
('Francisco', 'Torres', 'francisco_t@ejemplo.com', '555-7789', 'Moda clásica', '2024-01-18'),
('Luciana', 'Vargas', 'luciana_v@ejemplo.com', '555-8890', 'Colores vibrantes', '2024-01-19'),
('Roberto', 'Navarro', 'roberto_n@ejemplo.com', '555-3346', 'Accesorios con estilo', '2024-01-20'),
('Isabel', 'Díaz', 'isabel_d@ejemplo.com', '555-2235', 'Prendas multifuncionales', '2024-01-21'),
('Alejandro', 'Cortés', 'alejandro_c@ejemplo.com', '555-4457', 'Tonos neutros', '2024-01-22'),
('Fernanda', 'Reyes', 'fernanda_r@ejemplo.com', '555-6679', 'Durabilidad y estilo', '2024-01-23'),
('Miguel', 'López', 'miguel_l@ejemplo.com', '555-7780', 'Accesorios versátiles', '2024-01-24'),
('Patricia', 'Álvarez', 'patricia_a@ejemplo.com', '555-8891', 'Moda ecológica', '2024-01-25'),
('Iván', 'Silva', 'ivan_s@ejemplo.com', '555-3347', 'Estilo funcional', '2024-01-26'),
('Camila', 'Ortiz', 'camila_o@ejemplo.com', '555-2236', 'Practicidad y durabilidad', '2024-01-27'),
('Diego', 'Mendoza', 'diego_m@ejemplo.com', '555-4458', 'Estilo deportivo', '2024-01-28'),
('Natalia', 'Ramírez', 'natalia_r@ejemplo.com', '555-6670', 'Colores metálicos', '2024-01-29'),
('Raúl', 'Espinoza', 'raul_e@ejemplo.com', '555-7781', 'Diseños atrevidos', '2024-01-30'),
('Gabriela', 'Cano', 'gabriela_cano@ejemplo.com', '555-8892', 'Estilo minimalista', '2024-01-31'),
('Antonio', 'Vega', 'antonio_v@ejemplo.com', '555-3348', 'Diseños exclusivos', '2024-02-01'),
('Adriana', 'Navarrete', 'adriana_n@ejemplo.com', '555-2237', 'Tonos tierra', '2024-02-02'),
('Ricardo', 'Flores', 'ricardo_f@ejemplo.com', '555-4459', 'Estilo vintage', '2024-02-03'),
('Carmen', 'Torres', 'carmen_t@ejemplo.com', '555-6671', 'Practicidad moderna', '2024-02-04'),
('Esteban', 'Luna', 'esteban_l@ejemplo.com', '555-7782', 'Moda funcional', '2024-02-05'),
('Mariana', 'Paredes', 'mariana_p@ejemplo.com', '555-8893', 'Accesorios compactos', '2024-02-06'),
('José', 'Hernández', 'jose_h@ejemplo.com', '555-3349', 'Diseños ligeros', '2024-02-07'),
('Carolina', 'Martínez', 'carolina_m@ejemplo.com', '555-2238', 'Colores vivos', '2024-02-08'),
('Ángel', 'Morales', 'angel_m@ejemplo.com', '555-4460', 'Estilo sofisticado', '2024-02-09'),
('Santiago', 'Jiménez', 'santiago_j@ejemplo.com', '555-6672', 'Resistencia al agua', '2024-02-10'),
('Claudia', 'Vázquez', 'claudia_v@ejemplo.com', '555-7783', 'Moda casual', '2024-02-11'),
('Rosa', 'García', 'rosa_g@ejemplo.com', '555-8894', 'Colores llamativos', '2024-02-12'),
('Hugo', 'Ramos', 'hugo_r@ejemplo.com', '555-3350', 'Practicidad moderna', '2024-02-13'),
('Liliana', 'Sosa', 'liliana_s@ejemplo.com', '555-2239', 'Diseños compactos', '2024-02-14'),
('Eduardo', 'Gómez', 'eduardo_g@ejemplo.com', '555-4461', 'Estilo duradero', '2024-02-15'),
('Cristina', 'Cruz', 'cristina_c@ejemplo.com', '555-6673', 'Moda juvenil', '2024-02-16'),
('Andrés', 'Cárdenas', 'andres_c@ejemplo.com', '555-7784', 'Colores oscuros', '2024-02-17'),
('Paola', 'Figueroa', 'paola_f@ejemplo.com', '555-8895', 'Diseños versátiles', '2024-02-18');

SELECT * FROM Clientes;

-- Insertar datos en la tabla Ventas (sin especificar el campo ID_Venta, ya que es AUTO_INCREMENT)
INSERT INTO Ventas (ID_Cliente, Total, Estado, FechaVenta) VALUES
(1, 999.00, 'Completada', '2024-02-01'),  -- Daniel
(2, 1998.00, 'Completada', '2024-02-02'), -- Laura
(3, 2997.00, 'Pendiente', '2024-02-03'),  -- Carlos
(4, 999.00, 'Cancelada', '2024-02-04'),   -- Ana
(5, 1998.00, 'Completada', '2024-02-05'), -- Luis
(6, 999.00, 'Pendiente', '2024-02-06'),   -- María
(7, 2997.00, 'Completada', '2024-02-07'), -- Pedro
(8, 999.00, 'Pendiente', '2024-02-08'),   -- Lucía
(9, 3996.00, 'Completada', '2024-02-09'), -- Javier
(10, 2997.00, 'Cancelada', '2024-02-10'), -- Sara
(11, 1998.00, 'Completada', '2024-02-11'), -- Sofía
(12, 999.00, 'Pendiente', '2024-02-12'),   -- Fernando
(13, 2997.00, 'Completada', '2024-02-13'), -- Adriana
(14, 3996.00, 'Pendiente', '2024-02-14'),  -- Gabriel
(15, 999.00, 'Cancelada', '2024-02-15'),   -- Elena
(16, 999.00, 'Completada', '2024-02-16'),  -- Jorge
(17, 1998.00, 'Pendiente', '2024-02-17'),  -- Valeria
(18, 2997.00, 'Completada', '2024-02-18'), -- Francisco
(19, 3996.00, 'Pendiente', '2024-02-19'),  -- Luciana
(20, 1998.00, 'Completada', '2024-02-20'), -- Roberto
(21, 2997.00, 'Pendiente', '2024-02-21'),  -- Isabel
(22, 1998.00, 'Completada', '2024-02-22'), -- Alejandro
(23, 3996.00, 'Pendiente', '2024-02-23'),  -- Fernanda
(24, 1998.00, 'Completada', '2024-02-24'), -- Miguel
(25, 2997.00, 'Cancelada', '2024-02-25'),  -- Patricia
(26, 999.00, 'Pendiente', '2024-02-26'),   -- Iván
(27, 3996.00, 'Completada', '2024-02-27'), -- Camila
(28, 2997.00, 'Pendiente', '2024-02-28'),  -- Diego
(29, 1998.00, 'Completada', '2024-02-29'), -- Natalia
(30, 999.00, 'Pendiente', '2024-03-01'),   -- Raúl
(31, 2997.00, 'Completada', '2024-03-02'), -- Gabriela
(32, 3996.00, 'Pendiente', '2024-03-03'),  -- Antonio
(33, 1998.00, 'Completada', '2024-03-04'), -- Adriana N.
(34, 999.00, 'Pendiente', '2024-03-05'),   -- Ricardo
(35, 2997.00, 'Completada', '2024-03-06'), -- Carmen
(36, 3996.00, 'Pendiente', '2024-03-07'),  -- Esteban
(37, 1998.00, 'Completada', '2024-03-08'), -- Mariana
(38, 2997.00, 'Pendiente', '2024-03-09'),  -- José
(39, 3996.00, 'Completada', '2024-03-10'), -- Carolina
(40, 999.00, 'Pendiente', '2024-03-11'),   -- Ángel
(41, 1998.00, 'Completada', '2024-03-12'), -- Santiago
(42, 2997.00, 'Pendiente', '2024-03-13'),  -- Claudia
(43, 3996.00, 'Completada', '2024-03-14'), -- Rosa
(44, 1998.00, 'Pendiente', '2024-03-15'),  -- Hugo
(45, 999.00, 'Completada', '2024-03-16'),  -- Liliana
(46, 2997.00, 'Pendiente', '2024-03-17'),  -- Eduardo
(47, 3996.00, 'Completada', '2024-03-18'), -- Cristina
(48, 1998.00, 'Pendiente', '2024-03-19'),  -- Andrés
(49, 999.00, 'Completada', '2024-03-20');  -- Paola


-- Insertar datos en la tabla Producción
INSERT INTO Producción (ID_Producto, Cantidad_Producida, Costo_Producción, FechaProducción) VALUES
-- Producción inicial para ajustar el inventario
(1, 50, 5000.00, '2024-01-01'),  -- Bolso Convertible Rojo
(2, 45, 4500.00, '2024-01-02'),  -- Bolso Convertible Azul
(3, 60, 6000.00, '2024-01-03'),  -- Bolso Convertible Verde
(4, 70, 7000.00, '2024-01-04'),  -- Bolso Convertible Negro
(5, 55, 5500.00, '2024-01-05'),  -- Bolso Convertible Amarillo
(6, 65, 6500.00, '2024-01-06'),  -- Bolso Convertible Gris
(7, 40, 4000.00, '2024-01-07'),  -- Bolso Convertible Blanco
(8, 50, 5000.00, '2024-01-08'),  -- Bolso Convertible Rosa
(9, 45, 4500.00, '2024-01-09'),  -- Bolso Convertible Morado
(10, 60, 6000.00, '2024-01-10'), -- Bolso Convertible Naranja
(11, 70, 7000.00, '2024-01-11'), -- Bolso Convertible Marrón
(12, 55, 5500.00, '2024-01-12'), -- Bolso Convertible Turquesa
(13, 65, 6500.00, '2024-01-13'), -- Bolso Convertible Violeta
(14, 40, 4000.00, '2024-01-14'), -- Bolso Convertible Celeste
(15, 50, 5000.00, '2024-01-15'), -- Bolso Convertible Beige
(16, 45, 4500.00, '2024-01-16'), -- Bolso Convertible Coral
(17, 60, 6000.00, '2024-01-17'), -- Bolso Convertible Lila
(18, 70, 7000.00, '2024-01-18'), -- Bolso Convertible Oliva
(19, 55, 5500.00, '2024-01-19'), -- Bolso Convertible Mostaza
(20, 65, 6500.00, '2024-01-20'), -- Bolso Convertible Azul Marino
(21, 40, 4000.00, '2024-01-21'), -- Bolso Convertible Verde Lima
(22, 45, 4500.00, '2024-01-22'), -- Bolso Convertible Azul Cielo
(23, 60, 6000.00, '2024-01-23'), -- Bolso Convertible Verde Menta
(24, 70, 7000.00, '2024-01-24'), -- Bolso Convertible Marrón Oscuro
(25, 55, 5500.00, '2024-01-25'), -- Bolso Convertible Gris Claro
(26, 65, 6500.00, '2024-01-26'), -- Bolso Convertible Blanco Perla
(27, 40, 4000.00, '2024-01-27'), -- Bolso Convertible Rosa Pastel
(28, 50, 5000.00, '2024-01-28'); -- Bolso Convertible Morado Oscuro

-- Insertar datos en la tabla Envíos
INSERT INTO Envíos (ID_Venta, Dirección, FechaEnvío, FechaEntrega, Estado, CostoEnvío) VALUES
-- Ventas Completadas
(1, 'Av. México 123, Ciudad Bella', '2024-02-01', '2024-02-05', 'Entregado', 150.00),
(2, 'Calle Libertad 456, Villa Real', '2024-02-02', '2024-02-06', 'Entregado', 150.00),
(3, 'Calle del Sol 789, Pueblo Nuevo', '2024-02-05', '2024-02-10', 'Entregado', 200.00),
(4, 'Av. Revolución 321, Ciudad Jardín', '2024-02-07', '2024-02-12', 'Entregado', 180.00),
(5, 'Calle de los Olivos 654, Colonia Verde', '2024-02-09', '2024-02-15', 'Entregado', 200.00),
(6, 'Calle de las Flores 111, Villa del Lago', '2024-02-11', '2024-02-17', 'Entregado', 150.00),
(7, 'Calle Santa María 234, Santa Clara', '2024-02-13', '2024-02-19', 'Entregado', 200.00),
(8, 'Calle Hidalgo 567, La Esperanza', '2024-02-16', '2024-02-22', 'Entregado', 150.00),
(9, 'Av. Constitución 890, Monte Azul', '2024-02-18', '2024-02-24', 'Entregado', 180.00),
(10, 'Calle de la Paz 345, Ciudad Esperanza', '2024-02-20', '2024-02-26', 'Entregado', 200.00),
(11, 'Calle del Mar 678, Villa Dorada', '2024-02-22', '2024-02-28', 'Entregado', 180.00),
(12, 'Calle de los Abetos 123, Colina Alta', '2024-02-24', '2024-03-02', 'Entregado', 150.00),
(13, 'Calle de la Luna 456, Tierra Firme', '2024-02-27', '2024-03-05', 'Entregado', 200.00),
(14, 'Calle del Río 789, Villa Azul', '2024-02-29', '2024-03-06', 'Entregado', 150.00),
(15, 'Calle del Lago 101, San Pedro', '2024-03-02', '2024-03-08', 'Entregado', 200.00),
(16, 'Calle de los Naranjos 202, Colinas Verdes', '2024-03-04', '2024-03-10', 'Entregado', 180.00),
(17, 'Calle Real 303, La Unión', '2024-03-06', '2024-03-12', 'Entregado', 200.00),
(18, 'Calle 5 de Febrero 404, El Horizonte', '2024-03-08', '2024-03-14', 'Entregado', 150.00),
(19, 'Calle de la Cruz 505, Bella Vista', '2024-03-10', '2024-03-16', 'Entregado', 200.00),
(20, 'Calle Reforma 606, Jardines del Valle', '2024-03-12', '2024-03-18', 'Entregado', 180.00),
(21, 'Calle del Sol 707, Colonia El Paraíso', '2024-03-14', '2024-03-20', 'Entregado', 200.00),
(22, 'Calle Juárez 808, San Martín', '2024-03-16', '2024-03-22', 'Entregado', 150.00),
(23, 'Calle Fenix 909, El Retiro', '2024-03-18', '2024-03-24', 'Entregado', 200.00),
(24, 'Calle de los Pinos 1000, La Paz', '2024-03-20', '2024-03-26', 'Entregado', 150.00),

-- Ventas Pendientes
(25, 'Calle del Ángel 123, Ciudad Azul', '2024-02-03', NULL, 'Pendiente', 150.00),
(26, 'Calle Nueva 456, Villa Santa María', '2024-02-06', NULL, 'Pendiente', 150.00),
(27, 'Calle de la Estrella 789, Colonia Esperanza', '2024-02-08', NULL, 'Pendiente', 150.00),
(28, 'Calle Principal 101, El Paraíso', '2024-02-10', NULL, 'Pendiente', 150.00),
(29, 'Calle de los Cedros 202, San Sebastián', '2024-02-12', NULL, 'Pendiente', 150.00),
(30, 'Calle del Sol 303, La Loma', '2024-02-14', NULL, 'Pendiente', 200.00),
(31, 'Calle Victoria 404, Colina Bonita', '2024-02-17', NULL, 'Pendiente', 150.00),
(32, 'Calle del Norte 505, Monte Grande', '2024-02-19', NULL, 'Pendiente', 180.00),
(33, 'Calle de la Aurora 606, Ciudad del Río', '2024-02-21', NULL, 'Pendiente', 200.00),
(34, 'Calle Libertad 707, Villa Esperanza', '2024-02-23', NULL, 'Pendiente', 150.00),
(35, 'Calle de los Jardines 808, Villa San José', '2024-02-25', NULL, 'Pendiente', 150.00),
(36, 'Calle de los Valles 909, Colinas del Valle', '2024-02-28', NULL, 'Pendiente', 150.00),
(37, 'Calle del Mirador 1001, Ciudad del Sol', '2024-03-01', NULL, 'Pendiente', 150.00),
(38, 'Calle Sierra 1101, San Marcos', '2024-03-03', NULL, 'Pendiente', 150.00),
(39, 'Calle del Molino 1201, La Gran Vista', '2024-03-05', NULL, 'Pendiente', 150.00),
(40, 'Calle de los Olivos 1301, Villa Santa Clara', '2024-03-07', NULL, 'Pendiente', 200.00),
(41, 'Calle de la Luz 1401, El Lago', '2024-03-09', NULL, 'Pendiente', 150.00),
(42, 'Calle Santa Teresa 1501, San Pedro', '2024-03-11', NULL, 'Pendiente', 150.00),
(43, 'Calle del Valle 1601, Jardines del Río', '2024-03-13', NULL, 'Pendiente', 180.00),
(44, 'Calle del Mar 1701, Pueblo Viejo', '2024-03-15', NULL, 'Pendiente', 200.00),
(45, 'Calle de la Madera 1801, El Cielo', '2024-03-17', NULL, 'Pendiente', 150.00),
(46, 'Calle de la Rosa 1901, El Bosque', '2024-03-19', NULL, 'Pendiente', 200.00),
(47, 'Calle del Naranjo 2001, Tierra Blanca', '2024-03-21', NULL, 'Pendiente', 150.00),

-- Logística para Envíos Cancelados
(48, 'Calle de los Pinos 2101, Ciudad Nueva', '2024-02-04', NULL, 'Cancelado', 0.00),
(49, 'Calle del Río 2201, El Remanso', '2024-02-15', NULL, 'Cancelado', 0.00),

-- Insertar datos en la tabla Logística
INSERT INTO Logística (Tipo, Costo, ID_Proveedor, FechaInicio, FechaFin) VALUES
-- Logística para Envíos Completados
('Transporte', 100.00, 1, '2024-02-01', '2024-02-05'),
('Transporte', 120.00, 2, '2024-02-02', '2024-02-06'),
('Transporte', 200.00, 3, '2024-02-05', '2024-02-10'),
('Transporte', 150.00, 1, '2024-02-07', '2024-02-12'),
('Transporte', 250.00, 3, '2024-02-09', '2024-02-15'),
('Transporte', 100.00, 1, '2024-02-11', '2024-02-17'),
('Transporte', 220.00, 3, '2024-02-13', '2024-02-19'),
('Transporte', 150.00, 2, '2024-02-16', '2024-02-22'),
('Transporte', 180.00, 1, '2024-02-18', '2024-02-24'),
('Transporte', 200.00, 2, '2024-02-20', '2024-02-26'),
('Transporte', 220.00, 3, '2024-02-22', '2024-02-28'),
('Transporte', 180.00, 1, '2024-02-24', '2024-03-02'),
('Transporte', 250.00, 3, '2024-02-27', '2024-03-05'),
('Transporte', 150.00, 1, '2024-02-29', '2024-03-06'),
('Transporte', 200.00, 3, '2024-03-02', '2024-03-08'),
('Transporte', 180.00, 2, '2024-03-04', '2024-03-10'),
('Transporte', 220.00, 3, '2024-03-06', '2024-03-12'),
('Transporte', 150.00, 1, '2024-03-08', '2024-03-14'),
('Transporte', 250.00, 3, '2024-03-10', '2024-03-16'),
('Transporte', 200.00, 2, '2024-03-12', '2024-03-18'),
('Transporte', 250.00, 3, '2024-03-14', '2024-03-20'),
('Transporte', 150.00, 1, '2024-03-16', '2024-03-22'),
('Transporte', 200.00, 3, '2024-03-18', '2024-03-24'),
('Transporte', 180.00, 2, '2024-03-20', '2024-03-26'),

-- Logística para Envíos Pendientes
('Transporte', 100.00, 1, '2024-02-03', NULL),
('Transporte', 120.00, 2, '2024-02-06', NULL),
('Transporte', 200.00, 3, '2024-02-08', NULL),
('Transporte', 150.00, 1, '2024-02-10', NULL),
('Transporte', 100.00, 2, '2024-02-12', NULL),
('Transporte', 250.00, 3, '2024-02-14', NULL),
('Transporte', 100.00, 1, '2024-02-17', NULL),
('Transporte', 220.00, 3, '2024-02-19', NULL),
('Transporte', 180.00, 2, '2024-02-21', NULL),
('Transporte', 250.00, 3, '2024-02-23', NULL),
('Transporte', 150.00, 1, '2024-02-25', NULL),
('Transporte', 200.00, 3, '2024-02-28', NULL),
('Transporte', 220.00, 1, '2024-03-01', NULL),
('Transporte', 150.00, 1, '2024-03-03', NULL),
('Transporte', 100.00, 2, '2024-03-05', NULL),
('Transporte', 250.00, 3, '2024-03-07', NULL),
('Transporte', 180.00, 1, '2024-03-09', NULL),
('Transporte', 200.00, 3, '2024-03-11', NULL),
('Transporte', 150.00, 2, '2024-03-13', NULL),
('Transporte', 250.00, 3, '2024-03-15', NULL),
('Transporte', 200.00, 1, '2024-03-17', NULL),
('Transporte', 220.00, 3, '2024-03-19', NULL),
('Transporte', 180.00, 2, '2024-03-21', NULL),

-- Logística para Envíos Cancelados
('Transporte', 0.00, 1, '2024-02-04', NULL),
('Transporte', 0.00, 2, '2024-02-15', NULL),
('Transporte', 0.00, 3, '2024-02-26', NULL);

-- Insertar datos en la tabla Reseñas
INSERT INTO Reseñas (ID_Cliente, ID_Producto, Calificación, Comentario, Fecha) VALUES
(5, 5, 4, 'Me gustó mucho, aunque un poco caro.', '2024-02-15'),
(10, 10, 4, 'Muy práctico, pero las asas son un poco cortas.', '2024-02-27'),
(8, 8, 5, 'Un diseño hermoso, recibí muchos cumplidos.', '2024-02-22'),
(12, 12, 1, 'Llegó con un defecto en las costuras, decepcionante.', '2024-03-03'),
(3, 3, 3, 'El material es bueno, pero esperaba más opciones de colores.', '2024-02-10'),
(14, 14, 3, 'Está bien, pero el precio es muy alto para la calidad.', '2024-03-07'),
(7, 7, 4, 'La idea es innovadora, pero el tamaño podría ser más grande.', '2024-02-20'),
(11, 11, 2, 'El color no coincide con las fotos del sitio web.', '2024-03-01'),
(17, 17, 3, 'Cumple su función, pero podría ser más cómodo.', '2024-03-13'),
(4, 4, 5, 'Perfecto para mi día a día, diseño increíble.', '2024-02-12'),
(15, 15, 3, 'Producto promedio, pero el envío fue muy rápido.', '2024-03-09'),
(13, 13, 2, 'No cumple mis expectativas, el material no es lo que esperaba.', '2024-03-05'),
(19, 19, 5, 'Producto excelente, superó mis expectativas.', '2024-03-17'),
(9, 9, 5, 'Calidad excepcional, lo recomiendo.', '2024-02-25'),
(6, 6, 5, 'Funcional y cómodo, lo uso todos los días.', '2024-02-18'),
(1, 1, 5, 'Excelente calidad y diseño. Muy funcional.', '2024-02-05'),
(18, 18, 4, 'Buena calidad, aunque el diseño no me convenció del todo.', '2024-03-15'),
(20, 20, 5, 'Muy práctico, lo volvería a comprar.', '2024-03-19'),
(16, 16, 3, 'Es funcional, pero nada especial.', '2024-03-11'),
(2, 2, 4, 'Buen producto, pero el envío demoró más de lo esperado.', '2024-02-07');