DROP TABLE IF EXISTS tb_formando;
CREATE TABLE tb_formando(
    idFormando INT(11) NOT NULL AUTO_INCREMENT,
    nome VARCHAR(20) NOT NULL,
    apelido VARCHAR(20) NOT NULL,
    dataNascimento DATE,
    telemovel VARCHAR(20),
    PRIMARY KEY(idFormando)
);
DESCRIBE tb_formando;