-- Tuprak Nomor 1
SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM orderdetails;

SELECT DISTINCT c.customerName namaKustomer, p.productName namaProduk, p.productDescription textDescription
FROM customers c
INNER JOIN orders o
ON o.customerNumber = c.customerNumber
INNER JOIN orderdetails od
ON o.orderNumber = od.orderNumber
INNER JOIN products p
ON p.productCode = od.productCode
WHERE p.productName LIKE '%Titanic%'
ORDER BY c.customerName;

-- Tuprak Nomor 2
SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM orderdetails;

SELECT c.customerName, p.productName, o.status, o.shippedDate
FROM customers c
INNER JOIN orders o
ON o.customerNumber = c.customerNumber
INNER JOIN orderDetails od
ON od.orderNumber = o.orderNumber
INNER JOIN products p
ON p.productCode = od.productCode
WHERE p.productName LIKE '%Ferrari%' AND o.`status` = 'Shipped' 
AND o.shippedDate >= '2003-10-01' AND o.shippedDate <= '2004-10-01'
ORDER BY o.shippedDate DESC;

-- Tuprak Nomor 3
SELECT * FROM offices;
SELECT * FROM employees
WHERE firstName LIKE '%Gerard%' OR lastName LIKE '%Gerard%'

SELECT CONCAT(supervisor.firstName, ' ', supervisor.lastName) AS Supervisor, 
CONCAT(employee.firstName, ' ', employee.lastName) AS Karyawan
FROM employees employee
INNER JOIN employees supervisor
ON employee.reportsTo = supervisor.employeeNumber
WHERE supervisor.firstName = 'Gerard'
ORDER BY employee.firstName;

-- Tuprak Nomor 4
SELECT * FROM customers;
SELECT * FROM employees;
SELECT * FROM orders;
SELECT * FROM orderdetails;
SELECT * FROM payments;

-- Nomor 4a
SELECT c.customerName, p.paymentDate, CONCAT(e.firstName, ' ', e.lastName) AS employeeName, p.amount 
FROM customers c
INNER JOIN payments p
ON c.customerNumber = p.customerNumber
INNER JOIN employees e
ON e.employeeNumber = c.salesRepEmployeeNumber
WHERE p.paymentDate LIKE '%____-11-__%';

-- Nomor 4b
SELECT c.customerName, p.paymentDate, CONCAT(e.firstName, ' ', e.lastName) AS employeeName, p.amount 
FROM customers c
INNER JOIN payments p
ON c.customerNumber = p.customerNumber
INNER JOIN employees e
ON e.employeeNumber = c.salesRepEmployeeNumber
INNER JOIN orders o
ON o.customerNumber = c.customerNumber
WHERE p.paymentDate LIKE '%____-11-__%'
ORDER BY p.amount DESC
LIMIT 1;

-- Nomor 4c
SELECT c.customerName, pr.productName
FROM customers c
INNER JOIN orders o ON c.customerNumber = o.customerNumber
INNER JOIN orderdetails od ON o.orderNumber = od.orderNumber
INNER JOIN products pr ON od.productCode = pr.productCode
INNER JOIN payments p
ON c.customerNumber = p.customerNumber
WHERE c.customerName = 'Corporate Gift Ideas Co.'
AND p.paymentDate LIKE '____-11%';

-- Soal Tambahan Nomor 1
SELECT * FROM orders;
SELECT * FROM orderdetails;
SELECT * FROM customers;
SELECT * FROM products;

SELECT o.orderNumber, o.orderDate, o.shippedDate, c.customerName, p.productName, o.`status`
FROM orders o
JOIN customers c
ON c.customerNumber = o.customerNumber
JOIN orderdetails od
ON od.orderNumber = o.orderNumber
JOIN products p
ON p.productCode = od.productCode
WHERE o.shippedDate IS NULL;

UPDATE orders
SET STATUS = 'On Hold'
WHERE shippedDate IS NULL

-- Soal Tambahan Nomor 2
SELECT * FROM orders;
SELECT * FROM orderdetails;
SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM productlines


SELECT c.customerName, o.orderNumber, o.orderDate, o.shippedDate, p.productName, od.quantityOrdered, od.priceEach,
offi.city, CONCAT(e.firstName, ' ', e.lastName) AS 'Nama Sales'
FROM orders o
JOIN customers c
ON c.customerNumber = o.customerNumber
JOIN orderdetails od
ON od.orderNumber = o.orderNumber
JOIN products p 
ON p.productCode = od.productCode
JOIN employees e
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN offices offi
ON offi.officeCode = e.officeCode
WHERE p.productName LIKE '%69%' AND offi.city IN ('Paris', 'London')
AND od.priceEach > 70 AND o.orderDate > '2003-06-30'
ORDER BY od.priceEach DESC





