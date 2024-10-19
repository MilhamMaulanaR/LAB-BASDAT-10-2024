USE classicmodels;

# Nomor 1
SELECT c.customerName, CONCAT(s.firstName, ' ', s.lastName) AS salesRep, 
    c.creditLimit - SUM(p.amount) AS remainingCredit
FROM customers AS c
JOIN employees AS s 
ON c.salesRepEmployeeNumber = s.employeeNumber
JOIN payments AS p 
USING (customerNumber)
GROUP BY c.customerName
HAVING remainingCredit > 0;

# Nomor 2
SELECT p.productName AS 'Nama Produk', GROUP_CONCAT(DISTINCT c.customerName SEPARATOR ' | ') AS 'Nama Kostumer',
    COUNT(DISTINCT c.customerName) AS 'Total Kostumer',
    SUM(od.quantityOrdered) AS 'Total Kuantitas'
FROM products AS p
JOIN orderdetails AS od
USING (productCode)
JOIN orders AS o
USING (orderNumber)
JOIN customers AS c
USING (customerNumber)
GROUP BY p.productName;

# Nomor 3
SELECT CONCAT(e.firstName,' ',e.lastName) AS employeeName, 
	 COUNT(c.customerName) AS totalCustomers
FROM employees AS e
JOIN customers AS c
ON e.employeeNumber = c.salesRepEmployeeNumber
GROUP BY employeeName
ORDER BY totalCustomers DESC;
	
# Nomor 4
SELECT CONCAT(e.firstName, ' ', e.lastName) AS 'Nama Karyawan',
		 p.productName AS 'Nama Produk',
		 SUM(od.quantityOrdered) AS 'Jumlah Pesanan'
FROM products p
JOIN orderdetails od
USING (productCode)
JOIN orders o
USING (orderNumber)
JOIN customers c
USING (customerNumber)
RIGHT JOIN employees e
ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN offices ofc
USING (officeCode)
WHERE ofc.country = 'Australia'
GROUP BY employeeNumber, productName
ORDER BY 'Jumlah Pesanan' DESC;

SELECT CONCAT(e.firstName, ' ', e.lastName) AS 'Nama Karyawan',
		p.productName AS 'Nama Produk',
		SUM(od.quantityOrdered) AS 'Jumlah Pesanan'
FROM offices
JOIN employees e
USING(officeCode)
LEFT JOIN customers c
ON e.employeeNumber = c.salesRepEmployeeNumber
LEFT JOIN orders o
USING(customerNumber)
LEFT JOIN orderdetails od
USING (orderNumber)
LEFT JOIN products p
USING(productCode)
WHERE offices.country = 'Australia'
GROUP BY 'Nama Karyawan', p.productName
ORDER BY 'Jumlah Pesanan' DESC;

DROP DATABASE classicmodels;

SELECT * FROM employees

# Nomor 5
SELECT c.customerName AS 'Nama Pelanggan',
    GROUP_CONCAT(DISTINCT p.productName) AS 'Nama Produk',
    COUNT(DISTINCT p.productCode) AS 'Banyak Jenis Produk'
FROM customers AS c
JOIN orders AS o 
USING (customerNumber)
JOIN orderdetails AS od 
USING (orderNumber)
JOIN products AS p
USING (productCode) 
WHERE o.shippedDate IS NULL
GROUP BY c.customerName;

# Soal Tambahan
SELECT GROUP_CONCAT(ofc.city) AS kota, ofc.addressLine2 AS 'Alamat Sekunder',
		CONCAT(e.firstName,' ',e.lastName) AS 'Nama Pegawai',
		ofc.postalCode AS 'Kode Pos'
FROM offices ofc
JOIN employees e
USING(officeCode)
WHERE addressLine1 LIKE '%11%';


SELECT * FROM offices; 

