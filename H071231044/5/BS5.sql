USE classicmodels;

SELECT * FROM products;
-- Query 1
SELECT DISTINCT
    c.customerName AS 'namaKustomer',
    p.productName AS 'namaProduk',
    pl.textDescription
FROM customers AS c
JOIN orders AS o
    ON c.customerNumber = o.customerNumber
JOIN orderdetails AS od
    ON o.orderNumber = od.orderNumber
JOIN products AS p
    ON od.productCode = p.productCode
JOIN productlines AS pl
    ON p.productLine = pl.productLine
WHERE p.productName LIKE '%Titanic%'
ORDER BY c.customerName ASC;

-- Query 2
SELECT
    c.customerName,
    p.productName,
    o.`status`,
    o.shippedDate
FROM customers AS c
JOIN orders AS o
    ON c.customerNumber = o.customerNumber
JOIN orderdetails AS od
    ON o.orderNumber = od.orderNumber
JOIN products AS p
    ON od.productCode = p.productCode
WHERE 
    p.productName LIKE '%Ferrari%'
    AND o.`status` = 'Shipped'
    AND o.shippedDate BETWEEN '2003-10-01' AND '2004-10-01'
ORDER BY o.shippedDate DESC;

-- Query 3
SELECT
    s.firstName AS 'Supervisor',
    k.firstName AS 'Karyawan'
FROM employees AS k
JOIN employees AS s
    ON k.reportsTo = s.employeeNumber
WHERE s.firstName = 'Gerard'
ORDER BY k.firstName ASC;

-- Query 4
## a
SELECT
    c.customerName,
    p.paymentDate,
    e.firstName AS 'employeeName',
    p.amount
FROM customers AS c
JOIN payments AS p
    ON c.customerNumber = p.customerNumber
JOIN employees AS e
    ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE p.paymentDate LIKE '%-11-%';

## b
SELECT
    c.customerName,
    p.paymentDate,
    e.firstName AS 'employeeName',
    p.amount
FROM customers AS c
JOIN payments AS p
    ON c.customerNumber = p.customerNumber
JOIN employees AS e
    ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE p.paymentDate LIKE '%-11-%'
ORDER BY p.amount DESC
LIMIT 1;

## c
SELECT
    c.customerName,
    po.productName
FROM customers AS c
JOIN orders AS o
    ON c.customerNumber = o.customerNumber
JOIN orderdetails AS od
    ON o.orderNumber = od.orderNumber
JOIN products AS po
    ON od.productCode = po.productCode
JOIN payments AS p
	ON p.customerNumber = c.customerNumber
WHERE p.paymentDate LIKE '%-11-%' and c.customerName = 'corporate gift ideas co.';


##5
UPDATE orders
SET `status` = 'On Hold'
WHERE shippedDate IS NULL;

SELECT 
	od.orderNumber, 
	o.orderDate, 
	o.shippedDate, 
	c.customerName, 
	p.productName,
	o.`status`
	
FROM orders AS o
JOIN customers AS c
	ON c.customerNumber = o.customerNumber
JOIN orderdetails AS od 
	ON o.orderNumber = od.orderNumber
JOIN products AS p
	ON od.productCode = p.productCode
	WHERE o.shippedDate IS NULL
	ORDER BY c.customerName;
	
DROP DATABASE classicmodels;

##Hard
SELECT
	c.customerName,
	o.orderNumber,
	o.orderDate,
	o.shippedDate,
	p.productName,
	p.buyPrice,
	od.quantityOrdered,
	off.city,
	e.firstName,
	e.lastName
FROM customers AS c
JOIN orders AS o
	ON o.customerNumber = c.customerNumber
JOIN orderdetails AS od
	ON od.orderNumber = o.orderNumber
JOIN products AS p
	ON p.productCode = od.productCode
JOIN employees AS e
	ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN offices AS `off`
	ON `off`.officeCode = e.officeCode
	WHERE p.productName LIKE '2%o'
	AND o.orderDate > '2003-03-01'
	AND od.quantityOrdered > 15
	AND c.city = 'San Francisco'
	AND p.buyPrice BETWEEN 50 AND 150
	ORDER BY c.customerName ASC, o.orderDate DESC;
	
