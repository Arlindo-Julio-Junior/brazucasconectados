-- slide 163

SET @n1 = '3 Bárbara';
SET @n2 = 4;
SELECT @n2+@n1 AS result;

--slide 164

SET @n1 = 2, @n2 = 5;
SET @n1= 100;

 SELECT @n1 + @n2 AS result;

--slide 167

DROP PROCEDURE IF EXISTS p_crd;
CREATE PROCEDURE p_crd(IN a int, b int)
BEGIN
    SET @rest = a % b;
    SELECT @rest AS result;
END;

CALL p_crd(7,4);

SELECT PI();

CREATE PROCEDURE p_pc(IN a decimal)
BEGIN
    SELECT 2 * PI() * a;
END;

CALL p_pc(5,2);

SHOW PROCEDURE STATUS WHERE Db = (SELECT DATABASE());

-- trabalhando com funções

DROP  FUNCTION IF EXISTS f_area;

CREATE FUNCTION f_area(a float, b float) -- não precisa do "IN"
RETURNS float
BEGIN
    DECLARE area float;
    SET area = a * b;
    return area;
END;

SELECT f_area(10,5) + f_area(6,5) AS area;

SELECT f_area(5.2, 3.6) AS area;

show tables;

-- treinando

SELECT * FROM tb_cidade;

INSERT INTO tb_cidade VALUES (NULL, 'Madrid');

-- IF dentro de procedimento

DROP PROCEDURE IF EXISTS p_registar_cidade;

CREATE PROCEDURE p_registar_cidade(IN a text)
BEGIN
    DECLARE total int;
    SELECT COUNT(idCidade) INTO total FROM tb_cidade WHERE cidade = a;
    IF total = 0 THEN
        INSERT INTO tb_cidade VALUES (NULL, a);
        SELECT 'registou' AS result;
    ELSE
        SELECT 'Valor repetido!' AS result;
    END IF;

    INSERT INTO tb_cidade VALUES (NULL, a);
END;

CALL p_registar_cidade('Bragança');

-- usando procedimento para inserir valores na tabela tb_curso

DROP PROCEDURE IF EXISTS p_registar_curso;
CREATE PROCEDURE p_registar_curso(IN curso text)
BEGIN
    DECLARE resultado int;

    SELECT COUNT(idCurso) INTO resultado FROM tb_curso WHERE designacao = curso;
    IF resultado = 0 THEN
        INSERT INTO tb_curso VALUES (NULL, curso);
        SELECT 'Registado com sucesso!' AS result;
    ELSE
        SELECT 'Valor repetido!' AS result;
    END IF;
END;


CALL p_registar_curso('Linguagem Python');

SELECT * FROM tb_curso;

-- usando procedimento para inserir valores na tabela tb_emprego

SELECT * FROM tb_emprego;

DESCRIBE tb_emprego;

DROP procedure if EXISTS p_registar_emprego;

CREATE procedure p_registar_emprego (IN registoEmprego text)
BEGIN
    declare resultado int;

    SELECT count(idEmprego) into resultado from tb_emprego where emprego = registoEmprego;
    IF resultado = 0 THEN
        INSERT into tb_emprego VALUES (NULL, registoEmprego);
        SELECT 'Emprego registado com sucesso!' as result;
    ELSE
        SELECT 'Valor repetido!' as result;
    END IF;
END;

call p_registar_emprego('Formador');

SELECT * FROM tb_emprego;