-- Habilita o contexto do banco de dados INTERCAMBIO
USE INTERCAMBIOCJ3032221;
GO

--Muda lingagem do sistema
SET LANGUAGE us_english;
GO

-- STORED PROCEDURES (PROCEDIMENTOS ARMAZENADOS)
-- executa sequencia de comandos no server do banco
-- simplifica escrita de comandos (define método e executa via parametro)
-- pré compilado(+ desempenho), reduz trafego rede(mais rápido), segurança(restriçao de acesso)
-- reutilizar código, facilidade na manutenção e controle de transãção( mantem integridade de deados)
-- isolamento de dados(não espoe diretamente as infos Encapsulamento)
-- compatibilidae com diferentes plataformas (suportado por variedade de SGBDs)

-- SQL SERVER procedueres TSQL e Common language runtime procedure(Procedures em linguagem C# ou VB.NET [Plataforma .NET]
-- MySQL = SQL procedures e Stored Procedures SQL/PSM Persistent Stored Modules
-- Oracle PL/SQL Procedures e Java Stores Procedures
-- SQL SERVER User-defined stored procedures, Temporary stores procedures, 
-- System stored procedures(sp_), Extended Stored Procedures(xp_)

-- SQL SERVER criação procedures CREATE PROCEDURE(CRIA), EXEC/EXECUTE(EXECUTA), 
-- ALTER PROCEDURE(ALTERA), DROP PROCEDURE(MATA).

--Lista tabelas disponíveis do banco
SELECT name
FROM sys.tables;
GO

--Cria stores procedura para exibir "Alô Mundo!"
CREATE PROCEDURE AloMundo
AS
		PRINT	'Alô Mundo!';
GO

--Utiliza stored procedure
EXEC AloMundo;
GO

--Meu teste pessoal
CREATE PROCEDURE uspSelectAlunos
AS
		SELECT * FROM ALUNOS;
GO

EXEC uspSelectAlunos;
GO

--Cria procedure que seleciona alunos masculinos
CREATE PROCEDURE uspAlunosMasculinos
AS
		SELECT	CodAluno		AS	'Código do Aluno',
						NomeAluno		AS	'Nome do Aluno',
						DataNasc		AS	'Data de Nascimento',
						Endereco		AS	'Endereço',
						Telefone,
						Genero			AS	'Gênero',
						PaisOrigem	AS	'Nascionalidade',
						CodViagem		AS	'Código de Viagem'
		FROM ALUNOS
		WHERE Genero = 'M';
GO

EXEC uspAlunosMasculinos;
GO

-- Info sobre os procedures

SELECT * FROM sys.procedures;
GO

-- Infos especificas dos procedures
SELECT	name					AS	'Procedure',
				create_date		AS	'Data de Criação',
				modify_date		AS	'Data de Alteração'
FROM	sys.procedures;
GO

-- Modificar conteúdo do procedure
ALTER PROCEDURE AloMundo
AS
		PRINT	'Hello World!';
GO

EXEC AloMundo;
GO

--Extende Stored Procedure SQL Server
--Exemplo de uso stored procedure do sistema
EXEC XP_SUBDIRS 'C:\';
GO

--Verifica oque tem no diretório especificado
EXEC XP_DIRTREE 'C:\dados', 1, 1;
GO

-- XP_FILEEXIST verifica a exixtencia de um arquivo
EXEC XP_FILEEXIST 'E:\01-Intercambio.sql';
GO

-- Lista com stored procedures do sistema
EXEC SP_HELPEXTENDEDPROC;
GO

-----
--continuação aula
--27/04
-----

-- Stored Procedure com parametros

-- Cria stored procedure que exibe saudação para nome passado como parametro
	CREATE PROCEDURE uspSaudacao
			@nome VARCHAR(200)
AS
		PRINT 'Olá, ' + @nome + '!';
GO

-- Utiliza Stored Procedure passa parametro após chamda do procedure
EXEC uspSaudacao 'Paulo';
EXEC uspSaudacao 'Cris';

-- Procedure que soma e retorna valor 
-- para funcionar 1 das variaveis deve ter clausula OUTPUT para receber a saida
-- Normalmente se usa funções e não procedure para RETORNO DE VALORES 
CREATE PROCEDURE uspSoma
		@valor1	INT,
		@valor2 INT,
		@soma INT OUTPUT
AS
		SET @soma = @valor1 + @valor2;
GO

-- Para utilizar se cria uma variavel de saida
DECLARE @saida INT;
EXEC uspSoma 5, 3, @saida OUTPUT;
PRINT @saida;
GO

DECLARE @saida INT;
EXEC uspSoma 100, 50, @saida OUTPUT;
PRINT @saida;
GO


-- SET NOCOUNT habilita não exibeção(não comtagem) de linhas retornadas pela consulta
-- Esconde o total de linhas retornadas pela consulta (SELECT)
CREATE PROCEDURE uspDescobreCodigoPais
		@Pais VARCHAR(255)
AS
		SET NOCOUNT ON;
		SELECT	CodPais		AS	'Código',
						NomePais	AS	'´País'
		FROM PAISES
		WHERE NomePais =  @Pais;
		SET NOCOUNT OFF;
GO

-- Utiliza procedure passando parametro
EXEC uspDescobreCodigoPais 'Brasil';
EXEC uspDescobreCodigoPais 'Turquia';
EXEC uspDescobreCodigoPais 'Japão';
GO

-- Procedure que retorna infos que fazem parte do parametro
CREATE PROCEDURE uspInfoIdiomaPaises
		@idioma VARCHAR(50)
AS
		SET NOCOUNT ON;
		SELECT * FROM PAISES
		WHERE IdiomaPais LIKE ('%' + @idioma + '%');
		SET NOCOUNT OFF;
GO

-- Utilização do procedure
EXEC uspInfoIdiomaPaises 'Português';
EXEC uspInfoIdiomaPaises 'hin';
GO

-- Nome do aluno como parametro de entrada
-- Exibe todas as tabelas e informações das viagens cadastradas
CREATE PROCEDURE uspBuscaDadosAlunos
			@nomeAluno	AS	VARCHAR(20)
AS
		SET NOCOUNT ON;
		SELECT
				VIAGENS.CodViagem																									AS	'Código da Viagem',
				ALUNOS.NomeAluno																									AS	'Nome',
				ALUNOS.Telefone,
				ALUNOS.Genero																											AS	'Gênero',
				(SELECT NomePais FROM PAISES WHERE CodPais = ALUNOS.PaisOrigem)		AS	'Origem',
				(SELECT NomePais FROM PAISES WHERE CodPais = VIAGENS.PaisDestino)	AS	'Destino',
				VIAGENS.DataSaida																									AS 'Data de Saída',
				VIAGENS.DataRetorno																								AS	'Data de Retorno',
				VIAGENS.Valor																											AS	'Preço da Viagem R$'
				FROM ALUNOS INNER JOIN VIAGENS
						ON ALUNOS.CodViagem = VIAGENS.CodViagem
				WHERE ALUNOS.NomeAluno LIKE '%' + @nomeAluno + '%'
				ORDER BY ALUNOS.NomeAluno, VIAGENS.PaisDestino;
		SET NOCOUNT OFF;
GO

-- Utilização do procedure
EXEC uspBuscaDadosAlunos 'P';
GO

EXEC uspBuscaDadosAlunos 'Ana';
GO

EXEC uspBuscaDadosAlunos 'Ana Mara';
GO

EXEC uspBuscaDadosAlunos 'Silva';
GO

EXEC uspBuscaDadosAlunos 'Luís';
GO

-- Infos sobre os stored procedures
EXEC SP_HELP uspBuscaDadosAlunos;
GO

-- COMANDOS DO PROCEDURE SE NAO CRIADO COM WITH ENCRYPTION.
EXEC SP_HELPTEXT uspBuscaDadosAlunos;
GO

-- PROCEDURES CRIADOS NO BANCO ATUAL
EXEC SP_STORED_PROCEDURES;
GO

-- procedure para retornar maior valor entre 2 passados por parametro
CREATE PROCEDURE uspAchaMaior
		@valor1 FLOAT,
		@valor2 FLOAT
AS
		DECLARE @maior FLOAT;

		IF (@valor1 > @valor2)
				SET @maior = @valor1;
		ELSE
				SET @maior = @valor2;

		PRINT 'Maior valor entre ' + CAST(@valor1 AS VARCHAR) 
		+ ' e ' + CAST(@valor2 AS VARCHAR) 
		+ ' é: ' + CAST(@maior AS VARCHAR);
GO

-- Utilização
EXEC uspAchaMaior 5, 2;
EXEC uspAchaMaior 1.356, 8.6352;
GO

-- Quant. paise sexistem para idioma passado por parametro
CREATE PROCEDURE uspContaIdiomas
		@idioma VARCHAR(50)
AS
		DECLARE	@mensagemOK		VARCHAR(100);
		DECLARE	@mensagemErro	VARCHAR(100);
		DECLARE	@total				INT;

		SET	@mensagemOK = 'Quantidade de registros encontrados para o idioma ' + @idioma + ': ';
		SET	@mensagemErro = 'Erro: nenhuma ocorrência encontrada para o idioma ' + @idioma + '! ';

		SET @total = (SELECT COUNT(*) FROM PAISES WHERE IdiomaPais LIKE ('%' + @idioma + '%'));

		IF (@total > 0)
				PRINT @mensagemOK + CAST(@total AS VARCHAR);
		ELSE
				PRINT @mensagemErro;
GO

-- Uso do Stored Procedure
EXEC uspContaIdiomas 'Inglês';
EXEC uspContaIdiomas 'Japonês';
EXEC uspContaIdiomas 'Português';
EXEC uspContaIdiomas 'Malgaxe';
EXEC uspContaIdiomas 'Americano';
GO