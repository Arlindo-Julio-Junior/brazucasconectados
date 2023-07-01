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
SELECT nome, apelido, genero, cidade, group_concat(estadoCivil), telemovel
FROM tb_formando_estadoCivil
JOIN tb_formando USING(idFormando)
JOIN tb_estadoCivil USING(idEstadoCivil)
JOIN tb_genero USING(idGenero)
JOIN tb_cidade USING(idCidade)
;
