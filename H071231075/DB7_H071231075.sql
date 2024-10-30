USE classicmodels;
-- 1
SELECT * FROM offices
SELECT productcode, productname, buyprice
FROM products
WHERE buyprice > (SELECT AVG(buyprice) FROM products);

-- 2
SELECT o.orderNumber,o.orderDate
FROM orders o 
JOIN customers c ON o.customerNumber = c.customerNumber
WHERE c.salesRepEmployeeNumber IN (
SELECT employeeNumber
FROM employees 
WHERE officeCode = (SELECT officecode FROM offices WHERE city = 'Tokyo'
	)
);


-- 3
SELECT customerName, orders.orderNumber, shippedDate, requiredDate, 
GROUP_CONCAT(products.productname ORDER BY products.productName SEPARATOR ';') AS nama_produknya ,
SUM(orderdetails.quantityOrdered) AS total_ordered,
CONCAT(employees.firstName, ' ', employees.lastName) AS employeeName
FROM products
JOIN orderdetails ON products.productCode = orderdetails.productCode
JOIN orders ON orderdetails.orderNumber = orders.orderNumber
JOIN customers ON orders.customerNumber = customers.customerNumber
JOIN employees ON customers.salesRepEmployeeNumber = employees.employeeNumber
WHERE orders.orderNumber IN (
SELECT orderNumber 
FROM orders 
WHERE shippedDate > requiredDate )

-- 4
SELECT p.productName,p.productLine,
SUM(od.quantityOrdered) AS total_quantity_ordered
FROM products p
JOIN orderdetails od USING(productCode)
WHERE p.productLine IN (
SELECT productLine FROM(
SELECT p2.productLine,
SUM(od2.quantityOrdered) AS total
FROM products p2
JOIN orderdetails od2 USING(productCode)
GROUP BY p2.productLine
ORDER BY total DESC
LIMIT 3) AS top3
) GROUP BY p.productCode
ORDER BY p.productLine, total_quantity_ordered DESC;

-- soal tambahan
SELECT 
	CONCAT(e.firstName,' ',e.lastName) AS employeeName,
	c.customerName, 
	SUM(od.quantityOrdered) As totalquantityordered
FROM customers c
JOIN employees e ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN orders o USING(customerNumber)
join orderdetails od ON od.orderNumber = o.orderNumber
WHERE e.officeCode in  (SELECT e2.officeCode FROM employees e2 WHERE e2.officeCode = 2)
GROUP BY customerName
ORDER BY employeename ;



