USE classicmodels;

-- nomor 1
SELECT distinct customername AS namakostumer,productname AS namaproduk,textdescription
FROM products JOIN productlines ON products.productLine = productlines.productLine
JOIN orderdetails ON products.productCode = orderdetails.productCode
JOIN orders ON orderdetails.orderNumber = orders.orderNumber
JOIN customers ON orders.customerNumber = customers.customerNumber
WHERE productname  LIKE  '%titanic%'
ORDER BY customername;

-- nomor 2
SELECT customername,productname,STATUS,shippeddate
FROM products JOIN productlines ON products.productLine = productlines.productLine
JOIN orderdetails ON products.productCode = orderdetails.productCode
JOIN orders ON orderdetails.orderNumber = orders.orderNumber
JOIN customers ON orders.customerNumber = customers.customerNumber
WHERE productname LIKE '%ferrari%'
AND STATUS = 'shipped' AND shippeddate > '2003-10-01' AND shippeddate < '2004-10-01'
ORDER BY shippeddate DESC;

-- nomor 3
SELECT e.firstname AS supervisor,s.firstname AS karyawan FROM employees AS e
JOIN employees AS s ON s.reportsTo = e.employeeNumber
WHERE e.firstName = 'Gerard'
ORDER BY s.firstname;

-- nomor 4
SELECT customername,paymentdate,firstname,amount
FROM customers JOIN payments ON customers.customerNumber = payments.customerNumber
JOIN employees ON employees.employeeNumber = customers.salesRepEmployeeNumber
WHERE  paymentdate LIKE '_____11%'
ORDER BY amount DESC
LIMIT 1;

UPDATE orders
SET STATUS ='ON Hold'
WHERE shippeddate IS NULL;

DROP DATABASE classicmodels;

SELECT * FROM orders;

SELECT customername,productname FROM customers 
JOIN orders ON customers.customerNumber = orders.customerNumber
JOIN orderdetails ON orders.orderNumber = orderdetails.orderNumber
JOIN products ON orderdetails.productCode = products.productCode
WHERE customername LIKE '%Corporate Gift Ideas Co.%';


-- nomor 5
SELECT od.ordernumber ,orderdate,shippeddate,customername,productname,STATUS 
FROM products JOIN orderdetails AS od ON products.productCode = od.productCode
JOIN orders ON od.orderNumber = orders.orderNumber
JOIN customers ON orders.customerNumber = customers.customerNumber
WHERE shippeddate IS NULL AND STATUS = 'On Hold'
ORDER BY customername ASC;

--
SELECT distinct ordernumber,orderdate,customername,amount 
FROM orders JOIN customers ON orders.customerNumber = customers.customerNumber
JOIN payments ON customers.customerNumber = payments.customerNumber
WHERE STATUS = 'shipped';