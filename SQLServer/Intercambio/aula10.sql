-- Habilita o contexto do banco de dados INTERCAMBIO
USE INTERCAMBIOCJ3032221;
GO
--
--Mais Uso de Funções de data
--
--Declara variavel (para data atual)
DECLARE @data DATETIME

--Atribui o valor (data atual)
SET @data = GETDATE();

--Exibe infos (data atual)
SELECT	@data					AS	'Data Atual',
		DATEPART(DAY, @data)	AS	'Dia do Mês',
		DATENAME(DW, @data)		AS	'Dia da Semana',	
		DATEPART(MONTH, @data)	AS	'Mês',
		DATENAME(MONTH, @data)	AS	'Nome do Mês',
		DATEPART(YEAR, @data)	AS	'Ano';
GO

--Declara variavel (para data atual)
DECLARE @data DATETIME

--Atribui o valor (data atual)
SET @data = GETDATE();

--Exibe infos (data atual)
SELECT	@data					AS	'Data Atual',
		DATENAME(DW, @data)		AS	'Dia da Semana',
		DATENAME(WK, @data)		AS	'Semana do Ano',	
		DATENAME(M, @data)		AS	'Nome do Mês',
		DATENAME(D, @data)		AS	'Dia do Mês',
		DATENAME(DY, @data)		AS	'Dia do Ano';
GO

--Altera idioma da sessão para Português Brasil
SET LANGUAGE Brazilian;
GO

--Declara variavel para data
DECLARE @data DATETIME;

--Atribui o valor da data
SET @data = GETDATE();

--Exibe o idioma, dia semana e nome mês
SELECT	@@LANGUAGE			AS 'Idioma',
		DATENAME(DW, @data)	AS 'Dia da Semana',
		DATENAME(M, @data)	AS 'Nome do Mês';
GO

--RETORNA VÁLIDO
--Altera o formato data/hora DMY
SET DATEFORMAT DMY;
GO

--Utiliza ISDATE e IF-ELSE verificar data
IF ISDATE('20/01/2015 00:10:50:000') = 1
	PRINT 'Data válida!';
ELSE
	PRINT 'Data inválida!';
GO

--RETORNA INVÁLIDO
--Altera o formato data/hora MDY
SET DATEFORMAT MDY;
GO

--Utiliza ISDATE e IF-ELSE verificar data
IF ISDATE('20/01/2015 00:10:50:000') = 1
	PRINT 'Data válida!';
ELSE
	PRINT 'Data inválida!';
GO

--Retorna para os valores padrões
SET LANGUAGE us_english;
SET DATEFORMAT MDY;
GO
--Ingles Americano

--Funções que manipulam o código ASCII e Unicode
SELECT	ASCII('A')							AS	'ASCII: A',
		UNICODE('A')						AS	'ASCII: A',
		CHAR(65)							AS	'CHAR: 65',
		NCHAR(65)							AS	'NCHAR: 65',
		ASCII(N'私')							AS	'ASCII: 私',
		UNICODE(N'私')						AS	'UNICODE: 私',
		CHAR(31169)							AS	'CHAR: 31169',
		NCHAR(31169)						AS	'NCHAR: 31169',
		CHARINDEX('S', 'Microsoft SQL')		AS	'CHARINDEX: S',
		CHARINDEX('SQL', 'Microsoft SQL')	AS	'CHARINDEX: SQL';
GO

--Demonstra utilização SPACE, QUOTENAME, STR, LEN
SELECT	'Paulo' + 'Cezar'				AS	'SPACE 1',
		'Paulo' + ' ' + 'Cezar'			AS	'SPACE 2',
		'Paulo' + SPACE(10) +  'Cezar'	AS	'SPACE 3',
		QUOTENAME('Paulo Cezar', '{')	AS 'QUOTENAME 1',
		QUOTENAME('Paulo Cezar', '"')	AS 'QUOTENAME 2',
		QUOTENAME('Paulo Cezar', '[')	AS 'QUOTENAME 3',
		STR(100)						AS 'STR 1',
		STR(100.0)						AS 'STR 2',
		STR(100.45, 6, 2)				AS 'STR 3',
		LEN('Paulo Cezar')				AS 'LEN 1';
GO

--Utilização PATINDEX
SELECT	PATINDEX('soft', 'Microsoft SQL')	AS 'PATINDEX 1',
		PATINDEX('%soft%', 'Microsoft SQL')	AS 'PATINDEX 2';
GO

--Utilização SOUNDEX e DIFFERENCE
SELECT	SOUNDEX('Paulo')			AS	'SOUNDEX: Paulo',
		SOUNDEX('Paul')			AS	'SOUNDEX: Paul',
		SOUNDEX('Cris')			AS	'SOUNDEX: Cris',
		DIFFERENCE('Paulo', 'Paul')	AS	'DIFF 1',
		DIFFERENCE('Paulo', 'Cris')	AS	'DIFF 2';
GO

--Data em vários Idiomas
DECLARE @d	DATETIME = GETDATE();

SELECT	FORMAT(@d, 'D', 'en-US')	AS	'Inglês Americano',
		FORMAT(@d, 'D', 'en-gb')	AS	'Inglês Britânico',
		FORMAT(@d, 'D', 'de-de')	AS	'Alemão',
		FORMAT(@d, 'D', 'zh-ch')	AS	'Chinês Simplificado',
		FORMAT(@d, 'D', 'pt-br')	AS	'Português Brasileiro';
GO

--Exemplo com data de nascimento Tabela ALUNOS
SELECT	NomeAluno	AS	'Nome do Aluno',
		DataNasc	AS	'Data de Nascimento',
		FORMAT(DataNasc,	'D', 'pt-br')	AS	'Data de Nascimento'
FROM ALUNOS;
GO

--Utilização de CONCAT, STUFF, REVERSE, REPLICATE
SELECT	CONCAT('Paulo', 'Cezar')								AS	'Concat',
		CONCAT('Rua ', 'João XXIII, ', '15', ' - São Paulo')	AS	'Endereço',
		STUFF('Paulo Cezar', 2, 1,	'TEXTO')					AS	'STUFF',
		REVERSE('Paulo Cezar')									AS	'REVERSE',
		REPLICATE(' * ', 10)									AS	'REPLICATE 1',
		'Paulo' + REPLICATE('.', 5) + ': ' + '6666-6666'		AS	'REPLICATE 2';
GO

--Altera Idioma
SET LANGUAGE Brazilian;
GO

--Exibe data Nasc ALUNOS
SELECT	NomeAluno								AS 'Nome do Aluno',
		DATEPART(DAY, DataNasc)					AS 'Dia',
		DATENAME(DW, DataNasc)					AS 'Dia da Semana',
		DATENAME(M, DataNasc)					AS 'Nome do Mês',
		DATEPART(YEAR, DataNasc)				AS 'Ano',
		CONCAT(DATENAME(DW, DataNasc), ', ',
			   DATEPART(DAY, DataNasc), ' de ',
			   DATENAME(M, DataNasc), ' de ',
			   DATEPART (YEAR, DataNasc), '.')	AS 'Data de Nascimento'
FROM ALUNOS;
GO