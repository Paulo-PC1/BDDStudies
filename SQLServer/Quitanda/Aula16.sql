-- Habilita o contexto do banco de dados QUITANDA
USE QUITANDACJ3032221
GO

--Muda lingagem do sistema
SET LANGUAGE us_english;
GO

----------------------
--TRIGGERS(GATILHOS)
----------------------

-----------------
--Ultimo Código

----------------
--TRIGGER SIMPLES
----------------
-- Quando executado INSERT na Tabela PRODUTOS trigger é disparado exibindo conteudo de INSERTED
CREATE TRIGGER trg_INSERE	ON	PRODUTOS
	FOR INSERT
AS
	SELECT 'Produto(s) cadastrado com sucesso: '
	SELECT * FROM INSERTED
GO

INSERT INTO PRODUTOS VALUES
	(11, 'Pepino', 100);
GO

INSERT INTO PRODUTOS VALUES
	(12, 'Uva', 100),
	(13, 'Laranja', 100),
	(14, 'Morango', 100),
	(15, 'Soja', 100)
GO

SELECT * FROM PRODUTOS
GO

-------------
--18/05
-------------

-- TRIGGER DELETE
-- apos uso de DELETE trigger disparado exibindo conteudo de DELETED
CREATE TRIGGER trg_DETELA ON PRODUTOS
	FOR DELETE
AS
	DECLARE @total AS INT 
	SET @total = (SELECT COUNT(*) FROM DELETED)
	PRINT 'Registro(s) excluído(s) com sucesso: ' + CAST(@total AS CHAR)
GO

-- Exibe 2 primeiros registros
SELECT TOP 2 *
FROM PRODUTOS
ORDER BY Cod_Produto DESC
GO

-- Exclusão dos 2 últimos registros automáticamente trigger é disparado
DELETE FROM PRODUTOS
WHERE Cod_Produto IN (SELECT TOP 2 Cod_Produto
											FROM PRODUTOS
											ORDER BY Cod_Produto DESC)
GO
-- Após comando acima registro 14 e 15 são excluídos da tabela PRODUTOS
SELECT * FROM PRODUTOS;
GO

--TRIGGER UPDATE 
-- Quando uso UPDATE dispara Trigger e exibe os comandos (Meche com INSERTED E DELETED)
CREATE TRIGGER trg_ATUALIZA ON PRODUTOS
	FOR UPDATE
AS
	BEGIN
		DECLARE @num_atualizados INT
		SELECT	@num_atualizados = COUNT(*) FROM DELETED
		SELECT	'Número de registro(s) atualizado(s) com sucesso: ' + 
		CONVERT(VARCHAR(30), @num_atualizados)
		SELECT * FROM INSERTED
	END
GO

SELECT * FROM PRODUTOS;
GO

--mostra os 3 primeiros registros
SELECT TOP 3 * 
FROM PRODUTOS;
GO

-- atualiza o estoque do primeiro registro e dispara o trigger
UPDATE PRODUTOS 
	SET Qtd_Estoque = 120
	WHERE Cod_Produto = 1
GO

-- atualiza o estoque de todos os registros e dispara o trigger
UPDATE PRODUTOS 
	SET Qtd_Estoque = 100
	WHERE Cod_Produto != 100
GO

SELECT * FROM PRODUTOS;
GO
-------------------------------------
--TRIGGER QUE ALTERA OUTRAS TABELAS
SELECT * FROM ITENS;
GO

SELECT * FROM PRODUTOS;
GO

-- TRIGGER que ao realizar INSERT em ITENS atualiza o a Quantidade do item na tabela PRODUTOS
CREATE TRIGGER	trg_ATUALIZA_ESTOQUE ON ITENS
	AFTER INSERT
AS
	BEGIN
		UPDATE PRODUTOS
			SET	Qtd_Estoque -= INSERTED.Quantidade
			FROM PRODUTOS INNER JOIN INSERTED
			ON PRODUTOS.Cod_Produto = INSERTED.Cod_Produto
	END
GO

--------
--muda formato data DIA/MES/ANO (br)
SET DATEFORMAT DMY
GO

--Insere nova compra
INSERT INTO COMPRAS VALUES
	(11, 1, '22/08/2018')
GO

--muda formato data MES/DIA/ANO (usa)
SET DATEFORMAT MDY
GO

--Verificando oque há em cada tabela
SELECT * FROM COMPRAS
GO

SELECT * FROM ITENS;
GO

SELECT * FROM PRODUTOS;
GO

-- Insere item referente a nova compra
INSERT INTO ITENS VALUES
	(11, 1, 12.50, 5)
GO

--Insere  alguns itens 
INSERT INTO ITENS VALUES
	(11, 5, 12.89, 20),
	(11, 7, 5, 10),
	(11, 10, 2.99, 10)
GO

SELECT * FROM ITENS;
GO

SELECT * FROM PRODUTOS;
GO

--Tabela de auditoria (contem dados do usuário)
CREATE TABLE AUDITORIA_ITENS (
	Data						SMALLDATETIME	DEFAULT	GETDATE(),
	Nome_Usuario		VARCHAR(20)		DEFAULT	USER_NAME(),
	Computador			VARCHAR(20)		DEFAULT HOST_NAME(),
	Tabela					CHAR(15),
	Cod_Compra			INT,
	Cod_Produto			INT,
	Valor_Unitario	DECIMAL(9,2),
	Quantidade			INT,
	Valor_Item			DECIMAL(9,2)
)
GO

SELECT * FROM AUDITORIA_ITENS
GO

SELECT * FROM sys.triggers
GO

CREATE TRIGGER trg_AUDITORIA_COMPRAS ON ITENS
	FOR DELETE
AS
	SET NOCOUNT ON
	INSERT INTO AUDITORIA_ITENS (Tabela, Cod_Compra, Cod_Produto, Valor_Unitario, Quantidade, Valor_Item)
	SELECT	'ITENS',
					Cod_Compra,
					Cod_Produto,
					Valor_Unitario,
					Quantidade,
					Valor_Item
	FROM DELETED
	SET NOCOUNT OFF
GO

SELECT * FROM ITENS
GO

DELETE FROM ITENS
WHERE Cod_Compra = 11
GO

SELECT * FROM ITENS
GO

SELECT * FROM AUDITORIA_ITENS
GO

SELECT * FROM ITENS
GO
-------------------
DELETE FROM ITENS
WHERE Cod_Compra = 1
GO

SELECT * FROM ITENS
GO

SELECT * FROM AUDITORIA_ITENS
GO