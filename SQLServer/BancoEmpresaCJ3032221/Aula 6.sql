--Cria Contexto
USE EmpresaCJ3032221;
GO


--Define Formato Data(DIA/MES/ANO) SQL Server
SET DATEFORMAT DMY;
GO
----------------------------------------
--aula 19/03 - 23/03

--CRIAÇAO DE TABELAS DEPENDENTES ARQ CSV IMPORTE MASSA E JUNÇÂO TABELAS
--Junção Tabelas (JOINS) 
--RELACIONAMENTo IMPLEMENTADO PELA CHAVE ESTRANGEIRA FK 
--Incerção de Dados (INSERT) importado por fonte externa como Arquivos CSV (Comma-Separated Values)
--células separadas por ',' ou '/'ou ' ' ou '/' ou';'

--Criação arquivo csv no LibreOffice Calc chave estrangeira deve corresponder com a chave primaria da tabela

-- PARA USO DE DOCKER
-- $ docker cp /ORIGEM/arquivo.csv 
--num_container:/arquivo.csv

-- $ docker cp /dados/arquivo.csv 
--1234:/arquivo.csv

--$ docker wxec num_container ls/

--Importe em massa (externo para tabela)/exportação em massa(contrario do importe) 

SELECT NAME FROM sys.tables;
GO

--Criar Tabela DEPENDENTES

CREATE TABLE DEPENDENTES (
	CodDependente		INT			PRIMARY KEY,
	Nome				VARCHAR(35)	NOT NULL,
	Sexo				CHAR(1)		NULL,
	DataNascimento		DATE		NOT NULL,
	ID					INT			FOREIGN KEY
	  REFERENCES FUNCIONARIOS (ID)
);
GO
--Ver dados tabela DEPENDENTES
SELECT  * FROM DEPENDENTES;
GO

--Sintaxe BULK INSERT (foto), PARAMETROS, (foto tbm), TIPOS -> char, native, widechar(unicode), widenative
--COD PAGINA	-> ACP, OEM, RAW, code_page 
BULK INSERT DEPENDENTES
	FROM '\dados\dependentes.csv' --...\xpto\arquivo.csv  (...\ -> ENDEREÇO COMPLETO)
WITH (
	FIRSTROW = 2,
	DATAFILETYPE = 'widechar',
	FIELDTERMINATOR = ','
  --CODEPAGE = '65001' -- para WINDOWS
);
GO

