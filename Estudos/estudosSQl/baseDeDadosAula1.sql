DROP DATABASE IF EXISTS bd_formacao;
CREATE DATABASE bd_formacao;

DROP TABLE IF EXISTS tb_curso;
CREATE TABLE tb_curso(

    idCurso INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    designacao VARCHAR(100),
    regime CHAR(100) NOT NULL

);
DESCRIBE tb_curso;

ALTER TABLE tb_curso CHANGE id idCurso INT AUTO_INCREMENT;

DESCRIBE tb_curso;

ALTER TABLE tb_curso ADD UNIQUE(regime);
DESCRIBE tb_curso;

ALTER TABLE tb_curso ADD PRIMARY KEY (idCurso);
DESCRIBE tb_curso;

ALTER TABLE tb_curso CHANGE idCurso idCurso INT AUTO_INCREMENT;
DESCRIBE tb_curso;

ALTER TABLE tb_curso ADD designacao VARCHAR(50) NOT NULL;
DESCRIBE tb_curso;

DESCRIBE tb_curso;
SELECT * FROM tb_curso;

INSERT INTO tb_curso VALUES (NULL, 'CET de Multimédia', 'Laboral');


INSERT INTO tb_curso (idCurso, designacao, regime)
VALUES (NULL, 'CET de SI', 'Laboral');


INSERT INTO tb_curso (designacao, regime)
VALUES ('EFA de Multimédia', 'Laboral');
SELECT * FROM tb_curso;
