#Nomor 1
SELECT DISTINCT c.customerName, p.productName, pl.textDescription
FROM customers c
INNER JOIN orders o ON c.customerNumber = o.customerNumber
INNER JOIN orderdetails od ON o.orderNumber = od.orderNumber
INNER JOIN products p ON od.productCode = p.productCode
INNER JOIN productlines pl ON p.productLine = pl.productLine
WHERE p.productName LIKE '%Titanic%'
ORDER BY c.customerName ASC;

#Nomor 2
SELECT c.customerName, p.productName, o.status, o.shippedDate
FROM customers c
INNER JOIN orders o ON c.customerNumber = o.customerNumber
INNER JOIN orderdetails od ON o.orderNumber = od.orderNumber
INNER JOIN products p ON od.productCode = p.productCode
WHERE p.productName LIKE '%Ferrari%'
AND o.status = 'Shipped'
AND o.shippedDate BETWEEN '2003-10-01' AND '2004-09-30'
ORDER BY o.shippedDate DESC;

#Nomor 3
SELECT s.firstName AS 'Supervisor', k.firstName AS 'Karyawan'
FROM employees s
INNER JOIN employees k ON s.employeeNumber = k.reportsTo
WHERE s.firstName = 'Gerard'
ORDER BY k.firstName ASC;

SELECT * FROM employees

#Nomor 4
#a
SELECT c.customerName, p.paymentDate, e.firstName AS 'employeeName',p.amount
FROM employees e
INNER JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
INNER JOIN payments p ON c.customerNumber= p.customerNumber
WHERE p.paymentDate LIKE '____-11-__';

#b
SELECT c.customerName, p.paymentDate, e.firstName AS 'employeeName',p.amount
FROM employees e
INNER JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
INNER JOIN payments p ON c.customerNumber= p.customerNumber
WHERE p.paymentDate LIKE '____-11-__'
ORDER BY p.amount DESC
LIMIT 1;

#c
SELECT c.customerName, pr.productName
FROM customers c
INNER JOIN orders o ON c.customerNumber = o.customerNumber
INNER JOIN payments p ON c.customerNumber = p.customerNumber
INNER JOIN orderdetails od ON o.orderNumber = od.orderNumber
INNER JOIN products pr ON od.productCode = pr.productCode
WHERE p.paymentDate LIKE '____-11-__'
AND c.customername = 'Corporate Gift Ideas Co.'
ORDER BY p.amount DESC;

pl.productLine, py.paymentDate, oc.city
#soal tambahan
SELECT pl.productLine, py.paymentDate, oc.city
FROM offices oc
INNER JOIN employees e ON oc.officeCode = e.officeCode
INNER JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
INNER JOIN payments py ON c.customerNumber = py.customerNumber
INNER JOIN orders o ON c.customerNumber = o.customerNumber
INNER JOIN orderdetails od ON o.orderNumber = od.orderNumber
INNER JOIN products p ON od.productCode = p.productCode
INNER JOIN productlines pl ON p.productLine = pl.productLine
WHERE c.creditLimit > 100000;