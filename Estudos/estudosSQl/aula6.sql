DROP TABLE IF EXISTS tb_formando_genero;
CREATE TABLE tb_formando_genero(
    idFormandoGenero int AUTO_INCREMENT,
    idFormando INT,
    idGenero int,
    dataRegistro timestamp NOT NULL,
    PRIMARY KEY(idFormandoGenero)
);

DESCRIBE tb_formando_genero;

SELECT * FROM tb_genero;
SELECT * FROM tb_formando;
SELECT * FROM tb_formando_cidade;
SELECT * FROM tb_formando_genero;

INSERT INTO tb_formando_genero
(idFormandoGenero, idFormando, idGenero) 
VALUES (1,1,1);

--exercício 16.3
SELECT nome, apelido, genero, telemovel
FROM tb_formando_cidade
JOIN tb_formando USING (idFormando)
JOIN tb_cidade USING(idCidade)
JOIN tb_formando_genero USING (idFormando)
JOIN tb_genero USING (idGenero);

--exercicio 16.4
SELECT nome, apelido, genero, cidade, telemovel
FROM tb_formando_cidade
JOIN tb_formando USING (idFormando)
JOIN tb_cidade USING(idCidade)
JOIN tb_formando_genero USING (idFormando)
JOIN tb_genero USING (idGenero);

--exercício 17.1
DROP TABLE IF EXISTS tb_formando_estadoCivil;
CREATE TABLE tb_formando_estadoCivil(
    idFormandoEstadoCivil int AUTO_INCREMENT,
    idFormando INT,
    idEstadoCivil int,
    dataRegistro timestamp NOT NULL,
    PRIMARY KEY(idFormandoEstadoCivil)
);

DESCRIBE tb_formando_estadoCivil;

--exercício 17.2

SELECT * FROM tb_estadoCivil;

INSERT INTO tb_estadoCivil (idEstadoCivil, estadoCivil)
VALUES (2, 'Solteiro');
SELECT * FROM tb_estadoCivil;

INSERT INTO tb_formando_estadoCivil
(idFormandoEstadoCivil, idFormando, idEstadoCivil) 
VALUES (1,1,1), (2, 1, 2);

SELECT * FROM tb_formando_estadoCivil;

--exercício 17.3

SELECT nome, apelido, estadoCivil
FROM tb_formando_estadoCivil
JOIN tb_formando USING (idFormando)
JOIN tb_estadoCivil USING (idEstadoCivil);

--exercicio 17.4

DROP TABLE IF EXISTS tb_formando_estadoCivil2;
CREATE TABLE tb_formando_estadoCivil2(
    idFormandoEstadoCivil int AUTO_INCREMENT,
    idFormando INT,
    idEstadoCivil int,
    idCidade int,
    idGenero int,
    dataRegistro timestamp NOT NULL,
    PRIMARY KEY(idFormandoEstadoCivil)
);

INSERT INTO tb_formando_estadoCivil2
(idFormandoEstadoCivil, idFormando, idEstadoCivil, idCidade, idGenero) 
VALUES (1,1,1,4,1);

SELECT * FROM tb_formando_estadoCivil2;

SELECT nome, apelido, genero, cidade, group_concat(estadoCivil), telemovel
FROM tb_formando_estadoCivil2
JOIN tb_formando USING(idFormando)
JOIN tb_estadoCivil USING(idEstadoCivil)
JOIN tb_genero USING(idGenero)
JOIN tb_cidade USING(idCidade)
;


--exercício 18.1

DROP TABLE IF EXISTS tb_formando_habilitacao;
CREATE TABLE tb_formando_habilitacao(
    idFormandoHabilitacao int NOT NULL AUTO_INCREMENT,
    idFormando INT,
    idHabilitacao INT,
    dataRegistro timestamp NOT NULL,
    PRIMARY KEY(idFormandoHabilitacao)
);

DESCRIBE tb_formando_habilitacao;

--exercício 18.2

INSERT INTO tb_formando_habilitacao
(idFormandoHabilitacao, idFormando, idHabilitacao) 
VALUES (2,1,2);

SELECT * FROM tb_formando_habilitacao;

SELECT * FROM tb_habilitacao;

INSERT INTO tb_habilitacao VALUES
(2, 'Básico');

SELECT nome, apelido, habilitacao
FROM tb_formando_habilitacao
JOIN tb_formando USING(idFormando)
JOIN tb_habilitacao USING(idHabilitacao)
;

-- exercício 19.1

DROP TABLE IF EXISTS tb_formando_emprego;
CREATE TABLE tb_formando_emprego(
    idFormandoEmprego int NOT NULL AUTO_INCREMENT,
    idFormando INT,
    idEmprego INT,
    dataRegistro timestamp NOT NULL,
    PRIMARY KEY(idFormandoEmprego)
);

DESCRIBE tb_formando_emprego;

--exercício 19.2

INSERT INTO tb_formando_emprego
(idFormandoEmprego, idFormando, idEmprego) 
VALUES (1,1,1);

SELECT * FROM tb_formando_emprego;

DROP PROCEDURE IF EXISTS p_crd;
CREATE PROCEDURE p_crd(IN a int, b int)
BEGIN
    SET @rest = a % b;
    SELECT @rest AS result;
END;

CALL p_crd(7,4);