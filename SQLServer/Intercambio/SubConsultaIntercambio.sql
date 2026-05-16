-- Habilita o contexto do banco de dados INTERCAMBIO
USE INTERCAMBIOCJ3032221;
GO

-- Realiza a união sem exibir os registros duplicados
SELECT CodAluno		AS 'Código do Aluno',
	   NomeAluno	AS 'Nome do Aluno',
	   Genero		AS 'Gênero do Aluno'
FROM ALUNOS
	UNION
SELECT CodAluno		AS 'Código do Aluno',
	   NomeAluno	AS 'Nome do Aluno',
	   Genero		AS 'Gênero do Aluno'
FROM AlunosCOPIA
ORDER BY CodAluno, NomeAluno;
GO

-- Realiza a união, exibindo os registros duplicados
SELECT CodAluno		AS 'Código do Aluno',
	   NomeAluno	AS 'Nome do Aluno',
	   Genero		AS 'Gênero do Aluno'
FROM ALUNOS
	UNION ALL
SELECT CodAluno		AS 'Código do Aluno',
	   NomeAluno	AS 'Nome do Aluno',
	   Genero		AS 'Gênero do Aluno'
FROM AlunosCOPIA
ORDER BY CodAluno, NomeAluno;
GO

-- Retorna somente os registros que existem nas duas consultas 
SELECT CodAluno		AS 'Código do Aluno',
	   NomeAluno	AS 'Nome do Aluno',
	   Genero		AS 'Gênero do Aluno'
FROM ALUNOS
	INTERSECT
SELECT CodAluno		AS 'Código do Aluno',
	   NomeAluno	AS 'Nome do Aluno',
	   Genero		AS 'Gênero do Aluno'
FROM AlunosCOPIA
ORDER BY CodAluno, NomeAluno;
GO

-- Retorna somente os registro que existem na primeira consulta
SELECT CodAluno		AS 'Código do Aluno',
	   NomeAluno	AS 'Nome do Aluno',
	   Genero		AS 'Gênero do Aluno'
FROM ALUNOS
	EXCEPT
SELECT CodAluno		AS 'Código do Aluno',
	   NomeAluno	AS 'Nome do Aluno',
	   Genero		AS 'Gênero do Aluno'
FROM AlunosCOPIA
ORDER BY CodAluno, NomeAluno;
GO

-- Seleciona somente os alunos cujo nome aparece
-- nas duas tabelas. Versão com INTERSECT
SELECT NomeAluno AS 'Nome do Aluno'
FROM ALUNOS
	INTERSECT
SELECT NomeAluno AS 'Nome do Aluno'
FROM AlunosCOPIA
ORDER BY NomeAluno;
GO

-- Seleciona somente os alunos cujo nome aparece
-- nas duas tabelas. Versão com uma subconsulta IN.
SELECT Nomealuno AS 'Nome do Aluno'
FROM ALUNOS
WHERE NomeAluno IN
	(SELECT NomeAluno FROM AlunosCOPIA)
ORDER BY NomeAluno;
GO

-- Exibe informações sobre os alunos e as viagens que eles realizaram
SELECT VIAGENS.CodViagem	AS 'Código',
	   ALUNOS.NomeAluno		AS 'Nome do Aluno',
	   ALUNOS.Telefone,
	   ALUNOS.Genero		AS 'Gênero',
	   (SELECT NomePais FROM PAISES WHERE CodPais = ALUNOS.PaisOrigem) AS 'Origem',
	   (SELECT NomePais FROM PAISES WHERE CodPais = VIAGENS.PaisDestino) AS 'Destino',
	   VIAGENS.DataSaida	AS 'Data de Saída',
	   VIAGENS.DataRetorno	AS 'Data de Retorno',
	   VIAGENS.Valor		AS 'Preço da Viagem R$'
FROM ALUNOS INNER JOIN VIAGENS
	ON ALUNOS.CodViagem = VIAGENS.CodViagem;
GO

-- Exibe os dados dos países utilizados como destino
-- nas viagens dos alunos, cujo código seja 'USA'
SELECT CodPais		AS 'Código',
	   NomePais		AS 'País de Destino',
	   IdiomaPais	AS 'Idioma'
FROM PAISES
WHERE CodPais = (
	SELECT DISTINCT PaisDestino
	FROM VIAGENS
	WHERE PaisDestino = 'USA'
);
GO

-- Exibe os dados dos países utilizados como
-- destino nas viagens dos alunos cadastrados
SELECT CodPais		AS 'Código',
	   NomePais		AS 'País de Destino',
	   IdiomaPais	AS 'Idioma'
FROM PAISES
WHERE CodPais IN (
	SELECT PaisDestino FROM VIAGENS
);
GO

-- Exibe o código, nome e quantidade de viagens cadastradadas para o país de
-- destino. Exibe somente as informações para os países onde a quantidade de
-- viagens seja maior ou igual a quantidade de viagens realizadas para o México.
SELECT P.CodPais	AS 'Código',
	   P.NomePais	AS 'País de Destino',
	   COUNT (CodPais) AS 'Total de Viagens'
FROM PAISES P INNER JOIN VIAGENS V
	ON P.CodPais = V.PaisDestino
GROUP BY P.CodPais, P.NomePais
HAVING COUNT(P.CodPais) >= (
	SELECT COUNT(PaisDestino) FROM VIAGENS
	WHERE PaisDestino = 'MEX'
);
GO

-- Exibe os dados dos países utilizados como destino nas viagens dos alunos,
-- desde que esses países sejam Estados Unidos, México ou Brasil.
SELECT CodPais		AS 'Código',
	   NomePais		AS 'País de Destino',
	   IdiomaPais	AS 'Idioma'
FROM PAISES
WHERE CodPais = ANY (
	SELECT PaisDestino FROM VIAGENS
	WHERE PaisDestino IN ('USA', 'MEX', 'BRA')
);
GO

-- Exibe os dados das viagens que não foram cadastradas na tabela ALUNOS
SELECT CodViagem	AS 'Código da Viagem',
	   DataSaida	AS 'Data de Saída',
	   DataRetorno	AS 'Data de Retorno',
	   PaisDestino	AS 'Destino'
FROM VIAGENS
WHERE CodViagem > ALL (
	SELECT CodViagem FROM ALUNOS
);
GO

