--Sistema Inteligente de Exercícios Matemáticos (SIEM)
--Criação do Banco de Dados
CREATE DATABASE SIEM;
GO

USE SIEM;
GO

SET DATEFORMAT YMD;
GO

--Criação das Tabelas
CREATE TABLE USUARIOS	(
	IdUsuario		INT	IDENTITY	PRIMARY KEY,
	Nome			VARCHAR(150)	NOT NULL,
	Email			VARCHAR(200)	UNIQUE NOT NULL,
	Senha			VARCHAR(255)	NOT NULL,
	DataCadastro	DATETIME		NOT	NULL
);

CREATE TABLE NIVEL	(
	IdNivel		INT	IDENTITY	PRIMARY	KEY,
	Nome		VARCHAR(50)		NOT NULL,
	Descricao	VARCHAR(255)
);

CREATE TABLE CATEGORIA	(
	IdCategoria		INT IDENTITY	PRIMARY KEY,
	Nome			VARCHAR(200)	NOT NULL,
	Descricao		VARCHAR(200)
);

CREATE TABLE MODELO_EXERCICIO	(
	IdModelo				INT IDENTITY PRIMARY KEY,
	Nome					VARCHAR(200),
	Operacao				VARCHAR(50),
	ValorMaximo				INT,
	ValorMinimo				INT,
	QuantidadeOperandos		INT,
	Ativo					BIT,
	IdCategoria				INT	NOT NULL FOREIGN KEY REFERENCES CATEGORIA(IdCategoria),
	IdNivel					INT NOT NULL FOREIGN KEY REFERENCES NIVEL(IdNivel)
);

CREATE TABLE EXERCICIO_GERADO (
    IdExercicioGerado	INT IDENTITY PRIMARY KEY,
    Enunciado           VARCHAR(255),
    RespostaCorreta     DECIMAL(10,2),
    DataGeracao			DATETIME,
    IdModelo			INT NOT NULL FOREIGN KEY REFERENCES MODELO_EXERCICIO(IdModelo)
);

CREATE TABLE RESPOSTA (
    IdResposta			INT IDENTITY PRIMARY KEY,
    RespostaUsuario     DECIMAL(10,2),
    Correta             BIT,
    TempoResposta       INT,
    DataResposta        DATETIME,
    IdUsuario			INT NOT NULL FOREIGN KEY REFERENCES USUARIOS(IdUsuario),
    IdExercicioGerado	INT NOT NULL FOREIGN KEY REFERENCES EXERCICIO_GERADO(IdExercicioGerado)
);

CREATE TABLE PROGRESSO (
    IdProgresso		INT IDENTITY PRIMARY KEY,
    TotalAcertos    INT DEFAULT 0,
    TotalErros      INT DEFAULT 0,
    Pontuacao       INT DEFAULT 0,
    IdUsuario		INT UNIQUE NOT NULL FOREIGN KEY REFERENCES USUARIOS(IdUsuario),
    IdNivel			INT	NOT NULL FOREIGN KEY REFERENCES NIVEL(IdNivel)
);

--Inserção dos dados do Banco
INSERT INTO USUARIOS VALUES
	('João Silva', 'joao@gmail.com', '123456', CAST('2026-01-15 09:30:00' AS DATETIME)),
	('Maria Souza', 'maria@gmail.com', '123456', CAST('2024-01-18 14:20:00' AS DATETIME)),
	('Carlos Lima', 'carlos@gmail.com', '123456', CAST('2023-02-02 11:45:00' AS DATETIME)),
	('Ana Paula', 'ana@gmail.com', '123456', CAST('2020-02-10 08:10:00' AS DATETIME)),
	('Lucas Rocha', 'lucas@gmail.com', '123456', CAST('2017-03-05 16:00:00' AS DATETIME)),
	('Fernanda Alves', 'fernanda@gmail.com', '123456', CAST('2018-03-20 13:40:00' AS DATETIME)),
	('Ricardo Mendes', 'ricardo@gmail.com', '123456', CAST('2025-03-21 10:15:00' AS DATETIME)),
	('Juliana Costa', 'juliana@gmail.com', '123456', CAST('2025-03-22 18:30:00' AS DATETIME)),
	('Pedro Henrique', 'pedro@gmail.com', '123456', CAST('2020-03-23 09:50:00' AS DATETIME)),
	('Camila Freitas', 'camila@gmail.com', '123456', CAST('2019-03-24 15:25:00' AS DATETIME));
GO

INSERT INTO NIVEL VALUES
	('Fácil', 'Operações simples'),
	('Médio', 'Operações intermediárias'),
	('Difícil', 'Operações complexas'),
	('Avançado', 'Alta complexidade'),
	('Expert', 'Nível máximo');
GO

INSERT INTO CATEGORIA VALUES
	('Adição', 'Operações de soma'),
	('Subtração', 'Operações de subtração'),
	('Multiplicação', 'Operações de multiplicação'),
	('Divisão', 'Operações de divisão'),
	('Misto', 'Operações combinadas');
GO

INSERT INTO MODELO_EXERCICIO VALUES
	('Soma Fácil', '+', 10, 1, 2, 1, 1, 1),
	('Subtração Fácil', '-', 10, 1, 2, 1, 2, 1),
	('Multiplicação Média', '*', 50, 1, 2, 1, 3, 2),
	('Divisão Difícil', '/', 100, 1, 2, 1, 4, 3),
	('Operação Mista', '+,-,*,/', 100, 1, 2, 1, 5, 4),
	('Soma Média', '+', 50, 10, 2, 1, 1, 2),
	('Subtração Média', '-', 50, 5, 2, 1, 2, 2),
	('Multiplicação Difícil', '*', 100, 10, 2, 1, 3, 3),
	('Divisão Avançada', '/', 200, 2, 2, 1, 4, 4),
	('Operação Expert', '+,-,*,/', 500, 10, 3, 1, 5, 5);
GO

INSERT INTO EXERCICIO_GERADO VALUES
	('2 + 3', 5, CAST('2026-03-10 10:00:00' AS DATETIME), 1),
	('5 + 4', 9, CAST('2024-03-10 10:05:00' AS DATETIME), 1),
	('7 - 2', 5, CAST('2023-03-11 09:15:00' AS DATETIME), 2),
	('10 - 6', 4, CAST('2020-03-11 09:30:00' AS DATETIME), 2),
	('6 * 3', 18, CAST('2017-03-12 14:00:00' AS DATETIME), 3),
	('8 * 4', 32, CAST('2018-03-12 14:20:00' AS DATETIME), 3),
	('20 / 5', 4, CAST('2025-03-13 11:10:00' AS DATETIME), 4),
	('15 / 3', 5, CAST('2025-03-13 11:25:00' AS DATETIME), 4),
	('3 + 5 * 2', 13, CAST('2020-03-14 15:00:00' AS DATETIME), 5),
	('10 - 2 * 3', 4, CAST('2026-03-14 15:15:00' AS DATETIME), 5),
	('12 + 18', 30, CAST('2026-03-25 10:00:00' AS DATETIME), 6),
	('45 - 12', 33, CAST('2026-03-25 10:15:00' AS DATETIME), 7),
	('9 * 8', 72, CAST('2026-03-26 11:20:00' AS DATETIME), 8),
	('144 / 12', 12, CAST('2026-03-26 11:40:00' AS DATETIME), 9),
	('15 + 3 * 4', 27, CAST('2026-03-27 14:10:00' AS DATETIME), 10);
GO

INSERT INTO RESPOSTA VALUES
	(5, 1, 10, CAST('2026-03-10 10:01:00' AS DATETIME), 1, 1),
	(9, 1, 8, CAST('2024-03-10 10:06:00' AS DATETIME), 2, 2),
	(4, 0, 12, CAST('2026-03-11 09:17:00' AS DATETIME), 1, 3),
	(4, 1, 15, CAST('2023-03-11 09:32:00' AS DATETIME), 3, 4),
	(18, 1, 20, CAST('2024-03-12 14:03:00' AS DATETIME), 2, 5),
	(30, 0, 18, CAST('2020-03-12 14:23:00' AS DATETIME), 4, 6),
	(4, 1, 9, CAST('2017-03-13 11:12:00' AS DATETIME), 5, 7),
	(6, 0, 11, CAST('2026-03-13 11:28:00' AS DATETIME), 1, 8),
	(13, 1, 14, CAST('2023-03-14 15:04:00' AS DATETIME), 3, 9),
	(5, 0, 16, CAST('2024-03-14 15:18:00' AS DATETIME), 2, 10),
	(30, 1, 11, CAST('2018-03-25 10:02:00' AS DATETIME), 6, 11),
	(35, 0, 14, CAST('2025-03-25 10:18:00' AS DATETIME), 7, 12),
	(72, 1, 16, CAST('2025-03-26 11:23:00' AS DATETIME), 8, 13),
	(10, 0, 20, CAST('2020-03-26 11:44:00' AS DATETIME), 9, 14),
	(27, 1, 18, CAST('2019-03-27 14:14:00' AS DATETIME), 10, 15);
GO

INSERT INTO PROGRESSO VALUES
	(3, 2, 30, 1, 1),
	(2, 3, 20, 2, 2),
	(4, 1, 40, 3, 3),
	(1, 4, 10, 4, 1),
	(5, 0, 50, 5, 2),
	(6, 1, 60, 6, 2),
	(3, 4, 30, 7, 2),
	(7, 0, 70, 8, 3),
	(2, 5, 20, 9, 4),
	(8, 1, 80, 10, 5);
GO

--Comandos debug
/*
USE master;
GO

DROP DATABASE SIEM;
GO
*/

--Consultas SQL com os dados acima
-- Consultas que retornam todas as informações das tabelas

--01. Mostra todos os registros da tabela Usuarios
SELECT	IdUsuario		AS	'Código do Usuário',
		Nome			AS	'Nome do Usuário',
		Email		 	AS	'E-mail',
		DataCadastro	AS	'Data do Cadastro'
FROM USUARIOS
GO

--02. Mostra todos os registros da tabela Nível
SELECT	IdNivel		AS	'Código do Nível',
		Nome		AS	'Nome do Nível',
		Descricao	AS	'Descrição'
FROM NIVEL;
GO

--03. Mostra todos os registros da tabela Categoria
SELECT	IdCategoria	AS	'Código da Categoria',
		Nome		AS	'Nome da Categoria',
		Descricao	AS	'Descrição'
FROM CATEGORIA;
GO

--04. Mostra todos os registros da tabela Modedlo de Exercicio
SELECT	IdModelo			AS	'Código do Modelo de Exercício',
		Nome				AS	'Nome do Modelo de Exercício',
		Operacao			AS	'Operação',
		ValorMaximo			AS	'Valor Máximo',
		ValorMinimo			AS	'Valor Mínimo',
		QuantidadeOperandos	AS	'Quantidade de Operandos',
		Ativo				AS	'Status',
		IdCategoria			AS	'Código da Categoria',
		IdNivel				AS	'Código do Nível'
FROM MODELO_EXERCICIO;
GO

--05. Mostra todos os registros da tabela Exercicios Gerados
SELECT	IdExercicioGerado	AS	'Código do Exercício',
		Enunciado			AS	'Enunciado',
		RespostaCorreta		AS	'Resposta Correta',
		DataGeracao			AS	'Data Criação do Exercício',
		IdModelo			AS	'Código do Modelo de Exercício'
FROM EXERCICIO_GERADO;
GO

--06. Mostra todos os registros da tabela Resposta
SELECT	 IdResposta			AS 'Código da Resposta',
		 RespostaUsuario	AS 'Resposta do Usuário', 
		CASE
			WHEN Correta = 1 THEN 'Sim'
			ELSE 'Não'
		END AS	'Resposta Certa',
		 TempoResposta		AS 'Tempo da Resposta',
		 DataResposta		AS 'Data da Resposta',
		 IdUsuario			AS 'Código do Usuário',
		 IdExercicioGerado	AS 'Código do Exercício'
FROM RESPOSTA;
GO

--07. Mostra todos os registros da tabela Progresso
SELECT	IdProgresso		AS 'Código do Progresso',
		TotalAcertos	AS 'Total de Acertos',
		TotalErros		AS 'Total de Erros',
		Pontuacao		AS 'Pontuação Total',
		IdUsuario		AS 'Código do Usuário',
		IdNivel			AS 'Código do Nível'
FROM PROGRESSO;
GO

--Consultas mais detalhadas sobre as tabelas 

--08. Exibe Usuarios cadastrados após 2020
SELECT	Nome			AS	'Nome',
		Email			AS	'E-mail',
		DataCadastro	AS	'Data do Cadastro'
FROM USUARIOS
WHERE YEAR(DataCadastro) >= 2020
ORDER BY DataCadastro ASC;
GO

--09. Exibe todas as respostas corretas 
SELECT	IdResposta						AS	'Código Da Resposta',
		IdUsuario						AS	'Código do Usuário',
		RespostaUsuario					AS	'Resposta do Usuário',
		CASE
			WHEN Correta = 1 THEN 'Sim'
		END AS	'Resposta Certa',   
		TempoResposta					AS	'Tempo da Resposta',
		DataResposta					AS	'Data da Resposta'
FROM RESPOSTA
WHERE Correta = 1;
GO

--10. Exibe todas as respostas erradas
SELECT	IdResposta						AS	'Código Da Resposta',
		IdUsuario						AS	'Código do Usuário',
		RespostaUsuario					AS	'Resposta do Usuário',
		CASE
			WHEN Correta = 0 THEN 'Não'
		END AS	'Resposta Certa',   
		TempoResposta					AS	'Tempo da Resposta',
		DataResposta					AS	'Data da Resposta'
FROM RESPOSTA
WHERE Correta = 0;
GO

--11. Exibe Usuários que nome inicia com letra C
SELECT	IdUsuario		AS	'Código do Usuário',
		Nome			AS	'Nome'
FROM USUARIOS
WHERE Nome LIKE 'C%';
GO

--12. Exibe o total de usuários cadastrados 
SELECT	COUNT(IdUsuario)	AS 'Total de Usuarios Cadastrados'
FROM USUARIOS;
GO

--13. Exibe a maior pontuação registrada
SELECT MAX(Pontuacao)	AS 'Maior Pontuação Registrada'
FROM PROGRESSO;
GO 

--14. Exibe a menor pontuação registrada
SELECT MIN(Pontuacao)	AS 'Menor Pontuação Registrada'
FROM PROGRESSO;
GO 

--15. Exibe a soma total dos acertos
SELECT	SUM(TotalAcertos)	AS	'Soma de Todos os Acertos'
FROM PROGRESSO;
GO

--16. Exibe a soma total dos erros
SELECT	SUM(TotalErros)	AS	'Soma de Todos os Erros'
FROM PROGRESSO;
GO

--17. Exibe o nome do usuário e sua pontuação
SELECT	U.Nome							AS	'Nome do Usuário',
		P.Pontuacao						AS	'Pontuação'
FROM USUARIOS U INNER JOIN PROGRESSO P
    ON U.IdUsuario = P.IdUsuario
ORDER BY P.Pontuacao DESC;
GO

--18. Exibe a categoria e quantos exercicios existem da categoria 
SELECT	C.Nome									AS 'Nome da Cagegoria',
		COUNT(M.IdModelo)						AS 'Quantidade de Exercícios'
FROM CATEGORIA C INNER JOIN MODELO_EXERCICIO M
	ON C.IdCategoria = M.IdCategoria
GROUP BY C.Nome;
GO

--19. Exibe nome do usuario, o enunciado da questão, a resposta, se ela está correta e o tempo de resposta
SELECT	U.Nome								AS	'Nome do Usuário',
		E.Enunciado							AS	'Enunciado',
		R.RespostaUsuario					AS	'Resposta do Usuário',
		CASE
			WHEN R.Correta = 1 THEN 'Sim'
			ELSE 'Não'
		END AS	'Resposta Certa',
		R.TempoResposta						AS	'Tempo de Resposta'
FROM RESPOSTA R INNER JOIN USUARIOS U
    ON R.IdUsuario = U.IdUsuario	
INNER JOIN EXERCICIO_GERADO E
	ON R.IdExercicioGerado = E.IdExercicioGerado;
GO

--20. Exibe o nome do modelo de exercicio e sua categoria
SELECT	M.Nome									AS	'Modelo do Exercício',
		C.Nome									AS	'Categoria do Exercício'
FROM MODELO_EXERCICIO M	INNER JOIN CATEGORIA C
    ON M.IdCategoria = C.IdCategoria;
GO

--21. Exibe o modelo do exercicio e seu nível
SELECT	M.Nome									AS	'Modelo do Exercício',
		N.Nome									AS	'Dificuldade (Nível) do Exercício'
FROM MODELO_EXERCICIO M	INNER JOIN NIVEL N
    ON M.IdNivel = N.IdNivel;
GO

--22. Exibe o calculo de quantos anos o usuario está cadastrado
CREATE PROCEDURE uspCalculoTempoCadastro
		@nome	AS VARCHAR(100)
AS
		SET NOCOUNT ON;

		DECLARE @data_cadastro		DATETIME;
		DECLARE @tempo_cadastrado	INT;
		DECLARE @data_atual			DATETIME;

		SET @data_atual = (SELECT GETDATE());
		SET @data_cadastro = (SELECT DataCadastro FROM USUARIOS WHERE Nome = @nome);
		SET @tempo_cadastrado = DATEDIFF(YEAR, @data_cadastro, @data_atual)
				- CASE WHEN @data_atual < DATEADD(YEAR, DATEDIFF(YEAR, @data_cadastro, @data_atual),@data_cadastro)
					THEN 1
					ELSE 0
				END;

		SELECT	@nome				AS	'Nome do Usuário',
				@tempo_cadastrado	AS	'Tempo cadastrado em anos';

		SET NOCOUNT OFF;
GO

EXEC uspCalculoTempoCadastro 'Camila Freitas';
EXEC uspCalculoTempoCadastro 'Ricardo Mendes';
EXEC uspCalculoTempoCadastro 'João Silva';
GO

--23. Exibe o 3 exercicos respondidos mais rápido
SELECT TOP 3
	U.Nome			AS	'Nome do Usuário',
	E.Enunciado		AS	'Enunciado do Exercicio',
	R.TempoResposta	AS	'Tempo de Resposta'
FROM RESPOSTA R INNER JOIN USUARIOS U
	ON R.IdUsuario = U.IdUsuario
INNER JOIN EXERCICIO_GERADO E
	ON R.IdExercicioGerado = E.IdExercicioGerado
ORDER BY R.TempoResposta ASC;
GO

--24.  Exibe o percentual de acertos 
CREATE FUNCTION PercentualAcertos (@Acertos INT, @Erros INT)
	RETURNS DECIMAL(10,2)
AS
	BEGIN
		DECLARE @Resultado DECIMAL(10,2);
		SET @Resultado = (@Acertos * 100.0) / (@Acertos + @Erros);
		RETURN @Resultado;
	END;
GO

SELECT dbo.PercentualAcertos(10,2) AS	'Percentual de Acertos';
GO

--25. Exibe o total de respostas de um usuário passando seu ID
CREATE FUNCTION TotalRespostasUsuario (@IdUsuario INT)
	RETURNS INT
AS
		BEGIN	
			DECLARE @Total INT;
			SELECT @Total = COUNT(*) FROM RESPOSTA
			WHERE IdUsuario = @IdUsuario;
			RETURN @Total;
		END;
GO

SELECT dbo.TotalRespostasUsuario(1)	AS	'Total de Respostas';
GO

--26. 