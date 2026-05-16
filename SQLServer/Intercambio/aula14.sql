-- Habilita o contexto do banco de dados INTERCAMBIO
USE INTERCAMBIOCJ3032221;
GO

--Muda lingagem do sistema
SET LANGUAGE us_english;
GO

-- STORED PROCEDURES (PROCEDIMENTOS ARMAZENADOS)

-----------------------------------------------------------------------------------------------------
-- Ultimo código aula passada
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
----------------------------
--07/05
----------------------------

--UDF escalar (SQL_SCALAR_FUNCTION)

CREATE FUNCTION DescobreNomePais (@sigla CHAR(3))
		RETURNS	VARCHAR(50)
AS
		BEGIN
				DECLARE	@resposta	VARCHAR(50);
				SET @resposta = (
						SELECT NomePais	FROM PAISES
						WHERE CodPais = @sigla);
				RETURN @resposta;
		END;
GO

--Ulitilação da Função para descobrir nome do pais passado por parâmetro
SELECT dbo.DescobreNomePais('BRA')	AS	'País';
GO

--Exibe dados da viagem usando função descobre nome pais para exibir o nome dos países
SELECT	A.CodAluno													AS	'Código do Aluno',
				A.NomeAluno													AS	'Nome do Aluno',
				A.Genero														AS	'Gênero',
				A.Endereco													AS	'Endereço',
				A.PaisOrigem												AS 'Código da Origem',
				dbo.DescobreNomePais(A.PaisOrigem)	AS	'Origem',
				V.PaisDestino												AS 'Código do Destino',
				dbo.DescobreNomePais(V.PaisDestino) AS 'Destino',
				V.Valor															AS	'Custo R$'
FROM ALUNOS A INNER JOIN VIAGENS V
		ON A.CodViagem = V.CodViagem;
GO

--UDF Inline (SQL_INLINE_TABLE_VALUED_FUNCTION)

--Função que retorna uma tabela

CREATE FUNCTION	ExibeViagensPais	(@sigla CHAR(3))
		RETURNS TABLE
AS
		RETURN
				SELECT	V.CodViagem															AS	'Código da Viagem',
								P.NomePais + ' (' + V.PaisDestino + ')'	AS 'Destino',
								P.IdiomaPais														AS	'Idioma',
								V.DataSaida															AS	'Saída',
								V.DataRetorno														AS	'Retorno',
								V.Valor																	AS 'Valor R$'
				FROM PAISES P INNER JOIN VIAGENS V
						ON P.CodPais = V.PaisDestino
				WHERE V.PaisDestino = @sigla;
GO

--Uso função inline Incorreto
SELECT dbo.ExibeViagensPais('USA');
GO

SELECT * FROM dbo.ExibeViagensPais('USA');
GO

SELECT * FROM dbo.ExibeViagensPais('MEX');
GO

SELECT	[Código da Viagem],
				Destino,
				[Valor R$]
FROM dbo.ExibeViagensPais('MEX');
GO


--UDF Multi-Statement (SQL_TABLE_VALUED_FUNCTION)
--Retorna variavel do tipo TABELA
CREATE FUNCTION ViagensFuturas (@data DATE)
		RETURNS @viagens_futuras TABLE (Codigo INT, Saida DATE, Retorno DATE, Destino VARCHAR(50))
AS
		BEGIN
				INSERT INTO @viagens_futuras
				SELECT V.CodViagem, V.DataSaida, V.DataRetorno, P.NomePais
				FROM VIAGENS V INNER JOIN PAISES P
						ON V.PaisDestino = P.CodPais
				WHERE V.DataSaida > @data;
				RETURN;
		END;
GO

--Muda formato de exibição de data e hora
SET DATEFORMAT DMY;
GO

--USO UDF Multi-statement
SELECT * FROM ViagensFuturas('01-01-2011');
GO

SELECT * FROM ViagensFuturas('01-02-2011');
GO

--Infos das Funções do banco de dados em uso
SELECT	name				AS 'Nome da Função',
				definition	AS	'Definição',
				type_desc		AS 'Tipo'
FROM sys.sql_modules M INNER JOIN sys.objects O
		ON M.object_id = O.object_id
WHERE type_desc LIKE '%function%';
GO

--Infos dos Procedures do banco de dados em uso
SELECT	name				AS 'Nome da Função',
				definition	AS	'Definição',
				type_desc		AS 'Tipo'
FROM sys.sql_modules M INNER JOIN sys.objects O
		ON M.object_id = O.object_id
WHERE type_desc LIKE '%procedures%';
GO

--Excluir Função
DROP FUNCTION fatorial;
GO

---------------------
--TRIGGERS(GATILHOS)
----------------------