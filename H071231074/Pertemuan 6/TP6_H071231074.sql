-- Tuprak Nomor 1
SELECT * FROM customers;
SELECT * FROM employees;
SELECT * FROM orders;
SELECT * FROM orderdetails;
SELECT * FROM payments;

SELECT 
	c.customerName, 
	CONCAT(e.firstName, ' ', e.lastName) AS salesRep,
	(c.creditLimit - SUM(p.amount)) AS remainingCredit
FROM customers c
JOIN employees e
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments p
USING(customerNumber)
GROUP BY c.customerName
HAVING remainingCredit > 0;

-- Tuprak Nomor 2
SELECT 
	p.productName AS 'Nama Produk',
	GROUP_CONCAT(DISTINCT c.customerName) AS 'Nama Customer',
	COUNT(DISTINCT c.customerName) AS 'Jumlah Customer',
	SUM(od.quantityOrdered) AS 'Total Quantitas'
FROM customers c
JOIN orders o
USING(customerNumber)
JOIN orderDetails od
USING(orderNumber)
JOIN products p
USING(productCode)
GROUP BY p.productName;

-- Tuprak Nomor 3
SELECT 
	CONCAT(e.firstName, ' ', e.lastName) AS employeeName,
	COUNT(c.customerName) AS totalCustomers
FROM employees e
JOIN customers c
ON c.salesRepEmployeeNumber = e.employeeNumber
GROUP BY e.employeeNumber
ORDER BY totalCustomers DESC;

-- Tuprak Nomor 4
SELECT * FROM offices;
SELECT * FROM employees;
SELECT * FROM orders;
SELECT * FROM orderdetails;
SELECT * FROM products;
SELECT * FROM payments;

SELECT
   CONCAT(e.firstName, ' ', e.lastName) AS "Nama Karyawan",
   p.productName AS "Nama Produk",
   SUM(od.quantityOrdered) AS "Jumlah Pesanan"
FROM employees e
LEFT JOIN offices ofi
ON e.officeCode = ofi.officeCode
LEFT JOIN customers c
ON c.salesRepEmployeeNumber = e.employeeNumber
LEFT JOIN orders o
ON c.customerNumber = o.customerNumber
LEFT JOIN orderdetails od
ON o.orderNumber = od.orderNumber
LEFT JOIN products p
ON od.productCode = p.productCode
WHERE e.officeCode = 6
GROUP BY e.employeeNumber, p.productName
ORDER BY SUM(od.quantityOrdered) DESC;

-- Tuprak Nomor 5
SELECT 
   c.customerName AS 'Nama Pelanggan',
   GROUP_CONCAT(DISTINCT p.productName) AS 'Nama Produk',
   COUNT(p.productName) AS 'Banyak Jenis Produk',
   o.`status`
FROM orders o
JOIN customers c
USING(customerNumber)
JOIN orderdetails od
USING(orderNumber)
JOIN products p
USING(productCode)
WHERE o.shippedDate IS NULL
GROUP BY c.customerName;




-- Persiapan
SELECT
	offi.city AS Kota,
	offi.addressLine2 AS "Alamat Sekunder",
	GROUP_CONCAT(DISTINCT CONCAT(e.firstName, ' ', e.lastName)) AS "Nama Pegawai",
	offi.postalCode AS "Kode Pos",
	offi.addressLine1
FROM 
customers AS c
JOIN employees AS e 
ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN orders AS o USING (customerNumber)
JOIN orderdetails AS od USING (orderNumber)
JOIN products AS p USING (productCode)
JOIN productlines AS pl USING (productLine)
JOIN payments AS pay USING (customerNumber)
JOIN offices AS offi USING (officeCode)
GROUP BY offi.officeCode
HAVING offi.addressLine1 LIKE '%11%';











