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
--------------------------------------------------------------------------------------------------------------------------

--Mostra Dados (TODOS) Tabela Funcionarios (pode ser feito em linha ou formatado)
SELECT * 
FROM FUNCIONARIOS;
GO