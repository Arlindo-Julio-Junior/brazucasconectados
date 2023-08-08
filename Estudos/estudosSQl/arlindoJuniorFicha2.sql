-- ********* Ficha de Exercício nª 2 **************
-- questão 1

-- drop DATABASE if EXISTS bd_pescaria76;
CREATE DATABASE bd_pescaria76;

-- questão 2.1

-- drop TABLE if EXISTS tb_barco;
CREATE TABLE tb_barco(
    idBarco int NOT NULL AUTO_INCREMENT,
    nome varchar(50) NOT NULL,
    pesoMaximo float(8,1) NOT NULL,
    tripulacao int NOT NULL,
    comprimento float(3,1) not NULL,
    UNIQUE(nome, pesoMaximo, tripulacao, comprimento),
    PRIMARY KEY(idBarco)
);

DESCRIBE tb_barco;

-- questão 2.2

-- drop procedure if EXISTS p_registar_barco;
CREATE procedure p_registar_barco( 
    in p_nome varchar(50),
    in p_pesoMaximo float,
    in p_tripulacao int,
    in p_comprimento float
)
BEGIN
    insert into tb_barco(nome, pesoMaximo, tripulacao, comprimento)
    VALUES (p_nome, p_pesoMaximo, p_tripulacao, p_comprimento);
END;

call p_registar_barco('Aurélio', 100000, 2, 20.5);
call p_registar_barco('Simone', 20000, 3, 4.0);
call p_registar_barco('Batista', 50000, 3, 10.5);
call p_registar_barco('Fortunato', 40000, 2, 8.0);
call p_registar_barco('Evaristo', 45000, 2, 8.5);
call p_registar_barco('Afonso', 30000, 3, 6.0);

SELECT * FROM tb_barco;

-- questão 2.3

-- drop view IF EXISTS v_barco;
create VIEW v_barco AS
SELECT nome, pesoMaximo, tripulacao,comprimento
from tb_barco;

SELECT * FROM v_barco;

-- questão 3.1

-- drop TABLE IF EXISTS tb_peixe;
CREATE TABLE tb_peixe(
    idPeixe int not NULL AUTO_INCREMENT,
    nome varchar(50) not NULL,
    pesoMedio float(5,1) not NULL,
    precoKg float(5,1) not NULL,
    PRIMARY key (idPeixe),
    UNIQUE (nome)
);

DESCRIBE tb_peixe;

-- questão 3.2

-- drop procedure if EXISTS p_registar_peixe;
CREATE procedure p_registar_peixe(
    in p_nome text,
    in p_pesoMedio float,
    in p_precoKg float
)
BEGIN
    INSERT into tb_peixe(nome, pesoMedio, precoKg)
    VALUES (p_nome, p_pesoMedio, p_precoKg);
END;

call p_registar_peixe('Faneca', 0.3, 5.0);
call p_registar_peixe('Carapau', 0.8, 6.0);
call p_registar_peixe('Dourada', 8.5, 12.5);
call p_registar_peixe('Pescada', 1.2, 7.5);
call p_registar_peixe('Cavala', 0.75, 8.0);
call p_registar_peixe('Atum', 12.5, 15.0);
call p_registar_peixe('Peixe espada', 1.3, 12.0);
call p_registar_peixe('Robalo', 3.1, 3.5);

SELECT * FROM tb_peixe;

-- questão 3.3

-- drop view IF EXISTS v_peixe;
CREATE VIEW v_peixe AS
SELECT nome, pesoMedio, precoKg
from tb_peixe;

SELECT * FROM v_peixe;

-- questão 4.1

-- drop TABLE IF EXISTS tb_pescador;
CREATE TABLE tb_pescador(
    idPescador int not null AUTO_INCREMENT,
    nome varchar(50) not null,
    cidade varchar(50) not null,
    idade int not null,
    PRIMARY KEY(idPescador),
    UNIQUE(nome, cidade, idade)
);

DESCRIBE tb_pescador;

-- questão 4.2

-- drop procedure if EXISTS p_registar_pescador;
CREATE procedure p_registar_pescador(
    in p_nome text,
        p_cidade text,
        p_idade int
)
BEGIN
    INSERT into tb_pescador(nome, cidade, idade)
    VALUES(p_nome, p_cidade, p_idade);
END;

call p_registar_pescador('Marco Rocha', 'Vila do Conde', 52);
call p_registar_pescador('Miguel Abrantes', 'Aveiro', 44);
call p_registar_pescador('Paulo Trindade', 'Gaia', 46);
call p_registar_pescador('Inês Vieira', 'Gaia', 45);
call p_registar_pescador('Carlos Santana', 'Mira', 45);
call p_registar_pescador('Daniela Oliveira', 'Ilhavo', 66);
call p_registar_pescador('Ricardo Oliveira', 'Ilhavo', 68);
call p_registar_pescador('Luis Ralha', 'Gaia', 35);

SELECT * FROM tb_pescador;

-- questão 4.3

-- drop view IF EXISTS v_pescador;
CREATE view v_pescador AS
SELECT nome, cidade, idade from tb_pescador;

SELECT * from v_pescador;

-- questão 5.1

-- drop TABLE IF EXISTS tb_pescaria;
CREATE TABLE tb_pescaria(
    idPescaria int not null PRIMARY KEY AUTO_INCREMENT,
    dataReg date not null,
    hora time not null,
    duracao int not null,
    idBarco int not null
);

DESCRIBE tb_pescaria;

-- questão 5.2

-- drop procedure if EXISTS p_registar_pescaria;
CREATE procedure p_registar_pescaria(
    in p_dataReg date,
    in p_hora time,
    in p_duracao int,
    in p_idBarco int
)
BEGIN
    INSERT INTO tb_pescaria(dataReg, hora, duracao, idBarco)
    VALUES(p_dataReg, p_hora, p_duracao, p_idBarco);
END;

call p_registar_pescaria('2017-1-1', '06:00:00', 2, 1);
call p_registar_pescaria('2017-1-1', '07:30:00', 1, 2);
call p_registar_pescaria('2017-1-1', '08:00:00', 1, 4);
call p_registar_pescaria('2017-1-2', '05:00:00', 4, 3);
call p_registar_pescaria('2017-1-2', '05:30:00', 6, 4);
call p_registar_pescaria('2017-1-2', '06:00:00', 2, 2);
call p_registar_pescaria('2017-1-2', '06:30:00', 3, 6);
call p_registar_pescaria('2017-1-3', '07:00:00', 4, 2);
call p_registar_pescaria('2017-1-3', '07:30:00', 5, 4);
call p_registar_pescaria('2017-1-4', '08:00:00', 1, 2);
call p_registar_pescaria('2017-1-4', '09:30:00', 1, 3);
call p_registar_pescaria('2017-1-5', '06:00:00', 3, 6);

SELECT DATE_FORMAT(dataReg, '%d/%m/%Y') AS data_registada, hora, duracao, idBarco
FROM tb_pescaria;

-- questão 5.3

SELECT * FROM tb_pescaria;
SELECT * from tb_pescador;
SELECT * FROM tb_barco;

-- drop view IF EXISTS v_pescaria;
CREATE VIEW v_pescaria AS
SELECT tb_barco.nome,ifnull(tb_pescaria.idPescaria, 'NÃO PESCOU') as pescaria, 
ifnull(DATE_FORMAT(tb_pescaria.dataReg, '%d/%m/%Y'), 'NÃO PESCOU') 
as dataPescaria, ifnull(tb_pescaria.hora, 'NÃO PESCOU') as horaPescaria, 
ifnull(tb_pescaria.duracao, 'NÃO PESCOU') as duracao
from tb_barco
left JOIN tb_pescaria on tb_barco.idBarco = tb_pescaria.idBarco
ORDER BY tb_barco.nome;

SELECT * from v_pescaria;

-- questão 6.1

-- drop TABLE IF EXISTS tb_pescado;
CREATE TABLE tb_pescado(
    idPescado int not null AUTO_INCREMENT,
    idPescaria int not null,
    idPeixe int not null,
    peso float(6,1) not null,
    PRIMARY KEY(idPescado)
);

DESCRIBE tb_pescado;

-- questão 6.2

-- drop procedure if EXISTS p_registar_pescado;
CREATE procedure p_registar_pescado(
    in p_idPescaria int,
    in p_idPeixe time,
    in p_peso int
)
BEGIN
    INSERT INTO tb_pescado(idPescaria, idPeixe, peso)
    VALUES(p_idPescaria, p_idPeixe, p_peso);
END;

call p_registar_pescado(1,1,10000);
call p_registar_pescado(1,5,20000);
call p_registar_pescado(2,6,15000);
call p_registar_pescado(2,4,25000);
call p_registar_pescado(3,2,8000);
call p_registar_pescado(4,8,7000);
call p_registar_pescado(5,7,12000);
call p_registar_pescado(5,8,1000);
call p_registar_pescado(6,4,3000);
call p_registar_pescado(6,2,5000);
call p_registar_pescado(7,1,8500);
call p_registar_pescado(8,6,9000);
call p_registar_pescado(9,6,13000);
call p_registar_pescado(10,4,4000);
call p_registar_pescado(11,7,5000);
call p_registar_pescado(12,8,20000);

SELECT * FROM tb_pescado;

-- questão 6.3

SELECT * from tb_pescaria;
SELECT * from tb_peixe;
SELECT * from tb_pescado;

-- drop view if EXISTS v_pescado;
create view v_pescado AS
SELECT idPescaria, nome as peixe, hora, duracao, idBarco, dataReg as dataPescaria
from tb_pescaria join tb_pescado USING (idPescaria)
JOIN tb_peixe USING (idPeixe);

SELECT * from v_pescado
ORDER BY peixe;

-- questão 7.1

-- drop TABLE IF EXISTS tb_pescador_pescaria;
CREATE TABLE tb_pescador_pescaria(
    idPescadorPescaria int not null AUTO_INCREMENT,
    idPescador int not null,
    idPescaria int not null,
    PRIMARY KEY(idPescadorPescaria)
);

DESCRIBE tb_pescador_pescaria;

-- questão 7.2

-- drop procedure if EXISTS p_registar_pescador_pescaria;
CREATE procedure p_registar_pescador_pescaria(
    in p_idPescador int,
    in p_idPescaria int
)
BEGIN
    INSERT into tb_pescador_pescaria(idPescador, idPescaria)
    VALUES(p_idPescador, p_idPescaria);
End;

call p_registar_pescador_pescaria(1,1);
call p_registar_pescador_pescaria(2,1);
call p_registar_pescador_pescaria(3,2);
call p_registar_pescador_pescaria(4,2);
call p_registar_pescador_pescaria(5,3);
call p_registar_pescador_pescaria(8,3);
call p_registar_pescador_pescaria(6,4);
call p_registar_pescador_pescaria(5,5);
call p_registar_pescador_pescaria(8,5);
call p_registar_pescador_pescaria(1,5);
call p_registar_pescador_pescaria(2,6);
call p_registar_pescador_pescaria(4,6);
call p_registar_pescador_pescaria(3,7);
call p_registar_pescador_pescaria(8,8);
call p_registar_pescador_pescaria(6,8);
call p_registar_pescador_pescaria(5,9);
call p_registar_pescador_pescaria(1,9);
call p_registar_pescador_pescaria(1,10);
call p_registar_pescador_pescaria(3,10);
call p_registar_pescador_pescaria(4,11);
call p_registar_pescador_pescaria(8,11);
call p_registar_pescador_pescaria(5,12);

SELECT * FROM tb_pescador_pescaria;

-- questão 7.3

SELECT * FROM tb_pescador;
SELECT * FROM tb_pescaria;
SELECT * FROM tb_pescador_pescaria;

-- drop view IF EXISTS v_pescador_pescaria;
create view v_pescador_pescaria AS
SELECT nome as pescador, idade, dataReg as dataPescaria, duracao, idBarco
from tb_pescador join tb_pescador_pescaria USING (idPescador)
JOIN tb_pescaria USING (idPescaria);

SELECT * from v_pescador_pescaria
ORDER BY pescador;

-- **************** Grupo 2 **************

-- 1 Qual é o barco mais comprido.

SELECT * FROM tb_barco;

SELECT nome, MAX(comprimento) 
as maiorComprimento from tb_barco
GROUP BY comprimento
ORDER BY comprimento desc LIMIT 1;

-- 2 Qual é o barco mais curto.

SELECT * FROM tb_barco;

SELECT nome, min(comprimento) 
as menorComprimento from tb_barco
GROUP BY comprimento
ORDER BY comprimento asc LIMIT 1;

-- 3 Quais são os 3 barcos que suportam mais carga.

SELECT * from tb_barco;

SELECT nome, max(pesoMaximo) 
from tb_barco
GROUP BY pesoMaximo
ORDER BY pesoMaximo DESC
LIMIT 3;

-- 4 Qual é barco o que suporta menos carga.

SELECT * from tb_barco;

SELECT nome, min(pesoMaximo) 
from tb_barco
GROUP BY pesoMaximo
ORDER BY pesoMaximo ASC
LIMIT 1;

-- 5 Quais são os barcos com menos de 10 metros

SELECT * from tb_barco;

SELECT nome, comprimento from tb_barco
WHERE comprimento < 10;

-- 6 Qual é a media de tripulantes por barco da frota.

SELECT * from tb_barco;

SELECT avg(tripulacao) as mediaTripulacao from tb_barco;

-- 7 Se os barcos estiverem na capacidade máxima de tripulantes, quantos tripulantes tem a frota.

SELECT * from tb_barco;

SELECT sum(tripulacao) as totalTripulacao from tb_barco;

-- 8 Qual é o peixe que tem o peso médio mais elevado.

SELECT * FROM tb_peixe;

SELECT nome, pesoMedio as maiorPesoMedio from tb_peixe
GROUP BY pesoMedio
ORDER BY pesoMedio desc
LIMIT 1;

-- 9 Qual é o peixe que tem um preço Kg mais elevado.

SELECT * FROM tb_peixe;

SELECT nome, precoKg from tb_peixe
GROUP BY precoKg
ORDER BY precoKg desc
LIMIT 1;

-- 10 Se forem pescados 500Kg de carapau, qual é o seu valor total.

SELECT * FROM tb_peixe;

SELECT nome,precoKg, sum(precoKg * 500) as precoX500 from tb_peixe
WHERE nome in ('Carapau');

-- 11 Se um Robalo com 4.2 Kg for pescado, qual é a diferença do seu peso para o peso médio.

SELECT * FROM tb_peixe;

SELECT nome, pesoMedio, sum(pesoMedio - 4.2) as diferencaPeso from tb_peixe
WHERE nome in ('Robalo');

-- 12 Qual é a média de idades atual dos pescadores que videm em Mira e Ílhavo

SELECT * FROM tb_pescador;

set @mediaMira = (SELECT avg(idade) from tb_pescador WHERE cidade = 'Mira');
set @mediaIlhavo = (SELECT avg(idade) from tb_pescador WHERE cidade = 'Ilhavo');
set @mediaTotal = (@mediaMira + @mediaIlhavo) / 2;
SELECT @mediaTotal as mediaIdadesMiraIlhavo;

-- 13 Qual é a diferença de idades entre o pescador mais novo e o pescador mais velho.

SELECT * FROM tb_pescador;

set @pescadorNovo = (SELECT min(idade) from tb_pescador);
set @pescadorVelho = (SELECT max(idade) from tb_pescador);
set @diferencaIdadeNovoVelho = @pescadorVelho - @pescadorNovo;
SELECT @diferencaIdadeNovoVelho as diferencaIdadeNovoVelho;

-- 14 Qual é a cidade que tem mais pescadores.

SELECT * FROM tb_pescador;

SELECT count(cidade) as cidade, cidade  from tb_pescador
GROUP BY cidade
ORDER BY cidade DESC
LIMIT 1;

-- 15 Quantas pescarias estão registadas na base de dados.

SELECT * from tb_pescaria;

SELECT count(idPescaria) as totalPescaria from tb_pescaria;

-- 16 Quanto tempo duraram todas as pescarias.

SELECT * from tb_pescaria;

SELECT sum(duracao) as duracaoTotalPescarias from tb_pescaria;

-- 17 Quantos barcos diferentes participaram nas pescarias.

SELECT * from tb_pescaria;

SELECT count(DISTINCT idBarco) as totalBarcos from tb_pescaria;

-- 18 Quantas pescarias ocorreram entre o dia 2 e o dia 3 de janeiro de 2017.

SELECT * FROM tb_pescaria;

SELECT idPescaria, date_format(tb_pescaria.dataReg, '%d/%m/%Y') 
as dataPescaria FROM tb_pescaria
WHERE tb_pescaria.dataReg BETWEEN STR_TO_DATE('02/01/2017', '%d/%m/%Y') 
AND STR_TO_DATE('03/01/2017', '%d/%m/%Y');

SELECT COUNT(idPescaria) as totalPescaria 
FROM tb_pescaria
WHERE tb_pescaria.dataReg BETWEEN STR_TO_DATE('2017-01-02', '%Y-%m-%d') 
AND STR_TO_DATE('2017-01-03', '%Y-%m-%d');

-- 19 No dia 4 de janeiro qual foi a pescaria que começou mais cedo.

SELECT * FROM tb_pescaria;

SELECT idPescaria, date_format(tb_pescaria.dataReg, '%d/%m/%Y') 
as dataPescaria, hora, duracao, idBarco FROM tb_pescaria
WHERE tb_pescaria.dataReg = STR_TO_DATE('04/01/2017', '%d/%m/%Y')
GROUP BY hora
ORDER BY hora ASC
LIMIT 1;

-- 20 Qual foi a diferença em horas entre a primeira e a última pescaria do dia 1 de janeiro de 2017.

SELECT * FROM tb_pescaria;

SELECT idPescaria, date_format(tb_pescaria.dataReg, '%d/%m/%Y') 
as dataPescaria, hora, duracao, idBarco FROM tb_pescaria
WHERE tb_pescaria.dataReg = STR_TO_DATE('01/01/2017', '%d/%m/%Y');



set @primeiraHora = (SELECT hora FROM tb_pescaria
WHERE tb_pescaria.dataReg = STR_TO_DATE('01/01/2017', '%d/%m/%Y')
GROUP BY hora
ORDER BY hora
LIMIT 1);

set @ultimaHora = (SELECT hora FROM tb_pescaria
WHERE tb_pescaria.dataReg = STR_TO_DATE('01/01/2017', '%d/%m/%Y')
GROUP BY hora
ORDER BY hora desc
LIMIT 1);

SELECT @ultimaHora - @primeiraHora as diferencaHoras;

-- 21 Crie uma view geral com todas as tabelas.

SELECT * FROM tb_barco;
SELECT * FROM tb_peixe;
SELECT * FROM tb_pescado;
SELECT * FROM tb_pescador;
SELECT * FROM tb_pescador_pescaria;
SELECT * FROM tb_pescaria;

-- drop VIEW IF EXISTS v_global_tables;
CREATE view v_global_tables AS
SELECT idBarco, idPescaria, idPescador, idPescado,
date_format(tb_pescaria.dataReg, '%d/%m/%y') as dataPescaria,
hora, duracao, tb_barco.nome as nomeBarco, 
tb_pescador.nome as nomePescador, tb_pescador.cidade as cidadePescador,
tb_pescador.idade as idadePescador, tb_barco.pesoMaximo as pesoBarco, tripulacao,
tb_barco.comprimento as comprimBarco, idPeixe, tb_peixe.nome as nomePeixe,
tb_peixe.pesoMedio as pesoMedPeixePesc, tb_peixe.precoKg as precoKgPeixe,
 tb_pescado.peso as pesoPeixePescado from tb_barco
join tb_pescaria USING (idBarco)
join tb_pescador_pescaria USING (idPescaria)
JOIN tb_pescador USING (idPescador)
JOIN tb_pescado USING (idPescaria)
JOIN tb_peixe USING (idPeixe);

SELECT * FROM v_global_tables;

-- 22 Pescadores que saíram para pescar na data '2017-1-3'.

SELECT * FROM v_global_tables;

SELECT nomePescador FROM v_global_tables
WHERE dataPescaria in ('03/01/17');

-- 23 Apresente o nome do peixe pescado na data 2017-1-3 .

SELECT * FROM v_global_tables;

SELECT nomePeixe FROM v_global_tables
WHERE dataPescaria in ('03/01/17')
ORDER BY nomePeixe
LIMIT 1;

-- 24 Apresente o número de pescadores que saíram por viagem.

SELECT * FROM v_global_tables;

SELECT idPescaria as viagem, count(idPescador) as numPescadores
from v_global_tables
GROUP BY idPescaria
ORDER BY idPescaria;

-- 25 Projete o número de espécies de peixe diferente capturados em cada pescaria.

SELECT * FROM v_global_tables;

SELECT idPescaria as Pescaria, count(DISTINCT idPeixe) as especiePeixe
from v_global_tables
GROUP BY idPescaria
ORDER BY idPescaria;

-- 26 Projete as pescarias cujo peso total de peixes capturados excedeu os 10.000 kg.

SELECT * FROM v_global_tables;

SELECT * from v_global_tables
WHERE pesoPeixePescado > 10000;

-- 27 Projete as pescarias nas quais a idade média dos pescadores foi superior a 50 anos de idade.

SELECT * FROM v_global_tables;

SELECT * from v_global_tables
WHERE idadePescador > 50;

-- 28 Projete os barcos que nunca capturaram Atum

SELECT * FROM v_global_tables;

-- drop view if EXISTS v_viagem_sem_atum;
CREATE view v_viagem_sem_atum as
SELECT idPescaria, idBarco, nomeBarco, nomePeixe as PeixeCapturado from v_global_tables
WHERE nomePeixe != 'Atum'
GROUP BY idPescaria
ORDER BY idPescaria;

-- drop view if EXISTS v_viagem_com_atum;
CREATE view v_viagem_com_atum as
SELECT idPescaria, idBarco, nomeBarco, nomePeixe as PeixeCapturado from v_global_tables
WHERE nomePeixe = 'Atum'
GROUP BY idPescaria
ORDER BY idPescaria;

SELECT * FROM v_viagem_sem_atum;
SELECT * FROM v_viagem_com_atum;

SELECT DISTINCT(nomeBarco) from v_viagem_sem_atum
where v_viagem_sem_atum.nomeBarco not in 
(SELECT nomeBarco from v_viagem_com_atum)
ORDER BY nomeBarco;

-- 29 Projete os barcos nos quais ‘Paulo Trindade’ nunca pescou.

SELECT * FROM v_global_tables;

-- drop view if EXISTS v_viagem_sem_paulo;
CREATE view v_viagem_sem_paulo as
SELECT idPescaria, idBarco, nomeBarco, nomePescador from v_global_tables
WHERE nomePescador != 'Paulo Trindade'
GROUP BY idPescaria
ORDER BY idPescaria;

drop view if EXISTS v_viagem_com_paulo;
CREATE view v_viagem_com_paulo as
SELECT idPescaria, idBarco, nomeBarco, nomePescador from v_global_tables
WHERE nomePescador = 'Paulo Trindade'
GROUP BY idPescaria
ORDER BY idPescaria;

SELECT * FROM v_viagem_sem_paulo;
SELECT * FROM v_viagem_com_paulo;

SELECT DISTINCT(nomeBarco) from v_viagem_sem_paulo
where v_viagem_sem_paulo.nomeBarco not in 
(SELECT nomeBarco from v_viagem_com_paulo)
ORDER BY nomeBarco;

/*
-- 30 Projete o número de pescarias feitas por cada pescador? 
Considere que alguns pescadores podem nunca ter feito uma viagem */

SELECT * FROM tb_pescador;
SELECT * from tb_pescador_pescaria;
SELECT * FROM v_global_tables;

SELECT DISTINCT(nome), 
       COUNT(v_global_tables.idPescador) AS quantPescaria 
FROM tb_pescador
LEFT JOIN v_global_tables ON tb_pescador.idPescador = v_global_tables.idPescador
GROUP BY nomePescador
ORDER BY nomePescador;

/*
-- 31 Quantas vezes cada espécie de peixe foi capturada? Considere que algumas espécies de peixe podem
nunca ter sido capturados. */

SELECT * FROM tb_peixe;
SELECT * from tb_pescaria;
SELECT * FROM v_global_tables;

SELECT DISTINCT(nome), 
       COUNT(v_global_tables.idPeixe) AS quantXCapturas
FROM tb_peixe
LEFT JOIN v_global_tables ON tb_peixe.idPeixe = v_global_tables.idPeixe
GROUP BY nomePeixe
ORDER BY nomePeixe;

-- 32 Em qual pescaria, ou pescarias, se verificou a tripulação mais nova.

SELECT * FROM v_global_tables;

set @pescadorNovo = (SELECT min(idade) from tb_pescador);
SELECT * FROM v_global_tables
WHERE idadePescador = @pescadorNovo;

-- 33 Em qual ou quais pescarias foi pescada a menor quantidade de peixe.

SELECT * FROM v_global_tables;

SELECT * FROM v_global_tables
ORDER BY pesoPeixePescado
LIMIT 3;

-- 34 Quais pescadores fizeram pescarias em que o limite de peso do barco foi ultrapassado.

SELECT * FROM v_global_tables;

SELECT nomePescador, idPescaria, pesoBarco, pesoPeixePescado
 FROM v_global_tables
WHERE pesoBarco < pesoPeixePescado
ORDER BY pesoPeixePescado;

-- 35 Quais peixes foram capturados em pescarias em que o limite de peso do barco foi ultrapassado.

SELECT * FROM v_global_tables;

SELECT nomePeixe, idPescaria, pesoBarco, pesoPeixePescado
 FROM v_global_tables
WHERE pesoBarco < pesoPeixePescado
ORDER BY pesoPeixePescado;