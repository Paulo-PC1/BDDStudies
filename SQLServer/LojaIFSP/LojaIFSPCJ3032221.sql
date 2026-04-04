--------------------------------
--Cria o Banco de Dados LojaIFSP
--------------------------------

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

--Cria a tabela para armazenar os clientes
--Obsereve a maneira como são criadas as restições 
CREATE TABLE CLIENTES (
	ID		INT PRIMARY KEY,
	Nome	VARCHAR(50)	NOT NULL,
	Sexo	CHAR(1)	NULL,
	Idade	INT CHECK ( Idade > 18) NOT NULL,
	CPF		CHAR(11) UNIQUE NOT NULL,
	Email VARCHAR(200) DEFAULT 'meu@email.com' NOT NULL
);
GO

---------------------------------------------------
--Verifica a inserção dos registros com restrições
---------------------------------------------------

--OK, registro inserido normalmente
INSERT INTO CLIENTES VALUES
	(1, 'Ana Cristina', 'F', '20', '11111111111', 'ana@gmail.com');
GO

--Erro, devido ao valor repetido da chave primaria
INSERT INTO CLIENTES VALUES
	(1, 'Marcos Paulo', 'M', '45', '22222222222', 'marcos@gmail.com');
GO

--Erro, devido ao valor da idade ser menor do que 18
INSERT INTO CLIENTES VALUES
	(3, 'André Luís', 'M', '15', '33333333333', 'andre@gmail.com');
GO

--OK, registro inserido normalmente
INSERT INTO CLIENTES VALUES
	(4, 'Maria Clara', NULL, '22', '44444444444', 'maria@gmail.com');
GO

--Erro, devido ao valor repetido de CPF
INSERT INTO CLIENTES VALUES
	(5, 'Pedro Augusto', 'M', '45', '11111111111', 'pedro@gmail.com');
GO

--Erro, devido ao valor repetido de CPF ser nulo
INSERT INTO CLIENTES VALUES
	(6, 'Ricardo Lima', 'M', '52', NULL, 'ricardo@gmail.com');
GO

--Erro, devido ao valor de chave primária ser nulo
INSERT INTO CLIENTES VALUES
	(NULL, 'José Pereira', 'M', '45', '77777777777', 'marcos@gmail.com');
GO

--Erro, devido ao total de caracteres do Sexo
INSERT INTO CLIENTES VALUES
	(8, 'Marcelo Souza', 'Masculino', '56', '88888888888', 'marcelo@gmail.com');
GO

--Maneira de inserir campos com valor DEFAULT
INSERT INTO CLIENTES  (ID,Nome, Sexo, Idade, CPF)
	VALUES (9, 'Daphne Lima', 'F', '32', '99999999999');
GO

--Exibe todos os registros da tabela CLIENTES
SELECT * FROM CLIENTES;
GO

--Insere os registros, corrigindo os erros
INSERT INTO CLIENTES VALUES
	(2,'Marcos Paulo', 'M', '45', '22222222222', 'marcos@gmail.com'),
	(3,'Andé Luís', 'M', '25', '33333333333', 'andre@gmail.com'),
	(5,'Pedro Augusto', 'M', '45', '55555555555', 'pedro@gmail.com'),
	(6,'Ricardo Lima', 'M', '52', '66666666666', 'ricardo@gmail.com'),
	(7,'José Pereira', 'M', '45', '77777777777', 'marcos@gmail.com'),
	(8,'Marcelo Souzaz', 'M', '56', '88888888888', 'marcelo@gmail.com'),
	(10,'Sheila Pereira', NULL, '21', '10101010101', 'sheila@yahoo.com.br'),
	(11,'Tiago Augusto', NULL, '70', '20202020202', 'tiago@yahoo.com.br'),
	(12,'Maria Pereira', 'F', '45', '30303030303', 'maria@bol.com.br')
GO

--Insere is registros dos clientes sem e-mail
INSERT INTO CLIENTES (ID, Nome, Sexo, Idade, CPF)
	VALUES
		(13,'Lucas Silva','M','19','40404040404'),
		(14,'Benedito Silva',NULL,'44','50505050505'),
		(15,'Fernanda Pereira','F','31','60606060606')
GO

--Exibe todos os registros da tabela CLIENTES
SELECT * FROM CLIENTES;
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

--Exibe informações sobre as restrições da tabela
SELECT	CONSTRAINT_CATALOG	AS	'Banco de Dados',
		TABLE_NAME			AS	'Tabela',
		CONSTRAINT_TYPE		AS	'Tipo de Restrição',
		CONSTRAINT_NAME		AS	'Nome da Restrição'
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_NAME = 'CLIENTES';
GO

--Verifica a estrutura da tabela, utilizando o 
--comando sp_help 'CLIENTES'
EXEC sp_help 'CLIENTES';
GO

---------------------------------------
--EXERCICIOS

--01 Exibir todos os registros
SELECT * FROM CLIENTES;
GO

--02 Exibir todos os registros de acordo com nome
SELECT * FROM CLIENTES
ORDER BY Nome ASC;
GO

--03 Exibir todos os registros de acordo com idade
SELECT * FROM CLIENTES
ORDER BY Idade ASC;
GO

--04 Exibir todos os registros de acordo com idade (mais velhos primeiro)
SELECT * FROM CLIENTES
ORDER BY Idade DESC;
GO

--05 Exibir todos os registros de acordo com sexo e idade (sexo masculino primeiro)
SELECT * FROM CLIENTES
ORDER BY Sexo DESC, Idade;
GO

--06 Exibir todos os clientes cadastrados mas apenas o Nome, Idade e Email
SELECT	Nome,
		Idade,
		Email
FROM CLIENTES;
GO

--07 Exibir todos os clientes cadastrados mas apenas o Nome, Idade e Email(ordenado pelo nome)
SELECT	Nome,
		Idade,
		Email
FROM CLIENTES
ORDER BY Nome;
GO

--08 Exibir todos os clientes cadastrados mas apenas o ID, Nome, Idade e Email(onde o ID é maior ou igual a 10)
SELECT	ID		AS 'Código do Cliente',
		Nome,
		Idade,
		Email
FROM CLIENTES
WHERE ID >= 10;
GO

--09 Exibir todos os registros cadastrados ordenando por Nome retornado os 1° 5 registros exibindo apelas o ID, Nome, Idade e e-mail.
SELECT	TOP 5	
		ID		AS 'Código do Cliente',
		Nome,
		Idade,
		Email
FROM CLIENTES
ORDER BY Nome;
GO

--10 Exibir todos os clientes cadastrados que possuem masi de 30 anos ordenando pelo Nome exibindo ID, Nome, Sexo, Idade e E-mail que sejam do Seco Masculino
SELECT	ID		AS 'Código do Cliente',
		Nome,
		Sexo,
		Idade,
		Email	AS 'E-mail'
FROM CLIENTES
WHERE	Idade	> 30 AND Sexo	= 'M'
ORDER BY Nome;
GO
