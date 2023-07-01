DROP TABLE IF EXISTS tb_habilitacao;
CREATE TABLE tb_habilitacao(
    idHabilitacao INT(11) NOT NULL AUTO_INCREMENT,
    habilitacao VARCHAR(20) NOT NULL,
    PRIMARY KEY(idHabilitacao),
    UNIQUE(habilitacao)
);
DESCRIBE tb_habilitacao;

INSERT INTO tb_habilitacao (habilitacao) VALUES
('Mestrado');
SELECT * FROM tb_habilitacao

UPDATE tb_habilitacao
SET habilitacao = 'Mestrado'
WHERE habilitacao = 'Mestre';

SELECT * FROM tb_habilitacao;


DELETE FROM tb_habilitacao
WHERE habilitacao = 'Mestrado' LIMIT 1;

SELECT * FROM tb_habilitacao;

INSERT INTO tb_habilitacao (habilitacao) VALUES ('Doutor');
SELECT * FROM tb_habilitacao;

SHOW CREATE TABLE tb_habilitacao;

-- slide 90

DROP TABLE IF EXISTS tb_regime;
CREATE TABLE tb_regime(
    idRegime INT AUTO_INCREMENT,
    regime VARCHAR(20),
    PRIMARY KEY (idRegime),
    UNIQUE(regime)
);

DESCRIBE tb_regime;

--slide 92

ALTER TABLE tb_curso
DROP regime;

SELECT * FROM tb_curso;

-- slide 93

DROP TABLE IF EXISTS tb_curso_regime;
CREATE TABLE tb_curso_regime(
    idCursoRegime INT AUTO_INCREMENT,
    idCurso INT,
    idRegime INT,
    PRIMARY KEY (idCursoRegime),
    UNIQUE (idCurso, idRegime)
);
DESCRIBE tb_curso_regime;

SELECT * FROM tb_curso;
INSERT INTO tb_curso (designacao)
VALUES ('EFA de Rede'), ('CET de Redes');

DESCRIBE tb_curso_regime;

SELECT * FROM tb_regime;
SELECT * FROM tb_curso;

INSERT INTO tb_curso_regime (idCurso, idRegime) VALUES
(1,1), (2,1), (3,1), (4,1), (5,1), (1,2), (2,2), (3,2);

SELECT * FROM tb_curso_regime;

SELECT designacao FROM tb_curso_regime JOIN tb_curso USING (idCurso);

SELECT designacao FROM tb_curso_regime JOIN tb_curso
ON tb_curso.idCurso=tb_curso_regime.idCurso;

--slide 101

SELECT regime FROM tb_regime JOIN tb_curso_regime USING (idRegime);

SELECT designacao, regime
FROM tb_curso JOIN tb_curso_regime USING(idCurso)
JOIN tb_regime USING(idRegime);

ORDER BY designacao ASC, regime DESC;

SELECT idCursoRegime, designacao, regime
FROM tb_curso_regime
JOIN tb_curso USING(idCurso)
JOIN tb_regime USING(idRegime)

ORDER BY  designacao DESC
LIMIT 5,8;

SELECT designacao, regime
FROM tb_curso JOIN tb_curso_regime USING(idCurso)
JOIN tb_regime USING(idRegime);


DROP VIEW IF EXISTS v_curso_regime;
CREATE VIEW v_curso_regime AS
SELECT * FROM tb_curso_regime
JOIN tb_curso USING(idCurso)
JOIN tb_regime USING(idRegime);

SELECT * FROM v_curso_regime;
SELECT COUNT(*) AS total_cursos FROM
v_curso_regime;

SELECT distinct regime FROM v_curso_regime;

-- aula 5



SELECT * FROM tb_curso;
SELECT * FROM tb_regime;
SELECT * FROM tb_curso_regime;

DROP VIEW IF EXISTS v1;
CREATE VIEW v1 AS

SELECT * FROM tb_curso JOIN tb_curso_regime USING(idCurso)
JOIN tb_regime USING(idRegime);

DROP VIEW IF EXISTS v_curso_laboral;
CREATE VIEW v_curso_laboral AS

SELECT * FROM v1
WHERE regime = 'Laboral';
SELECT * FROM v_curso_laboral;

SELECT * FROM v1
WHERE designacao LIKE '%CET%';

SELECT * FROM v1
WHERE designacao LIKE '%Multimédia'
AND regime = 'Laboral';

SELECT * FROM v1
WHERE designacao LIKE '%Multimédia'
OR regime LIKE 'Laboral';

SELECT * FROM v1
WHERE designacao IN('CET de Multimédia', 'CET de SI')

SELECT COUNT(idCursoRegime) AS total FROM v1;

SELECT COUNT(idCursoRegime) AS 'total de cursos laborais' 
FROM v1 WHERE regime LIKE 'Laboral';

SELECT MIN(idCursoRegime) AS minimo
FROM v1;

SELECT * FROM v1 WHERE idCursoRegime=(SELECT MIN(idCursoRegime) AS minimo
FROM v1);

SELECT * FROM v1 WHERE idCursoRegime=(SELECT MAX(idCursoRegime) AS maximo
FROM v1);

SELECT * FROM tb_curso_regime;

SELECT MAX(idCursoRegime) FROM v1; -- devolve o máximo

SELECT idCursoRegime, designacao, regime 
FROM v1 WHERE idCursoRegime = (SELECT MAX(idCursoRegime) FROM v1);




-- Exercício 13
SELECT idCursoRegime, designacao FROM v1 WHERE idCursoRegime = (SELECT MIN (idCursoRegime) from v1);

--Exercício 14 slide 131
SELECT * FROM tb_formando;--exiber a tabela

DESCRIBE tb_formando;--Descreve/mostra os elementos da tabela

--Inserir dados na tabela
INSERT INTO tb_formando
VALUES(1, 'Ana', 'Moreira', '1973-06-21', '919730620');

SELECT * FROM tb_formando;

--slide 138
--Criando a tabela tb_formando_cidade

DROP TABLE IF EXISTS tb_formando_cidade;
CREATE TABLE tb_formando_cidade(
    idFormandoCidade int AUTO_INCREMENT,
    idFormando INT NOT NULL,
    idCidade int NOT NULL,
    dataRegistro timestamp,
    PRIMARY KEY(idFormandoCidade)
);

--mostrando a estrutura da tabela
DESCRIBE tb_formando_cidade;


INSERT INTO tb_cidade (cidade) VALUES ('Coimbra'), ('Faro'), ('Setubal'), ('Porto'), ('Lisboa');


--slide 140
SELECT * FROM tb_cidade WHERE cidade LIKE 'Porto';

SELECT * FROM tb_formando WHERE nome LIKE 'Ana' AND apelido LIKE'Moreira;

INSERT INTO tb_formando_cidade
(idFormando, idCidade) VALUES (1,5);

SELECT * FROM tb_formando_cidade;

--USE tb_formacao;
SELECT nome, apelido, cidade, telemovel
FROM tb_formando_cidade
JOIN tb_formando USING (idFormando)
JOIN tb_cidade USING(idCidade);

DROP TABLE IF EXISTS tb_formando_genero;
CREATE TABLE tb_formando_genero(
    idFormandoGenero int AUTO_INCREMENT,
    idFormando INT,
    idGenero int,
    dataRegistro timestamp NOT NULL,
    PRIMARY KEY(idFormandoGenero)
);

SELECT * FROM tb_genero;

DESCRIBE tb_formando_genero;

SELECT * FROM tb_formando_cidade;

SELECT * FROM tb_formando_genero;

INSERT INTO tb_cidade (cidade) VALUES ;

SELECT nome, apelido, genero, telemovel
FROM tb_formando_cidade
JOIN tb_formando USING (idFormando)
JOIN tb_cidade USING(idCidade)
JOIN tb_formando_genero USING (idFormando)
JOIN tb_genero USING (idGenero);

INSERT INTO tb_genero (idGenero), (genero)
VALUES (2, 'Feminimo');