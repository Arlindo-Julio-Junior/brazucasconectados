SELECT DATABASE();

SHOW TRIGGERS from bd_formacao;

DROP TABLE IF EXISTS tb_trg_formando;

CREATE TABLE tb_trg_formando(
    idFormando int,
    nome varchar(50),
    apelido varchar(50),
    dataNascimento DATE,
    telemovel varchar(50),
    evento varchar(50),
    dataEvento TIMESTAMP
);

describe tb_trg_formando;

SELECT * from tb_trg_formando;

-- slide 195 
-- trigger para INSERIR

SELECT * FROM tb_formando;

drop trigger if EXISTS trg_registar_formando;
CREATE TRIGGER trg_registar_formando
AFTER INSERT ON tb_formando
FOR EACH ROW
BEGIN 
    INSERT into tb_trg_formando
    values(new.idFormando, new.Nome, new.apelido,
    new.dataNascimento, new.telemovel, 'insert',
    CURRENT_TIMESTAMP);
end;


insert INTO tb_formando
VALUES (null, 'Arlindo', 'Souza', '1990-06-01', '987098789');

SELECT * from tb_trg_formando;

-- slide 196
-- trigger para quando ALTERAR dados na tabela

drop TRIGGER if EXISTS trg_alterar_formando;
CREATE TRIGGER trg_alterar_formando
BEFORE UPDATE on tb_formando
FOR EACH ROW
BEGIN

    INSERT into tb_trg_formando
    values(new.idFormando, new.Nome, new.apelido,
    new.dataNascimento, new.telemovel, 'Update before new',
    CURRENT_TIMESTAMP);

END;

SELECT * FROM tb_formando;

UPDATE tb_formando set nome = 'Bea', apelido = 'Loureiro' WHERE idFormando = 2;

SELECT * from tb_trg_formando;

-- outro trigger com AFTER no lugar no BEFORE

drop TRIGGER if EXISTS trg_alterar_formando;
CREATE TRIGGER trg_alterar_formando
BEFORE UPDATE on tb_formando
FOR EACH ROW
BEGIN

    INSERT into tb_trg_formando
    values(old.idFormando, old.Nome, old.apelido,
    old.dataNascimento, old.telemovel, 'Update before old',
    CURRENT_TIMESTAMP);

END;

UPDATE tb_formando set nome = 'Bea', apelido = 'Marques' WHERE idFormando = 2;

SELECT * FROM tb_formando;

SELECT * from tb_trg_formando;

-- Com OLD

drop TRIGGER if EXISTS trg_alterar_formando;
CREATE TRIGGER trg_alterar_formando
BEFORE UPDATE on tb_formando
FOR EACH ROW
BEGIN

    INSERT into tb_trg_formando
    values(idFormando, Nome, new.apelido,
    dataNascimento, telemovel, 'Update before new',
    CURRENT_TIMESTAMP);

END;

UPDATE tb_formando set nome = 'Bea', apelido = 'Faria' WHERE idFormando = 2;

SELECT * FROM tb_formando;

SELECT * from tb_trg_formando;

-- trigger de eliminação

drop TRIGGER if EXISTS trg_apagar_formando;
CREATE TRIGGER trg_apagar_formando
AFTER DELETE on tb_formando
for EACH ROW
BEGIN

    INSERT into tb_trg_formando
    values(old.idFormando, old.Nome, old.apelido,
    old.dataNascimento, old.telemovel, 'delete after old',
    CURRENT_TIMESTAMP);


END;

DELETE from tb_formando WHERE idFormando = 3;

SELECT * FROM tb_formando;

SELECT * FROM trg_apagar_formando;
