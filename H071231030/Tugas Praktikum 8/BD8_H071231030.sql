USE classicmodels;

# Nomor 1
(SELECT p.productName, SUM(od.priceEach * od.quantityOrdered) TotalRevenue, 'Pendapatan Tinggi' Pendapatan
	FROM products p
	JOIN orderdetails od
	USING(productCode)
	JOIN orders o
	USING(orderNumber)
WHERE MONTH(o.orderDate) = 9
GROUP BY p.productCode
ORDER BY TotalRevenue DESC
LIMIT 5)
UNION
(SELECT p.productName, SUM(od.priceEach * od.quantityOrdered) TotalRevenue, 'Pendapatan Rendah' Pendapatan
	FROM products p
	JOIN orderdetails od
	USING(productCode)
	JOIN orders o
	USING(orderNumber)
WHERE MONTH(o.orderDate) = 9
GROUP BY p.productCode
ORDER BY TotalRevenue ASC
LIMIT 5);

# Nomor 2
SELECT productName
FROM products
WHERE productCode NOT IN (SELECT od.productCode
FROM orderdetails od
JOIN orders o
USING(orderNumber)
WHERE o.customerNumber IN (SELECT o.customerNumber
		FROM orders o
		GROUP BY o.customerNumber
		HAVING COUNT(orderNumber) > 10
		INTERSECT
		SELECT o.customerNumber
		FROM orders o
		JOIN orderdetails od
		USING(orderNumber)
		WHERE od.productCode IN (SELECT productCode FROM products
			 WHERE buyPrice > (SELECT AVG(buyPrice) FROM products)
)));

# Nomor 3
SELECT c.customerName
FROM customers c
JOIN payments p
USING(customerNumber)
GROUP BY customerNumber
HAVING SUM(amount) > (SELECT AVG(amount)* 2 FROM payments)
AND customerNumber IN (SELECT o.customerNumber
	FROM orders o
      JOIN orderdetails od
      USING(orderNumber) 
   	JOIN products p
      USING(productCode)
      WHERE productLine = 'Planes'
      GROUP BY o.customerNumber, p.productLine
      HAVING SUM(quantityOrdered * priceEach) > 20000
      INTERSECT
      SELECT o.customerNumber
	FROM orders o
   	JOIN orderdetails od
      USING(orderNumber) 
   	JOIN products p
      USING(productCode)
      WHERE productLine = 'Trains'
      GROUP BY o.customerNumber, p.productLine
      HAVING SUM(quantityOrdered * priceEach) > 20000);
                         
# Nomor 4
SELECT Tanggal, customerNumber , GROUP_CONCAT(Riwayat SEPARATOR ' Dan ') Riwayat
FROM (SELECT o.orderDate Tanggal, c.customerNumber, 'Memesan Barang' Riwayat
		FROM orders o
		JOIN customers c
		USING(customerNumber)
		WHERE o.orderDate LIKE ('2003-09-%')
      UNION
		SELECT p.paymentDate Tanggal, c.customerNumber, 'Membayar Pesanan' Riwayat
		FROM payments p
		JOIN customers c
		USING(customerNumber)
		WHERE p.paymentDate LIKE ('2003-09-%')
      ORDER BY customerNumber) s
GROUP BY Tanggal;

# Nomor 5
SELECT p.productCode
	FROM products p
	JOIN orderdetails od
	USING(productCode)
	JOIN orders o
	USING(orderNumber)
	JOIN customers c
	USING(customerNumber)
WHERE od.quantityOrdered > 48
AND LEFT(productVendor, 1) IN ('A', 'I', 'U', 'E', 'O') 
AND p.buyPrice > (SELECT AVG(p.buyPrice) 
	FROM products p
	JOIN orderdetails od
	USING(productCode)
	JOIN orders o
	USING(orderNumber)
	WHERE orderDate BETWEEN '2001-01-01' AND '2004-03-31')
GROUP BY p.productCode
EXCEPT
SELECT p.productCode
	FROM products p
	JOIN orderdetails od
	USING(productCode)
	JOIN orders o
	USING(orderNumber)
	JOIN customers c
	USING(customerNumber)
WHERE c.country IN ('Italy', 'Japan', 'Germany');

# Soal Tambahan
SELECT c.customerName AS 'Nama Karyawan/Pelanggan', 'Pelanggan' AS STATUS
FROM customers c
JOIN employees e
ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE officeCode IN (
	SELECT DISTINCT officeCode
	FROM employees
	JOIN offices
	USING(officeCode)
	GROUP BY officeCode
	HAVING COUNT(firstName) = 2
)
UNION
SELECT CONCAT(firstName,' ',lastName) AS 'Nama Karyawan/Pelanggan','Karyawan' AS STATUS
FROM employees e
JOIN offices o
USING(officeCode)
WHERE o.officeCode IN (
	SELECT DISTINCT officeCode
	FROM employees
	JOIN offices
	USING(officeCode)
	GROUP BY officeCode
	HAVING COUNT(firstName) = 2
)
ORDER BY 'Pelanggan', 'Karyawan';