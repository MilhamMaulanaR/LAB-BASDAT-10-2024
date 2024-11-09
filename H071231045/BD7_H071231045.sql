#1
SELECT productCode, productName, buyPrice
FROM products
WHERE buyPrice > (SELECT AVG(buyPrice) FROM products);

#2
SELECT orderNumber, orderDate
FROM orders
WHERE customerNumber IN (
   SELECT customerNumber
   FROM customers
   WHERE salesRepEmployeeNumber IN (
   SELECT employeeNumber
		FROM employees
      WHERE officeCode = (
      SELECT officeCode
         FROM offices
         WHERE city = 'Tokyo'
        )
    )
);

#3
SELECT c.customerName, o.orderNumber, o.shippedDate, o.requiredDate, 
	GROUP_CONCAT(p.productName) AS 'products',
	SUM(od.quantityOrdered) AS 'total_quantity_ordered', 
	CONCAT(e.firstName, ' ',e.lastName) AS 'employeeName'
FROM customers c
JOIN orders o USING(customerNumber) 
JOIN orderDetails od USING (orderNumber)
JOIN products p USING(productCode)
JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE o.orderNumber IN (
	SELECT o2.orderNumber
	FROM orders o2
	WHERE o2.shippedDate > o2.requiredDate);

#4
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
GROUP BY p.productName
ORDER BY p.productLine, total_quantity_ordered DESC;

#Soal Tambahan
SELECT 
   CONCAT(e.firstName, ' ', e.lastName) AS employeeName,
   c.customerName, SUM(od.quantityOrdered) AS totalQuantityOrdered
FROM 
   employees e
JOIN 
   customers c ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN 
   orders o ON c.customerNumber = o.customerNumber
JOIN 
   orderdetails od USING (orderNumber)
WHERE e.officeCode = (
   SELECT officeCode
   FROM offices
   WHERE city = 'Boston'
   )
GROUP BY 
   e.employeeNumber, c.customerName;