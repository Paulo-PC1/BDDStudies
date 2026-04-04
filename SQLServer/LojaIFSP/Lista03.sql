-----------------------------
--Exercicios Lista 03
----------------------------

--Cria o banco de dados ou haabilina seu contexto
IF DB_ID (N'LojaIFSPCJ3032221') IS NULL
	CREATE DATABASE LojaIFSPCJ3032221;
ELSE
	USE LojaIFSPCJ3032221;
GO

--Exibe a data de criação e o nome das tabelas 
--que existem no banco de dados em uso
SELECT create_date AS 'Data de Criação',
       name        AS 'Nome da Tabela'
FROM sys.tables;
GO

--Exibe informações sobre a estrutura da tabela
SELECT	TABLE_CATALOG		AS	'Banco de Dados',
		TABLE_NAME			AS	'Tabela',
		ORDINAL_POSITION	AS	'Posição',
		COLUMN_NAME			AS	'Coluna',
		DATA_TYPE			AS	'Tipo de Dados',
		COLLATION_NAME		AS	'Idioma da Coluna',
		IS_NULLABLE			AS	'Aceita Nulo?'
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'CLIENTES';
GO

--Exibe todos os registros da tabela CLIENTES
SELECT * FROM CLIENTES;
GO

--01 alterar estrutura tabela CLIENTES Add campos DDD(CHAR(2)) e Telefone(CHAR(10))
ALTER TABLE CLIENTES
	ADD	DDD			CHAR(2),
		Telefone	CHAR(10);
GO

--02 atualizar registros dos clientes conforme Fig.3
UPDATE CLIENTES SET DDD = '12', Telefone = '3664-5060'	WHERE ID = 1;
UPDATE CLIENTES SET DDD = '12', Telefone = '3664-8090'	WHERE ID = 2;
UPDATE CLIENTES SET DDD = '12', Telefone = '3663-1070'	WHERE ID = 3;
UPDATE CLIENTES SET DDD = NULL, Telefone = NULL			WHERE ID = 4;
UPDATE CLIENTES SET DDD = '12', Telefone = '3664-6070'	WHERE ID = 5;
UPDATE CLIENTES SET DDD = NULL, Telefone = NULL			WHERE ID = 6;
UPDATE CLIENTES SET DDD = '12', Telefone = '98790-6070'	WHERE ID = 7;
UPDATE CLIENTES SET DDD = NULL, Telefone = NULL			WHERE ID = 8;
UPDATE CLIENTES SET DDD = '12', Telefone = '97070-6070'	WHERE ID = 9;
UPDATE CLIENTES SET DDD = NULL, Telefone = NULL			WHERE ID = 10;
UPDATE CLIENTES SET DDD = NULL, Telefone = NULL			WHERE ID = 11;
UPDATE CLIENTES SET DDD = '11', Telefone = '99555-0001'	WHERE ID = 12;
UPDATE CLIENTES SET DDD = '11', Telefone = '97890-1010'	WHERE ID = 13;
UPDATE CLIENTES SET DDD = NULL, Telefone = NULL			WHERE ID = 14;
UPDATE CLIENTES SET DDD = NULL, Telefone = '98888-0102'	WHERE ID = 15;
GO

--03 consulta para copiar dados da tabela CLIENTES para tapela temporária global(##) clientesCOPIA, alterar estrutura da tebela add restrição nomeada PRIMARY KEY coluna ID
--e consulta para exibir todas as restriçoes
SELECT *
	INTO clientesCOPIA
FROM CLIENTES;
GO

ALTER TABLE clientesCOPIA
	ADD CONSTRAINT pk_id PRIMARY KEY (ID);
GO

SELECT CONSTRAINT_CATALOG	AS 'Banco de Dados',
	   TABLE_NAME			AS 'Tabela',
	   CONSTRAINT_TYPE		AS 'Tipo da Restrição',
	   CONSTRAINT_NAME		AS 'Nome da Restrição'
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_NAME IN ('CLIENTES', 'clientesCOPIA');
GO

--04 consulta para copiar dados da tabela CLIENTES para tabela CLIENTES2, a tabela deve conter apenas registros de clientes com telefone cadastrado
SELECT *
	INTO CLIENTES2
FROM CLIENTES
WHERE Telefone IS NOT NULL;
GO

--05 Consulta para remover registros de clientes com telefone sem DDD ou DDD = 11
SELECT * FROM CLIENTES2; -- ANTES
GO

DELETE FROM CLIENTES2
WHERE	DDD = '11' OR DDD IS NULL;
GO

SELECT * FROM CLIENTES2; -- DEPOIS
GO

--06 consulta para excluir usando TRUNCATE 
TRUNCATE TABLE CLIENTES2;
GO

--07 consulta para excluir tabela CLIENTES2
DROP TABLE CLIENTES2;
GO

--08 consulta para atualizar dados do cliente (Fernanda Pereira), atualizar e-mail(fernanda.pereira@uol.com.br) e DDD(15) e exibir conteudo da tabela atualizado
UPDATE CLIENTES SET Email = 'fernanda.pereira@uol.com.br'	WHERE Nome = 'Fernanda Pereira';
UPDATE CLIENTES SET DDD = '15'	WHERE Nome = 'Fernanda Pereira';
GO

SELECT * FROM CLIENTES;
GO

--09 consulta para exibir registros de clientes com idade < 40 ordenando do mais velho para o masi novo exibir ID, nome, sexo, idade, DDD, telefone.
SELECT	ID,
		Nome,
		Sexo,
		Idade,
		DDD,
		Telefone
FROM CLIENTES
WHERE Idade > 40
ORDER BY Idade DESC;
GO

--10 todos clientes que tem email padrão ou sem numero de telefone cadastrado, ordenado por nome, alias para exibir e-mail e DDD, exibir ID, nome, DDD, telefone.
SELECT	ID,
		Nome,
		Email	AS	'E-mail',
		DDD		AS 'Código de Área',
		Telefone	
FROM CLIENTES
WHERE	Email = 'meu@email.com' OR 
		Telefone IS NULL
ORDER BY Nome;
GO

--11 consulta clientes sexo Masculino(M), idade entre 20 e 50, ordenado por cliente mais novo e nome, aliase para exibir email, exibir ID, nome, sexo, idade, email
SELECT	ID,
		Nome,
		Sexo,
		Idade,
		Email	AS 'E-mail'
FROM CLIENTES
WHERE	Sexo = 'M' AND 
		Idade BETWEEN 20 AND 50
ORDER BY Idade ASC,
		 Nome;
GO