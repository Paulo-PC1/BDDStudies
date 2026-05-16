-- Habilita o contexto do banco de dados INTERCAMBIO
USE INTERCAMBIOCJ3032221;
GO

--Muda lingagem do sistema
SET LANGUAGE us_english;
GO

--PROCEDIMENTO ARMAZENADO E FUNÇÃO (SQL PROCEDURAL)
--aula 23/04/2026

-- continuação

DECLARE @rows	AS	INT;

SET @rows = (SELECT COUNT(*) FROM VIAGENS);

SELECT @rows AS	'Total de Viagens'
GO

--Estrutura de decisão IF-ELSE & SELECT-CASE-WHEN(tipo SWITCH)
DECLARE	@A			AS	INT = 10,
				@B			AS	INT = 100,
				@maior	AS	INT;

--IF-ELSE para verificar qual maior
IF @A > @B
		SET @maior = @A;
ELSE
		SET @maior = @B;

-- Exibir resultado comando PRINT
PRINT 'O maior valor é: ' + CAST(@maior	AS VARCHAR);
GO

-- OTO EXEMPRO
DECLARE @numero	 AS INT = 240;

IF ((@numero % 2) = 0)
		PRINT 'O número' + CAST(@numero AS VARCHAR) + 'é par!';
ELSE
		PRINT 'O número' + CAST(@numero AS VARCHAR) + 'é impar!';
GO

-- Consulta pra ver se é homi ou muié
-- IF-ELSE NAO FUNCIONA/Sintaxe correto usa CASE
-- case avalia lista de condiçoes, aceita ELSE (case simples e case pesquisada)
-- pode ser usado com qualquer outra instrução TSQL

--CASE SIMPLES
SELECT	CodAluno	AS	'Código',
				NomeAluno	AS	'Nome do Aluno',
				Endereco	AS	'Endereço',
				Genero		AS	'Gênero',
				CASE Genero
						WHEN	'M'	THEN	'Homem'
						WHEN	'F'	THEN	'Mulher'
						ELSE	'Não delcarado'
				END AS	'Homem | Mulher'
FROM ALUNOS;
GO

-- Estrutura de Repetição SQL SERVER -> WHILE
-- Pode usar instrução de controle BRAKE E CONTINUE e contem BEGIN E END para identar bloco

--Exemplo bobo uso WHILE (incrementa e apresenta valor da variavel)
DECLARE @i	AS	INT;

SET @i = 1;

WHILE	@i <= 10
		BEGIN
				PRINT 'Valor de i: ' + CAST(@i AS CHAR);
				SET @i = @i + 1;
		END
GO

--Exemplo tabuada com WHILE
DECLARE	@quantidade	AS	INT = 5,
				@total			AS	INT = 1,
				@contador		AS	INT,
				@limite			AS	INT = 10;

--Loop para controle tabuada
	WHILE @total <= @quantidade
			BEGIN
				--IMPRIME CABEÇALHO
				PRINT 'Tabuada do ' + CAST(@total	AS	VARCHAR(5));
				PRINT REPLICATE('-', 13);
			
				--DEFINR VALOR INICIAL
				SET @contador = 1;

				--LOOP QUE CONTROLA CRIAÇÃO TABUADA
				WHILE @contador <= @limite
						BEGIN
								--IMPRIME TABUADA
								PRINT CAST(@total AS VARCHAR(5))
								+ 'X'
								+ CAST(@contador AS VARCHAR(5))
								+ '='
								+ CAST((@total * @contador) AS VARCHAR(5));
								--ATUALIZA MULTIPLICADOR
								SET @contador += 1;
						END;

				--ATUALIZA VARIAVEL CONTROLE QUANT TABUADA
				SET @total += 1;

				--IMPRIME LINHA EM BRANCO
				PRINT '';
	END;
GO