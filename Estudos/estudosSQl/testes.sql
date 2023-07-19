Drop procedure if exists p_aeroporto;
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













DROP VIEW IF EXISTS v_aeroporto;
CREATE VIEW v_aeroporto AS 
SELECT nome, cidade, pais FROM tb_aeroporto;

SELECT * FROM v_aeroporto;


















DROP procedure if EXISTS p_modelo;

CREATE procedure p_modelo (in a text, in b text, in c int)
BEGIN
    declare total1 INT;
    declare total2 int;
    declare msg TEXT;

    SELECT count(fabricante), count(versao) into total1, total2
    from tb_modelo where fabricante = a and versao = b and numMotores = c;
    if total1 = 1 and total2 = 1 THEN
        set msg = -1;
    ELSE
        insert into tb_modelo (idModelo,fabricante, versao, numMotores) values(null, a, b, c);
        SET msg = 1;
    end If;
    SELECT msg as result;
END;