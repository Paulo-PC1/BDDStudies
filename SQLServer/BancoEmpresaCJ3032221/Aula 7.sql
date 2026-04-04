--Cria Contexto
USE EmpresaCJ3032221;
GO


--Define Formato Data(DIA/MES/ANO) SQL Server
SET DATEFORMAT DMY;
GO
----------------------------------------
--CRIAÇAO DE TABELAS DEPENDENTES ARQ CSV IMPORTE MASSA E JUNÇÂO TABELAS
--Junção Tabelas (JOINS) 
--RELACIONAMENTo IMPLEMENTADO PELA CHAVE ESTRANGEIRA FK 
--Incerção de Dados (INSERT) importado por fonte externa como Arquivos CSV (Comma-Separated Values)
--células separadas por ',' ou '/'ou ' ' ou '/' ou';'
-------------------------------------------------

--aula 26/03

--Junção de TabelaS (JOINS)
--SELECT [CAMPOS] FROM TABELA1 [TIPO JOIN] TABELA2 ON TABELA1.PK = TABELA2.FK
--TIPOS DE JOINS (INNER E OUTER) INNER JOIN, LEFT OUTER JOIN, RIGHT OUTER JOIN, FULL OUTER JOIN, CROSS JOIN
--(INNER -> NATURAL JOIN(ORACLE), JOIN USING(ORACLE), JOIN ON/INNER JOIN...ON, THETA JOIN...ON)

--SINTAXE ANTIGA CROSS JOIN (10(LINHAS FUNCIONARIOS) X 20(LINHAS DEPENDENTES) = 200(TOTAL))
SELECT * 
FROM FUNCIONARIOS, DEPENDENTES;
GO

--SINTAXE "NOVA" CROSS JOIN (10(LINHAS FUNCIONARIOS) X 20(LINHAS DEPENDENTES) = 200(TOTAL))
SELECT * 
FROM FUNCIONARIOS CROSS JOIN DEPENDENTES;
GO

--Cross Join com utilização de alias para nomear tabelas (F, D)
SELECT	F.ID				AS 'Código do Funcionário',
		F.Nome				AS 'Nome do Funcionário',
		D.Nome				AS 'Nome do Dependente',
		D.DataNascimento	AS 'Data de Nascimento'	
FROM FUNCIONARIOS F CROSS JOIN DEPENDENTES D;
GO

--NATURAL JOIN E JOIN USING : NÃO TEM NO SQL SERVER 
SELECT * 
FROM FUNCIONARIOS NATURAL JOIN DEPENDENTES;
GO

SELECT * 
FROM FUNCIONARIOS F JOIN DEPENDENTES D
	USING F.ID;
GO

--JOIN ON 
SELECT	F.ID		AS 'Código do Funcionário',
		F.Nome		AS 'Nome do Funcionário',
		F.Salario	AS 'Salário',
		D.Nome		AS 'Nome do Dependente',
		D.ID		AS 'Código do Responsável'	
FROM FUNCIONARIOS F JOIN DEPENDENTES D
	ON F.ID = D.ID;
GO

--INNER JOIN (YEAR) -> Para recuperar dados do ano especificado
SELECT	F.ID				AS 'Código do Funcionário',
		F.Nome				AS 'Nome do Funcionário',
		F.Salario			AS 'Salário',
		D.Nome				AS 'Nome do Dependente',
		D.DataNascimento	AS 'Data de Nascimento',
		D.ID				AS 'Código do Responsável'	
FROM FUNCIONARIOS F INNER JOIN DEPENDENTES D
	ON F.ID = D.ID
WHERE YEAR(D.DataNascimento) >= 2000
ORDER BY F.Nome, D.Nome;
GO

--Novos funcionários
INSERT INTO FUNCIONARIOS VALUES
	(11,'Ana Cláudia', 'F', '12/09/2011', 4900.00, '3663-9090'),
	(12,'André Lima', 'M', '05/11/2009', 2050.00, '3664-8989'),
	(13,'Marcos Souza', 'M', '2/10/2009', 3800.00, NULL),
	(14,'Mariana Gomes', 'F', '10/11/2010', 1750.50, NULL),
	(15,'Cínthia Faria', 'F', '10/07/2016', 1750.50, '3662-1212')
GO

--LEFT OUTER JOIN ->da tabela da esquerda exibe todos os registros atrelados a da direita
SELECT	F.ID				AS 'Código do Funcionário',
		F.Nome				AS 'Nome do Funcionário',
		F.Admissao			AS 'Admissão',
		F.Salario			AS 'Salário',
		D.Nome				AS 'Nome do Dependente',
		D.DataNascimento	AS 'Data de Nascimento'	
FROM FUNCIONARIOS F LEFT OUTER JOIN DEPENDENTES D
	ON F.ID = D.ID;
GO

--LEFT OUTER JOIN de quem não tem dependente base tabela esquerda exibe
SELECT	F.ID				AS 'Código do Funcionário',
		F.Nome				AS 'Nome do Funcionário',
		F.Admissao			AS 'Admissão',
		F.Salario			AS 'Salário',
		D.Nome				AS 'Nome do Dependente',
		D.DataNascimento	AS 'Data de Nascimento'	
FROM FUNCIONARIOS F LEFT OUTER JOIN DEPENDENTES D
	ON F.ID = D.ID
WHERE D.Nome IS NULL;
GO

--RIGHT OUTER JOIN -> da tabela da direita exibe todos os registros atrelados a da esquerda
SELECT	F.ID				AS 'Código do Funcionário',
		F.Nome				AS 'Nome do Funcionário',
		F.Admissao			AS 'Admissão',
		F.Salario			AS 'Salário',
		D.Nome				AS 'Nome do Dependente',
		D.DataNascimento	AS 'Data de Nascimento'	
FROM DEPENDENTES D RIGHT OUTER JOIN FUNCIONARIOS F
	ON F.ID = D.ID;
GO

--FULL OUTER JOIN -> junta os 3 joins anteriores
SELECT	F.ID				AS 'Código do Funcionário',
		F.Nome				AS 'Nome do Funcionário',
		F.Admissao			AS 'Admissão',
		F.Salario			AS 'Salário',
		D.Nome				AS 'Nome do Dependente',
		D.DataNascimento	AS 'Data de Nascimento'	
FROM FUNCIONARIOS F FULL OUTER JOIN DEPENDENTES D 
	ON F.ID = D.ID;
GO

--total dependentes de cada funcionarios AGREGAÇÃO COUNT
--lógica incorreta
SELECT	F.ID		AS 'ID',
		F.Nome		AS 'Funcionário',
		COUNT(F.ID)	AS 'Total de Dependentes'
FROM FUNCIONARIOS F INNER JOIN DEPENDENTES D
	ON F.ID = D.ID
GROUP BY F.ID, F.Nome;
GO

--Mesmo resultado do acima mas lógica incorreta
SELECT	F.ID		AS 'ID',
		F.Nome		AS 'Funcionário',
		COUNT(F.ID)	AS 'Total de Dependentes'
FROM FUNCIONARIOS F FULL OUTER JOIN DEPENDENTES D
	ON F.ID = D.ID
GROUP BY F.ID, F.Nome;
GO

--Lógica correta
SELECT	F.ID		AS 'ID',
		F.Nome		AS 'Funcionário',
		COUNT(D.ID)	AS 'Total de Dependentes'
FROM FUNCIONARIOS F FULL OUTER JOIN DEPENDENTES D
	ON F.ID = D.ID
GROUP BY F.ID, F.Nome;
GO