-- Habilita o contexto do banco de dados INTERCAMBIO
USE INTERCAMBIOCJ3032221;
GO

--Formato de Data
SET DATEFORMAT MDY;
GO

--Aula dia 13/04
-----
--Continuação funçoes e procedure
-----

--Demosntra uso de SUBSTRING, LEFT, RIGHT, LOWER, UPPER, LTRIM e RTRIM
SELECT	NomeAluno					AS	'Nome do aluno',	
		SUBSTRING(NomeAluno, 1, 1)	AS	'Inicial',
		LOWER(NomeAluno)			AS	'Nome em minúsculas',
		UPPER(NomeAluno)			AS	'Nome em maiúsculas',
		LEN(NomeAluno)				AS	'Qtd caracteres',
		LEFT(NomeAluno, 3)			AS	'LEFT',
		RIGHT(NomeAluno, 3)			AS	'RIGHT',
		RIGHT(RTRIM(NomeAluno), 3)	AS	'RTRIM',
		'	 ' + NomeAluno			AS	'LTRIM 1',
		LTRIM('    ' + NomeAluno)	AS	'LTRIM 2'
FROM ALUNOS;
GO

--CAST, CONVERT, PARSE[TRY_{CAST, CONVERT, PARSE}]

--Exemplo CAST e CONVERT
DECLARE	@valor	AS	DECIMAL(5, 2) = 156.90;

SELECT	CAST(@valor	AS	CHAR(20))		AS	'CAST',
		CONVERT(DECIMAL(10, 5), @valor)	AS 'CONVERT';
GO

--OUTRO EXEMPLO
DECLARE	@valor	AS	DECIMAL(5, 2) = 156.90;

SELECT	CAST(@valor	AS	CHAR(20))		AS	'CAST 1',
		CAST(@valor	AS	DECIMAL(10, 3))	AS	'CAST 2',
		CONVERT(CHAR(10), @valor)		AS	'CONVERT 1',
		CONVERT(DECIMAL(10, 5), @valor)	AS	'CONVERT 2';
GO

--EXEMPLO USANDO DATA
DECLARE	@data	AS	DATE = '01/25/2024';

SELECT	CAST(@data	AS	CHAR(20))			AS	'CAST (Padrão)',
		CONVERT(CHAR(20), @data)			AS	'CONVERT (Padrão)',
		CONVERT(CHAR(20), @data, 101)		AS	'EUA (mm/dd/aaaa)',
		CONVERT(CHAR(20), @data, 103)		AS	'Brasil (dd/mm/aaaa)',
		CONVERT(CHAR(20), @data, 111)		AS	'Japão (aaa/mm/dd)';
GO

--Uso de PARSE converter data e dinheiro
SELECT	PARSE('Quinta-feira, 25 de janeiro de 2024'	AS	DATE USING 'pt-BR')	AS	'Data Brasileira',
		PARSE('Thursday, 25 January 2024'	AS	DATE USING 'en-US')	AS	'Data Americana',
		PARSE('01/25/2024'	AS	DATETIME2)	AS	'Data Padrão',
		PARSE('R$ 345,98'	AS	MONEY USING 'pt-BR')	AS	'Dinheiro Brasileiro',
		PARSE('$ 345.98'	AS	MONEY USING 'en-US')	AS	'Dinheiro Americano',
		PARSE('¥ 345.98'	AS	MONEY USING 'jp-JP')	AS	'Dinheiro Japonês';		
GO

--Exemplo com TRY
DECLARE	@data	AS	CHAR(10) = '25/01/2024';

SELECT	TRY_CAST(@data	AS	DATE)	AS	'TRY CAST',
		TRY_CONVERT(DATE, @data, 103)	AS	'TRY CONVERT 1 Brasil (dd/mm/aaa)',
		TRY_CONVERT(DATE, @data, 101)	AS	'TRY CONVERT 2 EUA (mm/dd/aaa)',
		TRY_PARSE(@data	AS	DATE)	AS	'TRY PARSE';
GO
