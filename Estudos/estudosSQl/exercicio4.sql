DROP TABLE IF EXISTS tb_estadoCivil;
CREATE TABLE tb_estadoCivil(
    idEstadoCivil INT(11) NOT NULL AUTO_INCREMENT,
    estadoCivil VARCHAR(20) NOT NULL,
    PRIMARY KEY(idEstadoCivil),
    UNIQUE(estadoCivil)
);
DESCRIBE tb_estadoCivil;