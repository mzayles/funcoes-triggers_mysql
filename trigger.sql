-- Ex. 01
CREATE TRIGGER dt_hora AFTER INSERT ON Clientes
FOR EACH ROW
    INSERT INTO Auditoria(mensagem, data_hora)
    VALUES('Hello, world!', NOW());

INSERT INTO Clientes (nome)
VALUES('Astrogilda');

INSERT INTO Clientes (nome)
VALUES('Gertrudes');

SELECT * FROM Auditoria;
