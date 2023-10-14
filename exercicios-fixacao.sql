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
WHERE nome LIKE '%O';

SELECT CONCAT('Sra. ', nome) AS nome
FROM nomes
WHERE nome LIKE '%A';