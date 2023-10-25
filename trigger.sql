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

-- Ex. 02
CREATE TRIGGER exclusao_cliente BEFORE DELETE ON Clientes
FOR EACH ROW
    INSERT INTO Auditoria(mensagem)
    VALUES('ATENÇÂO! Tentativa de exclusão de cliente.');

DELETE FROM Clientes WHERE nome = 'Astrogilda';
SELECT * FROM Auditoria;

-- Ex. 03
CREATE TRIGGER atualizar_nome AFTER UPDATE ON Clientes
FOR EACH ROW
    INSERT INTO Auditoria(mensagem)
    VALUES(CONCAT('Nome antigo: ', OLD.nome, ', Nome novo: ', NEW.nome));

UPDATE Clientes
SET nome = 'Bartolomeu'
WHERE nome = 'Gertrudes';

SELECT * FROM Auditoria;
