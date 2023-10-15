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
END;
//
  
DELIMITER ;

SELECT total_livros_por_genero('Terror') AS livros
