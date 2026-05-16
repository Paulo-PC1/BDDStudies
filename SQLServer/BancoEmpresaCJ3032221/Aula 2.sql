--Cria Contexto
USE EmpresaCJ3032221;
GO


--Define Formato Data(DIA/MES/ANO) SQL Server
SET DATEFORMAT DMY;
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

--Mostra Dados (TODOS) Tabela Funcionarios (pode ser feito em linha ou formatado)
SELECT * 
FROM FUNCIONARIOS;
GO