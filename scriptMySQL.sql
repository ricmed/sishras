-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: 192.168.14.50    Database: sishras
-- ------------------------------------------------------
-- Server version	5.7.23-0ubuntu0.16.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `100item`
--

DROP TABLE IF EXISTS `100item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `100item` (
  `idItem` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` varchar(45) DEFAULT NULL,
  `descItem` varchar(250) NOT NULL,
  `idGrupoItem` int(11) DEFAULT NULL,
  `idSubGrupoItem` int(11) DEFAULT NULL,
  `idUnidade` int(11) DEFAULT NULL,
  `idUnidadeSimas` int(11) DEFAULT NULL,
  `itemImagemFile` blob,
  `itemImagemPath` varchar(45) DEFAULT NULL,
  `codBarras` varchar(45) DEFAULT NULL,
  `tipoItem` int(11) DEFAULT NULL,
  `qtdCritica` int(11) DEFAULT NULL,
  `qtdPadrao` int(11) DEFAULT NULL,
  `isAtivo` tinyint(1) NOT NULL COMMENT '0 - ativo1 - inativo',
  `isFarmacia` varchar(45) DEFAULT NULL COMMENT '0 - sim 1 - nao',
  PRIMARY KEY (`idItem`),
  UNIQUE KEY `descItem_UNIQUE` (`descItem`),
  UNIQUE KEY `codigo_UNIQUE` (`codigo`),
  KEY `tipoItem_100_idx` (`tipoItem`),
  KEY `idGrupoItem_100_idx` (`idGrupoItem`),
  KEY `idSubGrupoItem_100_idx` (`idSubGrupoItem`),
  CONSTRAINT `idGrupoItem_100` FOREIGN KEY (`idGrupoItem`) REFERENCES `150grupoitem` (`idGrupoItem`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `idSubGrupoItem_100` FOREIGN KEY (`idSubGrupoItem`) REFERENCES `151subgrupoitem` (`idSubGrupoItem`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `tipoItem_100` FOREIGN KEY (`tipoItem`) REFERENCES `903tipoitem` (`idTipoItem`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3078 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `101estoque`
--

DROP TABLE IF EXISTS `101estoque`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `101estoque` (
  `idEstoque` int(11) NOT NULL AUTO_INCREMENT,
  `idSetor` int(11) DEFAULT NULL COMMENT 'ou Centro de Custos',
  `idItem` int(11) NOT NULL,
  `lote` varchar(45) DEFAULT NULL,
  `dataValidade` date DEFAULT NULL,
  `quantidade` int(11) NOT NULL,
  `valorUnit` double DEFAULT NULL,
  `valorTotal` double DEFAULT NULL,
  PRIMARY KEY (`idEstoque`),
  KEY `idItem_idx` (`idItem`),
  KEY `lote_idx` (`idItem`),
  KEY `idSetor_101_idx` (`idSetor`),
  CONSTRAINT `idItem_101` FOREIGN KEY (`idItem`) REFERENCES `100item` (`idItem`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `idSetor_101` FOREIGN KEY (`idSetor`) REFERENCES `900setor` (`idSetor`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4933 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `102requisicao`
--

DROP TABLE IF EXISTS `102requisicao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `102requisicao` (
  `idRequisicao` int(11) NOT NULL AUTO_INCREMENT,
  `idSetorOrigem` int(11) NOT NULL,
  `idUsuario` varchar(255) NOT NULL,
  `dataRequisicao` datetime NOT NULL,
  `tipo` int(11) NOT NULL COMMENT '0 - Requisição\n1 - Devolução',
  `idSetorDestino` int(11) NOT NULL,
  `status` varchar(1) NOT NULL,
  `horaStatus1` datetime DEFAULT NULL,
  `horaStatus2` datetime DEFAULT NULL,
  `horaStatus3` datetime DEFAULT NULL,
  `horaStatus4` datetime DEFAULT NULL,
  `horaStatus5` datetime DEFAULT NULL,
  `horaStatus6` datetime DEFAULT NULL,
  PRIMARY KEY (`idRequisicao`),
  KEY `idUsuario_102_idx` (`idUsuario`),
  KEY `idSetorOrigem_102_fk_idx` (`idSetorOrigem`),
  KEY `idSetorDestino_102_idx` (`idSetorDestino`),
  CONSTRAINT `102requisicao_ibfk_1` FOREIGN KEY (`idSetorOrigem`) REFERENCES `115responsavelsetor` (`idSetorOrigem`),
  CONSTRAINT `102requisicao_ibfk_2` FOREIGN KEY (`idSetorDestino`) REFERENCES `115responsavelsetor` (`idSetorDestino`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `103requisicaodetalhe`
--

DROP TABLE IF EXISTS `103requisicaodetalhe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `103requisicaodetalhe` (
  `idRequisicaoDetalhe` int(11) NOT NULL AUTO_INCREMENT,
  `idRequisicao` int(11) NOT NULL,
  `idItem` int(11) NOT NULL,
  `lote` varchar(45) NOT NULL,
  `dataValidade` date NOT NULL,
  `qtdSolicitada` float NOT NULL,
  `qtdAtendida` float DEFAULT NULL,
  `isAtendida` tinyint(1) NOT NULL COMMENT '0 - Sim1 - Não',
  `obs` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`idRequisicaoDetalhe`),
  KEY `idRequisicao_103_idx` (`idRequisicao`),
  KEY `idItem_103_idx` (`idItem`),
  CONSTRAINT `idItem_103` FOREIGN KEY (`idItem`) REFERENCES `100item` (`idItem`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `idRequisicao_103` FOREIGN KEY (`idRequisicao`) REFERENCES `102requisicao` (`idRequisicao`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `104padrao`
--

DROP TABLE IF EXISTS `104padrao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `104padrao` (
  `idpadrao` int(11) NOT NULL AUTO_INCREMENT,
  `idSetor` int(11) NOT NULL,
  `dataAlteracao` date NOT NULL,
  `tipoPadrao` int(11) NOT NULL,
  `idUsuario` int(11) DEFAULT NULL,
  `idSetorDestino` int(11) DEFAULT NULL,
  `dataCriacao` date DEFAULT NULL,
  PRIMARY KEY (`idpadrao`),
  KEY `idSetor_idx` (`idSetor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `105padraodetalhe`
--

DROP TABLE IF EXISTS `105padraodetalhe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `105padraodetalhe` (
  `idpadraoDetalhe` int(11) NOT NULL AUTO_INCREMENT,
  `idPadrao` int(11) NOT NULL,
  `idItem` int(11) NOT NULL,
  `qtdPadrao` float NOT NULL,
  `periodicidade` varchar(1) NOT NULL,
  PRIMARY KEY (`idpadraoDetalhe`),
  KEY `idPadrao_idx` (`idPadrao`),
  CONSTRAINT `idPadrao_fk` FOREIGN KEY (`idPadrao`) REFERENCES `104padrao` (`idpadrao`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `106saida`
--

DROP TABLE IF EXISTS `106saida`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `106saida` (
  `idSaida` int(11) NOT NULL AUTO_INCREMENT,
  `IdTipoSaida` int(11) NOT NULL DEFAULT '2',
  `idSetorOrigem` int(11) NOT NULL,
  `idSetorDestino` int(11) NOT NULL,
  `dataSaida` datetime NOT NULL,
  `turno` int(11) DEFAULT NULL COMMENT 'campo para a farmacia',
  `requisicao` varchar(45) DEFAULT NULL,
  `isFechado` varchar(1) DEFAULT NULL,
  `usuario` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idSaida`),
  KEY `idSetor_106_idx` (`idSetorOrigem`),
  KEY `idTipoEntSai_106_idx` (`IdTipoSaida`),
  KEY `idSetor_destino106_idx` (`idSetorDestino`),
  CONSTRAINT `idSetor_106` FOREIGN KEY (`idSetorOrigem`) REFERENCES `900setor` (`idSetor`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `idSetor_destino106` FOREIGN KEY (`idSetorDestino`) REFERENCES `900setor` (`idSetor`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `idTipoEntSai_106` FOREIGN KEY (`IdTipoSaida`) REFERENCES `905tipoentradasaida` (`idTipoEntradaSaida`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=15210 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `107entrada`
--

DROP TABLE IF EXISTS `107entrada`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `107entrada` (
  `idEntrada` int(11) NOT NULL AUTO_INCREMENT,
  `idSetor` int(11) NOT NULL,
  `idTipoEntrada` int(11) NOT NULL,
  `dataEntrada` date NOT NULL,
  `numProcesso` varchar(11) DEFAULT NULL,
  `numEmpenho` varchar(11) DEFAULT NULL,
  `isFecahdo` varchar(1) NOT NULL,
  PRIMARY KEY (`idEntrada`),
  KEY `idSetor_107_idx` (`idSetor`),
  KEY `tipoEntrada_107_idx` (`idTipoEntrada`),
  CONSTRAINT `idSetor_107` FOREIGN KEY (`idSetor`) REFERENCES `900setor` (`idSetor`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `idTipoEntSai_107` FOREIGN KEY (`idTipoEntrada`) REFERENCES `905tipoentradasaida` (`idTipoEntradaSaida`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `108emprestimo`
--

DROP TABLE IF EXISTS `108emprestimo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `108emprestimo` (
  `idEmprestimo` int(11) NOT NULL AUTO_INCREMENT,
  `idItem` int(11) NOT NULL,
  `lote` int(11) DEFAULT NULL,
  `dataValidade` date DEFAULT NULL,
  `quantidade` float DEFAULT NULL,
  `idRequisicao` int(11) NOT NULL,
  PRIMARY KEY (`idEmprestimo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `109entradadetalhe`
--

DROP TABLE IF EXISTS `109entradadetalhe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `109entradadetalhe` (
  `idEntradaDetalhe` int(11) NOT NULL AUTO_INCREMENT,
  `idEntrada` int(11) NOT NULL,
  `idItem` int(11) NOT NULL,
  `quantidade` float NOT NULL,
  `lote` varchar(10) DEFAULT NULL,
  `datavalidade` date DEFAULT NULL,
  `valorUnit` double DEFAULT NULL,
  `valorTotal` double DEFAULT NULL,
  PRIMARY KEY (`idEntradaDetalhe`),
  KEY `idEntrada_109_idx` (`idEntrada`),
  KEY `idItem_109_idx` (`idItem`),
  CONSTRAINT `idEntrada_109` FOREIGN KEY (`idEntrada`) REFERENCES `107entrada` (`idEntrada`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `idItem_109` FOREIGN KEY (`idItem`) REFERENCES `100item` (`idItem`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1404 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `110saidadetalhe`
--

DROP TABLE IF EXISTS `110saidadetalhe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `110saidadetalhe` (
  `idSaidaDetalhe` int(11) NOT NULL AUTO_INCREMENT,
  `idSaida` int(11) NOT NULL,
  `idRequisicao` int(11) DEFAULT NULL,
  `idItem` int(11) NOT NULL,
  `quantidade` float NOT NULL COMMENT 'quantidade atendida',
  `lote` varchar(45) DEFAULT NULL,
  `dataValidade` date DEFAULT NULL,
  `valorUnit` double DEFAULT NULL,
  `valorTotal` double DEFAULT NULL,
  `qtdSolicitada` int(11) DEFAULT NULL,
  PRIMARY KEY (`idSaidaDetalhe`),
  KEY `idSaida_110_idx` (`idSaida`),
  KEY `idItem_110_idx` (`idItem`),
  CONSTRAINT `idItem_110` FOREIGN KEY (`idItem`) REFERENCES `100item` (`idItem`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `idSaida_110` FOREIGN KEY (`idSaida`) REFERENCES `106saida` (`idSaida`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=94992 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `111estoque`
--

DROP TABLE IF EXISTS `111estoque`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `111estoque` (
  `idEstoque` int(11) NOT NULL AUTO_INCREMENT,
  `idSetor` int(11) NOT NULL,
  `idItem` int(11) NOT NULL,
  `qtd` int(11) NOT NULL,
  PRIMARY KEY (`idEstoque`),
  KEY `idItem111_idx` (`idItem`),
  KEY `idSetor_idx` (`idSetor`),
  CONSTRAINT `idItem111` FOREIGN KEY (`idItem`) REFERENCES `100item` (`idItem`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `idSetor` FOREIGN KEY (`idSetor`) REFERENCES `900setor` (`idSetor`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `112inventario`
--

DROP TABLE IF EXISTS `112inventario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `112inventario` (
  `idInventario` int(11) NOT NULL AUTO_INCREMENT,
  `numeroInv` varchar(45) NOT NULL,
  `dataInventario` date NOT NULL,
  `idSetor` int(11) NOT NULL,
  `idTipoInventario` int(11) DEFAULT NULL,
  `status` varchar(1) NOT NULL,
  PRIMARY KEY (`idInventario`),
  KEY `idSetor112_idx` (`idSetor`),
  KEY `idTipoInventario112_idx` (`idTipoInventario`),
  CONSTRAINT `idSetor112` FOREIGN KEY (`idSetor`) REFERENCES `900setor` (`idSetor`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `idTipoInventario112` FOREIGN KEY (`idTipoInventario`) REFERENCES `114tipoinventario` (`idTipoInventario`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `113inventariodetalhe`
--

DROP TABLE IF EXISTS `113inventariodetalhe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `113inventariodetalhe` (
  `idInventario` int(11) NOT NULL,
  `idInventarioDetalhe` int(11) NOT NULL AUTO_INCREMENT,
  `idItem` int(11) NOT NULL,
  `lote` varchar(45) DEFAULT NULL,
  `dataValidade` date DEFAULT NULL,
  `qtdEstoque` int(11) DEFAULT NULL,
  `qtdContada` int(11) DEFAULT NULL,
  `qtdDivergente` int(11) DEFAULT NULL,
  `obs` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`idInventarioDetalhe`),
  KEY `idInventario113_idx` (`idInventario`),
  KEY `idItem113_idx` (`idItem`),
  CONSTRAINT `idInventario113` FOREIGN KEY (`idInventario`) REFERENCES `112inventario` (`idInventario`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `idItem113` FOREIGN KEY (`idItem`) REFERENCES `100item` (`idItem`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1977 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `114tipoinventario`
--

DROP TABLE IF EXISTS `114tipoinventario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `114tipoinventario` (
  `idTipoInventario` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(45) NOT NULL,
  PRIMARY KEY (`idTipoInventario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `116agendapedido`
--

DROP TABLE IF EXISTS `116agendapedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `116agendapedido` (
  `idAgendaPedido` int(11) NOT NULL AUTO_INCREMENT,
  `idSetor` varchar(45) DEFAULT NULL,
  `dia1` varchar(45) DEFAULT NULL,
  `dia2` varchar(45) DEFAULT NULL,
  `dia3` varchar(45) DEFAULT NULL,
  `dia4` varchar(45) DEFAULT NULL,
  `dia5` varchar(45) DEFAULT NULL,
  `dia6` varchar(45) DEFAULT NULL,
  `dia7` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idAgendaPedido`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `117statuspedido`
--

DROP TABLE IF EXISTS `117statuspedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `117statuspedido` (
  `idStatusPedido` int(11) NOT NULL,
  `descricao` varchar(45) NOT NULL,
  PRIMARY KEY (`idStatusPedido`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `150grupoitem`
--

DROP TABLE IF EXISTS `150grupoitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `150grupoitem` (
  `idGrupoItem` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idGrupoItem`)
) ENGINE=InnoDB AUTO_INCREMENT=206 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `151subgrupoitem`
--

DROP TABLE IF EXISTS `151subgrupoitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `151subgrupoitem` (
  `idSubGrupoItem` int(11) NOT NULL AUTO_INCREMENT,
  `idGrupo` int(11) NOT NULL,
  `descricao` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idSubGrupoItem`),
  KEY `idGrupo_151_idx` (`idGrupo`),
  CONSTRAINT `idGrupo_151` FOREIGN KEY (`idGrupo`) REFERENCES `150grupoitem` (`idGrupoItem`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=205017 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `180avisoccih`
--

DROP TABLE IF EXISTS `180avisoccih`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `180avisoccih` (
  `idAvisoCcih` int(11) NOT NULL AUTO_INCREMENT,
  `idFuncionario` varchar(255) NOT NULL,
  `informe` mediumtext NOT NULL,
  `ativo` varchar(1) NOT NULL DEFAULT 'S' COMMENT 'S - sim\nN - nao',
  `obs` varchar(90) DEFAULT NULL,
  `dataInicio` date NOT NULL,
  `arquivo` mediumblob,
  `nomeArqivo` varchar(100) DEFAULT NULL,
  `tamanhoArquivo` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idAvisoCcih`),
  KEY `idFuncionario180_idx` (`idFuncionario`),
  CONSTRAINT `idFuncionario180` FOREIGN KEY (`idFuncionario`) REFERENCES `sec_users` (`login`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `181fabricante`
--

DROP TABLE IF EXISTS `181fabricante`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `181fabricante` (
  `idFabricante` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(200) NOT NULL,
  `cnpj` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`idFabricante`),
  UNIQUE KEY `nome_UNIQUE` (`nome`)
) ENGINE=InnoDB AUTO_INCREMENT=241 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `181itemaviso`
--

DROP TABLE IF EXISTS `181itemaviso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `181itemaviso` (
  `idItemaviso` int(11) NOT NULL AUTO_INCREMENT,
  `idAvisoCcih` int(11) NOT NULL,
  `idFabricante` int(11) DEFAULT NULL,
  `idItem` int(11) DEFAULT NULL,
  `nomeComercialItem` varchar(70) DEFAULT NULL,
  `lote` varchar(15) DEFAULT NULL,
  `dataValidade` date DEFAULT NULL,
  `obs` varchar(90) DEFAULT NULL,
  PRIMARY KEY (`idItemaviso`),
  KEY `idFabricante181_idx` (`idFabricante`),
  KEY `idItem181_idx` (`idItem`),
  KEY `idAvisoCcih181_idx` (`idAvisoCcih`),
  CONSTRAINT `idAvisoCcih181` FOREIGN KEY (`idAvisoCcih`) REFERENCES `180avisoccih` (`idAvisoCcih`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `idFabricante181` FOREIGN KEY (`idFabricante`) REFERENCES `181fabricante` (`idFabricante`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `idItem181` FOREIGN KEY (`idItem`) REFERENCES `100item` (`idItem`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `183avisoitemprocesso`
--

DROP TABLE IF EXISTS `183avisoitemprocesso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `183avisoitemprocesso` (
  `idAvisoItemProcesso` int(11) NOT NULL AUTO_INCREMENT,
  `idProcessoComum` varchar(45) DEFAULT NULL,
  `idItem` varchar(45) DEFAULT NULL,
  `idProcessoAta` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idAvisoItemProcesso`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `200chamado`
--

DROP TABLE IF EXISTS `200chamado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `200chamado` (
  `ordemServico` int(11) NOT NULL AUTO_INCREMENT,
  `idChamado` int(11) DEFAULT NULL,
  `rp` varchar(25) NOT NULL,
  `descrEquipamento` varchar(80) DEFAULT NULL,
  `descrProblema` varchar(90) DEFAULT NULL,
  `prioridade` int(11) NOT NULL,
  `solicitante` varchar(45) DEFAULT NULL,
  `setor` int(11) DEFAULT NULL,
  `defeitoEncontrato` mediumtext,
  `dataSolicitacao` date NOT NULL,
  `dataFechamento` date DEFAULT NULL,
  `isFechado` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ordemServico`),
  KEY `prioridade_idx` (`prioridade`),
  KEY `ordemServico` (`ordemServico`),
  KEY `setor_idx` (`setor`),
  KEY `rp_idx` (`rp`),
  CONSTRAINT `idPrioridade_200` FOREIGN KEY (`prioridade`) REFERENCES `902prioridade` (`idPrioridade`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `idSetor_200` FOREIGN KEY (`setor`) REFERENCES `900setor` (`idSetor`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `201equipamentos`
--

DROP TABLE IF EXISTS `201equipamentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `201equipamentos` (
  `idEquip` int(11) NOT NULL AUTO_INCREMENT,
  `rp` varchar(25) NOT NULL,
  `descricao` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`idEquip`),
  KEY `rp_index` (`rp`)
) ENGINE=InnoDB AUTO_INCREMENT=7280 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `202iteracoes`
--

DROP TABLE IF EXISTS `202iteracoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `202iteracoes` (
  `idIteracoes` int(11) NOT NULL AUTO_INCREMENT,
  `ordemServico` int(11) NOT NULL,
  `descIteracao` varchar(90) DEFAULT NULL,
  `executor` int(11) NOT NULL,
  `dataIteracao` date NOT NULL,
  `isCompleto` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'isCompleto Sim(0) Não(1)',
  `dataFinalizacao` date DEFAULT NULL,
  PRIMARY KEY (`idIteracoes`),
  KEY `ordemServico_idx` (`ordemServico`),
  KEY `idUsuario_idx` (`executor`),
  CONSTRAINT `idOrdemServico_202` FOREIGN KEY (`ordemServico`) REFERENCES `200chamado` (`ordemServico`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `203iteracaoitem`
--

DROP TABLE IF EXISTS `203iteracaoitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `203iteracaoitem` (
  `iditeracaoItem` int(11) NOT NULL AUTO_INCREMENT,
  `idInteracao` int(11) NOT NULL,
  `idOrdemServico` int(11) NOT NULL,
  `item` int(11) DEFAULT NULL COMMENT 'Itens (materiais) utilizados para realizar a iteração',
  `quantidade` int(11) DEFAULT NULL,
  PRIMARY KEY (`iditeracaoItem`),
  KEY `idIteracao_idx` (`idOrdemServico`),
  KEY `idInteracao_idx` (`idInteracao`),
  CONSTRAINT `idIteracoes_203` FOREIGN KEY (`idInteracao`) REFERENCES `202iteracoes` (`idIteracoes`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `idOrdemServico_203` FOREIGN KEY (`idOrdemServico`) REFERENCES `202iteracoes` (`ordemServico`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `300paciente`
--

DROP TABLE IF EXISTS `300paciente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `300paciente` (
  `idPaciente` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `dataNascimento` date NOT NULL,
  `sexo` varchar(1) NOT NULL,
  `idCidadeNasc` int(11) DEFAULT NULL,
  `idEstadoNasc` int(11) DEFAULT NULL,
  `nomeMae` varchar(90) DEFAULT NULL,
  `nomePai` varchar(90) DEFAULT NULL,
  `cartaoSUS` varchar(20) DEFAULT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  `celular` varchar(20) DEFAULT NULL,
  `estado` varchar(20) DEFAULT NULL,
  `cidade` varchar(50) DEFAULT NULL,
  `bairro` varchar(50) DEFAULT NULL,
  `idTipoLogradouro` varchar(3) DEFAULT NULL,
  `logradouro` varchar(100) DEFAULT NULL,
  `numero` varchar(10) DEFAULT NULL,
  `cep` varchar(12) DEFAULT NULL,
  `dataCadastro` date DEFAULT NULL,
  `dataUltAtend` date DEFAULT NULL,
  `idProntuario` int(11) DEFAULT NULL,
  `idPaisNasc` int(11) DEFAULT NULL,
  `tipndoc` varchar(45) DEFAULT NULL,
  `endCompl` varchar(45) DEFAULT NULL,
  `dataObito` date DEFAULT NULL,
  `rg` varchar(15) DEFAULT NULL,
  `cpf` varchar(15) DEFAULT NULL,
  `idEstadoCivil` int(11) DEFAULT NULL,
  `idGrauInstrucao` int(11) DEFAULT NULL,
  `idRaca` int(11) DEFAULT NULL,
  `idEtnia` varchar(4) DEFAULT NULL,
  `idDistrito` int(11) DEFAULT NULL,
  `email` varchar(80) DEFAULT NULL,
  `cadastradoPor` varchar(10) DEFAULT NULL,
  `atualizadoPor` varchar(10) DEFAULT NULL,
  `dataAtualizado` date DEFAULT NULL,
  PRIMARY KEY (`idPaciente`),
  KEY `idRaca_idx` (`idRaca`),
  KEY `idCidadeNasc300_idx` (`idCidadeNasc`),
  KEY `idEstadoNasc300_idx` (`idEstadoNasc`),
  KEY `idDistrito300_idx` (`idDistrito`),
  KEY `idEstadoCivil_idx` (`idEstadoCivil`),
  KEY `idGrauInstrucao300_idx` (`idGrauInstrucao`),
  KEY `cartaoSus300_idx` (`cartaoSUS`),
  CONSTRAINT `idCidadeNasc300` FOREIGN KEY (`idCidadeNasc`) REFERENCES `city` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `idDistrito300` FOREIGN KEY (`idDistrito`) REFERENCES `302distrito` (`idDistrito`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `idEstadoCivil300` FOREIGN KEY (`idEstadoCivil`) REFERENCES `506estadocivil` (`idEstadoCivil`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `idEstadoNasc300` FOREIGN KEY (`idEstadoNasc`) REFERENCES `state` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `idGrauInstrucao300` FOREIGN KEY (`idGrauInstrucao`) REFERENCES `507escolaridade` (`idEscolaridade`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `idRaca300` FOREIGN KEY (`idRaca`) REFERENCES `301raca` (`idRaca`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=196980 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `301raca`
--

DROP TABLE IF EXISTS `301raca`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `301raca` (
  `idRaca` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(45) NOT NULL,
  PRIMARY KEY (`idRaca`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `302distrito`
--

DROP TABLE IF EXISTS `302distrito`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `302distrito` (
  `idDistrito` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`idDistrito`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `303parentesco`
--

DROP TABLE IF EXISTS `303parentesco`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `303parentesco` (
  `idParentesco` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(45) NOT NULL,
  PRIMARY KEY (`idParentesco`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `304etnia`
--

DROP TABLE IF EXISTS `304etnia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `304etnia` (
  `idEtnia` varchar(4) NOT NULL,
  `descricao` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`idEtnia`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `330atendimento`
--

DROP TABLE IF EXISTS `330atendimento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `330atendimento` (
  `idAtendimento` int(11) NOT NULL AUTO_INCREMENT,
  `dataAtendimento` date DEFAULT NULL,
  `horaAtendimento` datetime DEFAULT CURRENT_TIMESTAMP,
  `setorAtend` int(11) DEFAULT NULL,
  `idAtendente` varchar(100) DEFAULT NULL,
  `idPaciente` int(11) NOT NULL,
  `logradouro` varchar(100) DEFAULT NULL,
  `numero` varchar(10) DEFAULT NULL,
  `cep` varchar(15) DEFAULT NULL,
  `bairro` varchar(40) DEFAULT NULL,
  `cidade` varchar(45) DEFAULT NULL,
  `estado` varchar(45) DEFAULT NULL,
  `reponsavel` varchar(45) DEFAULT NULL,
  `idParentesco` int(11) DEFAULT NULL,
  `telefone` varchar(45) DEFAULT NULL,
  `celular` varchar(45) DEFAULT NULL,
  `mausTratos` varchar(1) DEFAULT NULL,
  `acidTrabalho` varchar(1) DEFAULT NULL,
  `acidTransito` varchar(1) DEFAULT NULL,
  `pa` varchar(15) DEFAULT NULL,
  `fc` varchar(15) DEFAULT NULL,
  `glicose` varchar(15) DEFAULT NULL,
  `temp` varchar(15) DEFAULT NULL,
  `peso` varchar(15) DEFAULT NULL,
  `idQueixa` int(11) DEFAULT NULL,
  `idEscalaDor` int(11) DEFAULT NULL,
  `glasgowOcular` int(11) DEFAULT NULL,
  `glasgowVerbal` int(11) DEFAULT NULL,
  `glasgowMotora` int(11) DEFAULT NULL,
  `glasgowResultado` int(11) DEFAULT NULL,
  `classRisco` int(11) DEFAULT NULL,
  `idEncaminhamento` int(11) DEFAULT NULL,
  `dataPrimeirosSintomas` date DEFAULT NULL,
  `dadosClinicosEnfermagem` text,
  `dadosClinicosMedico` text,
  `diagnosticoPrincipal` text,
  `cidPrincipal` varchar(45) DEFAULT NULL,
  `diagnosticoSecundario` text,
  `cidSecundario` varchar(45) DEFAULT NULL,
  `dataSaida` date DEFAULT NULL,
  `horaSaida` datetime DEFAULT NULL,
  `idAlta` int(11) DEFAULT NULL,
  `descrObito` varchar(90) DEFAULT NULL,
  `idTransferencia` int(11) DEFAULT NULL,
  `status` varchar(1) DEFAULT 'A',
  `baixa` varchar(1) DEFAULT 'N',
  `dataInternacao` date DEFAULT NULL,
  `idDistrito` int(11) DEFAULT NULL,
  `zona` varchar(10) DEFAULT NULL,
  `alta_dataInternacao` date DEFAULT NULL,
  `alta_motivaInternacao` text,
  `alta_princAchadosHist` text,
  `alta_evolucao` text,
  `alta_tratamento` text,
  `alta_diagnostico` text,
  `alta_cidPrincipal` varchar(4) DEFAULT NULL,
  `alta_cidSecundario` varchar(4) DEFAULT NULL,
  `alta_condicaoAlta` text,
  `alta_orientacao` text,
  `alta_nomePreenchimento` varchar(80) DEFAULT NULL,
  `alta_data` date DEFAULT NULL,
  `alta_leito` varchar(5) DEFAULT NULL,
  `alta_medico` varchar(80) DEFAULT NULL,
  `alta_registro` varchar(10) DEFAULT NULL,
  `doc_aih` blob,
  `nome_doc_aih` varchar(45) DEFAULT NULL,
  `idAtendBaixa` varchar(20) DEFAULT NULL,
  `idAtendStatus` varchar(20) DEFAULT NULL,
  `tipoFau` varchar(1) NOT NULL DEFAULT 'E' COMMENT 'E - Eletronica\nM - Manual',
  PRIMARY KEY (`idAtendimento`),
  UNIQUE KEY `idAtendBaixa_UNIQUE` (`idAtendBaixa`),
  KEY `idPaciente330_idx` (`idPaciente`),
  KEY `idEscalaDor330_idx` (`idEscalaDor`),
  KEY `glasgowOcular330_idx` (`glasgowOcular`),
  KEY `glasgowVerbal330_idx` (`glasgowVerbal`),
  KEY `glasgowMotora330_idx` (`glasgowMotora`),
  KEY `classRisco330_idx` (`classRisco`),
  KEY `idQueixa330_idx` (`idQueixa`),
  KEY `idEncaminhamento330_idx` (`idEncaminhamento`),
  KEY `setorAtendimento330_idx` (`setorAtend`),
  KEY `idParentesco330_idx` (`idParentesco`),
  KEY `idAtendente330_idx` (`idAtendente`),
  KEY `idAtendBaixa_330_idx` (`idAtendBaixa`),
  KEY `idAtendStatus_330_idx` (`idAtendStatus`),
  KEY `tipoFau_330` (`tipoFau`),
  CONSTRAINT `classRisco330` FOREIGN KEY (`classRisco`) REFERENCES `908classrisco` (`idClass`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `glasgowMotora330` FOREIGN KEY (`glasgowMotora`) REFERENCES `907escalaglasgow` (`idGlasgow`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `glasgowOcular330` FOREIGN KEY (`glasgowOcular`) REFERENCES `907escalaglasgow` (`idGlasgow`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `glasgowVerbal330` FOREIGN KEY (`glasgowVerbal`) REFERENCES `907escalaglasgow` (`idGlasgow`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `idAtendente330` FOREIGN KEY (`idAtendente`) REFERENCES `sec_users` (`login`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `idEncaminhamento330` FOREIGN KEY (`idEncaminhamento`) REFERENCES `910encaminhamento` (`idEncamin`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `idEscalaDor330` FOREIGN KEY (`idEscalaDor`) REFERENCES `909classdor` (`idClassDor`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `idPaciente330` FOREIGN KEY (`idPaciente`) REFERENCES `300paciente` (`idPaciente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `idParentesco330` FOREIGN KEY (`idParentesco`) REFERENCES `303parentesco` (`idParentesco`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `idQueixa330` FOREIGN KEY (`idQueixa`) REFERENCES `911queixaprincipal` (`idQueixaPrinc`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `setorAtendimento330` FOREIGN KEY (`setorAtend`) REFERENCES `900setor` (`idSetor`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=65155 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `331atendmultiprofissional`
--

DROP TABLE IF EXISTS `331atendmultiprofissional`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `331atendmultiprofissional` (
  `idAtendMultiprofissional` int(11) NOT NULL AUTO_INCREMENT,
  `idAtendimento` int(11) NOT NULL,
  `idProfissional` int(11) DEFAULT NULL,
  `idProcedimento` int(11) DEFAULT NULL,
  `idPaciente` int(11) DEFAULT NULL,
  `descricao` text,
  PRIMARY KEY (`idAtendMultiprofissional`),
  KEY `idProfissional331_idx` (`idProfissional`),
  KEY `idProcedimento331_idx` (`idProcedimento`),
  KEY `idPaciente331_idx` (`idPaciente`),
  KEY `idAtendimento331_idx` (`idAtendimento`),
  CONSTRAINT `idAtendimento331` FOREIGN KEY (`idAtendimento`) REFERENCES `330atendimento` (`idAtendimento`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `idPaciente331` FOREIGN KEY (`idPaciente`) REFERENCES `300paciente` (`idPaciente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `idProfissional331` FOREIGN KEY (`idProfissional`) REFERENCES `500funcionario` (`idFuncionario`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `332prescricao`
--

DROP TABLE IF EXISTS `332prescricao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `332prescricao` (
  `idPrescricao` int(11) NOT NULL AUTO_INCREMENT,
  `prescMedica` text NOT NULL,
  `prescEnferm` text NOT NULL,
  `hora` datetime NOT NULL,
  `idAtendimento` int(11) NOT NULL,
  `peso` varchar(10) DEFAULT NULL,
  `arquivoPdf` mediumblob,
  `nomeArquivo` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`idPrescricao`),
  KEY `idAtendimento332_idx` (`idAtendimento`),
  CONSTRAINT `idAtendimento332` FOREIGN KEY (`idAtendimento`) REFERENCES `330atendimento` (`idAtendimento`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `334tipoprescricao`
--

DROP TABLE IF EXISTS `334tipoprescricao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `334tipoprescricao` (
  `idTipoPrescricao` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(50) NOT NULL,
  PRIMARY KEY (`idTipoPrescricao`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `335itemprescricao`
--

DROP TABLE IF EXISTS `335itemprescricao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `335itemprescricao` (
  `idItemPrescricao` int(11) NOT NULL AUTO_INCREMENT,
  `idtipoPrescricao` int(11) NOT NULL,
  `modelo` varchar(45) DEFAULT NULL,
  `prescrcaodet` varchar(300) NOT NULL,
  `horario` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idItemPrescricao`),
  KEY `idtipoPrescricao335_idx` (`idtipoPrescricao`),
  CONSTRAINT `idtipoPrescricao335` FOREIGN KEY (`idtipoPrescricao`) REFERENCES `334tipoprescricao` (`idTipoPrescricao`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `336aih`
--

DROP TABLE IF EXISTS `336aih`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `336aih` (
  `idAih` int(11) NOT NULL AUTO_INCREMENT,
  `idTipoAih` int(11) DEFAULT NULL,
  `idPaciente` int(11) DEFAULT NULL,
  `idAtendimento` int(11) DEFAULT NULL,
  `princSinais` text,
  `condJustificam` text,
  `princProvas` text,
  `diagInicial` text,
  `idCidPrincipal` int(11) DEFAULT NULL,
  `idCidSecundario` int(11) DEFAULT NULL,
  `idCidCausaAssoc` int(11) DEFAULT NULL,
  `idCodProcedimento` int(11) DEFAULT NULL,
  `descProcedimento` varchar(100) DEFAULT NULL,
  `docAih` blob,
  `nomeAih` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`idAih`),
  KEY `idTipoAih_idx` (`idTipoAih`),
  KEY `idPaciente_336_idx` (`idPaciente`),
  KEY `idAtendimento_336_idx` (`idAtendimento`),
  CONSTRAINT `idAtendimento_336` FOREIGN KEY (`idAtendimento`) REFERENCES `330atendimento` (`idAtendimento`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `idPaciente_336` FOREIGN KEY (`idPaciente`) REFERENCES `300paciente` (`idPaciente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `idTipoAih_336` FOREIGN KEY (`idTipoAih`) REFERENCES `342tipoaih` (`idTipoAih`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `340templateprescricao`
--

DROP TABLE IF EXISTS `340templateprescricao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `340templateprescricao` (
  `idTemplatePrescricao` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(45) NOT NULL,
  `descricao` text NOT NULL,
  `idTipoTemplate` int(11) DEFAULT NULL,
  PRIMARY KEY (`idTemplatePrescricao`),
  KEY `idTipoTemplate_340_idx` (`idTipoTemplate`),
  CONSTRAINT `idTipoTemplate_340` FOREIGN KEY (`idTipoTemplate`) REFERENCES `341tipotemplate` (`idTipoTemplate`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `341tipotemplate`
--

DROP TABLE IF EXISTS `341tipotemplate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `341tipotemplate` (
  `idTipoTemplate` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(45) NOT NULL,
  PRIMARY KEY (`idTipoTemplate`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `342tipoaih`
--

DROP TABLE IF EXISTS `342tipoaih`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `342tipoaih` (
  `idTipoAih` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idTipoAih`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `350bpa`
--

DROP TABLE IF EXISTS `350bpa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `350bpa` (
  `idBpa` int(11) NOT NULL AUTO_INCREMENT,
  `idFuncionario` int(11) NOT NULL,
  `idPaciente` int(11) NOT NULL,
  `coProcedimento` varchar(10) NOT NULL,
  `dataAtendimento` date DEFAULT NULL,
  `coCid` varchar(4) DEFAULT NULL,
  `qtd` varchar(2) DEFAULT NULL,
  `idUser` varchar(255) DEFAULT NULL,
  `idSetor` int(11) DEFAULT NULL,
  `idFuncionarioFatura` int(11) DEFAULT NULL,
  `incluidoBpa` varchar(1) NOT NULL DEFAULT 'N',
  `competencia` varchar(6) NOT NULL,
  `idCodServico` varchar(3) DEFAULT NULL,
  `idServClassificacao` varchar(3) DEFAULT NULL,
  `idCaraterAtendimento` int(11) DEFAULT NULL,
  `dataInclusao` datetime DEFAULT NULL,
  `idAtendimento` int(11) DEFAULT NULL,
  `idFaa` int(11) DEFAULT NULL,
  PRIMARY KEY (`idBpa`),
  KEY `idFuncionario350_idx` (`idFuncionario`),
  KEY `idPaciente350_idx` (`idPaciente`),
  KEY `idUser_350_idx` (`idUser`),
  KEY `idSetor_350_idx` (`idSetor`),
  KEY `coProcedimento_350_idx` (`coProcedimento`),
  KEY `idCaraterAtendimento350_idx` (`idCaraterAtendimento`),
  KEY `competencia_350` (`competencia`),
  KEY `idAtendimento_350` (`idAtendimento`),
  KEY `idFaa350_idx` (`idFaa`),
  CONSTRAINT `idCaraterAtendimento350` FOREIGN KEY (`idCaraterAtendimento`) REFERENCES `354carateratendimento` (`idCaraterAtendimento`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `idFaa350` FOREIGN KEY (`idFaa`) REFERENCES `620faa` (`idFaa`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `idFuncionario350` FOREIGN KEY (`idFuncionario`) REFERENCES `500funcionario` (`idFuncionario`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `idPaciente350` FOREIGN KEY (`idPaciente`) REFERENCES `300paciente` (`idPaciente`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=350372 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `352tipo_logradouro`
--

DROP TABLE IF EXISTS `352tipo_logradouro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `352tipo_logradouro` (
  `idTipoLogradouro` varchar(3) NOT NULL,
  `sigla` varchar(4) DEFAULT NULL,
  `descricao` varchar(45) NOT NULL,
  PRIMARY KEY (`idTipoLogradouro`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `353competencia`
--

DROP TABLE IF EXISTS `353competencia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `353competencia` (
  `idCompetencia` int(11) NOT NULL AUTO_INCREMENT,
  `dataInicio` date NOT NULL,
  `dataFim` date NOT NULL,
  `competencia` varchar(6) NOT NULL,
  PRIMARY KEY (`idCompetencia`),
  UNIQUE KEY `competencia_idx` (`competencia`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `354carateratendimento`
--

DROP TABLE IF EXISTS `354carateratendimento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `354carateratendimento` (
  `idCaraterAtendimento` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(45) NOT NULL,
  PRIMARY KEY (`idCaraterAtendimento`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `355procedimentoqtd`
--

DROP TABLE IF EXISTS `355procedimentoqtd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `355procedimentoqtd` (
  `idProcQtd` int(11) NOT NULL AUTO_INCREMENT,
  `coProcedimento` varchar(10) NOT NULL,
  `qtd` int(11) NOT NULL,
  `competencia` varchar(6) NOT NULL,
  PRIMARY KEY (`idProcQtd`),
  UNIQUE KEY `procedimento_idx` (`coProcedimento`,`competencia`),
  KEY `competencia_idx` (`competencia`)
) ENGINE=InnoDB AUTO_INCREMENT=114 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `400processos`
--

DROP TABLE IF EXISTS `400processos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `400processos` (
  `idProcesso` int(11) NOT NULL AUTO_INCREMENT,
  `ciOrigem` varchar(45) NOT NULL,
  `idAta` int(11) DEFAULT NULL,
  `dataCriacao` date DEFAULT NULL,
  `dataArquivamento` date DEFAULT NULL,
  `descricao` mediumtext NOT NULL,
  `idEspecie` int(11) DEFAULT NULL,
  `idSituacao` int(11) DEFAULT NULL,
  `idFornecedor` int(11) DEFAULT NULL,
  `numProcesso` varchar(45) NOT NULL,
  `dataChegada` date DEFAULT NULL COMMENT 'chegada do material processo comum',
  PRIMARY KEY (`idProcesso`),
  KEY `idEspecie_400_idx` (`idEspecie`),
  KEY `idSituacao_400_idx` (`idSituacao`),
  CONSTRAINT `idEspecie_400` FOREIGN KEY (`idEspecie`) REFERENCES `452tipoespecie` (`idTipoEspecie`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `idSituacao_400` FOREIGN KEY (`idSituacao`) REFERENCES `451sitprocesso` (`idSitProcesso`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=728 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `401fornecedor`
--

DROP TABLE IF EXISTS `401fornecedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `401fornecedor` (
  `idFornecedor` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(100) DEFAULT NULL,
  `cnpj` varchar(45) DEFAULT NULL,
  `telefone1` varchar(45) DEFAULT NULL,
  `telefone2` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `inscrEstadual` varchar(15) DEFAULT NULL,
  `inscrMunicipal` varchar(15) DEFAULT NULL,
  `logradouro` varchar(60) DEFAULT NULL,
  `cidade` varchar(45) DEFAULT NULL,
  `estado` varchar(15) DEFAULT NULL,
  `cep` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`idFornecedor`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `403historicoproc`
--

DROP TABLE IF EXISTS `403historicoproc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `403historicoproc` (
  `idHistoricoProc` int(11) NOT NULL AUTO_INCREMENT,
  `idProcesso` int(11) NOT NULL,
  `idUser` int(11) NOT NULL,
  `idSetor` int(11) NOT NULL,
  `idhistorio` int(11) NOT NULL,
  `data` date NOT NULL,
  `obs` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`idHistoricoProc`),
  KEY `idProcesso_400_idx` (`idProcesso`),
  KEY `idhistorio_403_idx` (`idhistorio`),
  CONSTRAINT `idProcesso_403` FOREIGN KEY (`idProcesso`) REFERENCES `400processos` (`idProcesso`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `idhistorio_403` FOREIGN KEY (`idhistorio`) REFERENCES `458tipohistorico` (`idTipoHistorico`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1236 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `404ata`
--

DROP TABLE IF EXISTS `404ata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `404ata` (
  `idAta` int(11) NOT NULL AUTO_INCREMENT,
  `numAta` varchar(20) NOT NULL,
  `vigenciaIni` date DEFAULT NULL,
  `vigenciaFim` date DEFAULT NULL,
  `status` int(11) NOT NULL,
  `idFornecedor` int(11) DEFAULT NULL,
  `descricao` mediumtext,
  `descricaoResumo` varchar(45) NOT NULL,
  PRIMARY KEY (`idAta`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `451sitprocesso`
--

DROP TABLE IF EXISTS `451sitprocesso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `451sitprocesso` (
  `idSitProcesso` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(45) NOT NULL,
  `flag` int(11) NOT NULL,
  PRIMARY KEY (`idSitProcesso`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `452tipoespecie`
--

DROP TABLE IF EXISTS `452tipoespecie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `452tipoespecie` (
  `idTipoEspecie` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(45) NOT NULL,
  PRIMARY KEY (`idTipoEspecie`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `454itensprocesso`
--

DROP TABLE IF EXISTS `454itensprocesso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `454itensprocesso` (
  `idItensProcesso` int(11) NOT NULL AUTO_INCREMENT,
  `idProcesso` int(11) NOT NULL,
  `idItem` int(11) NOT NULL,
  `qtdItem` int(11) DEFAULT NULL,
  `valorUnitario` float DEFAULT NULL,
  `qtdAtendida` int(11) DEFAULT NULL,
  PRIMARY KEY (`idItensProcesso`),
  KEY `idProcesso_idx` (`idProcesso`),
  KEY `fk_idItem454_idx` (`idItem`),
  CONSTRAINT `fk_idItem454` FOREIGN KEY (`idItem`) REFERENCES `100item` (`idItem`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `idProcesso` FOREIGN KEY (`idProcesso`) REFERENCES `400processos` (`idProcesso`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1176 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `455itemata`
--

DROP TABLE IF EXISTS `455itemata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `455itemata` (
  `idItemAta` int(11) NOT NULL AUTO_INCREMENT,
  `idAta` int(11) NOT NULL,
  `idItem` int(11) NOT NULL,
  `qtdContemplada` int(11) NOT NULL,
  `qtdRestante` int(11) DEFAULT NULL,
  PRIMARY KEY (`idItemAta`),
  KEY `fk_idAta455_idx` (`idAta`),
  KEY `fk_idItem455_idx` (`idItem`),
  CONSTRAINT `fk_idAta455` FOREIGN KEY (`idAta`) REFERENCES `404ata` (`idAta`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_idItem455` FOREIGN KEY (`idItem`) REFERENCES `100item` (`idItem`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=270 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `456processoata`
--

DROP TABLE IF EXISTS `456processoata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `456processoata` (
  `idProcessoAta` int(11) NOT NULL AUTO_INCREMENT,
  `idProcesso` int(11) NOT NULL,
  `data` date NOT NULL,
  `ciOrigem` varchar(45) NOT NULL,
  `status` int(11) NOT NULL,
  `descricao` varchar(60) DEFAULT NULL,
  `dataChegada` date DEFAULT NULL COMMENT 'chegada do material por ata',
  `dataArquivamento` date DEFAULT NULL,
  PRIMARY KEY (`idProcessoAta`),
  KEY `fk_idProcesso456_idx` (`idProcesso`),
  CONSTRAINT `fk_idProcesso456` FOREIGN KEY (`idProcesso`) REFERENCES `400processos` (`idProcesso`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `457itensprocessoata`
--

DROP TABLE IF EXISTS `457itensprocessoata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `457itensprocessoata` (
  `idItensProcessoAta` int(11) NOT NULL AUTO_INCREMENT,
  `idProcessoAta` int(11) NOT NULL,
  `idItens` int(11) DEFAULT NULL,
  `quantidade` int(11) NOT NULL,
  `quantidadeAtendida` int(11) DEFAULT NULL,
  `valorUnitario` float DEFAULT NULL,
  `qtdAtendidaAnterior` int(11) DEFAULT NULL,
  PRIMARY KEY (`idItensProcessoAta`),
  KEY `fk_idProcessoAta457_idx` (`idProcessoAta`),
  KEY `fk_idItem457_idx` (`idItens`),
  CONSTRAINT `fk_idItem457` FOREIGN KEY (`idItens`) REFERENCES `455itemata` (`idItem`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_idProcessoAta457` FOREIGN KEY (`idProcessoAta`) REFERENCES `456processoata` (`idProcessoAta`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=126 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `458tipohistorico`
--

DROP TABLE IF EXISTS `458tipohistorico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `458tipohistorico` (
  `idTipoHistorico` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(45) NOT NULL,
  PRIMARY KEY (`idTipoHistorico`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `459fornecerdorata`
--

DROP TABLE IF EXISTS `459fornecerdorata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `459fornecerdorata` (
  `idFornecerdorAta` int(11) NOT NULL AUTO_INCREMENT,
  `idAta` int(11) NOT NULL,
  `idFornecedor` int(11) NOT NULL,
  PRIMARY KEY (`idFornecerdorAta`),
  KEY `idAta459_idx` (`idAta`),
  KEY `idFornecedor_idx` (`idFornecedor`),
  CONSTRAINT `idAta459` FOREIGN KEY (`idAta`) REFERENCES `404ata` (`idAta`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `idFornecedor` FOREIGN KEY (`idFornecedor`) REFERENCES `401fornecedor` (`idFornecedor`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `460notafiscal`
--

DROP TABLE IF EXISTS `460notafiscal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `460notafiscal` (
  `idNotaFiscal` int(11) NOT NULL AUTO_INCREMENT,
  `idProcesso` int(11) NOT NULL,
  `idProcessoAta` int(11) DEFAULT NULL,
  `idAta` int(11) DEFAULT NULL,
  `numero` varchar(45) DEFAULT NULL,
  `dataEmissao` date DEFAULT NULL,
  `dataEntrega` date DEFAULT NULL,
  `idFornecedor` int(11) NOT NULL,
  PRIMARY KEY (`idNotaFiscal`),
  KEY `idFornecedor460_idx` (`idFornecedor`),
  CONSTRAINT `idFornecedor460` FOREIGN KEY (`idFornecedor`) REFERENCES `401fornecedor` (`idFornecedor`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=405 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `461notafiscalitem`
--

DROP TABLE IF EXISTS `461notafiscalitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `461notafiscalitem` (
  `idNotaFiscalItem` int(11) NOT NULL AUTO_INCREMENT,
  `idNotaFiscal` int(11) NOT NULL,
  `idItem` int(11) DEFAULT NULL,
  `lote` varchar(45) DEFAULT NULL,
  `dataValidade` date DEFAULT NULL,
  `quantidade` int(11) DEFAULT NULL,
  `valorUnitario` double DEFAULT NULL,
  `parcial` varchar(1) NOT NULL,
  PRIMARY KEY (`idNotaFiscalItem`)
) ENGINE=InnoDB AUTO_INCREMENT=729 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `462cnae`
--

DROP TABLE IF EXISTS `462cnae`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `462cnae` (
  `idCnae` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` varchar(45) NOT NULL,
  `descricao` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`idCnae`)
) ENGINE=InnoDB AUTO_INCREMENT=1303 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `463fornecedorcnae`
--

DROP TABLE IF EXISTS `463fornecedorcnae`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `463fornecedorcnae` (
  `idFornecedorCnae` int(11) NOT NULL AUTO_INCREMENT,
  `idFornecedor` int(11) NOT NULL,
  `idCnae` int(11) NOT NULL,
  PRIMARY KEY (`idFornecedorCnae`),
  KEY `idFornecedor463_idx` (`idFornecedor`),
  KEY `idCnae_idx` (`idCnae`),
  CONSTRAINT `idCnae` FOREIGN KEY (`idCnae`) REFERENCES `462cnae` (`idCnae`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `idFornecedor463` FOREIGN KEY (`idFornecedor`) REFERENCES `401fornecedor` (`idFornecedor`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `500funcionario`
--

DROP TABLE IF EXISTS `500funcionario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `500funcionario` (
  `idFuncionario` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(90) NOT NULL,
  `sexo` varchar(1) DEFAULT NULL,
  `nomeMae` varchar(90) DEFAULT NULL,
  `estadoNasc` int(11) DEFAULT NULL,
  `municipioNasc` int(11) DEFAULT NULL,
  `dataNascimento` date DEFAULT NULL,
  `matricula` varchar(12) DEFAULT NULL,
  `estadoCivil` int(11) DEFAULT NULL,
  `escolaridade` int(11) DEFAULT NULL,
  `telefoneFixo` varchar(10) DEFAULT NULL,
  `rua` varchar(90) DEFAULT NULL,
  `numero` varchar(7) DEFAULT NULL,
  `perimetro` varchar(45) DEFAULT NULL,
  `bairro` varchar(45) DEFAULT NULL,
  `cidade` varchar(45) DEFAULT NULL,
  `cep` varchar(15) DEFAULT NULL,
  `rg` varchar(15) DEFAULT NULL,
  `orgaoExpedidor` varchar(25) DEFAULT NULL,
  `ufRG` int(11) DEFAULT NULL,
  `dataExpedicaoRG` date DEFAULT NULL,
  `tituloEleitor` varchar(45) DEFAULT NULL,
  `zona` varchar(45) DEFAULT NULL,
  `secao` varchar(45) DEFAULT NULL,
  `cpf` varchar(15) DEFAULT NULL,
  `pis` varchar(12) DEFAULT NULL,
  `ctps` varchar(45) DEFAULT NULL,
  `serieCtps` varchar(45) DEFAULT NULL,
  `dataEmissaoCtps` date DEFAULT NULL,
  `celular1` varchar(45) DEFAULT NULL,
  `celular2` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `pendente` varchar(1) DEFAULT NULL,
  `obs` varchar(45) DEFAULT NULL,
  `cns` varchar(15) DEFAULT NULL,
  `ativo` varchar(1) NOT NULL DEFAULT 'S',
  `dataCadastro` datetime DEFAULT NULL,
  `dataAtualizacao` datetime DEFAULT NULL,
  `cadastradoPor` varchar(15) DEFAULT NULL,
  `atualizadoPor` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`idFuncionario`),
  KEY `estadoCivil500_idx` (`estadoCivil`),
  KEY `escolaridade500_idx` (`escolaridade`),
  CONSTRAINT `escolaridade500` FOREIGN KEY (`escolaridade`) REFERENCES `507escolaridade` (`idEscolaridade`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `estadoCivil500` FOREIGN KEY (`estadoCivil`) REFERENCES `506estadocivil` (`idEstadoCivil`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=499 DEFAULT CHARSET=utf8 COMMENT='						';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `501historicosetor`
--

DROP TABLE IF EXISTS `501historicosetor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `501historicosetor` (
  `idHistoricoSetor` int(11) NOT NULL AUTO_INCREMENT,
  `idVinculoProfissional` int(11) NOT NULL,
  `idSetor` int(11) DEFAULT NULL,
  `idTurno` int(11) DEFAULT NULL,
  `dataInicial` date NOT NULL,
  `dataFinal` date DEFAULT NULL,
  `ativo` varchar(1) NOT NULL DEFAULT 'S',
  `obs` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`idHistoricoSetor`),
  KEY `idSetor501_idx` (`idSetor`),
  KEY `idTurno501_idx` (`idTurno`),
  KEY `idVinculo_501_idx` (`idVinculoProfissional`),
  CONSTRAINT `idSetor501` FOREIGN KEY (`idSetor`) REFERENCES `900setor` (`idSetor`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `idTurno501` FOREIGN KEY (`idTurno`) REFERENCES `511turno` (`idTurno`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `idVinculo_501` FOREIGN KEY (`idVinculoProfissional`) REFERENCES `540vinculoprofissional` (`idVinculoProfissional`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=676 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `502historicoperiodo`
--

DROP TABLE IF EXISTS `502historicoperiodo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `502historicoperiodo` (
  `idHistoricoPeriodo` int(11) NOT NULL AUTO_INCREMENT,
  `idFuncionario` int(11) NOT NULL,
  `dataAdmissao` date DEFAULT NULL,
  `dataDesligamento` date DEFAULT NULL,
  PRIMARY KEY (`idHistoricoPeriodo`),
  KEY `idFuncionario502_idx` (`idFuncionario`),
  CONSTRAINT `idFuncionario502` FOREIGN KEY (`idFuncionario`) REFERENCES `500funcionario` (`idFuncionario`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `503atestado`
--

DROP TABLE IF EXISTS `503atestado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `503atestado` (
  `idAtestado` int(11) NOT NULL AUTO_INCREMENT,
  `idFuncionario` int(11) NOT NULL,
  `idTurno` int(11) DEFAULT NULL,
  `idTipo` int(11) NOT NULL,
  `dataEntrega` date DEFAULT NULL,
  `recebido` int(11) DEFAULT NULL,
  `inicioAfastamento` date DEFAULT NULL,
  `fimAfastamento` date DEFAULT NULL,
  `fimAfastamentoH` datetime DEFAULT NULL,
  `inicioAfastamentoH` datetime DEFAULT NULL,
  `emitente` varchar(45) DEFAULT NULL,
  `nomeMedico` varchar(45) DEFAULT NULL,
  `especialidade` varchar(45) DEFAULT NULL,
  `crm` varchar(45) DEFAULT NULL,
  `obs` varchar(80) DEFAULT NULL,
  `digitadoPor` int(11) DEFAULT NULL,
  `vinculado` varchar(1) DEFAULT 'N',
  PRIMARY KEY (`idAtestado`),
  KEY `idFuncionario503_idx` (`idFuncionario`),
  KEY `idTipo503_idx` (`idTipo`),
  CONSTRAINT `idFuncionario503` FOREIGN KEY (`idFuncionario`) REFERENCES `500funcionario` (`idFuncionario`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `idTipo503` FOREIGN KEY (`idTipo`) REFERENCES `516tipoatestado` (`idTipoAtestado`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=8451 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `504laudo`
--

DROP TABLE IF EXISTS `504laudo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `504laudo` (
  `idLaudo` int(11) NOT NULL AUTO_INCREMENT,
  `numero` varchar(45) DEFAULT NULL,
  `tipoPericia` int(11) DEFAULT NULL,
  `dataIncapacidade` date DEFAULT NULL,
  `dataPrazo` date DEFAULT NULL,
  `dataAgendamento` date DEFAULT NULL,
  `conclusao` varchar(90) DEFAULT NULL,
  `obs` varchar(90) DEFAULT NULL,
  `dataEntrega` date DEFAULT NULL,
  `idFuncionario` int(11) NOT NULL,
  `dataPericia` date DEFAULT NULL,
  PRIMARY KEY (`idLaudo`),
  KEY `tipoPericia504_idx` (`tipoPericia`),
  KEY `idFuncionario504_idx` (`idFuncionario`),
  CONSTRAINT `idFuncionario504` FOREIGN KEY (`idFuncionario`) REFERENCES `500funcionario` (`idFuncionario`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `tipoPericia504` FOREIGN KEY (`tipoPericia`) REFERENCES `513tipopericia` (`idTipoPericia`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=744 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `505cargo`
--

DROP TABLE IF EXISTS `505cargo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `505cargo` (
  `idCargo` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(45) NOT NULL,
  `idEscolaridade` int(11) NOT NULL,
  `flagGeraProcedimento` varchar(1) DEFAULT 'N',
  PRIMARY KEY (`idCargo`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `506estadocivil`
--

DROP TABLE IF EXISTS `506estadocivil`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `506estadocivil` (
  `idEstadoCivil` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(45) NOT NULL,
  PRIMARY KEY (`idEstadoCivil`),
  UNIQUE KEY `descricao_UNIQUE` (`descricao`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `507escolaridade`
--

DROP TABLE IF EXISTS `507escolaridade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `507escolaridade` (
  `idEscolaridade` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(45) NOT NULL,
  PRIMARY KEY (`idEscolaridade`),
  UNIQUE KEY `descricao_UNIQUE` (`descricao`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `508cidatestado`
--

DROP TABLE IF EXISTS `508cidatestado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `508cidatestado` (
  `idCidAtestado` int(11) NOT NULL AUTO_INCREMENT,
  `idAtestado` int(11) NOT NULL,
  `idCid` varchar(6) NOT NULL,
  PRIMARY KEY (`idCidAtestado`),
  KEY `idAtestado508_idx` (`idAtestado`),
  KEY `idCid508_idx` (`idCid`),
  CONSTRAINT `idAtestado508` FOREIGN KEY (`idAtestado`) REFERENCES `503atestado` (`idAtestado`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `idCid508` FOREIGN KEY (`idCid`) REFERENCES `hras505_cid` (`hras505_CID_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5028 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `509historicogeral`
--

DROP TABLE IF EXISTS `509historicogeral`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `509historicogeral` (
  `idHistorico` int(11) NOT NULL AUTO_INCREMENT,
  `idProfissional` int(11) NOT NULL,
  `descricao` varchar(350) NOT NULL,
  `acao` varchar(45) NOT NULL,
  `idUsuario` varchar(45) NOT NULL,
  `data` datetime NOT NULL,
  PRIMARY KEY (`idHistorico`),
  KEY `idFuncionario509_fk_idx` (`idProfissional`)
) ENGINE=InnoDB AUTO_INCREMENT=3922 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `510tipovinculo`
--

DROP TABLE IF EXISTS `510tipovinculo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `510tipovinculo` (
  `idTipoVinculo` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(45) NOT NULL,
  `ativo` varchar(1) NOT NULL DEFAULT 'S',
  PRIMARY KEY (`idTipoVinculo`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `511turno`
--

DROP TABLE IF EXISTS `511turno`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `511turno` (
  `idTurno` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(45) NOT NULL,
  PRIMARY KEY (`idTurno`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `512tipofuncao`
--

DROP TABLE IF EXISTS `512tipofuncao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `512tipofuncao` (
  `idFuncao` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(50) NOT NULL,
  `ativo` varchar(1) NOT NULL,
  PRIMARY KEY (`idFuncao`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `513tipopericia`
--

DROP TABLE IF EXISTS `513tipopericia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `513tipopericia` (
  `idTipoPericia` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(45) NOT NULL,
  PRIMARY KEY (`idTipoPericia`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `514cidlaudo`
--

DROP TABLE IF EXISTS `514cidlaudo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `514cidlaudo` (
  `idCidLaudo` int(11) NOT NULL AUTO_INCREMENT,
  `idLaudo` int(11) NOT NULL,
  `idCid` varchar(6) NOT NULL,
  PRIMARY KEY (`idCidLaudo`),
  KEY `idLaudo514_idx` (`idLaudo`),
  KEY `idCid514_idx` (`idCid`),
  CONSTRAINT `idCid514` FOREIGN KEY (`idCid`) REFERENCES `hras505_cid` (`hras505_CID_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `idLaudo514` FOREIGN KEY (`idLaudo`) REFERENCES `504laudo` (`idLaudo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `515bairro`
--

DROP TABLE IF EXISTS `515bairro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `515bairro` (
  `idBairros` int(11) NOT NULL AUTO_INCREMENT,
  `id_cidade` int(11) NOT NULL,
  `bairro` varchar(45) NOT NULL,
  PRIMARY KEY (`idBairros`),
  KEY `id_cidade515_idx` (`id_cidade`),
  CONSTRAINT `id_cidade515` FOREIGN KEY (`id_cidade`) REFERENCES `city` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `516tipoatestado`
--

DROP TABLE IF EXISTS `516tipoatestado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `516tipoatestado` (
  `idTipoAtestado` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(45) NOT NULL,
  PRIMARY KEY (`idTipoAtestado`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `517funcaovinculo`
--

DROP TABLE IF EXISTS `517funcaovinculo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `517funcaovinculo` (
  `idFuncaoVinculo` int(11) NOT NULL AUTO_INCREMENT,
  `idVinculoProfissional` int(11) NOT NULL,
  `idFuncao` int(11) NOT NULL,
  `idSetor` int(11) DEFAULT NULL,
  `dataInicio` date NOT NULL,
  `dataFim` date DEFAULT NULL,
  `ativo` varchar(1) NOT NULL,
  `obs` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`idFuncaoVinculo`),
  KEY `idFuncao517_idx` (`idFuncao`),
  KEY `idVinculoProfissional517_idx` (`idVinculoProfissional`),
  KEY `idSetor517_idx` (`idSetor`),
  CONSTRAINT `idFuncao517` FOREIGN KEY (`idFuncao`) REFERENCES `512tipofuncao` (`idFuncao`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `idSetor517` FOREIGN KEY (`idSetor`) REFERENCES `900setor` (`idSetor`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `idVinculoProfissional517` FOREIGN KEY (`idVinculoProfissional`) REFERENCES `540vinculoprofissional` (`idVinculoProfissional`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `518statusvinculo`
--

DROP TABLE IF EXISTS `518statusvinculo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `518statusvinculo` (
  `idStatusVinculo` int(11) NOT NULL AUTO_INCREMENT,
  `idVinculoProfissional` int(11) NOT NULL,
  `idStatus` int(11) NOT NULL,
  `dataInicio` date NOT NULL,
  `dataFim` date DEFAULT NULL,
  `ativo` varchar(1) NOT NULL,
  `obs` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`idStatusVinculo`),
  KEY `idVinculoProfissional518_idx` (`idVinculoProfissional`),
  KEY `idStatus518_idx` (`idStatus`),
  CONSTRAINT `idStatus518` FOREIGN KEY (`idStatus`) REFERENCES `519tipostatus` (`idTipoStatus`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `idVinculoProfissional518` FOREIGN KEY (`idVinculoProfissional`) REFERENCES `540vinculoprofissional` (`idVinculoProfissional`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `519tipostatus`
--

DROP TABLE IF EXISTS `519tipostatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `519tipostatus` (
  `idTipoStatus` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(60) NOT NULL,
  `ativo` varchar(1) NOT NULL DEFAULT 'S',
  PRIMARY KEY (`idTipoStatus`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `520ferias`
--

DROP TABLE IF EXISTS `520ferias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `520ferias` (
  `idFerias` int(11) NOT NULL AUTO_INCREMENT,
  `idFuncionario` int(11) NOT NULL,
  `dataInicio` date DEFAULT NULL,
  `dataFim` date DEFAULT NULL,
  `pendencia` varchar(2) NOT NULL,
  `obs` varchar(90) DEFAULT NULL,
  `mesPrevisto` varchar(2) DEFAULT NULL,
  `idRefLicenca` int(11) NOT NULL,
  `tipo` varchar(2) NOT NULL,
  `parcial` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`idFerias`),
  KEY `idFuncionario520_idx` (`idFuncionario`),
  KEY `idrefLicenca520_idx` (`idRefLicenca`),
  CONSTRAINT `idFuncionario520` FOREIGN KEY (`idFuncionario`) REFERENCES `500funcionario` (`idFuncionario`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `idrefLicenca520` FOREIGN KEY (`idRefLicenca`) REFERENCES `522reflicenca` (`idRefLicenca`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7952 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `521refferias`
--

DROP TABLE IF EXISTS `521refferias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `521refferias` (
  `idRefFerias` int(11) NOT NULL AUTO_INCREMENT,
  `referencia` varchar(12) NOT NULL,
  PRIMARY KEY (`idRefFerias`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `522reflicenca`
--

DROP TABLE IF EXISTS `522reflicenca`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `522reflicenca` (
  `idRefLicenca` int(11) NOT NULL AUTO_INCREMENT,
  `idFuncionario` int(11) NOT NULL,
  `tipo` varchar(2) NOT NULL,
  `descricao` varchar(45) NOT NULL,
  `status` varchar(2) NOT NULL,
  `dataInicio` date DEFAULT NULL,
  `dataFim` date DEFAULT NULL,
  PRIMARY KEY (`idRefLicenca`),
  KEY `idFuncionario522_idx` (`idFuncionario`),
  CONSTRAINT `idFuncionario522` FOREIGN KEY (`idFuncionario`) REFERENCES `500funcionario` (`idFuncionario`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7952 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `523laudoatestado`
--

DROP TABLE IF EXISTS `523laudoatestado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `523laudoatestado` (
  `idLaudoAtestado` int(11) NOT NULL AUTO_INCREMENT,
  `idLaudo` int(11) NOT NULL,
  `idAtestado` int(11) NOT NULL,
  PRIMARY KEY (`idLaudoAtestado`),
  KEY `idAtestado523_idx` (`idAtestado`),
  KEY `idLaudo523_idx` (`idLaudo`),
  CONSTRAINT `idAtestado523` FOREIGN KEY (`idAtestado`) REFERENCES `503atestado` (`idAtestado`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `idLaudo523` FOREIGN KEY (`idLaudo`) REFERENCES `504laudo` (`idLaudo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=615 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `524vinculogratificacao`
--

DROP TABLE IF EXISTS `524vinculogratificacao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `524vinculogratificacao` (
  `idVinculoGratificacao` int(11) NOT NULL AUTO_INCREMENT,
  `idVinculoProfissional` int(11) NOT NULL,
  `idTipoGratificacao` int(11) DEFAULT NULL,
  `dataInicio` date NOT NULL,
  `dataFim` date DEFAULT NULL,
  `ativo` varchar(1) NOT NULL,
  PRIMARY KEY (`idVinculoGratificacao`),
  KEY `idTipoGratificacao524_idx` (`idTipoGratificacao`),
  KEY `idVinculoProfissional524_idx` (`idVinculoProfissional`),
  CONSTRAINT `idTipoGratificacao524` FOREIGN KEY (`idTipoGratificacao`) REFERENCES `525tipogratificacao` (`idTipoGratificacao`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `idVinculoProfissional524` FOREIGN KEY (`idVinculoProfissional`) REFERENCES `540vinculoprofissional` (`idVinculoProfissional`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `525tipogratificacao`
--

DROP TABLE IF EXISTS `525tipogratificacao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `525tipogratificacao` (
  `idTipoGratificacao` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(45) NOT NULL,
  `ativo` varchar(1) NOT NULL DEFAULT 'S',
  PRIMARY KEY (`idTipoGratificacao`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `540vinculoprofissional`
--

DROP TABLE IF EXISTS `540vinculoprofissional`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `540vinculoprofissional` (
  `idVinculoProfissional` int(11) NOT NULL AUTO_INCREMENT,
  `idProfissional` int(11) NOT NULL,
  `numVinculo` varchar(1) NOT NULL,
  `cargo` int(11) DEFAULT NULL,
  `numeroCr` varchar(45) DEFAULT NULL,
  `dataEmissaoCr` date DEFAULT NULL,
  `tipoVinculo` int(11) DEFAULT NULL,
  `dataAdmissao` date NOT NULL,
  `dataDesligamento` date DEFAULT NULL,
  `pendente` varchar(1) NOT NULL,
  `cbo` varchar(10) DEFAULT NULL,
  `vinculoAtivo` varchar(1) NOT NULL,
  `obs` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`idVinculoProfissional`),
  KEY `cargo500_idx` (`cargo`),
  KEY `tipoVinculo500_idx` (`tipoVinculo`),
  KEY `idFuncionario5000_idx` (`idProfissional`),
  CONSTRAINT `cargo5000` FOREIGN KEY (`cargo`) REFERENCES `505cargo` (`idCargo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `idFuncionario5000` FOREIGN KEY (`idProfissional`) REFERENCES `500funcionario` (`idFuncionario`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `tipoVinculo5000` FOREIGN KEY (`tipoVinculo`) REFERENCES `510tipovinculo` (`idTipoVinculo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=913 DEFAULT CHARSET=utf8 COMMENT='						';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `541arquivoprofissional`
--

DROP TABLE IF EXISTS `541arquivoprofissional`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `541arquivoprofissional` (
  `idArquivoProfissional` int(11) NOT NULL AUTO_INCREMENT,
  `idProfissional` int(11) NOT NULL,
  `descricao` varchar(255) NOT NULL,
  `tipoArquivo` int(11) NOT NULL,
  `arquivo` mediumblob,
  `extensaoArquivo` varchar(45) DEFAULT NULL,
  `dataInclusao` datetime NOT NULL,
  `incluidoPor` varchar(15) DEFAULT NULL,
  `nomeArquivo` varchar(100) DEFAULT NULL,
  `tamanhoArquivo` varchar(45) DEFAULT NULL,
  `idVinculoProfissional` int(11) DEFAULT NULL,
  `idFuncaoVinculo` int(11) DEFAULT NULL,
  `idStatusVinculo` int(11) DEFAULT NULL,
  `idVinculoGratificacao` int(11) DEFAULT NULL,
  `idHistoricoSetor` int(11) DEFAULT NULL,
  PRIMARY KEY (`idArquivoProfissional`),
  KEY `idProfissional541_idx` (`idProfissional`),
  KEY `tipoArquivo541_idx` (`tipoArquivo`),
  KEY `idVinculoProfissional_idx` (`idVinculoProfissional`),
  KEY `idFuncaoVinculo541_idx` (`idFuncaoVinculo`),
  KEY `idStatusVinculo541_idx` (`idStatusVinculo`),
  KEY `idVinculoGratificacao_idx` (`idVinculoGratificacao`),
  KEY `idHistoricoSetor541_idx` (`idHistoricoSetor`),
  CONSTRAINT `idFuncaoVinculo541` FOREIGN KEY (`idFuncaoVinculo`) REFERENCES `517funcaovinculo` (`idFuncaoVinculo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `idHistoricoSetor541` FOREIGN KEY (`idHistoricoSetor`) REFERENCES `501historicosetor` (`idHistoricoSetor`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `idProfissional541` FOREIGN KEY (`idProfissional`) REFERENCES `500funcionario` (`idFuncionario`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `idStatusVinculo541` FOREIGN KEY (`idStatusVinculo`) REFERENCES `518statusvinculo` (`idStatusVinculo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `idVinculoGratificacao541` FOREIGN KEY (`idVinculoGratificacao`) REFERENCES `524vinculogratificacao` (`idVinculoGratificacao`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `idVinculoProfissional541` FOREIGN KEY (`idVinculoProfissional`) REFERENCES `540vinculoprofissional` (`idVinculoProfissional`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `tipoArquivo541` FOREIGN KEY (`tipoArquivo`) REFERENCES `542tipoarquivo` (`idTipoArquivo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=546 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `542tipoarquivo`
--

DROP TABLE IF EXISTS `542tipoarquivo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `542tipoarquivo` (
  `idTipoArquivo` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(30) NOT NULL,
  PRIMARY KEY (`idTipoArquivo`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `550formacaoacademica`
--

DROP TABLE IF EXISTS `550formacaoacademica`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `550formacaoacademica` (
  `idFormacaoAcademica` int(11) NOT NULL AUTO_INCREMENT,
  `idProfissional` int(11) NOT NULL,
  `idCurso` int(11) DEFAULT NULL,
  `idInstituicao` int(11) DEFAULT NULL,
  `anoFormacao` int(4) DEFAULT NULL,
  PRIMARY KEY (`idFormacaoAcademica`),
  KEY `idProfissional550_idx` (`idProfissional`),
  CONSTRAINT `idProfissional550` FOREIGN KEY (`idProfissional`) REFERENCES `500funcionario` (`idFuncionario`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `600horariobase`
--

DROP TABLE IF EXISTS `600horariobase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `600horariobase` (
  `idHorarioBase` int(11) NOT NULL AUTO_INCREMENT,
  `idProfissional` int(11) NOT NULL,
  `segunda` varchar(1) NOT NULL,
  `terca` varchar(1) NOT NULL,
  `quarta` varchar(1) NOT NULL,
  `quinta` varchar(1) NOT NULL,
  `sexta` varchar(1) NOT NULL,
  `dia1` varchar(15) DEFAULT NULL,
  `dia2` varchar(15) DEFAULT NULL,
  `dia3` varchar(15) DEFAULT NULL,
  `dia4` varchar(15) DEFAULT NULL,
  `dia5` varchar(15) DEFAULT NULL,
  `dia6` varchar(15) DEFAULT NULL,
  `dia7` varchar(15) DEFAULT NULL,
  `qtdVagas` int(2) NOT NULL,
  `idTipoConsulta` int(11) DEFAULT NULL,
  `tempoConsulta` int(2) NOT NULL,
  `horaCheckIn` varchar(8) NOT NULL,
  `horaInicio` varchar(8) NOT NULL,
  `tipo` varchar(1) NOT NULL,
  `isAtivo` varchar(1) NOT NULL DEFAULT 'S',
  PRIMARY KEY (`idHorarioBase`),
  KEY `idProfissional600_idx` (`idProfissional`),
  CONSTRAINT `idProfissional600` FOREIGN KEY (`idProfissional`) REFERENCES `500funcionario` (`idFuncionario`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `605feriado`
--

DROP TABLE IF EXISTS `605feriado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `605feriado` (
  `idFeriado` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(45) NOT NULL,
  `data` date NOT NULL,
  `tipo` varchar(1) NOT NULL COMMENT 'E-Estadual\\nF-Federal\\nM-Municipal',
  `cadastradoPor` varchar(15) NOT NULL,
  `dataCadastro` date NOT NULL,
  PRIMARY KEY (`idFeriado`),
  UNIQUE KEY `data_index` (`data`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `606impedimento`
--

DROP TABLE IF EXISTS `606impedimento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `606impedimento` (
  `idImpedimento` int(11) NOT NULL AUTO_INCREMENT,
  `dataInicio` date NOT NULL,
  `dataFim` date NOT NULL,
  `idTipoImpedimento` int(11) NOT NULL,
  `abrangencia` varchar(1) NOT NULL,
  `dataCadastro` datetime NOT NULL,
  `cadastradoPor` varchar(15) CHARACTER SET utf8 NOT NULL,
  `isAtivo` varchar(1) NOT NULL DEFAULT 'S',
  `idProfissional` int(11) DEFAULT NULL,
  PRIMARY KEY (`idImpedimento`),
  KEY `idImpedimento606_idx` (`idTipoImpedimento`),
  KEY `cadastradoPor_idx` (`cadastradoPor`),
  KEY `idProfissional_606_idx` (`idProfissional`),
  CONSTRAINT `cadastradoPor` FOREIGN KEY (`cadastradoPor`) REFERENCES `sec_users` (`login`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `idProfissional_606` FOREIGN KEY (`idProfissional`) REFERENCES `500funcionario` (`idFuncionario`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `idTipoImpedimento606` FOREIGN KEY (`idTipoImpedimento`) REFERENCES `607tipoimpedimento` (`idTipoImpedimento`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=109 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `607tipoimpedimento`
--

DROP TABLE IF EXISTS `607tipoimpedimento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `607tipoimpedimento` (
  `idTipoImpedimento` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(45) NOT NULL,
  `flag` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`idTipoImpedimento`),
  UNIQUE KEY `descricao` (`descricao`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `608especialidadeambulatorio`
--

DROP TABLE IF EXISTS `608especialidadeambulatorio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `608especialidadeambulatorio` (
  `idEspecialidade` int(11) NOT NULL AUTO_INCREMENT,
  `idOcupacao` varchar(10) NOT NULL,
  `idProfissional` int(11) NOT NULL,
  `ativo` varchar(1) NOT NULL,
  PRIMARY KEY (`idEspecialidade`),
  KEY `idOcupacao_608_idx` (`idOcupacao`),
  KEY `idProfissional_608_idx` (`idProfissional`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `610agenda`
--

DROP TABLE IF EXISTS `610agenda`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `610agenda` (
  `idAgenda` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(300) DEFAULT NULL,
  `dataInicio` date DEFAULT NULL,
  `horaInicio` time DEFAULT NULL,
  `periodo` varchar(1) DEFAULT NULL,
  `categoria` int(11) DEFAULT NULL,
  `idProfissional` int(11) NOT NULL,
  `idPaciente` int(11) DEFAULT NULL,
  `idStatus` int(11) NOT NULL,
  `cadastradoPor` varchar(10) NOT NULL,
  `dataCadastro` datetime DEFAULT NULL,
  `checkin` tinyint(1) NOT NULL DEFAULT '0',
  `tipoConsulta` varchar(1) NOT NULL DEFAULT 'N' COMMENT 'N -- Normal\\nE -- Extra',
  `horaCheckin` time DEFAULT NULL,
  `regulado` varchar(1) DEFAULT NULL,
  `idHorarioBase` int(11) NOT NULL,
  `agendadoPor` int(11) DEFAULT NULL,
  `dataAgendamento` datetime DEFAULT NULL,
  `impresso` varchar(1) DEFAULT NULL,
  `idImpedimento` int(11) DEFAULT NULL,
  `atualizadoPor` varchar(10) DEFAULT NULL,
  `dataAtualizado` date DEFAULT NULL,
  PRIMARY KEY (`idAgenda`),
  KEY `idPaciente_610_idx` (`idPaciente`),
  KEY `idStatus_610_idx` (`idStatus`),
  KEY `idProfissional_610_idx` (`idProfissional`),
  KEY `idHorarioBase_610_idx` (`idHorarioBase`),
  KEY `idImpedimento_610_idx` (`idImpedimento`),
  CONSTRAINT `idHorarioBase_610` FOREIGN KEY (`idHorarioBase`) REFERENCES `600horariobase` (`idHorarioBase`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `idImpedimento_610` FOREIGN KEY (`idImpedimento`) REFERENCES `606impedimento` (`idImpedimento`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `idPaciente_610` FOREIGN KEY (`idPaciente`) REFERENCES `300paciente` (`idPaciente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `idStatus_610` FOREIGN KEY (`idStatus`) REFERENCES `611statusconsulta` (`idStatusConsulta`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=54147 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `611statusconsulta`
--

DROP TABLE IF EXISTS `611statusconsulta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `611statusconsulta` (
  `idStatusConsulta` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(45) NOT NULL,
  PRIMARY KEY (`idStatusConsulta`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `613tipoconsulta`
--

DROP TABLE IF EXISTS `613tipoconsulta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `613tipoconsulta` (
  `idTipoConsulta` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(60) NOT NULL,
  `cor` varchar(15) NOT NULL,
  PRIMARY KEY (`idTipoConsulta`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `615horario`
--

DROP TABLE IF EXISTS `615horario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `615horario` (
  `idHorario` int(11) NOT NULL AUTO_INCREMENT,
  `horario` time DEFAULT NULL,
  PRIMARY KEY (`idHorario`)
) ENGINE=InnoDB AUTO_INCREMENT=146 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `616horarioprofissional`
--

DROP TABLE IF EXISTS `616horarioprofissional`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `616horarioprofissional` (
  `idHorarioProfissional` int(11) NOT NULL AUTO_INCREMENT,
  `idHorarioBase` int(11) NOT NULL,
  `idProfissional` int(11) NOT NULL,
  `dia` varchar(10) NOT NULL,
  `hora` time NOT NULL,
  `isAtivo` varchar(1) NOT NULL,
  `tipo` varchar(1) NOT NULL,
  PRIMARY KEY (`idHorarioProfissional`),
  KEY `idProfissional_616_idx` (`idProfissional`),
  KEY `idHorarioBase_616_idx` (`idHorarioBase`),
  CONSTRAINT `idHorarioBase_616` FOREIGN KEY (`idHorarioBase`) REFERENCES `600horariobase` (`idHorarioBase`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `idProfissional_616` FOREIGN KEY (`idProfissional`) REFERENCES `500funcionario` (`idFuncionario`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3722 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `617qtdconsultaregulada`
--

DROP TABLE IF EXISTS `617qtdconsultaregulada`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `617qtdconsultaregulada` (
  `idQtdConsultasRegulada` int(11) NOT NULL AUTO_INCREMENT,
  `idEspecialidade` varchar(45) NOT NULL,
  `qtdConsulta` int(11) NOT NULL,
  `dataInicio` date NOT NULL,
  `dataFim` date DEFAULT NULL,
  `ativo` varchar(1) NOT NULL,
  PRIMARY KEY (`idQtdConsultasRegulada`),
  KEY `idEspecialidade617_idx` (`idEspecialidade`),
  CONSTRAINT `idEspecialidade617` FOREIGN KEY (`idEspecialidade`) REFERENCES `618especialidadeofertada` (`idEspecialidade`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `618especialidadeofertada`
--

DROP TABLE IF EXISTS `618especialidadeofertada`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `618especialidadeofertada` (
  `idEspecialidadeOfertada` int(11) NOT NULL AUTO_INCREMENT,
  `idEspecialidade` varchar(10) NOT NULL,
  `ativo` varchar(1) NOT NULL,
  PRIMARY KEY (`idEspecialidadeOfertada`),
  UNIQUE KEY `idEspecialidade_idx` (`idEspecialidade`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `620faa`
--

DROP TABLE IF EXISTS `620faa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `620faa` (
  `idFaa` int(11) NOT NULL AUTO_INCREMENT,
  `idConsulta` int(11) DEFAULT NULL,
  `cadastradoPor` varchar(15) DEFAULT NULL,
  `dataCadastro` datetime DEFAULT CURRENT_TIMESTAMP,
  `evolucao` text,
  `idCid` varchar(4) DEFAULT NULL,
  `idCid2` varchar(4) DEFAULT NULL,
  `status` varchar(1) NOT NULL DEFAULT 'A',
  `dataBaixa` datetime DEFAULT NULL,
  `baixaPor` varchar(15) DEFAULT NULL,
  `baixa` varchar(1) DEFAULT 'N',
  PRIMARY KEY (`idFaa`),
  UNIQUE KEY `idAgenda_fk_idx` (`idConsulta`),
  KEY `idCid_fk_idx` (`idCid`),
  KEY `idCid2_620_idx` (`idCid2`),
  CONSTRAINT `idAgenda_fk` FOREIGN KEY (`idConsulta`) REFERENCES `610agenda` (`idAgenda`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `idCid2_620` FOREIGN KEY (`idCid2`) REFERENCES `sigtap_tb_cid` (`CO_CID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `idCid_fk` FOREIGN KEY (`idCid`) REFERENCES `sigtap_tb_cid` (`CO_CID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=10505 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `700afd`
--

DROP TABLE IF EXISTS `700afd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `700afd` (
  `idAfd` int(11) NOT NULL AUTO_INCREMENT,
  `tipo` int(11) NOT NULL,
  `dataRegistro` date NOT NULL,
  `horaRegistro` time DEFAULT NULL,
  `pis` varchar(12) DEFAULT NULL,
  PRIMARY KEY (`idAfd`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `900setor`
--

DROP TABLE IF EXISTS `900setor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `900setor` (
  `idSetor` int(11) NOT NULL AUTO_INCREMENT,
  `descSetor` varchar(45) NOT NULL,
  `flagFarmacia` varchar(45) DEFAULT NULL COMMENT 'para idetificar os setores para onde a farmácia pode dispensar medicamentos',
  `flagEstoque` varchar(1) NOT NULL,
  `centroCusto` varchar(4) DEFAULT NULL,
  `flagAlmox` varchar(1) DEFAULT NULL,
  `flagAtend` varchar(1) DEFAULT 'n',
  `flagCoord` varchar(1) DEFAULT 'n',
  PRIMARY KEY (`idSetor`),
  UNIQUE KEY `descSetor_UNIQUE` (`descSetor`)
) ENGINE=InnoDB AUTO_INCREMENT=111 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `901unidade`
--

DROP TABLE IF EXISTS `901unidade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `901unidade` (
  `idUnidade` int(11) NOT NULL AUTO_INCREMENT,
  `descUnidadeRed` varchar(15) NOT NULL,
  `descUnidade` varchar(45) NOT NULL,
  `is_simas` varchar(1) NOT NULL COMMENT 'S - sim\nN - não',
  PRIMARY KEY (`idUnidade`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `902prioridade`
--

DROP TABLE IF EXISTS `902prioridade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `902prioridade` (
  `idPrioridade` int(11) NOT NULL AUTO_INCREMENT,
  `descPrioridade` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idPrioridade`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `903tipoitem`
--

DROP TABLE IF EXISTS `903tipoitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `903tipoitem` (
  `idTipoItem` int(11) NOT NULL AUTO_INCREMENT,
  `descTipoItem` varchar(45) NOT NULL,
  `flag` int(11) NOT NULL COMMENT '0 - Medicamento\n1 - Demais tipos de itens',
  PRIMARY KEY (`idTipoItem`),
  UNIQUE KEY `descTipoItem_UNIQUE` (`descTipoItem`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `905tipoentradasaida`
--

DROP TABLE IF EXISTS `905tipoentradasaida`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `905tipoentradasaida` (
  `idTipoEntradaSaida` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(45) NOT NULL,
  `flag` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`idTipoEntradaSaida`),
  UNIQUE KEY `descricao_UNIQUE` (`descricao`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `907escalaglasgow`
--

DROP TABLE IF EXISTS `907escalaglasgow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `907escalaglasgow` (
  `idGlasgow` int(11) NOT NULL,
  `descricao` varchar(45) NOT NULL,
  `escore` int(11) DEFAULT NULL,
  `flag` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`idGlasgow`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `908classrisco`
--

DROP TABLE IF EXISTS `908classrisco`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `908classrisco` (
  `idClass` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(45) NOT NULL,
  PRIMARY KEY (`idClass`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `909classdor`
--

DROP TABLE IF EXISTS `909classdor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `909classdor` (
  `idClassDor` int(11) NOT NULL,
  `codigo` varchar(5) NOT NULL,
  `descricao` varchar(45) NOT NULL,
  PRIMARY KEY (`idClassDor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `910encaminhamento`
--

DROP TABLE IF EXISTS `910encaminhamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `910encaminhamento` (
  `idEncamin` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(45) NOT NULL,
  PRIMARY KEY (`idEncamin`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `911queixaprincipal`
--

DROP TABLE IF EXISTS `911queixaprincipal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `911queixaprincipal` (
  `idQueixaPrinc` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(45) NOT NULL,
  PRIMARY KEY (`idQueixaPrinc`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `912grupofarm`
--

DROP TABLE IF EXISTS `912grupofarm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `912grupofarm` (
  `idGrupoFarm` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(45) NOT NULL,
  PRIMARY KEY (`idGrupoFarm`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='classificação dos medicamentos feita pela farmácia';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `920medicamentos`
--

DROP TABLE IF EXISTS `920medicamentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `920medicamentos` (
  `PRINCIPIO_ATIVO` varchar(255) DEFAULT NULL,
  `CNPJ` varchar(255) DEFAULT NULL,
  `LABORATORIO` varchar(255) DEFAULT NULL,
  `CODIGO_GGREM` varchar(255) DEFAULT NULL,
  `REGISTRO` varchar(255) DEFAULT NULL,
  `EAN` varchar(255) DEFAULT NULL,
  `PRODUTO` varchar(255) DEFAULT NULL,
  `APRESENTACAO` varchar(255) DEFAULT NULL,
  `CLASSE_TERAPEUTICA` varchar(255) DEFAULT NULL,
  `TIPO_DE_PRODUTO` varchar(255) DEFAULT NULL,
  `RESTRICAO_HOSPITALAR` varchar(255) DEFAULT NULL,
  `CAP` varchar(255) DEFAULT NULL,
  `CONFAZ_87` varchar(255) DEFAULT NULL,
  `ANALISE_RECURSAL` varchar(255) DEFAULT NULL,
  `LISTA_CONCESSAO_CREDITO` varchar(255) DEFAULT NULL,
  `TARJA` varchar(255) DEFAULT NULL,
  `idMedicamento` int(11) NOT NULL AUTO_INCREMENT,
  `idLaboratorio` int(11) NOT NULL,
  PRIMARY KEY (`idMedicamento`)
) ENGINE=InnoDB AUTO_INCREMENT=25742 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `930cep`
--

DROP TABLE IF EXISTS `930cep`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `930cep` (
  `idCep` int(11) NOT NULL AUTO_INCREMENT,
  `estado` varchar(2) DEFAULT NULL,
  `logradouro` varchar(100) DEFAULT NULL,
  `cep` varchar(10) DEFAULT NULL,
  `cidade` varchar(50) DEFAULT NULL,
  `bairro` varchar(45) DEFAULT NULL,
  `complLogradouro` varchar(100) DEFAULT NULL,
  `tipoLogradouro` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idCep`),
  KEY `estado930` (`estado`),
  KEY `cidade930` (`cidade`),
  KEY `cep930` (`cep`),
  CONSTRAINT `estadofk_930` FOREIGN KEY (`estado`) REFERENCES `931estados` (`idEstado`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1014212 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `931estados`
--

DROP TABLE IF EXISTS `931estados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `931estados` (
  `idEstado` varchar(2) NOT NULL,
  `estado` varchar(45) NOT NULL,
  PRIMARY KEY (`idEstado`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `932localidades`
--

DROP TABLE IF EXISTS `932localidades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `932localidades` (
  `idLocalidade` int(11) NOT NULL AUTO_INCREMENT,
  `idEstado` varchar(2) NOT NULL,
  `localidade` varchar(70) NOT NULL,
  `cep` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`idLocalidade`),
  KEY `idEstado932` (`idEstado`),
  KEY `cep932` (`cep`),
  CONSTRAINT `idEstado_932` FOREIGN KEY (`idEstado`) REFERENCES `931estados` (`idEstado`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=10792 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `940avisossistema`
--

DROP TABLE IF EXISTS `940avisossistema`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `940avisossistema` (
  `idAvisosSistema` int(11) NOT NULL AUTO_INCREMENT,
  `idModulo` int(11) NOT NULL,
  `aviso` text NOT NULL,
  `dataInicio` date DEFAULT NULL,
  `dataFim` date DEFAULT NULL,
  `versao` varchar(45) DEFAULT NULL,
  `nomeSistema` varchar(45) DEFAULT NULL,
  `logoSistema` mediumblob,
  PRIMARY KEY (`idAvisosSistema`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `950menu`
--

DROP TABLE IF EXISTS `950menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `950menu` (
  `idMenu` int(11) NOT NULL AUTO_INCREMENT,
  `pai` int(11) DEFAULT NULL,
  `descricao` varchar(45) NOT NULL,
  `link` varchar(45) DEFAULT NULL,
  `ordem` int(11) NOT NULL,
  `perfil` int(11) NOT NULL,
  `icone` varchar(75) DEFAULT NULL,
  `idModulo` varchar(128) NOT NULL COMMENT 'faz referência a sec_apps - app_name',
  PRIMARY KEY (`idMenu`)
) ENGINE=InnoDB AUTO_INCREMENT=127 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `951tipoperfil`
--

DROP TABLE IF EXISTS `951tipoperfil`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `951tipoperfil` (
  `idTipoPerfil` int(11) NOT NULL AUTO_INCREMENT,
  `perfil` int(11) NOT NULL,
  `descricao` varchar(200) NOT NULL,
  PRIMARY KEY (`idTipoPerfil`),
  KEY `perfil_idx` (`perfil`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `city`
--

DROP TABLE IF EXISTS `city`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `city` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `id_state` int(11) NOT NULL COMMENT 'State',
  `title` varchar(50) NOT NULL COMMENT 'Title',
  `iso` int(8) NOT NULL COMMENT 'Code ISO',
  `iso_ddd` varchar(6) NOT NULL COMMENT 'DDD ISO',
  `created_at` datetime DEFAULT NULL COMMENT 'Created At',
  `updated_at` datetime DEFAULT NULL COMMENT 'Updated At',
  `status` enum('0','1') NOT NULL DEFAULT '1' COMMENT 'Status',
  PRIMARY KEY (`id`),
  KEY `FK_id_state_city` (`id_state`),
  CONSTRAINT `FK_id_state_city` FOREIGN KEY (`id_state`) REFERENCES `state` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5571 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `country`
--

DROP TABLE IF EXISTS `country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `country` (
  `id` int(4) NOT NULL COMMENT 'ID',
  `iso_code` char(2) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'ISO Code',
  `title` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'Title',
  `created_at` datetime DEFAULT NULL COMMENT 'Created At',
  `updated_at` datetime DEFAULT NULL COMMENT 'Updated At',
  `status` enum('0','1') NOT NULL DEFAULT '1' COMMENT 'Status',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `faixaetariafuncionarios`
--

DROP TABLE IF EXISTS `faixaetariafuncionarios`;
/*!50001 DROP VIEW IF EXISTS `faixaetariafuncionarios`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `faixaetariafuncionarios` AS SELECT 
 1 AS `Qtd`,
 1 AS `faixa`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `hras505_cid`
--

DROP TABLE IF EXISTS `hras505_cid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hras505_cid` (
  `hras505_CID_ID` varchar(6) NOT NULL,
  `hras505_ Classif` varchar(5) DEFAULT NULL,
  `hras505_ RestrSexo` varchar(4) DEFAULT NULL,
  `hras505_ CausaObito` varchar(4) DEFAULT NULL,
  `hras505_Descricao` mediumtext NOT NULL,
  `hras505_DescrAbrev` mediumtext NOT NULL,
  `hras505_Refer` varchar(45) DEFAULT NULL,
  `hras505_ Excluidos` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`hras505_CID_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pesquisa_lotacao`
--

DROP TABLE IF EXISTS `pesquisa_lotacao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pesquisa_lotacao` (
  `idPesquisaLotacao` int(11) NOT NULL AUTO_INCREMENT,
  `idProfissional` int(11) NOT NULL,
  `idVinculo` int(11) NOT NULL,
  `dataResposta` datetime NOT NULL,
  `respondeu` varchar(1) NOT NULL,
  PRIMARY KEY (`idPesquisaLotacao`),
  UNIQUE KEY `idVinculo_UNIQUE` (`idVinculo`)
) ENGINE=InnoDB AUTO_INCREMENT=245 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pesquisa_opcao`
--

DROP TABLE IF EXISTS `pesquisa_opcao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pesquisa_opcao` (
  `idOpcao` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(60) NOT NULL,
  PRIMARY KEY (`idOpcao`),
  UNIQUE KEY `descricao_UNIQUE` (`descricao`)
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pesquisa_opcao_cargo`
--

DROP TABLE IF EXISTS `pesquisa_opcao_cargo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pesquisa_opcao_cargo` (
  `idPesquisaOpcaoCargo` int(11) NOT NULL AUTO_INCREMENT,
  `idOpcao` int(11) NOT NULL,
  `idCargo` int(11) NOT NULL,
  `qtd` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`idPesquisaOpcaoCargo`),
  KEY `idOpcao_fk_idx` (`idOpcao`),
  KEY `idCargo_fk_idx` (`idCargo`),
  CONSTRAINT `idCargo_fk` FOREIGN KEY (`idCargo`) REFERENCES `505cargo` (`idCargo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `idOpcao_fk` FOREIGN KEY (`idOpcao`) REFERENCES `pesquisa_opcao` (`idOpcao`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=176 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pesquisa_profissional_opcao`
--

DROP TABLE IF EXISTS `pesquisa_profissional_opcao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pesquisa_profissional_opcao` (
  `idPesquisaProfissionalOpcao` int(11) NOT NULL AUTO_INCREMENT,
  `idPesquisaLotacao` int(11) NOT NULL,
  `idOpcao` int(11) DEFAULT NULL,
  `outro` varchar(45) DEFAULT NULL,
  `ordem` int(11) NOT NULL,
  PRIMARY KEY (`idPesquisaProfissionalOpcao`),
  KEY `idOpcao_pesquisa_idx` (`idOpcao`),
  KEY `idPesquisaLotacao_fk_idx` (`idPesquisaLotacao`),
  CONSTRAINT `idOpcao_pesquisa` FOREIGN KEY (`idOpcao`) REFERENCES `pesquisa_opcao` (`idOpcao`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `idPesquisaLotacao_fk` FOREIGN KEY (`idPesquisaLotacao`) REFERENCES `pesquisa_lotacao` (`idPesquisaLotacao`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=733 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ponto`
--

DROP TABLE IF EXISTS `ponto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ponto` (
  `id` int(11) NOT NULL,
  `data` date DEFAULT NULL,
  `funcionario_id` int(11) DEFAULT NULL,
  `entrada1` time DEFAULT NULL,
  `saida1` time DEFAULT NULL,
  `entrada2` time DEFAULT NULL,
  `saida2` time DEFAULT NULL,
  `entrada3` time DEFAULT NULL,
  `saida3` time DEFAULT NULL,
  `mem_entrada1` time DEFAULT NULL,
  `mem_saida1` time DEFAULT NULL,
  `mem_entrada2` time DEFAULT NULL,
  `mem_saida2` time DEFAULT NULL,
  `horario_num` int(11) DEFAULT NULL,
  `n_departamento` int(11) DEFAULT NULL,
  `n_folha` varchar(45) CHARACTER SET latin1 DEFAULT NULL,
  `nome` varchar(100) CHARACTER SET latin1 DEFAULT NULL,
  `n_identificador` varchar(45) CHARACTER SET latin1 DEFAULT NULL,
  `departamento` varchar(45) CHARACTER SET latin1 DEFAULT NULL,
  `obs` varchar(45) CHARACTER SET latin1 DEFAULT NULL,
  `cargo` varchar(45) COLLATE utf8_swedish_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `n_departamento_idx` (`n_departamento`),
  KEY `funcionario_id_idx` (`funcionario_id`),
  KEY `data_idx` (`data`),
  KEY `nome_idx` (`nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `region`
--

DROP TABLE IF EXISTS `region`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `region` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `id_language` int(11) DEFAULT NULL COMMENT 'Language',
  `title` varchar(80) DEFAULT NULL COMMENT 'Title',
  `created_at` datetime DEFAULT NULL COMMENT 'Created At',
  `updated_at` datetime DEFAULT NULL COMMENT 'Updated At',
  `status` enum('0','1') DEFAULT '1' COMMENT 'Status',
  PRIMARY KEY (`id`),
  KEY `id_language_region` (`id_language`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `rel_atestado`
--

DROP TABLE IF EXISTS `rel_atestado`;
/*!50001 DROP VIEW IF EXISTS `rel_atestado`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `rel_atestado` AS SELECT 
 1 AS `RecebidoPor`,
 1 AS `setor`,
 1 AS `DataEntrega`,
 1 AS `matricula`,
 1 AS `nome`,
 1 AS `turno`,
 1 AS `Tipo`,
 1 AS `InicioAfastamento`,
 1 AS `FimAfastamento`,
 1 AS `DiasAfastamento`,
 1 AS `Emitente`,
 1 AS `nomemedico`,
 1 AS `crm`,
 1 AS `AnoMes`,
 1 AS `Cargo`,
 1 AS `idatestado`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `rel_estoque_processo`
--

DROP TABLE IF EXISTS `rel_estoque_processo`;
/*!50001 DROP VIEW IF EXISTS `rel_estoque_processo`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `rel_estoque_processo` AS SELECT 
 1 AS `idItem`,
 1 AS `Tipo`,
 1 AS `Codigo`,
 1 AS `Item`,
 1 AS `QtdItemProcesso`,
 1 AS `NumProcesso`,
 1 AS `StatusAta`,
 1 AS `QtdItemEstoque`,
 1 AS `DataCriacao`,
 1 AS `Grupo`,
 1 AS `Status`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `sc_log`
--

DROP TABLE IF EXISTS `sc_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sc_log` (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `inserted_date` datetime DEFAULT NULL,
  `username` varchar(90) NOT NULL,
  `application` varchar(200) NOT NULL,
  `creator` varchar(30) NOT NULL,
  `ip_user` varchar(32) NOT NULL,
  `action` varchar(30) NOT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1952416 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sc_log_sast`
--

DROP TABLE IF EXISTS `sc_log_sast`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sc_log_sast` (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `inserted_date` datetime DEFAULT NULL,
  `username` varchar(90) NOT NULL,
  `application` varchar(200) NOT NULL,
  `creator` varchar(30) NOT NULL,
  `ip_user` varchar(32) NOT NULL,
  `action` varchar(30) NOT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20513 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sec_apps`
--

DROP TABLE IF EXISTS `sec_apps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sec_apps` (
  `app_name` varchar(128) NOT NULL,
  `app_type` varchar(255) DEFAULT NULL,
  `description` varchar(255) NOT NULL,
  PRIMARY KEY (`app_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sec_logged`
--

DROP TABLE IF EXISTS `sec_logged`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sec_logged` (
  `login` varchar(255) NOT NULL,
  `date_login` varchar(128) DEFAULT NULL,
  `sc_session` varchar(32) DEFAULT NULL,
  `ip` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sec_users`
--

DROP TABLE IF EXISTS `sec_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sec_users` (
  `login` varchar(255) NOT NULL,
  `pswd` varchar(32) NOT NULL,
  `name` varchar(64) DEFAULT NULL,
  `email` varchar(64) DEFAULT NULL,
  `active` varchar(1) DEFAULT NULL,
  `activation_code` varchar(32) DEFAULT NULL,
  `priv_admin` varchar(1) DEFAULT NULL,
  `idSetor` int(11) DEFAULT NULL,
  `flagSoPedido` varchar(1) DEFAULT NULL,
  `autorizaPedido` varchar(1) DEFAULT 'N',
  `idPerfil` int(11) DEFAULT NULL,
  PRIMARY KEY (`login`),
  KEY `idSetor_sec_idx` (`idSetor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sec_users_apps`
--

DROP TABLE IF EXISTS `sec_users_apps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sec_users_apps` (
  `login` varchar(255) NOT NULL,
  `app_name` varchar(128) NOT NULL,
  `priv_access` varchar(1) DEFAULT NULL,
  `priv_insert` varchar(1) DEFAULT NULL,
  `priv_delete` varchar(1) DEFAULT NULL,
  `priv_update` varchar(1) DEFAULT NULL,
  `priv_export` varchar(1) DEFAULT NULL,
  `priv_print` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`login`,`app_name`),
  KEY `sec_users_apps_ibfk_2` (`app_name`),
  CONSTRAINT `sec_users_apps_ibfk_1` FOREIGN KEY (`login`) REFERENCES `sec_users` (`login`) ON DELETE CASCADE,
  CONSTRAINT `sec_users_apps_ibfk_2` FOREIGN KEY (`app_name`) REFERENCES `sec_apps` (`app_name`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sigtap_rl_excecao_compatibilidade`
--

DROP TABLE IF EXISTS `sigtap_rl_excecao_compatibilidade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sigtap_rl_excecao_compatibilidade` (
  `CO_PROCEDIMENTO_RESTRICAO` varchar(10) NOT NULL,
  `CO_PROCEDIMENTO_PRINCIPAL` varchar(10) NOT NULL,
  `CO_REGISTRO_PRINCIPAL` varchar(2) NOT NULL,
  `CO_PROCEDIMENTO_COMPATIVEL` varchar(10) NOT NULL,
  `CO_REGISTRO_COMPATIVEL` varchar(2) NOT NULL,
  `TP_COMPATIBILIDADE` varchar(1) DEFAULT NULL,
  `DT_COMPETENCIA` varchar(6) NOT NULL,
  PRIMARY KEY (`CO_PROCEDIMENTO_RESTRICAO`,`CO_PROCEDIMENTO_PRINCIPAL`,`CO_REGISTRO_PRINCIPAL`,`CO_PROCEDIMENTO_COMPATIVEL`,`CO_REGISTRO_COMPATIVEL`,`DT_COMPETENCIA`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sigtap_rl_procedimento_cid`
--

DROP TABLE IF EXISTS `sigtap_rl_procedimento_cid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sigtap_rl_procedimento_cid` (
  `CO_PROCEDIMENTO` varchar(10) NOT NULL,
  `CO_CID` varchar(4) NOT NULL,
  `ST_PRINCIPAL` varchar(1) DEFAULT NULL,
  `DT_COMPETENCIA` varchar(6) NOT NULL,
  PRIMARY KEY (`CO_CID`,`DT_COMPETENCIA`,`CO_PROCEDIMENTO`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sigtap_rl_procedimento_comp_rede`
--

DROP TABLE IF EXISTS `sigtap_rl_procedimento_comp_rede`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sigtap_rl_procedimento_comp_rede` (
  `CO_PROCEDIMENTO` varchar(10) NOT NULL,
  `CO_COMPONENTE_REDE` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`CO_PROCEDIMENTO`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sigtap_rl_procedimento_compativel`
--

DROP TABLE IF EXISTS `sigtap_rl_procedimento_compativel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sigtap_rl_procedimento_compativel` (
  `CO_PROCEDIMENTO_PRINCIPAL` varchar(10) NOT NULL,
  `CO_REGISTRO_PRINCIPAL` varchar(2) NOT NULL,
  `CO_PROCEDIMENTO_COMPATIVEL` varchar(10) NOT NULL,
  `CO_REGISTRO_COMPATIVEL` varchar(2) NOT NULL,
  `TP_COMPATIBILIDADE` varchar(1) DEFAULT NULL,
  `QT_PERMITIDA` int(4) DEFAULT NULL,
  `DT_COMPETENCIA` varchar(6) NOT NULL,
  PRIMARY KEY (`CO_PROCEDIMENTO_PRINCIPAL`,`CO_REGISTRO_PRINCIPAL`,`CO_PROCEDIMENTO_COMPATIVEL`,`CO_REGISTRO_COMPATIVEL`,`DT_COMPETENCIA`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sigtap_rl_procedimento_detalhe`
--

DROP TABLE IF EXISTS `sigtap_rl_procedimento_detalhe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sigtap_rl_procedimento_detalhe` (
  `CO_PROCEDIMENTO` varchar(10) NOT NULL,
  `CO_DETALHE` varchar(3) NOT NULL,
  `DT_COMPETENCIA` varchar(6) NOT NULL,
  PRIMARY KEY (`CO_PROCEDIMENTO`,`DT_COMPETENCIA`,`CO_DETALHE`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sigtap_rl_procedimento_habilitacao`
--

DROP TABLE IF EXISTS `sigtap_rl_procedimento_habilitacao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sigtap_rl_procedimento_habilitacao` (
  `CO_PROCEDIMENTO` varchar(10) NOT NULL,
  `CO_HABILITACAO` varchar(4) NOT NULL,
  `NU_GRUPO_HABILITACAO` varchar(4) DEFAULT NULL,
  `DT_COMPETENCIA` varchar(6) NOT NULL,
  PRIMARY KEY (`CO_PROCEDIMENTO`,`CO_HABILITACAO`,`DT_COMPETENCIA`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sigtap_rl_procedimento_incremento`
--

DROP TABLE IF EXISTS `sigtap_rl_procedimento_incremento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sigtap_rl_procedimento_incremento` (
  `CO_PROCEDIMENTO` varchar(10) NOT NULL,
  `CO_HABILITACAO` varchar(4) NOT NULL,
  `VL_PERCENTUAL_SH` float DEFAULT NULL,
  `VL_PERCENTUAL_SA` float DEFAULT NULL,
  `VL_PERCENTUAL_SP` float DEFAULT NULL,
  `DT_COMPETENCIA` varchar(6) NOT NULL,
  PRIMARY KEY (`CO_PROCEDIMENTO`,`DT_COMPETENCIA`,`CO_HABILITACAO`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sigtap_rl_procedimento_leito`
--

DROP TABLE IF EXISTS `sigtap_rl_procedimento_leito`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sigtap_rl_procedimento_leito` (
  `CO_PROCEDIMENTO` varchar(10) NOT NULL,
  `CO_TIPO_LEITO` varchar(2) NOT NULL,
  `DT_COMPETENCIA` varchar(6) NOT NULL,
  PRIMARY KEY (`CO_PROCEDIMENTO`,`DT_COMPETENCIA`,`CO_TIPO_LEITO`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sigtap_rl_procedimento_modalidade`
--

DROP TABLE IF EXISTS `sigtap_rl_procedimento_modalidade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sigtap_rl_procedimento_modalidade` (
  `CO_PROCEDIMENTO` varchar(10) NOT NULL,
  `CO_MODALIDADE` varchar(2) NOT NULL,
  `DT_COMPETENCIA` varchar(6) NOT NULL,
  PRIMARY KEY (`CO_PROCEDIMENTO`,`CO_MODALIDADE`,`DT_COMPETENCIA`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sigtap_rl_procedimento_ocupacao`
--

DROP TABLE IF EXISTS `sigtap_rl_procedimento_ocupacao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sigtap_rl_procedimento_ocupacao` (
  `CO_PROCEDIMENTO` varchar(10) NOT NULL,
  `CO_OCUPACAO` varchar(6) NOT NULL,
  `DT_COMPETENCIA` varchar(6) NOT NULL,
  PRIMARY KEY (`CO_PROCEDIMENTO`,`CO_OCUPACAO`,`DT_COMPETENCIA`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sigtap_rl_procedimento_origem`
--

DROP TABLE IF EXISTS `sigtap_rl_procedimento_origem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sigtap_rl_procedimento_origem` (
  `CO_PROCEDIMENTO` varchar(10) NOT NULL,
  `CO_PROCEDIMENTO_ORIGEM` varchar(10) DEFAULT NULL,
  `DT_COMPETENCIA` varchar(6) NOT NULL,
  PRIMARY KEY (`CO_PROCEDIMENTO`,`DT_COMPETENCIA`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sigtap_rl_procedimento_registro`
--

DROP TABLE IF EXISTS `sigtap_rl_procedimento_registro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sigtap_rl_procedimento_registro` (
  `id_rl_procedimento_registro` int(11) NOT NULL AUTO_INCREMENT,
  `CO_PROCEDIMENTO` varchar(10) NOT NULL,
  `CO_REGISTRO` varchar(2) NOT NULL,
  `DT_COMPETENCIA` varchar(6) NOT NULL,
  PRIMARY KEY (`id_rl_procedimento_registro`,`DT_COMPETENCIA`)
) ENGINE=InnoDB AUTO_INCREMENT=163683 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sigtap_rl_procedimento_regra_cond`
--

DROP TABLE IF EXISTS `sigtap_rl_procedimento_regra_cond`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sigtap_rl_procedimento_regra_cond` (
  `CO_PROCEDIMENTO` varchar(10) NOT NULL,
  `CO_REGRA_CONDICIONADA` varchar(4) NOT NULL,
  PRIMARY KEY (`CO_REGRA_CONDICIONADA`,`CO_PROCEDIMENTO`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sigtap_rl_procedimento_renases`
--

DROP TABLE IF EXISTS `sigtap_rl_procedimento_renases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sigtap_rl_procedimento_renases` (
  `CO_PROCEDIMENTO` varchar(10) NOT NULL,
  `CO_RENASES` varchar(10) DEFAULT NULL,
  KEY `CO_PROCEDIMENTO_idx` (`CO_PROCEDIMENTO`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sigtap_rl_procedimento_servico`
--

DROP TABLE IF EXISTS `sigtap_rl_procedimento_servico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sigtap_rl_procedimento_servico` (
  `CO_PROCEDIMENTO` varchar(10) NOT NULL,
  `CO_SERVICO` varchar(3) NOT NULL,
  `CO_CLASSIFICACAO` varchar(3) NOT NULL,
  `DT_COMPETENCIA` varchar(6) NOT NULL,
  PRIMARY KEY (`CO_PROCEDIMENTO`,`DT_COMPETENCIA`,`CO_SERVICO`,`CO_CLASSIFICACAO`),
  KEY `CO_PROCEDIMENTO_serv` (`CO_PROCEDIMENTO`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sigtap_rl_procedimento_sia_sih`
--

DROP TABLE IF EXISTS `sigtap_rl_procedimento_sia_sih`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sigtap_rl_procedimento_sia_sih` (
  `CO_PROCEDIMENTO` varchar(10) NOT NULL,
  `CO_PROCEDIMENTO_SIA_SIH` varchar(10) NOT NULL,
  `TP_PROCEDIMENTO` varchar(1) DEFAULT NULL,
  `DT_COMPETENCIA` varchar(6) NOT NULL,
  PRIMARY KEY (`CO_PROCEDIMENTO`,`DT_COMPETENCIA`,`CO_PROCEDIMENTO_SIA_SIH`),
  KEY `CO_PROCEDIMENTO_SIA_SIH_idx` (`CO_PROCEDIMENTO_SIA_SIH`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sigtap_rl_procedimento_tuss`
--

DROP TABLE IF EXISTS `sigtap_rl_procedimento_tuss`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sigtap_rl_procedimento_tuss` (
  `CO_PROCEDIMENTO` varchar(10) NOT NULL,
  `CO_TUSS` varchar(10) NOT NULL,
  PRIMARY KEY (`CO_PROCEDIMENTO`,`CO_TUSS`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sigtap_tb_cid`
--

DROP TABLE IF EXISTS `sigtap_tb_cid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sigtap_tb_cid` (
  `CO_CID` varchar(4) NOT NULL,
  `NO_CID` varchar(100) NOT NULL,
  `TP_AGRAVO` varchar(1) DEFAULT NULL,
  `TP_SEXO` varchar(1) DEFAULT NULL,
  `TP_ESTADIO` varchar(1) DEFAULT NULL,
  `VL_CAMPOS_IRRADIADOS` varchar(4) DEFAULT NULL,
  PRIMARY KEY (`CO_CID`),
  KEY `NO_CID_idx` (`NO_CID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sigtap_tb_complexidade`
--

DROP TABLE IF EXISTS `sigtap_tb_complexidade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sigtap_tb_complexidade` (
  `CO_COMPLEXIDADE` varchar(1) NOT NULL,
  `NO_COMPLEXIDADE` varchar(35) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sigtap_tb_componente_rede`
--

DROP TABLE IF EXISTS `sigtap_tb_componente_rede`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sigtap_tb_componente_rede` (
  `CO_COMPONENTE_REDE` varchar(10) NOT NULL,
  `NO_COMPONENTE_REDE` varchar(150) DEFAULT NULL,
  `CO_REDE_ATENCAO` varchar(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sigtap_tb_descricao`
--

DROP TABLE IF EXISTS `sigtap_tb_descricao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sigtap_tb_descricao` (
  `CO_PROCEDIMENTO` varchar(10) NOT NULL,
  `DS_PROCEDIMENTO` varchar(4000) NOT NULL,
  `DT_COMPETENCIA` varchar(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sigtap_tb_descricao_detalhe`
--

DROP TABLE IF EXISTS `sigtap_tb_descricao_detalhe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sigtap_tb_descricao_detalhe` (
  `CO_DETALHE` varchar(3) NOT NULL,
  `DS_DETALHE` varchar(4000) DEFAULT NULL,
  `DT_COMPETENCIA` varchar(6) NOT NULL,
  PRIMARY KEY (`CO_DETALHE`,`DT_COMPETENCIA`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sigtap_tb_detalhe`
--

DROP TABLE IF EXISTS `sigtap_tb_detalhe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sigtap_tb_detalhe` (
  `CO_DETALHE` varchar(3) NOT NULL,
  `NO_DETALHE` varchar(100) DEFAULT NULL,
  `DT_COMPETENCIA` varchar(6) NOT NULL,
  PRIMARY KEY (`CO_DETALHE`,`DT_COMPETENCIA`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sigtap_tb_financiamento`
--

DROP TABLE IF EXISTS `sigtap_tb_financiamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sigtap_tb_financiamento` (
  `CO_FINANCIAMENTO` varchar(2) NOT NULL,
  `NO_FINANCIAMENTO` varchar(250) CHARACTER SET utf8 DEFAULT NULL,
  `DT_COMPETENCIA` varchar(6) NOT NULL,
  PRIMARY KEY (`CO_FINANCIAMENTO`,`DT_COMPETENCIA`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sigtap_tb_forma_organizacao`
--

DROP TABLE IF EXISTS `sigtap_tb_forma_organizacao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sigtap_tb_forma_organizacao` (
  `CO_GRUPO` varchar(2) NOT NULL,
  `CO_SUB_GRUPO` varchar(2) NOT NULL,
  `CO_FORMA_ORGANIZACAO` varchar(2) NOT NULL,
  `NO_FORMA_ORGANIZACAO` varchar(125) NOT NULL,
  `DT_COMPETENCIA` varchar(6) NOT NULL,
  PRIMARY KEY (`CO_GRUPO`,`DT_COMPETENCIA`,`CO_SUB_GRUPO`,`CO_FORMA_ORGANIZACAO`),
  KEY `CO_GRUPO_org_idx` (`CO_GRUPO`),
  KEY `CO_SUB_GRUPO_org_idx` (`CO_SUB_GRUPO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='	';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sigtap_tb_grupo`
--

DROP TABLE IF EXISTS `sigtap_tb_grupo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sigtap_tb_grupo` (
  `CO_GRUPO` varchar(2) NOT NULL,
  `NO_GRUPO` varchar(100) DEFAULT NULL,
  `DT_COMPETENCIA` varchar(6) NOT NULL,
  PRIMARY KEY (`CO_GRUPO`,`DT_COMPETENCIA`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sigtap_tb_grupo_habilitacao`
--

DROP TABLE IF EXISTS `sigtap_tb_grupo_habilitacao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sigtap_tb_grupo_habilitacao` (
  `NU_GRUPO_HABILITACAO` varchar(4) NOT NULL,
  `NO_GRUPO_HABILITACAO` varchar(20) NOT NULL,
  `DS_GRUPO_HABILITACAO` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sigtap_tb_habilitacao`
--

DROP TABLE IF EXISTS `sigtap_tb_habilitacao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sigtap_tb_habilitacao` (
  `CO_HABILITACAO` varchar(4) NOT NULL,
  `NO_HABILITACAO` varchar(150) NOT NULL,
  `DT_COMPETENCIA` varchar(6) NOT NULL,
  PRIMARY KEY (`CO_HABILITACAO`,`DT_COMPETENCIA`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sigtap_tb_modalidade`
--

DROP TABLE IF EXISTS `sigtap_tb_modalidade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sigtap_tb_modalidade` (
  `CO_MODALIDADE` varchar(2) NOT NULL,
  `NO_MODALIDADE` varchar(100) NOT NULL,
  `DT_COMPETENCIA` varchar(6) NOT NULL,
  PRIMARY KEY (`CO_MODALIDADE`,`DT_COMPETENCIA`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sigtap_tb_ocupacao`
--

DROP TABLE IF EXISTS `sigtap_tb_ocupacao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sigtap_tb_ocupacao` (
  `CO_OCUPACAO` varchar(10) NOT NULL,
  `NO_OCUPACAO` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sigtap_tb_procedimento`
--

DROP TABLE IF EXISTS `sigtap_tb_procedimento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sigtap_tb_procedimento` (
  `CO_PROCEDIMENTO` varchar(10) NOT NULL,
  `NO_PROCEDIMENTO` varchar(260) NOT NULL,
  `TP_COMPLEXIDADE` varchar(1) DEFAULT NULL,
  `TP_SEXO` varchar(1) DEFAULT NULL,
  `QT_MAXIMA_EXECUCAO` varchar(4) DEFAULT NULL,
  `QT_DIAS_PERMANENCIA` varchar(4) DEFAULT NULL,
  `QT_PONTOS` varchar(4) DEFAULT NULL,
  `VL_IDADE_MINIMA` varchar(4) DEFAULT NULL,
  `VL_IDADE_MAXIMA` varchar(4) DEFAULT NULL,
  `VL_SH` double DEFAULT NULL,
  `VL_SA` double DEFAULT NULL,
  `VL_SP` double DEFAULT NULL,
  `CO_FINANCIAMENTO` varchar(2) DEFAULT NULL,
  `CO_RUBRICA` varchar(6) DEFAULT NULL,
  `QT_TEMPO_PERMANENCIA` varchar(4) DEFAULT NULL,
  `DT_COMPETENCIA` varchar(6) NOT NULL,
  PRIMARY KEY (`CO_PROCEDIMENTO`,`DT_COMPETENCIA`),
  KEY `CO_PROCEDIMENTO_idx` (`CO_PROCEDIMENTO`),
  KEY `NO_PROCEDIMENTO_idx` (`NO_PROCEDIMENTO`),
  KEY `DT_COMPETENCIA` (`DT_COMPETENCIA`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sigtap_tb_rede_atencao`
--

DROP TABLE IF EXISTS `sigtap_tb_rede_atencao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sigtap_tb_rede_atencao` (
  `CO_REDE_ATENCAO` varchar(3) NOT NULL,
  `NO_REDE_ATENCAO` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sigtap_tb_registro`
--

DROP TABLE IF EXISTS `sigtap_tb_registro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sigtap_tb_registro` (
  `CO_REGISTRO` varchar(2) NOT NULL,
  `NO_REGISTRO` varchar(50) NOT NULL,
  `DT_COMPETENCIA` varchar(6) NOT NULL,
  PRIMARY KEY (`CO_REGISTRO`,`DT_COMPETENCIA`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sigtap_tb_regra_condicionada`
--

DROP TABLE IF EXISTS `sigtap_tb_regra_condicionada`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sigtap_tb_regra_condicionada` (
  `CO_REGRA_CONDICIONADA` varchar(4) NOT NULL,
  `NO_REGRA_CONDICIONADA` varchar(150) NOT NULL,
  `DS_REGRA_CONDICIONADA` varchar(4000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sigtap_tb_renases`
--

DROP TABLE IF EXISTS `sigtap_tb_renases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sigtap_tb_renases` (
  `CO_RENASES` varchar(10) CHARACTER SET big5 NOT NULL,
  `NO_RENASES` varchar(150) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sigtap_tb_rubrica`
--

DROP TABLE IF EXISTS `sigtap_tb_rubrica`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sigtap_tb_rubrica` (
  `CO_RUBRICA` varchar(6) NOT NULL,
  `NO_RUBRICA` varchar(100) NOT NULL,
  `DT_COMPETENCIA` varchar(6) NOT NULL,
  PRIMARY KEY (`CO_RUBRICA`,`DT_COMPETENCIA`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sigtap_tb_servico`
--

DROP TABLE IF EXISTS `sigtap_tb_servico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sigtap_tb_servico` (
  `CO_SERVICO` varchar(3) NOT NULL,
  `NO_SERVICO` varchar(120) DEFAULT NULL,
  `DT_COMPETENCIA` varchar(6) NOT NULL,
  PRIMARY KEY (`CO_SERVICO`,`DT_COMPETENCIA`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sigtap_tb_servico_classificacao`
--

DROP TABLE IF EXISTS `sigtap_tb_servico_classificacao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sigtap_tb_servico_classificacao` (
  `CO_SERVICO` varchar(3) NOT NULL,
  `CO_CLASSIFICACAO` varchar(3) NOT NULL,
  `NO_CLASSIFICACAO` varchar(150) DEFAULT NULL,
  `DT_COMPETENCIA` varchar(6) NOT NULL,
  PRIMARY KEY (`CO_SERVICO`,`CO_CLASSIFICACAO`,`DT_COMPETENCIA`),
  KEY `CO_SERVICO_idx` (`CO_SERVICO`),
  KEY `CO_CLASSIFICACAO_idx` (`CO_CLASSIFICACAO`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sigtap_tb_sia_sih`
--

DROP TABLE IF EXISTS `sigtap_tb_sia_sih`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sigtap_tb_sia_sih` (
  `CO_PROCEDIMENTO_SIA_SIH` varchar(10) NOT NULL,
  `NO_PROCEDIMENTO_SIA_SIH` varchar(100) DEFAULT NULL,
  `TP_PROCEDIMENTO` varchar(1) DEFAULT NULL,
  `DT_COMPETENCIA` varchar(6) NOT NULL,
  PRIMARY KEY (`CO_PROCEDIMENTO_SIA_SIH`,`DT_COMPETENCIA`),
  KEY `CO_PROCEDIMENTO_SIA_SIH_idx` (`CO_PROCEDIMENTO_SIA_SIH`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sigtap_tb_tipo_leito`
--

DROP TABLE IF EXISTS `sigtap_tb_tipo_leito`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sigtap_tb_tipo_leito` (
  `CO_TIPO_LEITO` varchar(2) NOT NULL,
  `NO_TIPO_LEITO` varchar(60) DEFAULT NULL,
  `DT_COMPETENCIA` varchar(6) NOT NULL,
  PRIMARY KEY (`CO_TIPO_LEITO`,`DT_COMPETENCIA`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sigtap_tb_tuss`
--

DROP TABLE IF EXISTS `sigtap_tb_tuss`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sigtap_tb_tuss` (
  `CO_TUSS` varchar(10) NOT NULL,
  `NO_TUSS` varchar(450) DEFAULT NULL,
  KEY `CO_TUSS` (`CO_TUSS`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sigtap_tbsubgrupo`
--

DROP TABLE IF EXISTS `sigtap_tbsubgrupo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sigtap_tbsubgrupo` (
  `CO_GRUPO` varchar(2) CHARACTER SET latin1 NOT NULL,
  `CO_SUB_GRUPO` varchar(2) CHARACTER SET latin1 NOT NULL,
  `NO_SUB_GRUPO` varchar(100) CHARACTER SET latin1 NOT NULL,
  `DT_COMPETENCIA` varchar(6) NOT NULL,
  PRIMARY KEY (`CO_GRUPO`,`CO_SUB_GRUPO`,`DT_COMPETENCIA`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `state`
--

DROP TABLE IF EXISTS `state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `state` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `id_country` int(4) NOT NULL COMMENT 'Country',
  `id_region` int(11) NOT NULL COMMENT 'Region',
  `title` varchar(35) NOT NULL COMMENT 'Title',
  `letter` char(2) NOT NULL COMMENT 'Letter State',
  `iso` int(2) NOT NULL COMMENT 'Code ISO',
  `created_at` datetime DEFAULT NULL COMMENT 'Created At',
  `updated_at` datetime DEFAULT NULL COMMENT 'Updated At',
  `status` enum('0','1') NOT NULL DEFAULT '1' COMMENT 'Status',
  PRIMARY KEY (`id`),
  KEY `FK_id_country_state` (`id_country`),
  CONSTRAINT `FK_id_country_state` FOREIGN KEY (`id_country`) REFERENCES `country` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 COMMENT='Tabela de Cadastro de ESTADOS';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `valores`
--

DROP TABLE IF EXISTS `valores`;
/*!50001 DROP VIEW IF EXISTS `valores`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `valores` AS SELECT 
 1 AS `competencia1`,
 1 AS `competencia2`,
 1 AS `coProcedimento`,
 1 AS `NO_PROCEDIMENTO`,
 1 AS `qtdMax`,
 1 AS `valorUnitario`,
 1 AS `QtdRealizada`,
 1 AS `previaProcedimentoTotal`,
 1 AS `valorMaxProcedimento`,
 1 AS `valorPago`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `zone`
--

DROP TABLE IF EXISTS `zone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zone` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `id_state` int(11) NOT NULL COMMENT 'State',
  `title` varchar(80) NOT NULL COMMENT 'Title',
  `iso` varchar(80) NOT NULL COMMENT 'ISO Code',
  `iso_name` varchar(80) NOT NULL COMMENT 'ISO Name',
  `created_at` datetime DEFAULT NULL COMMENT 'Created At',
  `updated_at` datetime DEFAULT NULL COMMENT 'Updated At',
  `status` enum('0','1') NOT NULL DEFAULT '1' COMMENT 'Status',
  PRIMARY KEY (`id`),
  KEY `id_state_region` (`id_state`),
  CONSTRAINT `id_state_region` FOREIGN KEY (`id_state`) REFERENCES `state` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Final view structure for view `faixaetariafuncionarios`
--

/*!50001 DROP VIEW IF EXISTS `faixaetariafuncionarios`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `faixaetariafuncionarios` AS select count(`f`.`idFuncionario`) AS `Qtd`,(case when ((timestampdiff(YEAR,`f`.`dataNascimento`,now()) < 18) or (timestampdiff(YEAR,`f`.`dataNascimento`,now()) > 100) or isnull(timestampdiff(YEAR,`f`.`dataNascimento`,now()))) then 'Não Informado' when ((timestampdiff(YEAR,`f`.`dataNascimento`,now()) >= 18) and (timestampdiff(YEAR,`f`.`dataNascimento`,now()) < 30)) then '18 - 30' when ((timestampdiff(YEAR,`f`.`dataNascimento`,now()) >= 30) and (timestampdiff(YEAR,`f`.`dataNascimento`,now()) < 40)) then '30 - 40' when ((timestampdiff(YEAR,`f`.`dataNascimento`,now()) >= 40) and (timestampdiff(YEAR,`f`.`dataNascimento`,now()) < 50)) then '40 - 50' when ((timestampdiff(YEAR,`f`.`dataNascimento`,now()) >= 50) and (timestampdiff(YEAR,`f`.`dataNascimento`,now()) < 100)) then '50 ou mais' end) AS `faixa` from `500funcionario` `f` group by (case when ((timestampdiff(YEAR,`f`.`dataNascimento`,now()) < 18) or (timestampdiff(YEAR,`f`.`dataNascimento`,now()) > 100) or isnull(timestampdiff(YEAR,`f`.`dataNascimento`,now()))) then 'Não Informado' when ((timestampdiff(YEAR,`f`.`dataNascimento`,now()) >= 18) and (timestampdiff(YEAR,`f`.`dataNascimento`,now()) < 30)) then '18 - 30' when ((timestampdiff(YEAR,`f`.`dataNascimento`,now()) >= 30) and (timestampdiff(YEAR,`f`.`dataNascimento`,now()) < 40)) then '30 - 40' when ((timestampdiff(YEAR,`f`.`dataNascimento`,now()) >= 40) and (timestampdiff(YEAR,`f`.`dataNascimento`,now()) < 50)) then '40 - 50' when ((timestampdiff(YEAR,`f`.`dataNascimento`,now()) >= 50) and (timestampdiff(YEAR,`f`.`dataNascimento`,now()) < 100)) then '50 ou mais' end) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `rel_atestado`
--

/*!50001 DROP VIEW IF EXISTS `rel_atestado`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `rel_atestado` AS select `f2`.`nome` AS `RecebidoPor`,`s`.`descSetor` AS `setor`,date_format(`a`.`dataEntrega`,'%d/%m/%Y') AS `DataEntrega`,`f`.`matricula` AS `matricula`,`f`.`nome` AS `nome`,`t`.`descricao` AS `turno`,`ta`.`descricao` AS `Tipo`,if((`ta`.`idTipoAtestado` = 2),date_format(`a`.`inicioAfastamentoH`,'%d/%m/%Y - %H:%i'),date_format(`a`.`inicioAfastamento`,'%d/%m/%Y')) AS `InicioAfastamento`,if((`ta`.`idTipoAtestado` = 2),date_format(`a`.`fimAfastamentoH`,'%d/%m/%Y - %H:%i'),date_format(`a`.`fimAfastamento`,'%d/%m/%Y')) AS `FimAfastamento`,if((`ta`.`idTipoAtestado` = 2),'0',((to_days(`a`.`fimAfastamento`) - to_days(`a`.`inicioAfastamento`)) + 1)) AS `DiasAfastamento`,if((`a`.`nomeMedico` = ''),`a`.`emitente`,`a`.`nomeMedico`) AS `Emitente`,`a`.`nomeMedico` AS `nomemedico`,`a`.`crm` AS `crm`,if((`ta`.`idTipoAtestado` = 2),date_format(`a`.`inicioAfastamentoH`,'%Y-%m'),date_format(`a`.`inicioAfastamento`,'%Y-%m')) AS `AnoMes`,`c`.`descricao` AS `Cargo`,`a`.`idAtestado` AS `idatestado` from ((((((((`503atestado` `a` join `500funcionario` `f` on((`f`.`idFuncionario` = `a`.`idFuncionario`))) left join `500funcionario` `f2` on((`f2`.`idFuncionario` = `a`.`recebido`))) left join `540vinculoprofissional` `vp` on((`vp`.`idProfissional` = `f`.`idFuncionario`))) left join `501historicosetor` `hs` on((`hs`.`idVinculoProfissional` = `f`.`idFuncionario`))) left join `900setor` `s` on((`s`.`idSetor` = `hs`.`idSetor`))) left join `511turno` `t` on((`t`.`idTurno` = `a`.`idTurno`))) left join `516tipoatestado` `ta` on((`ta`.`idTipoAtestado` = `a`.`idTipo`))) left join `505cargo` `c` on((`c`.`idCargo` = `vp`.`cargo`))) order by `f`.`nome`,`a`.`inicioAfastamento` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `rel_estoque_processo`
--

/*!50001 DROP VIEW IF EXISTS `rel_estoque_processo`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `rel_estoque_processo` AS select `e`.`idItem` AS `idItem`,if(isnull(`te`.`descricao`),'--',`te`.`descricao`) AS `Tipo`,`i`.`codigo` AS `Codigo`,`i`.`descItem` AS `Item`,if((isnull(`p`.`idSituacao`) or (`p`.`idSituacao` = 2) or (`p`.`idSituacao` = 5) or (`p`.`idSituacao` = 14)),'--',`ip`.`qtdItem`) AS `QtdItemProcesso`,if((isnull(`p`.`idSituacao`) or (`p`.`idSituacao` = 2) or (`p`.`idSituacao` = 5) or (`p`.`idSituacao` = 14)),'--',`p`.`numProcesso`) AS `NumProcesso`,`pa`.`status` AS `StatusAta`,sum(`e`.`quantidade`) AS `QtdItemEstoque`,if((isnull(`p`.`idSituacao`) or (`p`.`idSituacao` = 2) or (`p`.`idSituacao` = 5) or (`p`.`idSituacao` = 14)),'--',`p`.`dataCriacao`) AS `DataCriacao`,`gi`.`descricao` AS `Grupo`,if((isnull(`p`.`idSituacao`) or (`p`.`idSituacao` = 2) or (`p`.`idSituacao` = 5) or (`p`.`idSituacao` = 14)),'Sem Processo',`st`.`descricao`) AS `Status` from ((((((((`101estoque` `e` left join `454itensprocesso` `ip` on((`e`.`idItem` = `ip`.`idItem`))) left join `400processos` `p` on((`ip`.`idProcesso` = `p`.`idProcesso`))) left join `100item` `i` on((`e`.`idItem` = `i`.`idItem`))) left join `150grupoitem` `gi` on((`i`.`idGrupoItem` = `gi`.`idGrupoItem`))) left join `457itensprocessoata` `ipa` on((`e`.`idItem` = `ipa`.`idItens`))) left join `456processoata` `pa` on((`ipa`.`idProcessoAta` = `pa`.`idProcessoAta`))) left join `451sitprocesso` `st` on((`p`.`idSituacao` = `st`.`idSitProcesso`))) left join `452tipoespecie` `te` on((`p`.`idEspecie` = `te`.`idTipoEspecie`))) where ((`e`.`idSetor` = 4) or ((`p`.`idSituacao` <> 2) and (`p`.`idSituacao` <> 5) and (`p`.`idSituacao` <> 14) and (`pa`.`status` <> 2) and (`pa`.`status` <> 5) and (`pa`.`status` <> 14))) group by `i`.`descItem` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `valores`
--

/*!50001 DROP VIEW IF EXISTS `valores`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`sishrasdev`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `valores` AS select `b2`.`competencia` AS `competencia1`,`p2`.`DT_COMPETENCIA` AS `competencia2`,`b2`.`coProcedimento` AS `coProcedimento`,`p2`.`NO_PROCEDIMENTO` AS `NO_PROCEDIMENTO`,`pq`.`qtd` AS `qtdMax`,`p2`.`VL_SA` AS `valorUnitario`,sum(`b2`.`qtd`) AS `QtdRealizada`,sum((`p2`.`VL_SA` * `b2`.`qtd`)) AS `previaProcedimentoTotal`,if(isnull((`pq`.`qtd` * `p2`.`VL_SA`)),0,(`pq`.`qtd` * `p2`.`VL_SA`)) AS `valorMaxProcedimento`,if(isnull(`pq`.`qtd`),0,if((sum(`b2`.`qtd`) > `pq`.`qtd`),(`pq`.`qtd` * `p2`.`VL_SA`),sum((`p2`.`VL_SA` * `b2`.`qtd`)))) AS `valorPago` from ((`350bpa` `b2` join `sigtap_tb_procedimento` `p2` on((`b2`.`coProcedimento` = `p2`.`CO_PROCEDIMENTO`))) left join `355procedimentoqtd` `pq` on((`pq`.`coProcedimento` = `b2`.`coProcedimento`))) where ((`p2`.`DT_COMPETENCIA` = '201810') and (`b2`.`competencia` = '201810')) group by `b2`.`competencia`,`b2`.`coProcedimento` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-07-15 11:49:45
