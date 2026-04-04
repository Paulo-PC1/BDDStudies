--Cria Contexto
USE EmpresaCJ3032221;
GO


--Define Formato Data(DIA/MES/ANO) SQL Server
SET DATEFORMAT DMY;
GO
----------------------------------------
--aula 19/03

--Operador Like  e Tabelas Virtuais

--OPERADOR LIKE:
--Caracteres coringas 'A%' -> começa com o caracter, '%A%' -> tem caracter em qualquer posicao,
--'_A%' -> tem caracter na segunda posicao, '1__' -> que começa com 1 e tem 3 caracteres de comprimento,
-- '%6' -> valores que terminam com numero (6) informado, '_1%6' -> tem 1 na segunda posição e termna com 6,
--'_[O, I]%' -> começa com qualquer letra tem O ou I na segunda pos e termina com qualquer letra
--'[^T]% -> Valoer começa com qualquer caracter exeto o caracter informado (T)

--Exibe registros com nome comece com a letra citada
SELECT * FROM FUNCIONARIOS
WHERE Nome LIKE 'M%';
GO

--Funcão UPPER (converte para maiusculas para busca exibição mantem como cadastrado) 
--SQL SERVER não diferencia maiusculo de minusculo 
SELECT * FROM FUNCIONARIOS
WHERE UPPER(Nome) LIKE '%SILVA'
ORDER BY Nome;
GO

--Exibe registros sem o caracter selecionado 
SELECT * FROM FUNCIONARIOS
WHERE Nome LIKE '[^M]%'
ORDER BY Nome;
GO

--Tabela Virtual VIEW
--sintaxe criação: CREATE VIEW [nome] AS SELECT [instrução] GO
CREATE VIEW MaioresSalarios AS
	SELECT	ID			AS 'Código do Funcionario',
			Nome,
			Sexo,
			Salario		AS 'Salário'
	FROM FUNCIONARIOS;
GO

--Utilização da VIEW
--retorna todos os dados (Se usar AS 'XPTO' Colunas tem o nome do AS de acordo com o criado)
SELECT * FROM MaioresSalarios;
GO

--Retorna as Colunas de acordo com criação da VIEW
SELECT	[Código do Funcionario],
		Nome,
		Salário
FROM MaioresSalarios;
GO

--Alterar VIEW (SQL SERVER deve usar OFFSER [dislocamento] ROWS;
ALTER VIEW MaioresSalarios AS
	SELECT	ID			AS	'Código do Funcionário',
			Nome,
			Sexo		AS	'Sexo do Funcionário',
			Salario		AS	'Salário'
	FROM FUNCIONARIOS
	ORDER BY Salario DESC
	OFFSET 0 ROWS;
GO

--Usar VIEW aplicando view (Filtro nas infos q VIEW retorna)
SELECT	[Código do Funcionário],
		Nome,
		"Sexo do Funcionário",
		Salário
FROM MaioresSalarios
WHERE Salário > 1500;
GO

--Exibe infos de qualquer OBJ
EXEC sp_helptext MaioresSalarios;
GO

SELECT	TABLE_NAME			AS	'Nome da View',
		VIEW_DEFINITION		AS	'Código SQL'
FROM INFORMATION_SCHEMA.VIEWS;
GO

--Excluir VIEW
DROP VIEW MaioresSalarios;
GO

