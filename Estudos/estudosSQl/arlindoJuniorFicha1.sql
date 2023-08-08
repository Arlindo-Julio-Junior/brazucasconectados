-- Grupo 1
-- questão 1

-- DROP DATABASE IF EXISTS bd_aviacao;

CREATE DATABASE bd_aviacao;

-- questão 2.1

-- DROP table IF EXISTS tb_aeroporto;

CREATE TABLE tb_aeroporto(
    idAeroporto INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    cidade VARCHAR(50) NOT NULL,
    pais VARCHAR(50) NOT NULL,
    PRIMARY KEY(idAeroporto),
    UNIQUE ncp(nome, cidade, pais)
);

DESCRIBE tb_aeroporto;

-- questão 2.2

-- Drop procedure if exists p_aeroporto;
CREATE procedure p_aeroporto (IN a INT,IN b text, IN c text, IN d text)
BEGIN
    declare total INT;
    declare msg TEXT;

    SELECT COUNT(idAeroporto) INTO total FROM tb_aeroporto where nome = b AND cidade = c AND pais = d;
    IF total = 1 THEN
        SET msg = -1;
    ELSE
        INSERT into tb_aeroporto Values(a, b, c, d);
        SET msg = 1;
    END IF;
    SELECT msg as result;
END;


    CALL p_aeroporto (1,'Sa Carneiro', 'Porto', 'Portugal');
    CALL p_aeroporto (2,'Madeira', 'Funchal', 'Portugal');
    CALL p_aeroporto (3,'Portela', 'Lisboa', 'Portugal');
    CALL p_aeroporto (4,'Ponta Delgada', 'S. Miguel', 'Portugal');
    CALL p_aeroporto (5,'Faro', 'Faro', 'Portugal');
    CALL p_aeroporto (8,'Charles de Gaule', 'Paris', 'França');
    CALL p_aeroporto (9,'Orly', 'Paris', 'França');
    CALL p_aeroporto (11,'Heathrow', 'Londres', 'Reino Unido');
    CALL p_aeroporto (12,'Gatwick', 'Londres', 'Reino Unido');

SELECT * FROM tb_aeroporto;

-- questão 2.3

-- DROP VIEW IF EXISTS v_aeroporto;
CREATE VIEW v_aeroporto AS 
SELECT nome, cidade, pais FROM tb_aeroporto;

SELECT * FROM v_aeroporto;

-- questão 3.1

-- DROP TABLE IF EXISTS tb_modelo;

CREATE TABLE tb_modelo(
    idModelo INT not null auto_increment,
    idFabricante int not null,
    versao varchar(50) not null,
    numMotores int not null,
    PRIMARY KEY(idModelo),
    UNIQUE fv(idFabricante,versao, numMotores)
);
-- alterei o fabricante para idFabricante
DESCRIBE tb_modelo;

SELECT * from tb_modelo;

-- ************* grupo 4 *****************

-- drop TABLE if EXISTS tb_fabricante;
CREATE table tb_fabricante(
    idFabricante int not null AUTO_INCREMENT PRIMARY KEY,
    fabricante varchar(50),
    UNIQUE(fabricante)
);

insert into tb_fabricante VALUES(null, 'Airbus');
insert into tb_fabricante VALUES(null, 'Boeing');
insert into tb_fabricante VALUES(null, 'Douglas');

SELECT * from tb_fabricante;

-- questão 3.2

DROP procedure if EXISTS p_modelo;

CREATE procedure p_modelo (in a int, in b text, in c int)
BEGIN
    declare total1 INT;
    declare total2 int;
    declare msg TEXT;

    SELECT count(idFabricante), count(versao) into total1, total2
    from tb_modelo where idFabricante = a and versao = b and numMotores = c;
    if total1 = 1 and total2 = 1 THEN
        set msg = -1;
    ELSE
        insert into tb_modelo (idModelo,idFabricante, versao, numMotores) values(null, a, b, c);
        SET msg = 1;
    end If;
    SELECT msg as result;
END;

CALL p_modelo (3, 'DC-10', 3);
CALL p_modelo (2, '737', 2);
CALL p_modelo (2, '747', 4);
CALL p_modelo (1, 'A300', 2);
CALL p_modelo (1, 'A340', 4);

SELECT * FROM tb_modelo;

-- questão 3.3

-- drop view if exists v_modelo;

create view v_modelo as SELECT fabricante,
versao, numMotores from tb_modelo
join tb_fabricante on tb_fabricante.idFabricante = tb_modelo.idFabricante;

SELECT * from v_modelo;

-- questão 4.1

-- drop TABLE IF EXISTS tb_aviao;

CREATE TABLE tb_aviao(
    idAviao INT not null auto_increment,
    nome varchar(50) not null,
    idModelo int not null,
    PRIMARY KEY(idAviao),
    UNIQUE(nome, idModelo)
);

DESCRIBE tb_aviao;

-- questão 4.2

-- DROP procedure if EXISTS p_aviao;

CREATE procedure p_aviao (in a text, in b int)
BEGIN
    declare total int;
    declare msg text;

    SELECT count(nome) into total from tb_aviao
    where nome = a and idModelo = b;
    if total = 1 THEN
        set msg = -1;
    ELSE
        Insert into tb_aviao(idAviao, nome, idModelo) values (null, a, b);
        set msg = 1;
    end if;
    SELECT msg as result;
END;

CALL p_aviao('Vasco da Gama', 1);
CALL p_aviao('Gil Eanes', 1);
CALL p_aviao('Dom Henrique', 5);
CALL p_aviao('Bartolomeu Dias', 3);
CALL p_aviao('Pedro Álvares CAbral', 4);
CALL p_aviao('Fernão de Magalhães', 4);
CALL p_aviao('Gonçalo Cabral', 3);
CALL p_aviao('Diogo Cão', 3);
CALL p_aviao('Gaspar Corte Real', 1);

SELECT * FROM tb_aviao;

-- questão 4.3
SELECT * from tb_modelo;
SELECT * from tb_aviao;
SELECT * from tb_fabricante;

-- DROP VIEW if EXISTS v_aviao;
create view v_aviao AS
SELECT fabricante, versao, numMotores, ifnull(tb_aviao.nome, 'Não existe') as nome
from tb_modelo LEFT JOIN tb_aviao on
tb_modelo.idModelo = tb_aviao.idModelo JOIN
tb_fabricante on tb_fabricante.idFabricante = tb_modelo.idFabricante;

SELECT * FROM v_aviao
ORDER BY fabricante DESC;

-- ************* grupo 4 *****************

-- drop TABLE if EXISTS tb_companhia;
CREATE table tb_companhia(
    idCompanhia int not null AUTO_INCREMENT PRIMARY KEY,
    companhia varchar(50),
    UNIQUE(companhia)
);

describe tb_companhia;

insert into tb_companhia VALUES(null, 'TAP');
insert into tb_companhia VALUES(null, 'BA');
insert into tb_companhia VALUES(null, 'SATA');
insert into tb_companhia VALUES(null, 'AirFrance');
insert into tb_companhia VALUES(null, 'Portugalia');

SELECT * from tb_companhia;

-- questão 5.1

-- drop TABLE if EXISTS tb_voo;
CREATE TABLE tb_voo(
    idVoo int not null,
    idAviao int not null,
    idAeroportoPartida int not null,
    idAeroportoChegada int not null,
    idCompanhia int not null,
    duracao DECIMAL not NULL,
    PRIMARY key(idVoo)
);

DESCRIBE tb_voo;

SELECT * from tb_voo;

-- questão 5.2

SELECT * from tb_companhia;

-- drop procedure if EXISTS p_voo;
CREATE procedure p_voo (in a int, b int, c int, d int, e int, f float)
BEGIN
    declare total int;
    declare msg text;

    SELECT count(idVoo) into total from tb_voo 
    where idVoo = a and idAviao = b and idAeroportoPartida = c AND
    idAeroportoChegada = d and idCompanhia = e and duracao = f;
    if total = 1 THEN
        set msg = "já existe";
    ELSE
        insert into tb_voo(idVoo, idAviao, idAeroportoPartida, idAeroportoChegada,
        idCompanhia, duracao) VALUES (a, b, c, d, e, f);
        set msg = "cadastrado";
    end if;
    SELECT msg as result;
END;

CALL p_voo (1001, 1, 1, 2, 1, 2);
CALL p_voo (1002, 2, 2, 3, 1, 1);
CALL p_voo (1003, 5, 2, 12, 2, 2);
CALL p_voo (1004, 6, 4, 3, 3, 3);
CALL p_voo (1005, 3, 9, 2, 4, 2);
CALL p_voo (1006, 5, 8, 11, 2, 1);
CALL p_voo (1007, 5, 5, 1, 1,1);
CALL p_voo (1008, 4, 3, 12, 5, 3);
CALL p_voo (1009, 1, 3, 4, 5,2);
CALL p_voo (1010, 1, 4, 12, 2, 3);
CALL p_voo (1111, 3, 1, 3, 1, 2);

SELECT * FROM tb_voo;

-- questão 5.3

SELECT idVoo, idAeroportoPartida, idAeroportoChegada FROM tb_voo;

SELECT * FROM tb_aeroporto;

-- partidas
-- drop view if EXISTS v_partidas;
create view v_partidas as 
SELECT idAviao, idVoo, idAeroportoPartida, cidade AS cidadePartida,
pais AS paisPartida FROM tb_voo JOIN tb_aeroporto
ON tb_voo.idAeroportoPartida = tb_aeroporto.idAeroporto;

SELECT * FROM v_partidas;

-- chegadas
-- drop VIEW if EXISTS v_chegadas;
create view v_chegadas as 
SELECT idVoo, idAeroportoChegada, cidade AS cidadeChegada, pais AS
 paisChegada FROM tb_voo join tb_aeroporto on 
 tb_voo.idAeroportoChegada = tb_aeroporto.idAeroporto;

SELECT * FROM v_chegadas;

-- drop VIEW if EXISTS v_partidasChegadas;
CREATE VIEW v_partidasChegadas as 
SELECT idAviao, v_partidas.idVoo,idAeroportoPartida,  paisPartida, idAeroportoChegada, paisChegada, cidadePartida, cidadeChegada
 FROM v_partidas join v_chegadas USING (idVoo);

SELECT * from v_partidasChegadas;

SELECT * From tb_voo;

SELECT * FROM tb_aviao;

-- drop view IF EXISTS v_voo;
CREATE view v_voo AS 
SELECT idvoo, cidadePartida, paisPartida,
cidadeChegada, paisChegada, nome,
Fabricante, versao, numMotores FROM v_partidasChegadas
 JOIN tb_aviao USING (idAviao) 
 JOIN tb_modelo using (idModelo)
 join tb_fabricante USING (idFabricante);

 SELECT * from v_voo;

-- Grupo 2
-- questão 1

SELECT nome, cidade FROM v_aeroporto
where pais in ('Portugal');

-- questão 2

SELECT * FROM v_aviao;

SELECT nome from v_aviao
where versao in ('DC-10');

-- questão 3.1

SELECT * from v_aviao;

SELECT nome, numMotores from v_aviao;

-- questão 3.2

SELECT * from v_aviao;

SELECT nome, numMotores, fabricante from v_aviao
where fabricante in ('Airbus');

-- questão 3.3

SELECT nome, fabricante, versao, max(numMotores) from v_aviao
WHERE fabricante in ('Airbus');

-- questão 3.4

SELECT max(numMotores)
 from tb_modelo;

SELECT * from tb_aviao
join tb_modelo using (idModelo)
where numMotores in(4);

SELECT count (idAviao) as total from (SELECT * from tb_aviao
join tb_modelo using (idModelo)
where numMotores in(SELECT max(numMotores)
 from tb_modelo)) as total;

-- questão 4.1

SELECT * FROM tb_voo;
SELECT * from tb_companhia;

SELECT idVoo, idAviao, idAeroportoPartida, idAeroportoChegada,
companhia, duracao from tb_voo join tb_companhia
using (idCompanhia)
WHERE duracao in (3, 2);

-- questão 4.2
SELECT * FROM tb_voo;
SELECT * FROM tb_aeroporto;

SELECT idVoo, idAviao, idAeroportoPartida, idAeroportoChegada,
companhia, duracao, idAeroporto, nome, cidade, pais
FROM tb_voo
JOIN tb_aeroporto ON tb_voo.idAeroportoPartida = tb_aeroporto.idAeroporto
join tb_companhia USING (idCompanhia)
WHERE duracao IN (2)
  AND idAeroportopartida IN (1);

-- questão 5

SELECT * FROM tb_modelo;

SELECT versao, fabricante, numMotores from tb_modelo
join tb_fabricante USING (idFabricante)
WHERE versao like '%A3%';

-- questão 6

SELECT * from tb_voo;

SELECT idVoo, companhia, duracao from tb_voo
JOIN tb_companhia using (idCompanhia)
ORDER BY duracao DESC;

-- questão 7.1

SELECT idVoo as idVooEscala, idAeroportoPartida, idAeroportoChegada
 FROM tb_voo 
 WHERE idAeroportoChegada in (11,12);

SELECT idVoo as idVooPorto, idAeroportoPartida, idAeroportoChegada 
from tb_voo 
where idAeroportoPartida in (1);

SELECT idVooPorto, idVooEscala, Porto.idAeroportoPartida, Porto.idAeroportoChegada as idAeroportoEscala, Londres.idAeroportoChegada FROM
(SELECT idVoo as idVooPorto, idAeroportoPartida, idAeroportoChegada 
from tb_voo 
where idAeroportoPartida in (1)) as Porto JOIN (SELECT idVoo as idVooEscala, idAeroportoPartida, idAeroportoChegada
 FROM tb_voo 
 WHERE idAeroportoChegada in (11,12)) as Londres
on Porto.idAeroportoChegada = Londres.idAeroportoPartida;

-- drop view if EXISTS v_porto_londres;
create view v_porto_londres as 
SELECT idVooPorto, idVooEscala, Porto.idAeroportoPartida, Porto.idAeroportoChegada as idAeroportoEscala, Londres.idAeroportoChegada FROM
(SELECT idVoo as idVooPorto, idAeroportoPartida, idAeroportoChegada 
from tb_voo 
where idAeroportoPartida in (1)) as Porto JOIN (SELECT idVoo as idVooEscala, idAeroportoPartida, idAeroportoChegada
 FROM tb_voo 
 WHERE idAeroportoChegada in (11,12)) as Londres
on Porto.idAeroportoChegada = Londres.idAeroportoPartida;

SELECT * from v_porto_londres;

-- drop VIEW if EXISTS v_porto;
create VIEW v_porto as 
SELECT nome as Porto, idVooPorto, idAeroportoEscala from v_porto_londres
join tb_aeroporto
on idAeroporto = idAeroportoPartida;

SELECT * from v_porto;


-- drop VIEW if EXISTS v_escala;
create VIEW v_escala as 
SELECT nome as Escala, idVooEscala, idAeroportoEscala 
FROM v_porto_londres
join tb_aeroporto
on idAeroporto = idAeroportoEscala;

SELECT * FROM v_escala;


-- drop VIEW if EXISTS v_londres;
create VIEW v_londres as 
SELECT nome As Londres, idAeroportoEscala
 from v_porto_londres
 JOIN tb_aeroporto
 on idAeroporto = idAeroportoChegada;

SELECT * FROM v_londres;
SELECT * from v_escala, v_porto
WHERE v_escala.idAeroportoEscala = v_porto.idAeroportoEscala;

SELECT porto, idVooPorto, escala, idVooEscala, Londres from v_porto
join v_escala USING (idAeroportoEscala)
JOIN v_londres using (idAeroportoEscala);

-- questão 7.2

SELECT * FROM tb_aeroporto;

SELECT idAeroporto from tb_aeroporto
WHERE cidade in ('Porto');

-- questão 7.3

SELECT * from tb_aeroporto;

SELECT idAeroporto from tb_aeroporto
where cidade in ('Londres');

-- questão 7.4

SELECT * FROM v_partidasChegadas;

SELECT idVoo as PrimeiroVoo, idAeroportoChegada, cidadePartida as Partidas
from v_partidasChegadas WHERE
idAeroportoPartida in (1);

-- questão 7.5

SELECT * from v_partidasChegadas;

SELECT idVoo as segundoVoo, idAeroportoPartida, cidadeChegada as Chegada
from v_partidasChegadas WHERE cidadeChegada in ('Londres');

-- questão 8

SELECT * from tb_aeroporto;

SELECT pais, count(pais) as total from tb_aeroporto
GROUP by pais order by total asc;

-- questão 9.1

SELECT * from v_partidasChegadas;

SELECT idVoo, cidadePartida, cidadeChegada from v_partidasChegadas;

-- questão 9.2

SELECT * from v_partidasChegadas;

SELECT idVoo, cidadePartida from v_partidasChegadas;

-- questão 9.3

SELECT * from v_partidasChegadas;

SELECT idVoo, cidadeChegada from v_partidasChegadas;

-- questão 10

SELECT * from v_partidasChegadas;

SELECT idVoo, cidadePartida, cidadeChegada from v_partidasChegadas
WHERE cidadePartida in ('Porto') and cidadeChegada in ('Lisboa');

-- questão 11

SELECT * from tb_aeroporto;

SELECT * from (SELECT pais, count(idAeroporto) as total from tb_aeroporto
GROUP by pais) result WHERE total > 2;

--questão 12

SELECT * from tb_aeroporto;

SELECT 
    pais as Pais, 
    COUNT(pais) as total 
FROM 
    tb_aeroporto 
WHERE 
    pais IN ('França', 'Portugal', 'Reino Unido')
GROUP BY 
    pais
ORDER BY 
    total
LIMIT 2;

-- questão 13

SELECT 
    pais as Pais, 
    COUNT(pais) as total 
FROM 
    tb_aeroporto 
WHERE 
    pais IN ('França', 'Portugal', 'Reino Unido')
GROUP BY 
    pais
ORDER BY 
    total DESC
LIMIT 1;

-- questão 14

SELECT * from tb_aviao;
SELECT * from tb_modelo;

SELECT fabricante, versao, count(idAviao) 
as total from tb_modelo join tb_aviao USING(idModelo)
JOIN tb_fabricante using (idFabricante)
GROUP BY idModelo
ORDER BY total DESC;

-- questão 15

SELECT * from tb_aviao;
SELECT * from tb_modelo;

SELECT fabricante, versao, count(tb_aviao.idModelo) as total
from tb_modelo
join tb_fabricante USING (idFabricante)
left join tb_aviao USING (idModelo)
group by idModelo
ORDER BY total DESC;

-- questão 16

/* DROP TABLE if EXISTS tb_companhia;
CREATE TABLE tb_companhia(
    idCompanhia int AUTO_INCREMENT PRIMARY KEY,
    companhia varchar(50)
);
describe tb_companhia;

insert into tb_companhia (idCompanhia, companhia)
VALUES(1, 'TAP'), (2, 'BA'), (3, 'SATA'), (4, 'AirFrance'),
(5, 'Portugalia'); */

/* O código acima só era necessário na primeira fase do exercício quando 
ainda não existia a tabela tb_companhia separada da tabla tb_voo */

SELECT * from tb_companhia
ORDER by idCompanhia;

-- ******* Grupo 3 *******
-- questão 1.1

-- drop table if EXISTS tb_historico_aeroportos;
CREATE TABLE tb_historico_aeroportos(
    idAeroporto int,
    nome varchar(50),
    dataReg timestamp NOT NULL
);

describe tb_historico_aeroportos;

SELECT * from tb_historico_aeroportos;

-- questão 1.2

SELECT * from tb_aeroporto;

-- drop trigger if EXISTS trg_inserir_cliente;
CREATE TRIGGER trg_inserir_cliente
AFTER INSERT ON tb_aeroporto
FOR EACH ROW
BEGIN
    INSERT INTO tb_historico_aeroportos
    VALUES(new.idAeroporto, new.Nome, CURRENT_TIMESTAMP);
END;

SELECT * from tb_historico_aeroportos;

CALL p_aeroporto(NULL, 'Aeroporto da Capital', 'Lisboa', 'Portugal');

SELECT * FROM tb_aeroporto;

SELECT * from tb_historico_aeroportos;

-- questão 2.1

-- drop TABLE if EXISTS tb_aeroporto_apagado;
CREATE TABLE tb_aeroporto_apagado(
    idAeroporto int,
    dataReg TIMESTAMP not null,
    nome varchar(50)
);

Describe tb_aeroporto_apagado;

-- Questão 2.2

-- drop TRIGGER if EXISTS trg_apagar_aeroporto;
CREATE TRIGGER trg_apagar_aeroporto
AFTER DELETE on tb_aeroporto
FOR EACH ROW
BEGIN
    INSERT INTO tb_aeroporto_apagado
    VALUES(old.idAeroporto, CURRENT_TIMESTAMP, old.nome);
END;

show CREATE TRIGGER trg_apagar_aeroporto;

SELECT * from tb_aeroporto WHERE nome = 'Aeroporto da Capital';

DELETE FROM tb_aeroporto WHERE nome = 'Aeroporto da Capital';

SELECT * FROM tb_aeroporto_apagado;

-- questão 3.1

-- drop TABLE if EXISTS tb_aeroporto_atualizado;
CREATE TABLE tb_aeroporto_atualizado(
    idAeroporto int,
    dataReg TIMESTAMP not null,
    nome varchar(50),
    cidade varchar(50),
    pais varchar(50)
);

describe tb_aeroporto_atualizado;

-- questão 3.2

-- drop TRIGGER if EXISTS trg_atualizar_aeroporto;
CREATE TRIGGER trg_atualizar_aeroporto
BEFORE UPDATE on tb_aeroporto
FOR EACH ROW
BEGIN
    INSERT INTO tb_aeroporto_atualizado
    VALUES(new.idAeroporto, CURRENT_TIMESTAMP, new.nome, new.cidade, new.pais);
END;

show CREATE TRIGGER trg_atualizar_aeroporto;

call p_aeroporto(null, 'Aeroporto do Motijo', 'Lisboa', 'Portugal');

SELECT * FROM tb_aeroporto WHERE nome = 'Aeroporto do Motijo';

UPDATE tb_aeroporto set cidade = 'Motijo' WHERE nome = 'Aeroporto do Motijo';

SELECT * FROM tb_aeroporto_atualizado;