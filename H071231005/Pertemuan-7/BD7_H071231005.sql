## Nomor 1
SELECT	p.productCode,
			p.productName, p.buyPrice
FROM products AS p
WHERE p.buyPrice >  (
	SELECT AVG(buyprice) 
	FROM products
);

## Nomor 2
SELECT 	o.orderNumber,
			o.orderDate
FROM orders AS o
JOIN customers AS c
USING(customernumber)
JOIN employees AS e
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN offices AS ofc
USING (officecode)
WHERE ofc.city = (
	SELECT oc.city
	FROM offices AS oc
	WHERE oc.city = 'Tokyo'
);

## Nomor 3
SELECT 	c.customerName, 
			o.orderNumber, 
			o.shippedDate,
			o.requiredDate,
			GROUP_CONCAT(p.productName) AS 'products',
			SUM(od.quantityOrdered) AS 'total_quantity_ordered',
			CONCAT(e.firstName,' ', e.lastName) AS 'employeename'
FROM customers AS c
JOIN orders AS o
USING (customerNumber)
JOIN orderdetails AS od
USING (orderNumber)
JOIN products AS p
USING (productcode)
JOIN employees AS e
ON e.employeeNumber = c.salesRepEmployeeNumber
WHERE c.customerName IN (
	SELECT os.customerName
	FROM customers AS os
	WHERE shippedDate >  requiredDate
);

## nomor 4
SELECT 
	p.productName, 
	p.productLine, 
	SUM(od.quantityOrdered) total_quantity_ordered
FROM products p
JOIN orderdetails od
USING(productCode)
JOIN (SELECT productLine
    FROM products
    JOIN orderdetails  
	 USING(productCode)
    GROUP BY productLine
    ORDER BY SUM(quantityOrdered) DESC
    LIMIT 3) AS top3
USING(productLine)
GROUP BY p.productCode
ORDER BY p.productLine, total_quantity_ordered DESC;


## Tugas Tambahan
SELECT distinct(c.customerName),
c.country
FROM customers AS c
JOIN orders AS o
USING (customernumber)
JOIN orderdetails AS od
USING(ordernumber)
JOIN products AS p
USING (productcode)
WHERE p.buyPrice > (
		SELECT AVG(buyprice) 
		FROM products
)