--Criação do Banco
CREATE DATABASE P715;
GO

USE P715;
GO

SET DATEFORMAT DMY;
GO

--Criação das tabelas
CREATE TABLE CUSTOMER(
	CUS_CODE		INT				PRIMARY KEY,
	CUS_LNAME		VARCHAR(30)		NOT NULL,
	CUS_FNAME		VARCHAR(30)		NOT NULL,
	CUS_INITIAL		CHAR(1)			NULL,
	CUS_AREACODE	CHAR(3)			NOT NULL,	
	CUS_PHONE		VARCHAR(9)		NOT NULL,	
	CUS_BALANCE		DECIMAL(10,2)	NOT NULL DEFAULT 0
);
GO

CREATE TABLE INVOICE(
	INV_NUMBER	INT	PRIMARY KEY,
	CUS_CODE	INT NOT NULL FOREIGN KEY REFERENCES CUSTOMER(CUS_CODE),
	INV_DATE	DATE
);
GO

CREATE TABLE VENDOR(
	V_CODE		INT PRIMARY	KEY,
	V_NAME		VARCHAR(30)	NOT NULL,
	V_CONTACT	VARCHAR(30)	NOT NULL,
	V_AREACODE	CHAR(3)		NOT NULL,
	V_PHONE		CHAR(9)		NOT NULL,
	V_STATE		CHAR(2)		NOT NULL,
	V_ORDER		CHAR(1)		NOT NULL
);
GO

CREATE TABLE PRODUCT(
	P_CODE		VARCHAR(20) PRIMARY KEY,
	P_DESCRIPT	VARCHAR(200)	NOT NULL,
	P_INDATE	DATE			NOT NULL,
	P_QOH		INT				NOT NULL,
	P_MIN		INT				NOT NULL,
	P_PRICE		DECIMAL(10,2)	NOT NULL,
	P_DISCOUNT	DECIMAL(10,2)	NOT NULL,
	V_CODE		INT NULL FOREIGN KEY REFERENCES VENDOR(V_CODE)
);
GO

CREATE TABLE LINE(
	INV_NUMBER	INT		NOT NULL FOREIGN KEY REFERENCES INVOICE(INV_NUMBER),
	LINE_NUMBER INT		NOT NULL,
	P_CODE		VARCHAR(20)	NOT NULL FOREIGN KEY REFERENCES PRODUCT(P_CODE),
	LINE_UNITS	INT		NOT NULL,
	LINE_PRICE	DECIMAL(10,2) NOT NULL,
	PRIMARY KEY (INV_NUMBER, LINE_NUMBER)
);
GO


--INSERINDO OS VALORES CORESPONDENTES A FIGURA P7.15 DO LIVRO 
INSERT INTO CUSTOMER VALUES
	(10010, 'Ramas', 'Alfred', 'A', '615', '844-2573', 0.00),
	(10011, 'Dunne', 'Leona', 'K', '713', '894-1238', 0.00),
	(10012, 'Smith', 'Kathy', 'W', '615', '894-2285', 345.86),
	(10013, 'Olowski', 'Paul', 'F', '615', '894-2180', 536.75),
	(10014, 'Orlando', 'Myron', NULL, '615', '222-1672', 0.00),
	(10015, 'O''Brian', 'Amy', 'B', '713', '442-3381', 0.00),
	(10016, 'Brown', 'James', 'G', '615', '297-1228', 221.19),
	(10017, 'Williams', 'George', NULL, '615', '290-2556', 768.93),
	(10018, 'Farriss', 'Anne', 'G', '713', '382-7185', 216.55),
	(10019, 'Smith', 'Olette', 'K', '615', '297-3809', 0.00);
GO

INSERT INTO INVOICE VALUES
	(1001, 10014, '16-03-2008'),
	(1002, 10011, '16-03-2008'),
	(1003, 10012, '16-03-2008'),
	(1004, 10011, '17-03-2008'),
	(1005, 10018, '17-03-2008'),
	(1006, 10014, '17-03-2008'),
	(1007, 10015, '17-03-2008'),
	(1008, 10011, '17-03-2008');
GO

INSERT INTO VENDOR VALUES
	(21225, 'Bryson, Inc.', 'Smithson', '615', '223-3234', 'TN', 'Y'),
	(21226, 'SuperLoo, Inc.', 'Flushing', '904', '215-8995', 'FL', 'N'),
	(21231, 'D&E Supply', 'Singh', '615', '228-3245', 'TN', 'Y'),
	(21344, 'Gomez Bros.', 'Ortega', '615', '889-2546', 'KY', 'N'),
	(22567, 'Dome Supply', 'Smith', '901', '678-1419', 'GA', 'N'),
	(23119, 'Randsets Ltd.', 'Anderson', '901', '678-3998', 'GA', 'Y'),
	(24004, 'Brackman Bros.', 'Browning', '615', '228-1410', 'TN', 'N'),
	(24288, 'ORDVA, Inc.', 'Hakford', '615', '898-1234', 'TN', 'Y'),
	(25443, 'B&K, Inc.', 'Smith', '904', '227-0093', 'FL', 'N'),
	(25501, 'Damal Supplies', 'Smythe', '615', '890-3529', 'TN', 'N'),
	(25595, 'Rubicon Systems', 'Orton', '904', '456-0092', 'FL', 'Y');
GO

INSERT INTO PRODUCT VALUES
	('11QER/31', 'Power painter, 15 psi., 3-nozzle', '03-11-2007', 8, 5, 109.99, 0.00, 25595),
	('13-Q2/P2', '7.25-in. pwr.saw blade', '13-12-2007', 32, 15, 14.99, 0.05, 21344),
	('14-Q1/L3', '9.00-in. pwr.saw blade', '13-12-2007', 18, 12, 17.49, 0.00, 21344),
	('1546-QQ2', 'Hrd.cloth, 1/4-in.,2x50', '15-01-2008', 15, 8, 39.95, 0.00, 23119),
	('1558-QW1', 'Hrd.cloth, 1/2-in.,3x50', '15-01-2008', 23, 5, 43.99, 0.00, 23119),
	('2232/QTY', 'B&D jigsaw, 12-in. blade', '30-12-2007', 8, 5, 109.92, 0.05, 24288),
	('2232/QWE', 'B&D jigsaw, 8-in. blade', '24-12-2007', 6, 5, 99.87, 0.05, 24288),
	('2238/QPD', 'B&D cordless drill, 1/2-in', '20-01-2008', 12, 5, 38.95, 0.05, 25595),
	('23109-HB', 'Claw hammer', '20-01-2008', 23, 10, 9.95, 0.10, 21225),
	('23114-AA', 'Sledge hammer, 12 lb.', '02-01-2008', 8, 5, 14.40, 0.00, NULL),
	('54778-2T', 'Rat-tail file, 1/8-in. fine', '15-12-2007', 43, 20, 4.99, 0.00, 21344),
	('89-WRE-Q', 'Hicut chain saw, 16 in.', '07-02-2008', 11, 5, 256.99, 0.05, 24288),
	('PVC23DRT', 'PVC pipe, 3.5-in., 8-ft', '20-02-2008', 188, 75, 5.87, 0.00, NULL),
	('SM-18277', '1.25-in. metal screw, 25', '01-03-2008', 172, 75, 6.99, 0.00, 21225),
	('SW-23116', '2.5-in. wd. screw, 50', '24-02-2008', 237, 100, 8.45, 0.00, 21231),
	('WR3/TT3', 'Steel matting, 4''x8''x1/6'', .5'' mesh', '17-01-2008', 18, 5, 119.95, 0.10, 25595);
GO

INSERT INTO LINE VALUES
	(1001, 1, '13-Q2/P2', 1, 14.99),
	(1001, 2, '23109-HB', 1, 9.95),
	(1002, 1, '54778-2T', 2, 4.99),
	(1003, 1, '2238/QPD', 1, 38.95),
	(1003, 2, '1546-QQ2', 1, 39.95),
	(1003, 3, '13-Q2/P2', 5, 14.99),
	(1004, 1, '54778-2T', 3, 4.99),
	(1004, 2, '23109-HB', 2, 9.95),
	(1005, 1, 'PVC23DRT', 12, 5.87),
	(1006, 1, 'SM-18277', 3, 6.99),
	(1006, 2, '2232/QTY', 1, 109.92),
	(1006, 3, '23109-HB', 1, 9.95),
	(1006, 4, '89-WRE-Q', 1, 256.99),
	(1007, 1, '13-Q2/P2', 2, 14.99),
	(1007, 2, '54778-2T', 1, 4.99),
	(1008, 1, 'PVC23DRT', 5, 5.87),
	(1008, 2, 'WR3/TT3', 3, 119.95),
	(1008, 3, '23109-HB', 1, 9.95);
GO
-----
--EXERCICIOS LIVRO 16 - 33
-----
--16. Escreva uma consulta que conte o numero de faturas.
SELECT COUNT(INV_NUMBER) AS 'Total de Faturas'
FROM INVOICE;
GO

--17. Escreva uma consulta que conte o número de clientes com superior a US$ 500.
SELECT COUNT(CUS_BALANCE) AS 'Salários Superiores a US$500' FROM CUSTOMER
WHERE CUS_BALANCE > 500.00;
GO

--18. Gere uma listagem de todas as compras feitas por clientes, utilizando como orientação o resultado apresentado na figura P7.16
SELECT	C.CUS_CODE,
		I.INV_NUMBER,
		FORMAT(I.INV_DATE, 'dd-MMM-yy', 'en-US')	AS	'INV-DATE',
		P.P_DESCRIPT,
		L.LINE_UNITS,
		L.LINE_PRICE
FROM CUSTOMER C
JOIN INVOICE I 
    ON C.CUS_CODE = I.CUS_CODE
JOIN LINE L 
    ON I.INV_NUMBER = L.INV_NUMBER
JOIN PRODUCT P 
    ON L.P_CODE = P.P_CODE
ORDER BY 
    C.CUS_CODE,
    I.INV_NUMBER,
    P.P_DESCRIPT;
GO

--19. Gere uma lista de compras de clientes, incluindo os subtotais de cada numero de linha de fatura com orientação da figura P7.17
SELECT	C.CUS_CODE,
		I.INV_NUMBER,
		P.P_DESCRIPT,
		L.LINE_UNITS					AS	'Units Bought',
		L.LINE_PRICE					AS	'Unit Price',
		(L.LINE_UNITS * L.LINE_PRICE)	AS	'Subtotal'
FROM CUSTOMER C
JOIN INVOICE I 
    ON C.CUS_CODE = I.CUS_CODE
JOIN LINE L 
    ON I.INV_NUMBER = L.INV_NUMBER
JOIN PRODUCT P 
    ON L.P_CODE = P.P_CODE
ORDER BY 
	C.CUS_CODE,
    I.INV_NUMBER,
    P.P_DESCRIPT;
GO

--20. Modifique a consulta utilizada no Problema 19 para produzir o resumo apresentado na figura P7.18
SELECT	C.CUS_CODE,
		C.CUS_BALANCE,
		SUM(L.LINE_UNITS * L.LINE_PRICE)	AS	'Total Purchases'
FROM CUSTOMER C
JOIN INVOICE I
	ON C.CUS_CODE = I.CUS_CODE
JOIN LINE L
	ON I.INV_NUMBER = L.INV_NUMBER
GROUP BY	
	C.CUS_CODE,	
	C.CUS_BALANCE
ORDER BY
	C.CUS_CODE;
GO

--21. Modifique a consulta do Problema 20 de modo a incluir o nímero de compras individuais de produtos feitas por clientes
SELECT	C.CUS_CODE,
		C.CUS_BALANCE,
		SUM(L.LINE_UNITS * L.LINE_PRICE)	AS	'Total Purchases',
		COUNT(L.LINE_NUMBER)				AS	'Number of Purchases'
FROM CUSTOMER C
JOIN INVOICE I
	ON C.CUS_CODE = I.CUS_CODE
JOIN LINE L
	ON I.INV_NUMBER = L.INV_NUMBER
GROUP BY	
	C.CUS_CODE,	
	C.CUS_BALANCE
ORDER BY
	C.CUS_CODE;
GO

--22. Utilize uma consulta para computar a quantia média de compras por produto feita por cliente.
SELECT	C.CUS_CODE,
		C.CUS_BALANCE,
		SUM(L.LINE_UNITS * L.LINE_PRICE)	AS	'Total Purchases',
		COUNT(L.LINE_NUMBER)				AS	'Number of Purchases',
		AVG(L.LINE_UNITS * L.LINE_PRICE)	AS	'Average Purchase Amount' 
FROM CUSTOMER C
JOIN INVOICE I
	ON C.CUS_CODE = I.CUS_CODE
JOIN LINE L
	ON I.INV_NUMBER = L.INV_NUMBER
GROUP BY	
	C.CUS_CODE,	
	C.CUS_BALANCE
ORDER BY
	C.CUS_CODE;
GO

--23. Crie um aconsulta para produzir as compras totais por fatura.
SELECT	I.INV_NUMBER,
		SUM(L.LINE_UNITS * L.LINE_PRICE)	AS	'Invoice Total'
FROM INVOICE I 
JOIN LINE L
	ON I.INV_NUMBER = L.INV_NUMBER
GROUP BY
	I.INV_NUMBER
ORDER BY
	I.INV_NUMBER;
GO

--24. Utilize uma consulta para mostrar as faturas e totais de faturas.
SELECT	I.CUS_CODE,
		I.INV_NUMBER,
		SUM(L.LINE_UNITS * L.LINE_PRICE)	AS	'Invoice Total'
FROM INVOICE I 
JOIN LINE L
	ON I.INV_NUMBER = L.INV_NUMBER
GROUP BY
	I.CUS_CODE,
	I.INV_NUMBER
ORDER BY
	I.CUS_CODE,
	I.INV_NUMBER;
GO

--25. Escreva uma consulta que produza o numero de faturas e as quantias totais de compras por cliente.SELECT	I.CUS_CODE,
SELECT	I.CUS_CODE,
		COUNT(DISTINCT I.INV_NUMBER)		AS	'Number of Invoices',
		SUM(L.LINE_UNITS * L.LINE_PRICE)	AS	'Total Customer Purchases'
FROM INVOICE I
JOIN LINE L 
	ON I.INV_NUMBER = L.INV_NUMBER
GROUP BY
	I.CUS_CODE
ORDER BY
	I.CUS_CODE;
GO

--26. Utilizando os resultados do Problema 25 como base, escreva uma consulta que gere o número total de faturas, 
--o total de todas as faturas, o menor e o maior valor de fatura, e o valor médio de todas as faturas.
SELECT	SUM(INV_NUMBER)								AS 'Total Invoices',
		SUM(TOTAL_PURCHASE)							AS 'Total Sales',
		MIN(TOTAL_PURCHASE)							AS 'Minimum Sale',
		MAX(TOTAL_PURCHASE)							AS 'Largest Sale',
		ROUND(AVG(TOTAL_PURCHASE),2)				AS 'Average Sale'
FROM ( SELECT	I.CUS_CODE,
				COUNT(DISTINCT I.INV_NUMBER)		AS INV_NUMBER,
				SUM(L.LINE_UNITS * L.LINE_PRICE)	AS TOTAL_PURCHASE
FROM INVOICE I
	JOIN LINE L
		ON I.INV_NUMBER = L.INV_NUMBER
GROUP BY
	I.CUS_CODE
) AS CUSTOMER_TOTALS;
GO

--27. Liste as caracteristicas dos saldos dos clientes que fizeram compras durante o ciclo atual de faturas
-- ou seja, dos clientes que aparecem na tabela INVOICE.
SELECT	DISTINCT
		C.CUS_CODE,
		C.CUS_BALANCE
FROM CUSTOMER C
JOIN INVOICE I
	ON I.CUS_CODE = C.CUS_CODE
ORDER BY
	C.CUS_CODE;
GO

--28. Utilizando os resultados da consulta do Problema 27, forneça um resumo das caracteristicas dos saldos de clientes.
SELECT	MIN(CUS_BALANCE)	AS	'Minimum Balance',
		MAX(CUS_BALANCE)	AS	'Maximum Balance',
		AVG(CUS_BALANCE)	AS	'Average Balance'
FROM CUSTOMER
WHERE CUS_CODE IN (SELECT CUS_CODE FROM INVOICE);
GO

--29. Crie uma consulta que encontre as caracteristicas dos saldos de todos os clientes, incluindo o total de saldos a receber.
SELECT	SUM(CUS_BALANCE)	AS	'Total Balance',
		MIN(CUS_BALANCE)	AS	'Minimum Balance',
		MAX(CUS_BALANCE)	AS	'Maximum Balance',
		AVG(CUS_BALANCE)	AS	'Average Balance'
FROM CUSTOMER
GO

--30. Obtenha a listagem de clientes  que não fizeram compras durante o período de faturamento.
SELECT	CUS_CODE,
        CUS_BALANCE
FROM CUSTOMER
WHERE	CUS_CODE NOT IN (SELECT CUS_CODE FROM INVOICE)
ORDER BY
	CUS_CODE;
GO

--31. Obtenha o resumo dos saldos de todos os clientes que não fizeram compras durante o periodo atual de faturamento.
SELECT	SUM(CUS_BALANCE)	AS	'Total Balance',
		MIN(CUS_BALANCE)	AS	'Minimum Balance',
		MAX(CUS_BALANCE)	AS	'Maximum Balance',
		AVG(CUS_BALANCE)	AS	'Average Balance'
FROM CUSTOMER 
WHERE CUS_CODE NOT IN (SELECT CUS_CODE FROM INVOICE);
GO

--32. Crie uma consulta para produzir o resumo do valor dos produutos atualmente em esqtoque. Observe que
-- o valor de cada produto é obtido pela multiplicação das unidades atualmente em estoque pelo preço unitário.
-- utilize a cláusula ORDER BY para obter a ordem apresentada.
SELECT  P_DESCRIPT,
        P_QOH,
        P_PRICE,
        (P_PRICE * P_QOH) AS Subtotal
FROM PRODUCT
ORDER BY P_CODE;
GO

--33. Utilizando os resultados da consluta criada no Problema 32, obtenha o valor total do estoque de produtos.
SELECT  SUM(Subtotal) AS 'Total Inventory Value'
FROM (SELECT (P_PRICE * P_QOH) AS Subtotal FROM PRODUCT) AS PROD_TOTAL;
GO	
