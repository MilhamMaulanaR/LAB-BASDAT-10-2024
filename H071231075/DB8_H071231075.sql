USE classicmodels;
-- 1
(SELECT productName, SUM(priceEach * quantityOrdered) AS Revenue, 'Pendapatan Tertinggi' AS Pendapatan
FROM products
JOIN orderdetails ON products.productCode = orderdetails.productCode
JOIN orders ON orderdetails.orderNumber = orders.orderNumber
WHERE MONTH(orderDate) = 9
GROUP BY productName 
ORDER BY Revenue DESC
LIMIT 5)

UNION

(SELECT productName, SUM(priceEach * quantityOrdered) AS Revenue, 'Pendapatan Terendah' AS Pendapatan
FROM products
JOIN orderdetails ON products.productCode = orderdetails.productCode
JOIN orders ON orderdetails.orderNumber = orders.orderNumber
WHERE MONTH(orderDate) = 9
GROUP BY productName
ORDER BY Revenue ASC
LIMIT 5);

-- 2	
SELECT productName FROM products

EXCEPT 

SELECT productName FROM products
JOIN orderdetails ON products.productCode = orderdetails.productCode
JOIN orders ON orderdetails.orderNumber = orders.orderNumber
JOIN customers ON orders.customerNumber = customers.customerNumber
WHERE customers.customerName IN (
SELECT customers.customerName 
FROM customers
JOIN orders ON customers.customerNumber = orders.customerNumber
JOIN orderdetails ON orders.orderNumber = orderdetails.orderNumber
JOIN products ON orderdetails.productCode = products.productCode
WHERE buyPrice > (SELECT AVG(buyPrice) FROM products)
GROUP BY customers.customerName
HAVING COUNT(DISTINCT orders.orderNumber) > 10);


-- 3
SELECT customerName FROM customers
JOIN payments ON customers.customerNumber = payments.customerNumber
GROUP BY customerName
HAVING SUM(amount) > 2 * (SELECT AVG(totalAverage)
FROM (SELECT SUM(amount) AS totalAverage
FROM payments
GROUP BY customerNumber) AS hasil)

INTERSECT

SELECT customerName
FROM customers
JOIN orders ON customers.customerNumber = orders.customerNumber
JOIN orderdetails ON orders.orderNumber = orderdetails.orderNumber
JOIN products ON orderdetails.productCode = products.productCode
WHERE productLine = 'Planes' OR productLine = 'Trains'
GROUP BY customerName
HAVING SUM(quantityOrdered * priceEach) > 20000;

-- 4
SELECT 
orders.orderDate AS Tanggal,
customers.customerNumber AS CustomerNumber,
'Membayar Pesanan dan Memesan Barang' AS riwayat
FROM orders
JOIN customers ON orders.customerNumber = customers.customerNumber
JOIN payments ON orders.orderDate = payments.paymentDate
WHERE MONTH(orders.orderDate) = 9 AND YEAR(orders.orderDate) = 2003

UNION

SELECT 
orderDate, 
customerNumber,
'Memesan Barang' 
FROM orders
WHERE MONTH(orderDate) = 9 AND YEAR(orderDate) = 2003
AND orderDate NOT IN (  
SELECT orders.orderDate AS Tanggal
FROM orders
JOIN customers ON orders.customerNumber = customers.customerNumber
JOIN payments ON orders.orderDate = payments.paymentDate
WHERE MONTH(orders.orderDate) = 9 AND YEAR(orders.orderDate) = 2003)

UNION

SELECT 
paymentDate, 
customerNumber, 
'Membayar Pesanan' 
FROM payments
WHERE MONTH(paymentDate) = 9 AND YEAR(paymentDate) = 2003
AND paymentDate NOT IN (SELECT payments.paymentDate AS Tanggal
FROM orders
JOIN customers ON orders.customerNumber = customers.customerNumber
JOIN payments ON orders.orderDate = payments.paymentDate
WHERE MONTH(orders.orderDate) = 9 AND YEAR(orders.orderDate) = 2003)
ORDER BY Tanggal;

-- 5
SELECT DISTINCT products.productCode 
FROM products
JOIN orderdetails ON products.productCode = orderdetails.productCode
WHERE priceEach > (
SELECT AVG(priceEach) FROM orderdetails
JOIN orders ON orderdetails.orderNumber = orders.orderNumber
WHERE orderDate BETWEEN '2001-01-01' AND '2004-03-31')
AND quantityOrdered > 48
AND LEFT(productVendor, 1) IN ('A', 'I', 'U', 'E', 'O')

EXCEPT

SELECT DISTINCT products.productCode 
FROM products
JOIN orderdetails ON products.productCode = orderdetails.productCode
JOIN orders ON orderdetails.orderNumber = orders.orderNumber
JOIN customers ON orders.customerNumber = customers.customerNumber
WHERE country IN ("Japan", "Germany", "Italy");
-- soal tambahan
SELECT Tanggal, customerNumber,
GROUP_CONCAT(DISTINCT riwayat SEPARATOR ' dan ') riwayat
FROM (SELECT orderdate Tanggal,customerNumber, 'Memesan Barang' riwayat
FROM orders
WHERE orderdate LIKE '2003-09%'
UNION 
SELECT  paymentdate Tanggal,
customernumber,
'Membayar Pesanan' riwayat
FROM payments
WHERE paymentdate LIKE '2003-09%') payment
GROUP BY Tanggal;

--
SELECT CONCAT(firstname,' ',lastname) AS employees
FROM employees 
WHERE officecode = 1;

EXCEPT

SELECT officecode FROM offices;

SELECT * FROM products;
--
SELECT productName FROM products
JOIN orderdetails
USING(productCode)
WHERE quantityOrdered > 70
intersect
SELECT productName FROM products
WHERE productLine LIKE '%Cars%'
--
SELECT productname FROM products
JOIN orderdetails USING(productcode)
JOIN orders USING(ordernumber)
WHERE STATUS = 'In Process'
EXCEPT
SELECT productname FROM products
WHERE productline LIKE '%Cars%'

--
SELECT employeenumber FROM employees 
JOIN offices USING(officecode) 
WHERE city = 'london' AND jobtitle = 'Sales Rep'
EXCEPT
SELECT salesrepemployeenumber FROM customers
WHERE country = 'japan'

--
SELECT productName, SUM(quantityOrdered) AS total_quantity_ordered
FROM products
JOIN orderdetails
USING(productCode)
GROUP BY productName
HAVING SUM(quantityOrdered) = (SELECT MAX(total_quantity)
FROM (SELECT SUM(quantityOrdered) AS total_quantity
FROM products
JOIN orderdetails USING(productCode)
GROUP BY productCode) AS max_quantity)

UNION

SELECT productName, SUM(quantityOrdered) AS total_quantity_ordered
FROM products
JOIN orderdetails
USING(productCode)
GROUP BY productName
HAVING SUM(quantityOrdered) = (SELECT MIN(total_quantity)
FROM (SELECT SUM(quantityOrdered) AS total_quantity
FROM products
JOIN orderdetails USING(productCode)
GROUP BY productCode) AS min_quantity);