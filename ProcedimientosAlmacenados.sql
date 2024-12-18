CREATE DATABASE DEBERBASES;
USE DEBERBASES;


CREATE TABLE cliente (
    ClienteID INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100),
    Estatura DECIMAL(5,2),
    FechaNacimiento DATE,
    Sueldo DECIMAL(10,2)
);

INSERT INTO cliente (Nombre, Estatura, FechaNacimiento, Sueldo) 
VALUES 
    ('Gabriel Pérez', 1.65, '2004-01-01', 3000.00),
    ('Jaime Chiran', 1.60, '1985-05-10', 2500.50),
    ('Fernanda Villalva', 1.54, '1990-03-15', 1800.00);


DELIMITER //
CREATE PROCEDURE SeleccionarClientes()
BEGIN
    SELECT * FROM cliente;
END;
//
DELIMITER ;


CALL SeleccionarClientes();

DELIMITER //
CREATE PROCEDURE InsertarCliente(IN Nombre VARCHAR(100), IN Estatura DECIMAL(5,2), IN FechaNacimiento DATE, IN Sueldo DECIMAL(10,2))
BEGIN
    INSERT INTO cliente (Nombre, Estatura, FechaNacimiento, Sueldo) 
    VALUES (Nombre, Estatura, FechaNacimiento, Sueldo);
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE InsertarCliente(
    IN Nombre VARCHAR(100), 
    IN Estatura DECIMAL(5,2), 
    IN FechaNacimiento DATE, 
    IN Sueldo DECIMAL(10,2)
)

BEGIN
    INSERT INTO cliente (Nombre, Estatura, FechaNacimiento, Sueldo) 
    VALUES ("Johan Imbaquingo", 1.63, 2012-06-15, 1000.00);
END;
//
DELIMITER ;

CALL InsertarCliente('Gabriel Pérez', 1.65, '2004-01-01', 3000.00);

DELIMITER //
CREATE PROCEDURE ActualizarEdadCliente(
    IN p_ClienteID INT, 
    IN p_NuevaFechaNacimiento DATE
)
BEGIN
    UPDATE cliente 
    SET FechaNacimiento = p_NuevaFechaNacimiento 
    WHERE ClienteID = p_ClienteID;
END;
//
DELIMITER ;

CALL ActualizarEdadCliente(1, '1995-06-15');


DELIMITER //
CREATE PROCEDURE EliminarCliente(
    IN p_ClienteID INT
)
BEGIN
    DELETE FROM cliente 
    WHERE ClienteID = p_ClienteID;
END;
//
DELIMITER ;

CALL EliminarCliente(2);

DELIMITER //
CREATE PROCEDURE VerificarEdadCliente(
    IN p_ClienteID INT
)
BEGIN
    DECLARE v_Edad INT;

    SELECT TIMESTAMPDIFF(YEAR, FechaNacimiento, CURDATE()) INTO v_Edad
    FROM cliente 
    WHERE ClienteID = p_ClienteID;

    IF v_Edad >= 22 THEN
        SELECT CONCAT('El cliente con ID ', p_ClienteID, ' tiene ', v_Edad, ' años y es mayor o igual a 22.');
    ELSE
        SELECT CONCAT('El cliente con ID ', p_ClienteID, ' tiene ', v_Edad, ' años y es menor de 22.');
    END IF;
END;
//
DELIMITER ;

CREATE TABLE ordenes (
    OrdenID INT AUTO_INCREMENT PRIMARY KEY, 
    ClienteID INT, 
    Fecha DATE, 
    Monto DECIMAL(10,2), 
    FOREIGN KEY (ClienteID) REFERENCES cliente(ClienteID)
);

DELIMITER //
CREATE PROCEDURE InsertarOrden(
    IN p_ClienteID INT, 
    IN p_Fecha DATE, 
    IN p_Monto DECIMAL(10,2)
)
BEGIN
    INSERT INTO ordenes (ClienteID, Fecha, Monto) 
    VALUES (p_ClienteID, p_Fecha, p_Monto);
END;
//
DELIMITER ;

CALL InsertarOrden(1, '2024-12-05', 250.00);

DELIMITER //
CREATE PROCEDURE ActualizarMontoOrden(
    IN p_OrdenID INT, 
    IN p_NuevoMonto DECIMAL(10,2)
)
BEGIN
    UPDATE ordenes 
    SET Monto = p_NuevoMonto 
    WHERE OrdenID = p_OrdenID;
END;
//
DELIMITER ;

CALL ActualizarMontoOrden(1, 300.00);

DELIMITER //
CREATE PROCEDURE EliminarOrden(
    IN p_OrdenID INT
)
BEGIN
    DELETE FROM ordenes 
    WHERE OrdenID = p_OrdenID;
END;
//
DELIMITER ;

CALL EliminarOrden(2);

