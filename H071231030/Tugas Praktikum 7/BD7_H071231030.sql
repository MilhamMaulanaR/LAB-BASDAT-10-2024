USE classicmodels;

# Nomor 1
SELECT p.productCode, p.productName, p.buyPrice
FROM products p
WHERE p.buyPrice > (
		SELECT AVG (p2.buyPrice) 
		FROM products p2
);

# Nomor 2
SELECT o.orderNumber, o.orderDate
FROM orders o
WHERE o.customerNumber IN (
	SELECT customerNumber
	FROM customers c
	WHERE c.salesRepEmployeeNumber IN ( #jadikan 2 subquery
		SELECT e.employeeNumber
		FROM employees e
		WHERE e.officeCode IN (
			SELECT o.officeCode
			FROM offices o
			WHERE city = 'Tokyo'
		)
	)
);

# Nomor 3
SELECT c.customerName, o.orderNumber, o.shippedDate, o.requiredDate, 
		GROUP_CONCAT(p.productName) AS 'products',
		SUM(od.quantityOrdered) AS 'total_quantity_ordered', 
		CONCAT(e.firstName, ' ',e.lastName) AS 'employeeName'
FROM customers c
JOIN orders o
USING(customerNumber)
JOIN orderDetails od
USING (orderNumber)
JOIN products p
USING(productCode)
JOIN employees e
ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE o.orderNumber IN (
	 SELECT o2.orderNumber FROM orders o2
	 WHERE o2.shippedDate > o2.requiredDate
);

# Nomor 4
SELECT p.productName, p.productLine, SUM(od.quantityOrdered) AS 'total_quantity_ordered'
FROM products p
JOIN orderDetails od
USING (productCode)
WHERE p.productLine IN(
    SELECT productLine
    FROM (SELECT p1.productLine
       	 FROM products p1
       	 JOIN orderDetails od1
       	 USING (productCode)
	       GROUP BY p1.productLine
	       ORDER BY SUM(od1.quantityOrdered) DESC
	       LIMIT 3) AS top3)
GROUP BY p.productName, p.productLine
ORDER BY p.productLine, total_quantity_ordered DESC;

# Soal Tambahan
SELECT c.customerName, SUM(p.amount) AS 'totalPayment', SUM(p.amount) * 0.95 AS 'discountedPayment'
FROM customers c
JOIN payments p
USING(customerNumber)
GROUP BY c.customerName
HAVING totalPayment > (
	 SELECT AVG(totalAmount)
	 FROM (
	 SELECT SUM(p2.amount) AS totalAmount
	 FROM payments p2
	 GROUP BY p2.customerNumber
	 ) AS totalPayments
);