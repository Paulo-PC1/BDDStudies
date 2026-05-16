-- Habilita o contexto do banco de dados INTERCAMBIO
USE INTERCAMBIOCJ3032221;
GO

--Muda lingagem do sistema
SET LANGUAGE us_english;
GO

-- STORED PROCEDURES (PROCEDIMENTOS ARMAZENADOS)

-----------------------------------------------------------------------------------------------------
-- Código aula passada
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
----------------------------------------------------------------------------------------------------------

--------
--04/05/26
--------

-- Procedure com estrutura de decisão
CREATE PROCEDURE uspCalculoIdadeAluno
		@nome	AS CHAR(20)
AS
		SET NOCOUNT ON;

		DECLARE @data_nascimento	DATETIME;
		DECLARE @idade						INT;
		DECLARE @data_atual				DATETIME;

		SET @data_atual = (SELECT GETDATE());
		SET @data_nascimento = (SELECT DataNasc FROM ALUNOS WHERE NomeAluno = @nome);
		SET @idade = DATEDIFF(YEAR, @data_nascimento, @data_atual)
				- CASE WHEN @data_atual < DATEADD(YEAR, DATEDIFF(YEAR, @data_nascimento, @data_atual), @data_nascimento)
					THEN 1
					ELSE 0
				END;

		SELECT	@nome		AS	'Nome do Aluno',
						@idade	AS	'Idade do Aluno';

		SET NOCOUNT OFF;
GO

EXEC uspCalculoIdadeAluno 'Maria Cristina';
EXEC uspCalculoIdadeAluno 'Jair Lopes';
EXEC uspCalculoIdadeAluno 'Miguel Firmino';
GO

--- Stored Procedure com parâmetros de saida

CREATE PROCEDURE uspMediaViagens
		@pais	VARCHAR(50),
		@media MONEY OUTPUT
AS
		SET @media = (SELECT AVG(Valor)	AS	'Média dos Valores'
									FROM VIAGENS
									WHERE PaisDestino = (SELECT CodPais FROM PAISES WHERE NomePais = @pais));
GO

DECLARE @pais				VARCHAR(50) = 'Estados Unidos da América';
DECLARE @resultado	MONEY;

EXEC uspMediaViagens @pais, @resultado OUTPUT;

PRINT	'Custo médio das viagens realizadas para o ' + @pais + ': R$ ' + CAST(@resultado	AS	VARCHAR);
GO

--remocao de stored procedure
DROP PROCEDURE uspSaudacao;
GO

-- execução após remover = erro Could not find stored procedure 'nome_do_procedure'.
EXEC uspSaudacao 'Paulo';
GO

-- Verificar procedures no banco
SELECT	name				AS	'Procedure',
				create_date	AS	'Data de Criação',
				modify_date	AS	'Data de Modificação'
FROM sys.procedures;
GO

-- Outra forma
SELECT	name				AS	'Stored Procedure',
				definition	AS 'Definição',
				type_desc		AS	'Tipo'
FROM sys.sql_modules M INNER JOIN
sys.objects O
		ON M.object_id = O.object_id
WHERE	type_desc LIKE '%procedure';
GO

-- FUNÇÕES (USER DEFINED FUNCTIONS[UDF])
-- Necessita RETURN
-- Utilizadas por SELECT

-- 3 tipos
-- Scalar functions(retorna valor de 1 unico tipo)
-- Inline table-valued functions(retorna uma tabela menos lógica)
-- Multi-statement table-valued functions(permite mais instruçoes no corpo dela)

CREATE FUNCTION fatorial (@N INT)
		RETURNS BIGINT
AS
		BEGIN
				DECLARE @fator	BIGINT,
								@i			INT;
				SET	@fator = 1;
				SET @i	= 1;

		IF (@N <= 1)
				RETURN @fator;
		ELSE
				WHILE (@i <= @N)
						BEGIN
								SET @fator = @fator * @i;
								SET	@i = @i + 1;
						END;
				RETURN @fator;
		END;
GO

-- Utilização
SELECT dbo.fatorial(20)	AS	'Fatorial de 20',
			 dbo.fatorial(5)	AS	'Fatorial de 5';
GO

PRINT dbo.fatorial(10);
GO

-- Exibe dados das viagens dos alunos
SELECT	A.CodAluno			AS	'Código do Aluno',
				A.NomeAluno			AS	'Nome do Aluno',
				A.Genero				AS	'Gênero',
				A.Endereco			AS	'Endereço',
				A.PaisOrigem		AS	'Origem',
				V.PaisDestino		AS	'Destino',
				V.Valor					AS	'Custo R$'
FROM ALUNOS A INNER JOIN VIAGENS V
		ON A.CodViagem = V.CodViagem;
GO

-- Função para alinhar campos por valor
-- @texto = campo cujo valores serão alinhados
-- @tamanho = quantidade de vezes que o caractere será replicado
-- @caractere = caractere que serpa replicado
CREATE FUNCTION AlinhaCampo(@texto	VARCHAR(255), @tamanho TINYINT, @caractere CHAR(1))
		RETURNS VARCHAR(255)
AS
		BEGIN
				DECLARE @resultado VARCHAR(255);
				SET @resultado = REPLICATE(@caractere, @tamanho - LEN(@texto)) + @texto;
				RETURN @resultado;
		END;
GO

-- Exibe dados das viagens dos alunos usando a função acima para formatar
SELECT	dbo.AlinhaCampo(A.CodAluno, 2, 0)									AS	'Código do Aluno',
				A.NomeAluno																				AS	'Nome do Aluno',
				A.Genero																					AS	'Gênero',
				A.Endereco																				AS	'Endereço',
				A.PaisOrigem																			AS	'Origem',
				V.PaisDestino																			AS	'Destino',
				dbo.AlinhaCampo(CAST(V.Valor AS VARCHAR), 10, 0)	AS	'Custo R$'
FROM ALUNOS A INNER JOIN VIAGENS V
		ON A.CodViagem = V.CodViagem;
GO