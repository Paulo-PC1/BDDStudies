--Cria Contexto
USE EmpresaCJ3032221;
GO


--Define Formato Data(DIA/MES/ANO) SQL Server
SET DATEFORMAT DMY;
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
-----------------------------------------------------------------
--Mostra Dados (TODOS) Tabela Funcionarios (pode ser feito em linha ou formatado)
SELECT * 
FROM FUNCIONARIOS;
GO