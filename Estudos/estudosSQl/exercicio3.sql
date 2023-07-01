DROP TABLE IF EXISTS tb_emprego;
CREATE TABLE tb_emprego(
    idEmprego INT(11) NOT NULL AUTO_INCREMENT,
    emprego VARCHAR(20) NOT NULL,
    PRIMARY KEY(idEmprego),
    UNIQUE(emprego)
);
DESCRIBE tb_emprego;