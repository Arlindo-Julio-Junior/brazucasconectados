DROP TABLE IF EXISTS tb_genero;
CREATE TABLE tb_genero(
    idGenero INT(11) NOT NULL AUTO_INCREMENT,
    genero VARCHAR(20) NOT NULL,
    PRIMARY KEY(idGenero),
    UNIQUE(genero)
);

DESCRIBE tb_genero;