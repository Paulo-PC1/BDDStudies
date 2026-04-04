-----------------------------
--Exercicios Lista 02
----------------------------

--Cria o banco de dados ou haabilina seu contexto
IF DB_ID (N'LojaIFSPCJ3032221') IS NULL
	CREATE DATABASE LojaIFSPCJ3032221;
ELSE
	USE LojaIFSPCJ3032221;
GO

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
