## Nomor 1
SELECT DISTINCT c.customerName AS namaKustomer, p.productName AS namaProduk, pl.textDescription
FROM customers AS c
INNER JOIN orders AS o
USING (customerNumber)
INNER JOIN orderdetails AS od
USING (orderNumber)
INNER JOIN products AS p
USING (productCode)
INNER JOIN productlines AS pl
USING (productLine)
WHERE p.productName LIKE '%titanic%'
ORDER BY c.customerName ASC;

## Nomor 2
SELECT c.customerName, p.productName, o.`status`, o.shippedDate
FROM customers AS c
INNER JOIN orders AS o
USING (customerNumber)
INNER JOIN orderdetails AS od
USING (orderNumber)
INNER JOIN products AS p
USING (productCode)
INNER JOIN productlines AS pl
USING (productLine)
WHERE p.productName LIKE '%ferrari%' 
AND o.`status` LIKE '%shipped%'
AND o.shippedDate BETWEEN '2003-10-01' AND '2004-10-30'
ORDER BY o.shippedDate DESC;


## Nomor 3
SELECT * FROM employees
WHERE firstName = 'Gerard' OR lastName = 'Gerard'
SELECT e.firstName AS Supervisor, o.firstName AS Karyawan
FROM employees AS e
JOIN employees AS o
ON o.reportsTo = e.employeeNumber
WHERE e.firstName = 'Gerard'
ORDER BY o.firstName ASC;
 

## Nomor 4
-- 4a
SELECT c.customerName, p.paymentDate, e.firstName AS employeeName, p.amount
FROM payments AS p 
JOIN customers AS c
USING (customernumber)
JOIN employees AS e
ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE p.paymentDate LIKE '____-11%';

-- 4b
SELECT c.customerName, p.paymentDate, e.firstName AS employeeName, p.amount
FROM payments AS p 
JOIN customers AS c
USING (customernumber)
JOIN employees AS e
ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE p.paymentDate LIKE '____-11%'
ORDER BY p.amount DESC
LIMIT 1;

SELECT * FROM payments 
WHERE paymentdate LIKE '____-11%'
ORDER BY amount DESC
LIMIT 1;

-- 4c
SELECT c.customerName, ps.productName
FROM payments AS p 
JOIN customers AS c
USING (customernumber)
JOIN employees AS e
ON c.salesRepEmployeeNumber = e.employeeNumber
INNER JOIN orders AS o
USING (customerNumber)
INNER JOIN orderdetails AS od
USING (orderNumber)
INNER JOIN products AS ps
USING (productCode)
WHERE c.customerName = 'Corporate Gift Ideas Co.' 
AND p.paymentDate LIKE '____-11%'


SELECT o.orderNumber, o.orderDate, o.shippedDate, c.customerName, p.productName, o.`status`
FROM customers AS c
JOIN orders AS o
USING (customerNumber)
JOIN orderdetails AS od
USING (orderNumber)
JOIN products AS p
USING (productCode)


## Soal Tambahann

SELECT c.customerName, os.orderNumber, os.orderDate, 
os.shippedDate, p.productName, od.priceEach, o.city AS officeCity, 
od.quantityOrdered
FROM offices AS o
JOIN employees AS e
USING (officecode)
JOIN customers AS c
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN orders AS os
USING (customernumber)
JOIN orderdetails AS od
USING (ordernumber)
JOIN products AS p
USING (productcode)
WHERE os.orderDate < '2004-12-25';




 

	


