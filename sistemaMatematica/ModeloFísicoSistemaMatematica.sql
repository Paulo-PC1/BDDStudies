--Sistema Inteligente de Exercícios Matemáticos (SIEM)
--Criação do Banco de Dados
CREATE DATABASE SIEM;
GO

USE SIEM;
GO

SET DATEFORMAT YMD;
GO

--Criação das Tabelas
CREATE TABLE USUARIOS	(
	IdUsuario		INT	IDENTITY	PRIMARY KEY,
	Nome			VARCHAR(150)	NOT NULL,
	Email			VARCHAR(200)	UNIQUE NOT NULL,
	Senha			VARCHAR(255)	NOT NULL,
	DataCadastro	DATETIME		NOT	NULL
);

CREATE TABLE NIVEL	(
	IdNivel		INT	IDENTITY	PRIMARY	KEY,
	Nome		VARCHAR(50)		NOT NULL,
	Descricao	VARCHAR(255)
);

CREATE TABLE CATEGORIA	(
	IdCategoria		INT IDENTITY	PRIMARY KEY,
	Nome			VARCHAR(200)	NOT NULL,
	Descricao		VARCHAR(200)
);

CREATE TABLE MODELO_EXERCICIO	(
	IdModelo				INT IDENTITY PRIMARY KEY,
	Nome					VARCHAR(200),
	Operacao				VARCHAR(50),
	ValorMaximo				INT,
	ValorMinimo				INT,
	QuantidadeOperandos		INT,
	Ativo					BIT,
	IdCategoria				INT	NOT NULL FOREIGN KEY REFERENCES CATEGORIA(IdCategoria),
	IdNivel					INT NOT NULL FOREIGN KEY REFERENCES NIVEL(IdNivel)
);

CREATE TABLE EXERCICIO_GERADO (
    IdExercicioGerado	INT IDENTITY PRIMARY KEY,
    Enunciado           VARCHAR(255),
    RespostaCorreta     DECIMAL(10,2),
    DataGeracao			DATETIME,
    IdModelo			INT NOT NULL FOREIGN KEY REFERENCES MODELO_EXERCICIO(IdModelo)
);

CREATE TABLE RESPOSTA (
    IdResposta			INT IDENTITY PRIMARY KEY,
    RespostaUsuario     DECIMAL(10,2),
    Correta             BIT,
    TempoResposta       INT,
    DataResposta        DATETIME,
    IdUsuario			INT NOT NULL FOREIGN KEY REFERENCES USUARIOS(IdUsuario),
    IdExercicioGerado	INT NOT NULL FOREIGN KEY REFERENCES EXERCICIO_GERADO(IdExercicioGerado)
);

CREATE TABLE PROGRESSO (
    IdProgresso		INT IDENTITY PRIMARY KEY,
    TotalAcertos    INT DEFAULT 0,
    TotalErros      INT DEFAULT 0,
    Pontuacao       INT DEFAULT 0,
    IdUsuario		INT UNIQUE NOT NULL FOREIGN KEY REFERENCES USUARIOS(IdUsuario),
    IdNivel			INT	NOT NULL FOREIGN KEY REFERENCES NIVEL(IdNivel)
);

--Inserção dos dados do Banco
INSERT INTO USUARIOS VALUES
	('João Silva', 'joao@gmail.com', '123456', CAST('2026-01-15 09:30:00' AS DATETIME)),
	('Maria Souza', 'maria@gmail.com', '123456', CAST('2026-01-18 14:20:00' AS DATETIME)),
	('Carlos Lima', 'carlos@gmail.com', '123456', CAST('2026-02-02 11:45:00' AS DATETIME)),
	('Ana Paula', 'ana@gmail.com', '123456', CAST('2026-02-10 08:10:00' AS DATETIME)),
	('Lucas Rocha', 'lucas@gmail.com', '123456', CAST('2026-03-05 16:00:00' AS DATETIME));
GO

INSERT INTO NIVEL VALUES
	('Fácil', 'Operações simples'),
	('Médio', 'Operações intermediárias'),
	('Difícil', 'Operações complexas'),
	('Avançado', 'Alta complexidade'),
	('Expert', 'Nível máximo');
GO

INSERT INTO CATEGORIA VALUES
	('Adição', 'Operações de soma'),
	('Subtração', 'Operações de subtração'),
	('Multiplicação', 'Operações de multiplicação'),
	('Divisão', 'Operações de divisão'),
	('Misto', 'Operações combinadas');
GO

INSERT INTO MODELO_EXERCICIO VALUES
	('Soma Fácil', '+', 10, 1, 2, 1, 1, 1),
	('Subtração Fácil', '-', 10, 1, 2, 1, 2, 1),
	('Multiplicação Média', '*', 50, 1, 2, 1, 3, 2),
	('Divisão Difícil', '/', 100, 1, 2, 1, 4, 3),
	('Operação Mista', '+,-,*,/', 100, 1, 2, 1, 5, 4);
GO

INSERT INTO EXERCICIO_GERADO VALUES
	('2 + 3', 5, CAST('2026-03-10 10:00:00' AS DATETIME), 1),
	('5 + 4', 9, CAST('2026-03-10 10:05:00' AS DATETIME), 1),
	('7 - 2', 5, CAST('2026-03-11 09:15:00' AS DATETIME), 2),
	('10 - 6', 4, CAST('2026-03-11 09:30:00' AS DATETIME), 2),
	('6 * 3', 18, CAST('2026-03-12 14:00:00' AS DATETIME), 3),
	('8 * 4', 32, CAST('2026-03-12 14:20:00' AS DATETIME), 3),
	('20 / 5', 4, CAST('2026-03-13 11:10:00' AS DATETIME), 4),
	('15 / 3', 5, CAST('2026-03-13 11:25:00' AS DATETIME), 4),
	('3 + 5 * 2', 13, CAST('2026-03-14 15:00:00' AS DATETIME), 5),
	('10 - 2 * 3', 4, CAST('2026-03-14 15:15:00' AS DATETIME), 5);
GO

INSERT INTO RESPOSTA VALUES
	(5, 1, 10, CAST('2026-03-10 10:01:00' AS DATETIME), 1, 1),
	(9, 1, 8, CAST('2026-03-10 10:06:00' AS DATETIME), 2, 2),
	(4, 0, 12, CAST('2026-03-11 09:17:00' AS DATETIME), 1, 3),
	(4, 1, 15, CAST('2026-03-11 09:32:00' AS DATETIME), 3, 4),
	(18, 1, 20, CAST('2026-03-12 14:03:00' AS DATETIME), 2, 5),
	(30, 0, 18, CAST('2026-03-12 14:23:00' AS DATETIME), 4, 6),
	(4, 1, 9, CAST('2026-03-13 11:12:00' AS DATETIME), 5, 7),
	(6, 0, 11, CAST('2026-03-13 11:28:00' AS DATETIME), 1, 8),
	(13, 1, 14, CAST('2026-03-14 15:04:00' AS DATETIME), 3, 9),
	(5, 0, 16, CAST('2026-03-14 15:18:00' AS DATETIME), 2, 10);
GO

INSERT INTO PROGRESSO VALUES
	(3, 2, 30, 1, 1),
	(2, 3, 20, 2, 2),
	(4, 1, 40, 3, 3),
	(1, 4, 10, 4, 1),
	(5, 0, 50, 5, 2);
GO

--Consultas SQL com os dados acima
-- Consultas que retornam todas as informações das tabelas
SELECT	IdUsuario		AS	'Código do Usuário',
		Nome			AS	'Nome do Usuário',
		Email			AS	'E-mail',
		DataCadastro	AS	'Data do Cadastro'
FROM USUARIOS	
GO

SELECT	IdNivel		AS	'Código do Nível',
		Nome		AS	'Nome do Nível',
		Descricao	AS	'Descrição'
FROM NIVEL;
GO

SELECT	IdCategoria	AS	'Código da Categoria',
		Nome		AS	'Nome da Categoria',
		Descricao	AS	'Descrição'
FROM CATEGORIA;
GO

SELECT	IdModelo			AS	'Código do Modelo de Exercício',
		Nome				AS	'Nome do Modelo de Exercício',
		Operacao			AS	'Operação',
		ValorMaximo			AS	'Valor Máximo',
		ValorMinimo			AS	'Valor Mínimo',
		QuantidadeOperandos	AS	'Quantidade de Operandos',
		Ativo				AS	'Status',
		IdCategoria			AS	'Código da Categoria',
		IdNivel				AS	'Código do Nível'
FROM MODELO_EXERCICIO;
GO