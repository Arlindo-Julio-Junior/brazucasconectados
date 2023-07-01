DROP TABLE IF EXISTS tb_cidade;
CREATE TABLE tb_cidade(
    idCidade INT(11) NOT NULL AUTO_INCREMENT,
    cidade VARCHAR(20) NOT NULL,
    PRIMARY KEY(idCidade),
    UNIQUE(cidade)
);
DESCRIBE tb_cidade;