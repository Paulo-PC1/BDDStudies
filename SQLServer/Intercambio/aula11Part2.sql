-- Habilita o contexto do banco de dados INTERCAMBIO
USE INTERCAMBIOCJ3032221;
GO

--Muda lingagem do sistema
SET LANGUAGE us_english;
GO

--PROCEDIMENTO ARMAZENADO E FUNÇÃO (SQL PROCEDURAL)
-- AULA 13/04/2026 / 16/04/2026

--SEQUENCE obj associado a um esquema definido pelo usuário que gera sequencia de valores numéricos
--de acordo com a especificação a qual sequencia foi criada
--gerada em ordem crescente ou decrescente(numérico), dentro do intervalo definido e pode ser configurada
--a reiniciar  baseado no intervalo definido (se esgotar), não é acossiada a tabela especifica
--acionado sempre que necessário (diferente de IDENTITY que depende das tabelas e campos)
--usa em qualquer coisa (como contador)

CREATE TABLE AERONAVES	(
		CodAeronave	INT	IDENTITY PRIMARY KEY,
		Modelo		VARCHAR(50) NOT NULL
);
GO

--Não necessário coluna com IDENTITY(auto incremento)
INSERT INTO AERONAVES VALUES
		('Boeing 707'),
		('Boeing 737'),
		('Boeing 747'),
		('Embraer ERJ-145'),
		('Vickers VC-10');
GO

SELECT * FROM AERONAVES;
GO

--Não funciona por coluna CodAeronave é Auto Incremento
INSERT INTO AERONAVES (CodAeronave, Modelo) VALUES
		(6, 'Airbus A300');
GO

--Permite inserir valor em coluna auto incremento
SET IDENTITY_INSERT AERONAVES ON;
GO

--Tenta inserir um valor na tabela(e consegue) fornecendo um campo IDENTITY(auto incremento)
INSERT INTO AERONAVES (CodAeronave, Modelo) VALUES
		(6, 'Airbus A300');
GO

SELECT * FROM AERONAVES;
GO

--desliga a permisão de inserir auto-incremento
SET IDENTITY_INSERT AERONAVES OFF;
GO

CREATE TABLE VEICULOS (
	Codigo	INT	IDENTITY(1, 10)	PRIMARY KEY,
	Modelo	VARCHAR(50)	NOT	NULL
);
GO

INSERT INTO VEICULOS VALUES
	('Ferrari'),
	('Camaro'),
	('Fusca');
GO

SELECT * FROM VEICULOS;
GO

--Exibir valor do incremento usado
SELECT	IDENT_INCR('AERONAVES')		AS	'Inc. AERONAVES',
				IDENT_INCR('VEICULOS')	AS	'Inc. VEICULOS';
GO

--Exibe o ultimo valor IDENTITY utilizado
SELECT	@@IDENTITY							AS	'Último IDENTITY',
				IDENT_CURRENT('VEICULOS')	AS	'IDENTITY (VEICULOS)',
				IDENT_CURRENT('AERONAVES')	AS	'IDENTITY (AERONAVES)';
GO

--Demostração de Sequência SEQUENCE(OBJ USA CREATE)

--Cria sequência que começa em 1 com incremento de 1
CREATE SEQUENCE Incrementa1	AS	INT
		START WITH 1
		INCREMENT BY 1;
GO
--Cria sequência que começa em 10 com incremento de 100
CREATE SEQUENCE Incrementa100	AS	INT
		START WITH 10
		INCREMENT BY 100;
GO

--Cria sequência que começa em 10 com incremento de 100
CREATE SEQUENCE Incrementa1000	AS	INT
		START WITH 1000
		INCREMENT BY -100;
GO

--Infos das Sequências
SELECT	name					AS	'Nome',
				create_date		AS	'Data de Criação',
				start_value		AS	'Valor Inicial',
				increment		AS	'Incremento',
				minimum_value	AS	'Valor Minimo',
				maximum_value	AS	'Valor Maximo',
				current_value	AS	'Valor Atual'
FROM sys.sequences;
GO

--Sequencia com mais parametros
CREATE SEQUENCE IncrementaDecimal	AS	DECIMAL(3,0)
	START WITH 125
	INCREMENT BY 25
	MINVALUE	100
	MAXVALUE	200
	CYCLE
	CACHE 3
GO

--Exibe o Primeiro valor das sequências 
SELECT	NEXT VALUE FOR Incrementa1				AS	'Incrementa1',
		 		NEXT VALUE FOR Incrementa100			AS	'Incrementa100',
				NEXT VALUE FOR Incrementa1000			AS	'Incrementa1000',
				NEXT VALUE FOR IncrementaDecimal	AS	'IncrementaDecimal';
GO

--Cria tabela Temp para mostrar uso sequencia
CREATE	TABLE	#TestaSequência	(
		ID		INT,
		Nome	CHAR(20)
);
GO

--Reinicia valor da sequencia
ALTER SEQUENCE Incrementa100
		RESTART WITH	10;
GO

--Usa sequência para inserir valor na tabela Temp
--Da para por EX concatenar com String (CJ) mais o valor aleatório com sequence mais outra String ou qualquer coisa
INSERT	INTO #TestaSequência	(ID, Nome)	VALUES
		(NEXT VALUE FOR Incrementa100, 'Ana'),
		(NEXT VALUE FOR Incrementa100, 'Maria'),
		(NEXT VALUE FOR Incrementa100, 'João');
GO

SELECT * FROM #TestaSequência;
GO

--Recuperando valor ATUAL da sequencia
SELECT current_value	AS	'Valor Atual'
FROM	sys.sequences
WHERE	name =	'Incrementa100';
GO

--Excruir sequencia (DROP SEQUENCE {nome sequencia})
DROP SEQUENCE Incrementa100;
GO

--Tenta inserir registro usando a sequencia e falha pelo DROP SEQUENCE anterior 
INSERT	INTO #TestaSequência	(ID, Nome)	VALUES
		(NEXT VALUE FOR Incrementa100, 'José');
GO

--SQL PROCEDURAL (USO DE IF-THEN-ELSE-WHILE [Declaração de variaveis])
--Variaveis Declaradas com DECLERE atribuir valor usa SET/SELECT
--Var de Cursor[Ponteiro para resultado e avansa pra frente e traz] Inicializa com NULL
--ou algum valor

--Declara Variavel
DECLARE @nome	AS VARCHAR(100);

--Atribui valor a ela
SET	@nome = 'Carlos Pereira';


--Uso variavel numa consulta SQL
SELECT	CodAluno	AS	'Código',
				NomeAluno AS	'Nome do Aluno',
				Endereco	AS	'Endereço'
FROM ALUNOS
WHERE NomeAluno LIKE	@nome;
GO

--Declara e atribui valor na declaração
DECLARE @nome	AS VARCHAR(100) = 'Carlos Pereira';

--Uso variavel numa consulta SQL
SELECT	CodAluno	AS	'Código',
				NomeAluno AS	'Nome do Aluno',
				Endereco	AS	'Endereço'
FROM ALUNOS
WHERE NomeAluno LIKE	@nome;
GO