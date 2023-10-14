-- Ex. 01
-- A)
CREATE TABLE nomes (
nome VARCHAR(100)
);

INSERT INTO nomes (nome) VALUES
('Roberta'),
('Roberto'),
('Maria Clara'),
('João');

-- B)
SELECT UPPER(nome) AS nomes FROM nomes;

-- C)
SELECT LENGTH(nome) AS tamanho FROM nomes;

-- D)
SELECT CONCAT('Sr. ', nome) AS nome
FROM nomes
WHERE nome LIKE '%O'
UNION
SELECT CONCAT('Sra. ', nome) AS nome
FROM nomes
WHERE nome LIKE '%A';

-- Ex. 02
-- A)

CREATE TABLE produtos (
produto VARCHAR(100),
    preco DECIMAL(10, 2),
    quantidade INT
);

INSERT INTO produtos VALUES
('Base', '259.999', '100'),
('Batom', '54.999', '80'),
('Gloss', '69.999', '200'),
('Blush', '99.999', '50');

-- B)
SELECT ROUND(preco, 2) AS preço_arredondado
FROM produtos;

-- C)
SELECT ROUND(AVG(preco), 2) AS media_produto FROM produtos;

-- Ex. 03
-- A)
CREATE TABLE eventos (
   data_evento DATETIME
);

INSERT INTO eventos VALUES
('2006-05-30 09:17:30'),
('2007-02-22 17:12:50'),
('1981-10-16 20:23:32'),
('1980-09-30 05:23:45');

-- B)
INSERT INTO eventos (data_evento) VALUES
(now());

SELECT * FROM eventos;

-- C)
SELECT DATEDIFF ('2007-02-22' , '2006-05-30') AS dias_diferenca;

-- D)
SELECT DAYNAME('2007-02-22') AS dia_semana;

-- Ex. 04
-- A)
INSERT INTO produtos VALUES
('Rímel', '139.999', '0');

SELECT
    produto, preco, quantidade,
    IF(quantidade > 0, 'Em Estoque', 'Fora de Estoque') AS status_estoque
FROM produtos;

-- B)
SELECT
    produto, preco, quantidade,
    CASE
        WHEN preco < 50.00 THEN 'Barato'
        WHEN preco >= 50.00 AND preco < 100.00 THEN 'Médio'
        ELSE 'Caro'
    END AS categoria
FROM produtos
ORDER BY preco;
