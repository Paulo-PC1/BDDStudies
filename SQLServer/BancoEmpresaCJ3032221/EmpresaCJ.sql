-- Cria banco EmpresaCJ3032221

CREATE DATABASE EmpresaCJ3032221;
GO

--Cria Contexto
USE EmpresaCJ3032221;
GO

--Cria Tabela Funcionarios
CREATE TABLE FUNCIONARIOS(
	ID			INT				PRIMARY KEY,
	Nome		VARCHAR(25)		NOT NULL,
	Sexo		CHAR(1)			NULL,
	Admissao	DATE			NOT NULL,
	Salario		DECIMAL(10,2)	NOT NULL,
);
GO

--Insercao dados--

--Define Formato Data(DIA/MES/ANO) SQL Server
SET DATEFORMAT DMY;
GO

--Insere dados tabela Funcionarios Organizando as linhas
INSERT INTO FUNCIONARIOS(
	ID,
	Nome,
	Sexo,
	Admissao,
	Salario)
VALUES (1, 'Maria da Silva', 'F', '10/01/2018', 2500.00);
GO

--Inserindo dados na tabela Funcionarios caso ja esteja organizado--
INSERT INTO FUNCIONARIOS
	VALUES (2, 'Pedro Pereira', 'M', '25/05/2015', 990.00);
GO

--Inserir funcionario com mesmo identificador (PRIMARY KEY ERROR)
--INSERT INTO FUNCIONARIOS
	--VALUES (2, 'Maria Cristina', 'F', '10/09/2015', 1200.00);
--GO

--Inserir Funcionarios na tabela (em linha uma linha por vez)
INSERT INTO FUNCIONARIOS VALUES (3, 'Maria Cristina', 'F', '10/09/2015', 1200.00);
INSERT INTO FUNCIONARIOS VALUES (4, 'Antônio Carlos', 'm', '15/05/2015', 990.00);
GO

--Inserir Funcionarios na tabela (varias linhas de uma vez)
INSERT INTO FUNCIONARIOS VALUES 
	(5, 'Marcelo Augusto', 'M', '09/12/2017', 1900.00),
	(6, 'Pedro Silva', 'M', '15/11/2015', 1050.00),
	(7, 'Mônica da Silva', 'F', '12/10/2014', 3000.00),
	(8, 'Tiago Lima', 'M', '10/05/2016', 1350.50);
GO

-----------------------------------------

--aula 09/03
--apelido pode ser usado com ('') ou [] ou (""), pode ser feito tudo em uma linha só também ou como abaixo
SELECT ID      AS 'Código do Funcionário',
	   Nome,
	   Sexo,
	   Salario AS 'Salário'
FROM FUNCIONARIOS;
GO


--SELECT TOP [N° Linha] * FROM [Tabela] GO -> seleciona as 3 primeiras linhas da tabela {SQLSERVER}
SELECT TOP 3 * 
FROM FUNCIONARIOS 
GO

--seleciona no caso as 3 primeiras linhas da tabela porem puxando só as colunas pedidas[ID, Nome]
--SELECT TOP [N° Linhas] [Coluna/as] FROM [Tabela] GO
SELECT TOP 3 
	ID,
	Nome
FROM FUNCIONARIOs;
GO

--Operador de FILTRO + COMPARAÇÃO 
--SELECT [*] FROM [Tabela] WHERE condição de filtro GO
SELECT * FROM FUNCIONARIOS
WHERE Sexo = 'M' AND
	  Salario > 1000;
GO

--Insere Dados na tabela 
INSERT INTO FUNCIONARIOS VALUES
	(9, 'Maria Cristina', 'F', '21/09/2012', 1700.00),
	(10, 'Maria Cristina', 'F', '10/10/2017', 1400.00);
GO

--Seleciona Funcioinarios ordenados por Ordem alfabetica (A-Z) pelo parametro Nome e o comando ORDER BY
SELECT * FROM FUNCIONARIOS
ORDER BY Nome DESC; -- ASC é Padrão mas pode ser utilizado ASC -> Acendente/ DESC -> Decrecente
GO

--Consulta Por Nome ordem decrescente (Z-A) em caso empate no nome exibe o Maior salario primeiro
SELECT * FROM FUNCIONARIOS
WHERE Salario < 3000
ORDER BY Nome,
		 Salario DESC;
GO

--Uso de Restrições
CREATE TABLE CLIENTES (
	ID		INT				PRIMARY KEY,
	Nome	VARCHAR(50)		NOT NULL,
	Sexo	CHAR(1)			NULL,
	Idade	INT				NOT NULL CHECK (Idade > 18),
	CPF		CHAR(11)		NOT NULL UNIQUE,
	Email	VARCHAR(200)	NOT NULL DEFAULT 'meu@email.com'
);
GO

--ALT + F1 e  comando sp_help
EXEC sp_help 'CLIENTES';
GO
----------------------------------------------------------------
--aula 12/03

--Tabelas Temporárias (obj. temp) usa #-> local ou ##-> global
--MYSQL CREATE TEMPORARY TABLE [Nome tabela] etc..

--Tabela Temporária LOCAL
CREATE TABLE #TabelaA (
	ID		INT			NOT NULL,
	Nome	VARCHAR(25) NOT NULL,
	Sexo	CHAR(1)		NULL,
	PRIMARY KEY (ID) --outra maneira de add restriçao(no caso a chave primaria)
);
GO

--Insere valore tabela Temporaria
INSERT INTO #TabelaA VALUES
	(1, 'Marcelo Augusto', 'M'),
	(2, 'Maria Cristina', 'F');
GO

--Exibe registros das tabelas Local (não funciona em outra query(consulta)
SELECT * FROM #TabelaA;
GO

--tabela temporária GLOBAL 
CREATE TABLE ##TabelaB (
	ID		INT			NOT NULL,
	Nome	VARCHAR(25) NOT NULL,
	Sexo	CHAR(1)		NULL,
	PRIMARY KEY (ID) --outra maneira de add restriçao(no caso a chave primaria)
);
GO

--Insere valore tabela Temporaria
INSERT INTO ##TabelaB VALUES
	(1, 'Marcelo Augusto', 'M'),
	(2, 'Maria Cristina', 'F');
GO

--Exibe registros das tabelas Global(em outra query(consulta))
SELECT * FROM ##TabelaB;
GO

--copiando valores de uma tabela para outra (ou deve ser 2 tabelas iguais (estruturas iguais) FORMA 1
--INSERT INTO [Tabela]
--SELECT [Colunas ou *]
--FROM [Tabela destino]
--WHERE [Condição]
--GO

INSERT INTO #TabelaA
SELECT	ID,
		Nome,
		Sexo
FROM FUNCIONARIOS
WHERE ID > 2;
GO

--Exibir restrições tabelas temporarias locais (forma 1)
SELECT CONSTRAINT_CATALOG	AS 'Banco de Dados',
       TABLE_NAME			AS 'Tabela',
	   CONSTRAINT_TYPE		AS 'Tipo de Restrição',
	   CONSTRAINT_NAME		AS 'Nome da Restrição'
FROM tempdb.INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_NAME LIKE '#TabelaA%';
GO

--FORMA 2 (Não cria restrições)
--SELECT [Colunas]
--INTO [Nova TAbela]
--FROM [Tabela Origem]

SELECT *
	INTO FuncionariosCOPIA
FROM FUNCIONARIOS;
GO

SELECT * FROM FuncionariosCOPIA;
GO

--Infos da estrutura da tabela
SELECT TABLE_CATALOG	AS 'Banco de Dados',
	   TABLE_NAME		AS 'Tabela',
	   ORDINAL_POSITION AS 'Posição',
	   COLUMN_NAME		AS 'Coluna',
	   DATA_TYPE		AS 'Tipo de Dados',
	   COLLATION_NAME	AS 'Idioma da Coluna',
	   IS_NULLABLE		AS 'Aceita Nulo?'
FROM INFORMATION_SCHEMA. COLUMNS
WHERE TABLE_NAME = 'FuncionariosCOPIA';
GO
--retorna apenas a tabela que contem restrições
SELECT CONSTRAINT_CATALOG	AS 'Banco de Dados',
	   TABLE_NAME			AS 'Tabela',
	   CONSTRAINT_TYPE		AS 'Tipo da Restrição',
	   CONSTRAINT_NAME		AS 'Nome da Restrição'
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_NAME IN ('FUNCIONARIOS', 'FuncionariosCOPIA');
GO

--se for criar sem ser nomeada CONSTRAINT pk_id (nome gerado automáticamente)
ALTER TABLE FuncionariosCOPIA
	ADD CONSTRAINT pk_id PRIMARY KEY (ID);
GO

SELECT create_date AS 'Data de Criação',
	   name			AS 'Nome da Tabela'
FROM sys.tables;
GO

--------------------------------------------------------------------------------------------------------------------------
--Modificar/Adicionar/Remover Dados na Tabela [MODIFY -> geral] [SQLSERVER-> ALTER COLUMN] [DROP] [DROP COLUMN]
--e Adicionar [RESTRIÇÕES ADD] [Restrição nomeada ADD CONSTRAINT] P/ remover DROP CONSTRAINT [nome restrição]


--Tabela teste
CREATE TABLE TESTE (
	ID		INT,
	Nome	CHAR(10)
);
GO

--Exibe estrutura tabela (SQLSERVER) (DESRIBE TABLE MYSQL)
EXEC sp_columns TESTE;
GO

--OUTRA FORMA
SELECT * 
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'TESTE';
GO

-- Exibe INFOS Específicas
SELECT TABLE_CATALOG	AS 'Banco de Dados',
	   TABLE_NAME		AS 'Tabela',
	   ORDINAL_POSITION AS 'Posição',
	   COLUMN_NAME		AS 'Coluna',
	   DATA_TYPE		AS 'Tipo de Dados',
	   COLLATION_NAME	AS 'Idioma da Coluna',
	   IS_NULLABLE		AS 'Aceita Nulo?'
FROM INFORMATION_SCHEMA. COLUMNS
WHERE TABLE_NAME = 'TESTE';
GO

--Alterar estrutura da tabela de teste 
ALTER TABLE TESTE
	ALTER COLUMN Nome CHAR(50);
GO

--Adicionar
ALTER TABLE TESTE
	ADD Sexo CHAR(1) NULL;
GO

ALTER TABLE TESTE
	ADD DataNascimento	DATE,
		Peso			DECIMAL(5,2);		    
GO

--Remoção
ALTER TABLE TESTE
	DROP COLUMN DataNascimento;
GO

--Adicona Restição (no caso Unica) para a coluna
ALTER TABLE TESTE
	ADD UNIQUE (Sexo);
GO

--Coluna 'X' tira restrição para nao nula
ALTER TABLE TESTE
	ALTER COLUMN ID INT NOT NULL;
GO

--Restição NOMEADA tipo chave primaria
ALTER TABLE TESTE
	ADD CONSTRAINT pk_id PRIMARY KEY (ID);
GO

--exibe info das restições
EXEC sp_helpconstraint TESTE;
GO

--OUTRA FORMA
SELECT CONSTRAINT_CATALOG	AS 'Banco de Dados',
	   TABLE_NAME			AS 'Tabela',
	   CONSTRAINT_TYPE		AS 'Tipo da Restrição',
	   CONSTRAINT_NAME		AS 'Nome da Restrição'
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_NAME = 'TESTE';
GO

--Remover restrição nomeada
ALTER TABLE TESTE
	DROP CONSTRAINT pk_id;
GO

--Excluir tabela 
DROP TABLE TESTE;
GO
--------------------------------------------------------------------------------------------------------------------------

--Mostra Dados (TODOS) Tabela Funcionarios (pode ser feito em linha ou formatado)
SELECT * 
FROM FUNCIONARIOS;
GO