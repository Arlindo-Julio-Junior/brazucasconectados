-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Tempo de geração: 25-Jul-2023 às 23:34
-- Versão do servidor: 10.4.27-MariaDB
-- versão do PHP: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `bd_aviacao`
--

DELIMITER $$
--
-- Procedimentos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `p_aeroporto` (IN `a` INT, IN `b` TEXT, IN `c` TEXT, IN `d` TEXT)   BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `p_aviao` (IN `a` TEXT, IN `b` INT)   BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `p_modelo` (IN `a` TEXT, IN `b` TEXT, IN `c` INT)   BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `p_voo` (IN `a` INT, `b` INT, `c` INT, `d` INT, `e` TEXT, `f` FLOAT)   BEGIN
    declare total int;
    declare msg text;

    SELECT count(idVoo) into total from tb_voo 
    where idVoo = a and idAviao = b and idAeroportoPartida = c AND
    idAeroportoChegada = d and companhia = e and duracao = f;
    if total = 1 THEN
        set msg = "já existe";
    ELSE
        insert into tb_voo(idVoo, idAviao, idAeroportoPartida, idAeroportoChegada,
        companhia, duracao) VALUES (a, b, c, d, e, f);
        set msg = "cadastrado";
    end if;
    SELECT msg as result;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_aeroporto`
--

CREATE TABLE `tb_aeroporto` (
  `idAeroporto` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `cidade` varchar(50) NOT NULL,
  `pais` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `tb_aeroporto`
--

INSERT INTO `tb_aeroporto` (`idAeroporto`, `nome`, `cidade`, `pais`) VALUES
(14, 'Aeroporto do Motijo', 'Motijo', 'Portugal'),
(8, 'Charles de Gaule', 'Paris', 'França'),
(5, 'Faro', 'Faro', 'Portugal'),
(12, 'Gatwick', 'Londres', 'Reino Unido'),
(11, 'Heathrow', 'Londres', 'Reino Unido'),
(2, 'Madeira', 'Funchal', 'Portugal'),
(9, 'Orly', 'Paris', 'França'),
(4, 'Ponta Delgada', 'S. Miguel', 'Portugal'),
(3, 'Portela', 'Lisboa', 'Portugal'),
(1, 'Sa Carneiro', 'Porto', 'Portugal');

--
-- Acionadores `tb_aeroporto`
--
DELIMITER $$
CREATE TRIGGER `trg_apagar_aeroporto` AFTER DELETE ON `tb_aeroporto` FOR EACH ROW BEGIN
    INSERT INTO tb_aeroporto_apagado
    VALUES(old.idAeroporto, CURRENT_TIMESTAMP, old.nome);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_atualizar_aeroporto` BEFORE UPDATE ON `tb_aeroporto` FOR EACH ROW BEGIN
    INSERT INTO tb_aeroporto_atualizado
    VALUES(new.idAeroporto, CURRENT_TIMESTAMP, new.nome, new.cidade, new.pais);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_inserir_cliente` AFTER INSERT ON `tb_aeroporto` FOR EACH ROW BEGIN
    INSERT INTO tb_historico_aeroportos
    VALUES(new.idAeroporto, new.Nome, CURRENT_TIMESTAMP);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_registar_formando` AFTER INSERT ON `tb_aeroporto` FOR EACH ROW BEGIN
    INSERT INTO tb_historico_aeroportos
    VALUES(new.idAeroporto, new.Nome, CURRENT_TIMESTAMP);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_aeroporto_apagado`
--

CREATE TABLE `tb_aeroporto_apagado` (
  `idAeroporto` int(11) DEFAULT NULL,
  `dataReg` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `nome` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `tb_aeroporto_apagado`
--

INSERT INTO `tb_aeroporto_apagado` (`idAeroporto`, `dataReg`, `nome`) VALUES
(13, '2023-07-25 20:06:38', 'Aeroporto da Capital');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_aeroporto_atualizado`
--

CREATE TABLE `tb_aeroporto_atualizado` (
  `idAeroporto` int(11) DEFAULT NULL,
  `dataReg` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `nome` varchar(50) DEFAULT NULL,
  `cidade` varchar(50) DEFAULT NULL,
  `pais` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `tb_aeroporto_atualizado`
--

INSERT INTO `tb_aeroporto_atualizado` (`idAeroporto`, `dataReg`, `nome`, `cidade`, `pais`) VALUES
(14, '2023-07-25 20:34:17', 'Aeroporto do Motijo', 'Motijo', 'Portugal');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_aviao`
--

CREATE TABLE `tb_aviao` (
  `idAviao` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `idModelo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `tb_aviao`
--

INSERT INTO `tb_aviao` (`idAviao`, `nome`, `idModelo`) VALUES
(4, 'Bartolomeu Dias', 3),
(8, 'Diogo Cão', 3),
(3, 'Dom Henrique', 5),
(6, 'Fernão de Magalhães', 4),
(9, 'Gaspar Corte Real', 1),
(2, 'Gil Eanes', 1),
(7, 'Gonçalo Cabral', 3),
(5, 'Pedro Álvares CAbral', 4),
(1, 'Vasco da Gama', 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_companhia`
--

CREATE TABLE `tb_companhia` (
  `idCompanhia` int(11) NOT NULL,
  `companhia` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `tb_companhia`
--

INSERT INTO `tb_companhia` (`idCompanhia`, `companhia`) VALUES
(1, 'TAP'),
(2, 'BA'),
(3, 'SATA'),
(4, 'AirFrance'),
(5, 'Portugalia');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_historico_aeroportos`
--

CREATE TABLE `tb_historico_aeroportos` (
  `idAeroporto` int(11) DEFAULT NULL,
  `nome` varchar(50) DEFAULT NULL,
  `dataReg` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `tb_historico_aeroportos`
--

INSERT INTO `tb_historico_aeroportos` (`idAeroporto`, `nome`, `dataReg`) VALUES
(13, 'Aeroporto da Capital', '2023-07-25 19:14:50'),
(13, 'Aeroporto da Capital', '2023-07-25 19:14:50'),
(14, 'Aeroporto do Motijo', '2023-07-25 20:29:42'),
(14, 'Aeroporto do Motijo', '2023-07-25 20:29:42');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_modelo`
--

CREATE TABLE `tb_modelo` (
  `idModelo` int(11) NOT NULL,
  `fabricante` varchar(50) NOT NULL,
  `versao` varchar(50) NOT NULL,
  `numMotores` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `tb_modelo`
--

INSERT INTO `tb_modelo` (`idModelo`, `fabricante`, `versao`, `numMotores`) VALUES
(1, 'Douglas', 'DC-10', 3),
(2, 'Boeing', '737', 2),
(3, 'Boeing', '747', 4),
(4, 'Airbus', 'A300', 2),
(5, 'Airbus', 'A340', 4);

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_voo`
--

CREATE TABLE `tb_voo` (
  `idVoo` int(11) NOT NULL,
  `idAviao` int(11) NOT NULL,
  `idAeroportoPartida` int(11) NOT NULL,
  `idAeroportoChegada` int(11) NOT NULL,
  `companhia` varchar(50) NOT NULL,
  `duracao` decimal(10,0) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `tb_voo`
--

INSERT INTO `tb_voo` (`idVoo`, `idAviao`, `idAeroportoPartida`, `idAeroportoChegada`, `companhia`, `duracao`) VALUES
(1001, 1, 1, 2, 'TAP', '2'),
(1002, 2, 2, 3, 'TAP', '1'),
(1003, 5, 2, 12, 'BA', '2'),
(1004, 6, 4, 3, 'SATA', '3'),
(1005, 3, 9, 2, 'AirFrance', '2'),
(1006, 5, 8, 11, 'BA', '1'),
(1007, 5, 5, 1, 'TAP', '1'),
(1008, 4, 3, 12, 'Portugalia', '3'),
(1009, 1, 3, 4, 'Portugalia', '2'),
(1010, 1, 4, 12, 'BA', '3'),
(1111, 3, 1, 3, 'TAP', '2');

-- --------------------------------------------------------

--
-- Estrutura stand-in para vista `v_aeroporto`
-- (Veja abaixo para a view atual)
--
CREATE TABLE `v_aeroporto` (
`nome` varchar(50)
,`cidade` varchar(50)
,`pais` varchar(50)
);

-- --------------------------------------------------------

--
-- Estrutura stand-in para vista `v_aviao`
-- (Veja abaixo para a view atual)
--
CREATE TABLE `v_aviao` (
`fabricante` varchar(50)
,`versao` varchar(50)
,`numMotores` int(11)
,`nome` varchar(50)
);

-- --------------------------------------------------------

--
-- Estrutura stand-in para vista `v_chegadas`
-- (Veja abaixo para a view atual)
--
CREATE TABLE `v_chegadas` (
`idVoo` int(11)
,`idAeroportoChegada` int(11)
,`cidadeChegada` varchar(50)
,`paisChegada` varchar(50)
);

-- --------------------------------------------------------

--
-- Estrutura stand-in para vista `v_escala`
-- (Veja abaixo para a view atual)
--
CREATE TABLE `v_escala` (
`Escala` varchar(50)
,`idVooEscala` int(11)
,`idAeroportoEscala` int(11)
);

-- --------------------------------------------------------

--
-- Estrutura stand-in para vista `v_londres`
-- (Veja abaixo para a view atual)
--
CREATE TABLE `v_londres` (
`Londres` varchar(50)
,`idAeroportoEscala` int(11)
);

-- --------------------------------------------------------

--
-- Estrutura stand-in para vista `v_modelo`
-- (Veja abaixo para a view atual)
--
CREATE TABLE `v_modelo` (
`fabricante` varchar(50)
,`versao` varchar(50)
,`numMotores` int(11)
);

-- --------------------------------------------------------

--
-- Estrutura stand-in para vista `v_partidas`
-- (Veja abaixo para a view atual)
--
CREATE TABLE `v_partidas` (
`idAviao` int(11)
,`idVoo` int(11)
,`idAeroportoPartida` int(11)
,`cidadePartida` varchar(50)
,`paisPartida` varchar(50)
);

-- --------------------------------------------------------

--
-- Estrutura stand-in para vista `v_partidasChegadas`
-- (Veja abaixo para a view atual)
--
CREATE TABLE `v_partidasChegadas` (
`idAviao` int(11)
,`idVoo` int(11)
,`idAeroportoPartida` int(11)
,`paisPartida` varchar(50)
,`idAeroportoChegada` int(11)
,`paisChegada` varchar(50)
,`cidadePartida` varchar(50)
,`cidadeChegada` varchar(50)
);

-- --------------------------------------------------------

--
-- Estrutura stand-in para vista `v_porto`
-- (Veja abaixo para a view atual)
--
CREATE TABLE `v_porto` (
`Porto` varchar(50)
,`idVooPorto` int(11)
,`idAeroportoEscala` int(11)
);

-- --------------------------------------------------------

--
-- Estrutura stand-in para vista `v_porto_londres`
-- (Veja abaixo para a view atual)
--
CREATE TABLE `v_porto_londres` (
`idVooPorto` int(11)
,`idVooEscala` int(11)
,`idAeroportoPartida` int(11)
,`idAeroportoEscala` int(11)
,`idAeroportoChegada` int(11)
);

-- --------------------------------------------------------

--
-- Estrutura stand-in para vista `v_voo`
-- (Veja abaixo para a view atual)
--
CREATE TABLE `v_voo` (
`idvoo` int(11)
,`cidadePartida` varchar(50)
,`paisPartida` varchar(50)
,`cidadeChegada` varchar(50)
,`paisChegada` varchar(50)
,`nome` varchar(50)
,`fabricante` varchar(50)
,`versao` varchar(50)
,`numMotores` int(11)
);

-- --------------------------------------------------------

--
-- Estrutura para vista `v_aeroporto`
--
DROP TABLE IF EXISTS `v_aeroporto`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_aeroporto`  AS SELECT `tb_aeroporto`.`nome` AS `nome`, `tb_aeroporto`.`cidade` AS `cidade`, `tb_aeroporto`.`pais` AS `pais` FROM `tb_aeroporto``tb_aeroporto`  ;

-- --------------------------------------------------------

--
-- Estrutura para vista `v_aviao`
--
DROP TABLE IF EXISTS `v_aviao`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_aviao`  AS SELECT `tb_modelo`.`fabricante` AS `fabricante`, `tb_modelo`.`versao` AS `versao`, `tb_modelo`.`numMotores` AS `numMotores`, `tb_aviao`.`nome` AS `nome` FROM (`tb_modelo` join `tb_aviao` on(`tb_modelo`.`idModelo` = `tb_aviao`.`idModelo`))  ;

-- --------------------------------------------------------

--
-- Estrutura para vista `v_chegadas`
--
DROP TABLE IF EXISTS `v_chegadas`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_chegadas`  AS SELECT `tb_voo`.`idVoo` AS `idVoo`, `tb_voo`.`idAeroportoChegada` AS `idAeroportoChegada`, `tb_aeroporto`.`cidade` AS `cidadeChegada`, `tb_aeroporto`.`pais` AS `paisChegada` FROM (`tb_voo` join `tb_aeroporto` on(`tb_voo`.`idAeroportoChegada` = `tb_aeroporto`.`idAeroporto`))  ;

-- --------------------------------------------------------

--
-- Estrutura para vista `v_escala`
--
DROP TABLE IF EXISTS `v_escala`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_escala`  AS SELECT `tb_aeroporto`.`nome` AS `Escala`, `v_porto_londres`.`idVooEscala` AS `idVooEscala`, `v_porto_londres`.`idAeroportoEscala` AS `idAeroportoEscala` FROM (`v_porto_londres` join `tb_aeroporto` on(`tb_aeroporto`.`idAeroporto` = `v_porto_londres`.`idAeroportoEscala`))  ;

-- --------------------------------------------------------

--
-- Estrutura para vista `v_londres`
--
DROP TABLE IF EXISTS `v_londres`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_londres`  AS SELECT `tb_aeroporto`.`nome` AS `Londres`, `v_porto_londres`.`idAeroportoEscala` AS `idAeroportoEscala` FROM (`v_porto_londres` join `tb_aeroporto` on(`tb_aeroporto`.`idAeroporto` = `v_porto_londres`.`idAeroportoChegada`))  ;

-- --------------------------------------------------------

--
-- Estrutura para vista `v_modelo`
--
DROP TABLE IF EXISTS `v_modelo`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_modelo`  AS SELECT `tb_modelo`.`fabricante` AS `fabricante`, `tb_modelo`.`versao` AS `versao`, `tb_modelo`.`numMotores` AS `numMotores` FROM `tb_modelo``tb_modelo`  ;

-- --------------------------------------------------------

--
-- Estrutura para vista `v_partidas`
--
DROP TABLE IF EXISTS `v_partidas`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_partidas`  AS SELECT `tb_voo`.`idAviao` AS `idAviao`, `tb_voo`.`idVoo` AS `idVoo`, `tb_voo`.`idAeroportoPartida` AS `idAeroportoPartida`, `tb_aeroporto`.`cidade` AS `cidadePartida`, `tb_aeroporto`.`pais` AS `paisPartida` FROM (`tb_voo` join `tb_aeroporto` on(`tb_voo`.`idAeroportoPartida` = `tb_aeroporto`.`idAeroporto`))  ;

-- --------------------------------------------------------

--
-- Estrutura para vista `v_partidasChegadas`
--
DROP TABLE IF EXISTS `v_partidasChegadas`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_partidasChegadas`  AS SELECT `v_partidas`.`idAviao` AS `idAviao`, `v_partidas`.`idVoo` AS `idVoo`, `v_partidas`.`idAeroportoPartida` AS `idAeroportoPartida`, `v_partidas`.`paisPartida` AS `paisPartida`, `v_chegadas`.`idAeroportoChegada` AS `idAeroportoChegada`, `v_chegadas`.`paisChegada` AS `paisChegada`, `v_partidas`.`cidadePartida` AS `cidadePartida`, `v_chegadas`.`cidadeChegada` AS `cidadeChegada` FROM (`v_partidas` join `v_chegadas` on(`v_partidas`.`idVoo` = `v_chegadas`.`idVoo`))  ;

-- --------------------------------------------------------

--
-- Estrutura para vista `v_porto`
--
DROP TABLE IF EXISTS `v_porto`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_porto`  AS SELECT `tb_aeroporto`.`nome` AS `Porto`, `v_porto_londres`.`idVooPorto` AS `idVooPorto`, `v_porto_londres`.`idAeroportoEscala` AS `idAeroportoEscala` FROM (`v_porto_londres` join `tb_aeroporto` on(`tb_aeroporto`.`idAeroporto` = `v_porto_londres`.`idAeroportoPartida`))  ;

-- --------------------------------------------------------

--
-- Estrutura para vista `v_porto_londres`
--
DROP TABLE IF EXISTS `v_porto_londres`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_porto_londres`  AS SELECT `Porto`.`idVooPorto` AS `idVooPorto`, `Londres`.`idVooEscala` AS `idVooEscala`, `Porto`.`idAeroportoPartida` AS `idAeroportoPartida`, `Porto`.`idAeroportoChegada` AS `idAeroportoEscala`, `Londres`.`idAeroportoChegada` AS `idAeroportoChegada` FROM ((select `tb_voo`.`idVoo` AS `idVooPorto`,`tb_voo`.`idAeroportoPartida` AS `idAeroportoPartida`,`tb_voo`.`idAeroportoChegada` AS `idAeroportoChegada` from `tb_voo` where `tb_voo`.`idAeroportoPartida` = 1) `Porto` join (select `tb_voo`.`idVoo` AS `idVooEscala`,`tb_voo`.`idAeroportoPartida` AS `idAeroportoPartida`,`tb_voo`.`idAeroportoChegada` AS `idAeroportoChegada` from `tb_voo` where `tb_voo`.`idAeroportoChegada` in (11,12)) `Londres` on(`Porto`.`idAeroportoChegada` = `Londres`.`idAeroportoPartida`))  ;

-- --------------------------------------------------------

--
-- Estrutura para vista `v_voo`
--
DROP TABLE IF EXISTS `v_voo`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_voo`  AS SELECT `v_partidasChegadas`.`idVoo` AS `idvoo`, `v_partidasChegadas`.`cidadePartida` AS `cidadePartida`, `v_partidasChegadas`.`paisPartida` AS `paisPartida`, `v_partidasChegadas`.`cidadeChegada` AS `cidadeChegada`, `v_partidasChegadas`.`paisChegada` AS `paisChegada`, `tb_aviao`.`nome` AS `nome`, `tb_modelo`.`fabricante` AS `fabricante`, `tb_modelo`.`versao` AS `versao`, `tb_modelo`.`numMotores` AS `numMotores` FROM ((`v_partidasChegadas` join `tb_aviao` on(`v_partidasChegadas`.`idAviao` = `tb_aviao`.`idAviao`)) join `tb_modelo` on(`tb_aviao`.`idModelo` = `tb_modelo`.`idModelo`))  ;

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `tb_aeroporto`
--
ALTER TABLE `tb_aeroporto`
  ADD PRIMARY KEY (`idAeroporto`),
  ADD UNIQUE KEY `ncp` (`nome`,`cidade`,`pais`);

--
-- Índices para tabela `tb_aviao`
--
ALTER TABLE `tb_aviao`
  ADD PRIMARY KEY (`idAviao`),
  ADD UNIQUE KEY `nome` (`nome`,`idModelo`);

--
-- Índices para tabela `tb_companhia`
--
ALTER TABLE `tb_companhia`
  ADD PRIMARY KEY (`idCompanhia`);

--
-- Índices para tabela `tb_modelo`
--
ALTER TABLE `tb_modelo`
  ADD PRIMARY KEY (`idModelo`),
  ADD UNIQUE KEY `fv` (`fabricante`,`versao`);

--
-- Índices para tabela `tb_voo`
--
ALTER TABLE `tb_voo`
  ADD PRIMARY KEY (`idVoo`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `tb_aeroporto`
--
ALTER TABLE `tb_aeroporto`
  MODIFY `idAeroporto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de tabela `tb_aviao`
--
ALTER TABLE `tb_aviao`
  MODIFY `idAviao` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de tabela `tb_companhia`
--
ALTER TABLE `tb_companhia`
  MODIFY `idCompanhia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `tb_modelo`
--
ALTER TABLE `tb_modelo`
  MODIFY `idModelo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
