-- Habilita o contexto do banco de dados QUITANDA
USE QUITANDACJ3032221
GO

--Muda lingagem do sistema
SET LANGUAGE us_english;
GO

----------------------
--TRIGGERS(GATILHOS)
----------------------

----------------------------------
--TESTE DAS TABELAS

SELECT * FROM CLIENTES
GO

SELECT * FROM PRODUTOS
GO

SELECT * FROM COMPRAS
GO

SELECT * FROM ITENS
GO

--------------------------------------
--AULA 11/05
--------------------------------------

--apaga conteúdo da tabela e permite ver oque foi apagado
--acesso a taleba DELETED por meio de OUTPUT
DELETE ITENS OUTPUT DELETED.*
GO

--mostra tabela vazia após o comando acima
SELECT * FROM ITENS
GO

-- Insere alguns itens novamente
INSERT INTO ITENS VALUES
    (1, 1, 12.50, 5),
    (1, 2, 4.50, 7),
    (1, 3, 3, 2),
    (2, 1, 12.50, 10),
    (2, 2, 4.50, 3),
    (2, 3, 3, 2),
    (2, 4, 3, 2),
    (2, 5, 12.89, 10),
    (3, 6, 3.29, 2),
    (3, 9, 1.59, 7),
    (4, 1, 12.50, 2),
    (5, 8, 3.29, 2),
    (5, 10, 2.99, 5),
    (6, 2, 4.50, 8),
    (6, 4, 3, 7),
    (6, 6, 3.29, 2),
    (6, 7, 5, 5),
    (7, 6, 3.29, 2),
    (8, 1, 12.50, 1),
    (9, 5, 12.89, 12),
    (9, 6, 3.29, 5),
    (10, 1, 12.50, 2),
    (10, 2, 4.50, 3),
    (10, 3, 3, 7),
    (10, 4, 3, 5),
    (10, 5, 12.89, 5),
    (10, 6, 3.29, 4),
    (10, 7, 5, 4),
    (10, 8, 12.50, 2),
    (10, 9, 1.59, 7)
GO

--Apagar conteudo da tabela e permite vizualizar apenas algumas colunas
DELETE	ITENS
OUTPUT	DELETED.Cod_Compra,
				DELETED.Cod_Produto
GO

--mostra tabela vazia após o comando acima
SELECT * FROM ITENS
GO

-- Insere alguns itens novamente
INSERT INTO ITENS VALUES
    (1, 1, 12.50, 5),
    (1, 2, 4.50, 7),
    (1, 3, 3, 2),
    (2, 1, 12.50, 10),
    (2, 2, 4.50, 3),
    (2, 3, 3, 2),
    (2, 4, 3, 2),
    (2, 5, 12.89, 10),
    (3, 6, 3.29, 2),
    (3, 9, 1.59, 7),
    (4, 1, 12.50, 2),
    (5, 8, 3.29, 2),
    (5, 10, 2.99, 5),
    (6, 2, 4.50, 8),
    (6, 4, 3, 7),
    (6, 6, 3.29, 2),
    (6, 7, 5, 5),
    (7, 6, 3.29, 2),
    (8, 1, 12.50, 1),
    (9, 5, 12.89, 12),
    (9, 6, 3.29, 5),
    (10, 1, 12.50, 2),
    (10, 2, 4.50, 3),
    (10, 3, 3, 7),
    (10, 4, 3, 5),
    (10, 5, 12.89, 5),
    (10, 6, 3.29, 4),
    (10, 7, 5, 4),
    (10, 8, 12.50, 2),
    (10, 9, 1.59, 7)
GO

SELECT * FROM ITENS
GO

--Atualiza produtos e exibe APÓS a atualização
--Atualização utilizando tabela INSERTED por meio de OUTPUT
UPDATE	PRODUTOS
	SET Qtd_Estoque += 10
	OUTPUT INSERTED.*
GO

SELECT * FROM PRODUTOS
GO

--Atualiza estoque e mostra oq esta no DELETED
--UPDATE trabalha com INSERTED E DELETED
UPDATE	PRODUTOS
	SET	Qtd_Estoque += 50
	OUTPUT DELETED.*
GO

SELECT * FROM PRODUTOS
GO

--Atualiza conteudo da tabela Produtos e mostra tanto
--conteúdo de DELETED e INSERTED ( ANTES E DEPOIS)
UPDATE	PRODUTOS
	SET	Qtd_Estoque -= 60
	OUTPUT DELETED.*,
	REPLICATE(' ', 10) + '>>>' + REPLICATE(' ', 10)	AS	'<<< Antes -- Depois >>>',
	INSERTED.*
GO

----------------
--TRIGGER SIMPLES
----------------

-- Quando executado INSERT na Tabela PRODUTOS trigger é disparado exibindo os comandos abaixo
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