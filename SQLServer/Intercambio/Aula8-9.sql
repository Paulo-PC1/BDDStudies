-- Habilita o contexto do banco de dados INTERCAMBIO
USE INTERCAMBIOCJ3032221;
GO

--Funções matemáticas
SELECT '3.1415'			AS	'PI',
		PI()			AS	'PI',
		ABS(-3.1415)	AS	'ABS',
		CEILING(3.1415)	AS	'CEILING',
		FLOOR(3.1415)	AS	'FLOOR',
		EXP(1.0)		AS	'EXP',
		POWER(2, 3.0)	AS	'POWER',
		RAND(5)			AS	'RAND',
		SQRT(100)		AS	'SQRT',
		SIGN(-1)		AS	'SIGN',
		SQUARE(3)		AS	'SQUARE';
GO

--Exibe informações sobre o valor das viagens dos alunos
SELECT	V.CodViagem				 AS	'Código da Viagem',
		A.NomeAluno				 AS	'Nome do Aluno',
		V.Valor					 AS	'Preço da Viagem',
		V.Valor * 0.05			 AS	'Desconto de 5%',
		V.Valor	* 0.95			 AS	'Total a Pagar',
		ROUND(V.Valor * 0.95, 1) AS 'Total a Pagar (ROUND)'
FROM VIAGENS V INNER JOIN ALUNOS A ON V.CodViagem = A.CodViagem;
GO

--Exemplo de funções com precisão superior e inferior
SELECT	SYSDATETIME()			AS	'SYSDATETIME',
		SYSDATETIMEOFFSET()		AS	'SYSDATETIMEOFFSET',
		SYSUTCDATETIME()		AS	'SYSUTCDATETIME',
		CURRENT_TIMESTAMP		AS	'CURRENT_TIMESTAMP',
		GETDATE()				AS	'GETDATE',
		GETUTCDATE()			AS	'GETUTCDATE';
GO

--Exemplo de funções que obtêm a parte de uma data
SELECT	CodAluno						AS	'Código',
		DataNasc						AS	'Data de Nascimento',
		DAY(DataNasc)					AS	'Dia do Nascimento',
		MONTH(DataNasc)					AS	'Mês do Nascimento',
		YEAR(DataNasc)					AS	'Ano do Nascimento',
		DATEPART(WEEK, DataNasc)		AS	'Semana do Nascimento',
		DATEPART(WEEKDAY, DataNasc)		AS	'Dia da Semana do Nascimento'
FROM ALUNOS;
GO

--Declaração de variáveis em T-SQL
DECLARE	@dia	AS	INT,
		@mes	AS	CHAR(20),
		@ano	AS	INT,
		@data1	AS	DATE,
		@data2	AS	DATETIME;

--Atribui valores
SET @dia =	DAY(GETDATE());
SET	@mes =	MONTH(GETDATE());
SET	@ano =	YEAR(GETDATE());
SET	@data1 = DATEFROMPARTS(@ano, @mes, @dia);
SET	@data2 = DATETIMEFROMPARTS(@ano, @mes, @dia, 0, 0, 0, 0);

SELECT	@dia	AS 'Dia',
		@mes	AS 'MêS',
		@ano	AS 'Ano',
		@data1	AS 'Data 1',
		@data2	AS 'Data 2';
GO

--Declara 2 datas
DECLARE	@data1	AS DATE,
		@data2	AS DATE;

--Altera o formato de exibição da data 
SET DATEFORMAT DMY;

--Atribui valores
SET	@data1 = '01/01/2024';
SET	@data2 = GETDATE();

--Utiliza DATEDIFF para calcular a diferença entre as datas
SELECT	@data1							AS	'Data Inicial',
		@data2							AS	'Data de Hoje',
		DATEDIFF(DAY, @data1, @data2)	AS	'Qtd. Dias',
		DATEDIFF(MONTH, @data1, @data2)	AS	'Qtd. Meses',
		DATEDIFF(HOUR, @data1, @data2)	AS	'Qtd. Horas';
GO

--Modificação de data e valores da hora
SELECT	GETDATE()							AS	'Data atual',
		DATEADD(MONTH, 5, GETDATE())		AS	'Próximos 5 meses',
		EOMONTH(GETDATE(), 5)				AS	'Final do mês (daqui 5 meses)',
		SWITCHOFFSET(GETDATE(), '+10:00')	AS	'Alteração de fuso-horário (+10 horas)';
GO

--Exibe a cnfiguração atual idioma e do primeiro dia da semana
SELECT	@@LANGUAGE		AS	'Idioma Utilizado',
		@@DATEFIRST		AS	'Primeiro dia da semana'
GO

--Exibe a config do comando SELECT.. CASE
SELECT	@@LANGUAGE	AS	'Idioma Utilizado',
		CASE
			WHEN @@DATEFIRST = 1 THEN 'Segunda-feira'
			WHEN @@DATEFIRST = 2 THEN 'Terça-feira'
			WHEN @@DATEFIRST = 3 THEN 'Quarta-feira'
			WHEN @@DATEFIRST = 4 THEN 'Quinta-feira'
			WHEN @@DATEFIRST = 5 THEN 'Sexta-feira'
			WHEN @@DATEFIRST = 6 THEN 'Sábado'
			WHEN @@DATEFIRST = 7 THEN 'Domingo'
		END	AS	'Primeiro dia da semana';
GO

--Exibe info de todos os idiomas disponiveis
SELECT * FROM sys.syslanguages;
GO

--Infos sobre idiomas
SELECT	langid		AS	'ID do idioma',
		dateformat	AS	'Formato de data',
		datefirst	AS	'Primeiro dia da semana',
		name		AS	'Nome do idioma',
		alias		AS	'Nome alternativo do idioma',
		months		AS	'Nomes dos meses',
		shortmonths	AS	'Abreviatura dos meses',
		days		AS	'Nomes dos dias'
FROM sys.syslanguages
WHERE alias IN ('English', 'Brazilian', 'German', 'Japanese', 'Russian');
GO

--Retorna infosmsobre alguns idiomas
EXEC sp_helplanguage [Brazilian];
GO

EXEC sp_helplanguage [Japanese];
GO

EXEC sp_helplanguage [English];
GO
































































































































