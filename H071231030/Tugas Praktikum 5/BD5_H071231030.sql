USE classicmodels

# Nomor 1
SELECT DISTINCT c.customerName AS namakustomer, p.productName AS namaProduk, pl.textDescription
FROM products AS p
INNER JOIN productlines AS pl
ON p.productLine = pl.productLine
INNER JOIN orderdetails AS od
ON p.productCode = od.productCode
INNER JOIN orders AS o
ON od.orderNumber = o.orderNumber
JOIN customers AS c
ON o.customerNumber = c.customerNumber
WHERE p.productname LIKE '%titanic%'
ORDER BY c.customername ASC;

# Nomor 2
SELECT c.customerName, p.productName, o.status, o.shippedDate
FROM customers AS c
INNER JOIN orders AS o
ON c.customerNumber = o.customerNumber
INNER JOIN orderDetails AS det
ON o.orderNumber = det.orderNumber
INNER JOIN products AS p
ON det.productCode = p.productCode
WHERE productName LIKE '%ferrari%' 
AND STATUS = 'shipped'
AND shippedDate BETWEEN '2003-10-01' AND '2004-10-01'
ORDER BY shippedDate DESC;

SELECT * FROM customers

# Nomor 3
SELECT e.firstName AS Supervisor, sv.firstName AS Karyawan
FROM employees AS e
INNER JOIN employees AS sv
ON sv.reportsTo = e.employeeNumber
WHERE e.firstName LIKE '%Gerard%'
ORDER BY sv.firstName ASC;

SELECT * FROM employees

# Nomor 4 A
SELECT c.customername,p.paymentdate,e.firstname,p.amount
FROM customers AS c
INNER JOIN payments AS p
ON c.customerNumber = p.customerNumber
INNER JOIN employees AS e
ON e.employeeNumber = c.salesRepEmployeeNumber
WHERE p.paymentdate LIKE '_____11%'

# Nomor 4 B
ORDER BY p.amount DESC
LIMIT 1;

# Nomor 4 C
SELECT c.customerName, pd.productName
FROM payments AS p
INNER JOIN customers AS c
ON c.customerNumber = p.customerNumber
INNER JOIN orders AS o
ON c.customerNumber = o.customerNumber
INNER JOIN orderdetails AS od
ON o.orderNumber = od.orderNumber
INNER JOIN products AS pd
ON od.productCode = pd.productCode
WHERE c.customerName = 'Corporate Gift Ideas Co.'
AND p.paymentDate LIKE '_____11%';

# Nomor 5
UPDATE orders
SET STATUS = 'On Hold'
WHERE shippedDate IS NULL;

SELECT od.orderNumber, o.orderDate, shippedDate, c.customerName, p.productName, STATUS
FROM products 
INNER JOIN orderdetails AS od 
ON products.productCode = od.productCode
INNER JOIN orders AS o
ON od.orderNumber = o.orderNumber
JOIN customers AS c
ON o.customerNumber = c.customerNumber
WHERE shippeddate IS NULL 
AND STATUS = 'On Hold'
ORDER BY customername DESC;

# Soal Tambahan
SELECT o.orderNumber, o.orderDate, c.customerName, pm.amount
FROM orders AS o
INNER JOIN customers AS c
ON o.customerNumber = c.customerNumber
INNER JOIN payments AS pm
ON c.customerNumber = pm.customerNumber
WHERE c.city LIKE '%NYC%';

SELECT * FROM orders