-- Ex. 01
DELIMITER //
CREATE FUNCTION total_livros_por_genero(genero VARCHAR(100))
RETURNS INT 
DETERMINISTIC
BEGIN
    DECLARE total_livros INT DEFAULT 0;
    DECLARE padrao INT DEFAULT 0;
    DECLARE titulo VARCHAR(255);
    
    DECLARE livro_genero CURSOR FOR
    SELECT titulo
    FROM Livro
    WHERE id_genero = (SELECT id FROM Genero WHERE nome_genero = genero);
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET padrao = 1;
    
    OPEN livro_genero;
    
    livros: LOOP
        FETCH livro_genero INTO titulo;
        IF padrao = 1 THEN
            LEAVE livros;
        END IF;
        
        SET total_livros = total_livros + 1;
    END LOOP;
    
    CLOSE livro_genero;
    
    RETURN total_livros;
END; //
DELIMITER ;

SELECT total_livros_por_genero('Terror') AS livros;

-- Ex. 02
DELIMITER //
CREATE FUNCTION listar_livros_por_autor(primeiro_nome VARCHAR(255), ultimo_nome VARCHAR(255))
RETURNS TEXT
DETERMINISTIC
BEGIN
    DECLARE lista TEXT DEFAULT '';

    DECLARE padrao INT DEFAULT 0;
    DECLARE titulo VARCHAR(255);

    DECLARE livro_autor CURSOR FOR
    SELECT l.titulo
    FROM Livro_Autor AS la
    INNER JOIN Livro AS l ON la.id_livro = l.id
    INNER JOIN Autor AS a ON la.id_autor = a.id
    WHERE a.primeiro_nome = primeiro_nome AND a.ultimo_nome = ultimo_nome;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET padrao = 1;

    OPEN livro_autor;

    livros: LOOP
        FETCH livro_autor INTO titulo;
        IF padrao = 1 THEN
            LEAVE livros;
        END IF;

        SET lista = CONCAT(lista, titulo, '\n');
    END LOOP;

    CLOSE livro_autor;

    RETURN lista;
END //
DELIMITER ;

SELECT listar_livros_por_autor('Bruno', 'Machado');

-- Ex. 03
DELIMITER //
CREATE FUNCTION atualizar_resumos()
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE padrao INT DEFAULT 0;
    DECLARE livro INT;
    DECLARE resumo TEXT;
    
    DECLARE livro_resumo CURSOR FOR
    SELECT id, resumo
    FROM Livro;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET padrao = 1;

    OPEN livro_resumo;

    atualizar: LOOP
        FETCH livro_resumo INTO livro, resumo;
        IF padrao = 1 THEN
            LEAVE atualizar;
        END IF;

        SET resumo = CONCAT(resumo, ' Este é um excelente livro!');
        
        UPDATE Livro SET resumo = resumo WHERE id = livro;
    END LOOP;

    CLOSE livro_resumo;

    RETURN 1;
END //
DELIMITER ;

SELECT atualizar_resumos();
SELECT resumo FROM Livro;

-- Ex. 04
DELIMITER //
CREATE FUNCTION media_livros_por_editora() 
RETURNS DECIMAL(10, 2) 
DETERMINISTIC
BEGIN
    DECLARE padrao INT DEFAULT 0;
    DECLARE livros INT DEFAULT 0;
    DECLARE editoras INT DEFAULT 0;
    DECLARE media DECIMAL(10,2) DEFAULT 0.00;
    DECLARE id_editora_n INT;
    DECLARE livros_editora INT;

    DECLARE livro_editora CURSOR FOR
    SELECT COUNT(id) FROM Livro WHERE id_editora = id_editora_n;

    DECLARE media_editora CURSOR FOR
    SELECT id FROM Editora;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET padrao = 1;
    
    OPEN media_editora;

    r_media: LOOP
        FETCH media_editora INTO id_editora_n;

        IF padrao = 1 THEN
            LEAVE r_media;
        END IF;

        OPEN livro_editora;
        FETCH livro_editora INTO livros_editora;
        CLOSE livro_editora;

        SET livros = livros + livros_editora;
        SET editoras = editoras + 1;
    END LOOP;
    
    IF editoras > 0 THEN
        SET media = livros / editoras;
    END IF;

    CLOSE media_editora;

    RETURN media;
END; //
DELIMITER ;

SELECT media_livros_por_editora();

-- Ex. 05
DELIMITER //
CREATE FUNCTION autores_sem_livros()
RETURNS TEXT 
DETERMINISTIC
BEGIN
    DECLARE padrao INT DEFAULT 0;
    DECLARE autor_s TEXT DEFAULT '';

    DECLARE livro_autor CURSOR FOR
    SELECT primeiro_nome AS nome_autor
    FROM Autor
    WHERE id NOT IN (SELECT DISTINCT id_autor FROM Livro_Autor);

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET padrao = 1;

    OPEN livro_autor;

    contagem: LOOP
        FETCH livro_autor INTO autor_s;
        IF padrao = 1 THEN
            LEAVE contagem;
        END IF;

        IF autor_s != '' THEN
            SET autor_s = CONCAT(autor_s, ', ', autor_s);
        END IF;
    END LOOP;

    CLOSE livro_autor;

    RETURN autor_s;
END; //
DELIMITER ;

SELECT autores_sem_livros() AS autor_sem_livro;
