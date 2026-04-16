-- Habilita o contexto do banco de dados INTERCAMBIO
USE INTERCAMBIOCJ3032221;
GO

--Muda lingagem do sistema
SET LANGUAGE us_english;
GO

--PROCEDIMENTO ARMAZENADO E FUNÇÃO (SQL PROCEDURAL)
-- AULA 13/04/2026

--SEQUENCE obj associado a um esquema definido pelo usuário que gera sequencia de valores numéricos
--de acordo com a especificação a qual sequencia foi criada
--gerada em ordem crescente ou decrescente(numérico), dentro do intervalo definido e pode ser configurada
--a reiniciar  baseado no intervalo definido (se esgotar), não é acossiada a tabela especifica
--acionado sempre que necessário (diferente de IDENTITY que depende das tabelas e campos)
--usa em qualquer coisa (como contador)

