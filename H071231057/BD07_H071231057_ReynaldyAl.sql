-- TUGAS PRAKTIKUM WEEK 7 SUB-QUERY

-- #1 Products with buyPrice > Avg all products
SELECT 
	 productCode,
	 productName,
    buyPrice
FROM products
WHERE buyPrice > (SELECT AVG(buyPrice) FROM products);
-- WHERE buyPrice > AVG(buyPrice);


-- #2 orderNumber & orderDate that's handled by sales representative where city is Tokyo
SELECT 
	 o.orderNumber,
 	 o.orderDate
FROM orders o
JOIN customers c USING (customerNumber)
WHERE c.salesRepEmployeeNumber IN (
    SELECT employeeNumber 
    FROM employees 
    	WHERE officeCode = (
	 	SELECT officeCode FROM offices WHERE city = 'Tokyo'
	 )
);

-- #3 all products that's been late including customer-data, orderNumber, shipped date, requiredDate, products, total_quantity_ordered, employee name
SELECT 
	 c.customerName,
 	 o.orderNumber,
    o.shippedDate,
    o.requiredDate,
      (SELECT GROUP_CONCAT(p.productName SEPARATOR ', ')
      FROM orderdetails od
      JOIN products p USING (productCode)
      WHERE od.orderNumber = o.orderNumber) AS products,
      
      (SELECT SUM(od.quantityOrdered)
      FROM orderdetails od
      WHERE od.orderNumber = o.orderNumber) AS total_quantity_ordered,
      CONCAT(e.firstName, ' ', e.lastName) AS employeeName
FROM orders o
JOIN customers c USING (customerNumber)
JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE o.shippedDate > o.requiredDate;



-- #4 productName, productLine, total_quantity_ordered, but there's top 3 product in it and desc by category and total_quantity 
SELECT p.productName, 
       p.productLine, 
       SUM(od.quantityOrdered) AS total_quantity_ordered
FROM products p
JOIN orderdetails od USING (productCode)
GROUP BY p.productName, p.productLine
HAVING p.productLine IN  (
    SELECT productLine
    FROM (
        SELECT p.productLine, SUM(od.quantityOrdered) AS total_quantity
        FROM products p
        JOIN orderdetails od USING (productCode)	
        GROUP BY p.productLine
        ORDER BY total_quantity DESC 
        LIMIT 3
    ) AS Top_three
    
)

ORDER BY p.productLine, total_quantity_ordered DESC;


-- #LATIHAN
-- #1 office addres country - pelanggan pembayaran paling sedikit
SELECT 
	 offi.officeCode,
	 offi.addressline1,
	 offi.country
FROM offices offi
JOIN employees e USING (officeCode)
JOIN customers c ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN payments p USING (customerNumber)
WHERE p.amount =   (
	 SELECT MIN(p2.amount)
	 FROM payments p2
)

SELECT 
	CONCAT(e.firstName, ' ', e.lastName) AS karyawan, SUM(p.amount) AS 'Pendapatan'
	FROM employees e 
	JOIN customers c ON c.salesRepEmployeeNumber = e.employeeNumber
	JOIN  payments p USING (customerNumber)
WHERE e.employeeNumber  IN  (
(SELECT e.employeeNumber
	FROM employees e
	JOIN customers c ON c.salesRepEmployeeNumber = e.employeeNumber
	JOIN  payments p USING (customerNumber)
	GROUP BY e.employeeNumber
	ORDER BY SUM(p.amount) DESC 
	LIMIT 1 ),
	
 (SELECT e.employeeNumber 
	FROM employees e
	JOIN customers c ON c.salesRepEmployeeNumber = e.employeeNumber
	JOIN  payments p USING (customerNumber)
	GROUP BY e.employeeNumber
	ORDER BY SUM(p.amount) ASC  
	LIMIT 1
	))
	
GROUP BY e.employeeNumber
ORDER BY SUM(p.amount) DESC ;


	
	





	 








