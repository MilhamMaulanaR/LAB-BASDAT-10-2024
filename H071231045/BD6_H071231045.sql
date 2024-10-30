#Nomor 1
SELECT 
	c.customerName,
	CONCAT(e.firstName," ",e.lastName) AS salesRep,
	c.creditLimit - SUM(p.amount) AS remainingCredit
FROM customers c
INNER JOIN payments p 
ON c.customerNumber = p.customerNumber
INNER JOIN employees e 
ON c.salesRepEmployeeNumber = e.employeeNumber
GROUP BY c.customerName
HAVING remainingCredit > 0;

#Nomor2
SELECT
	p.productName AS 'Nama Produk',
	GROUP_CONCAT(c.customerName ORDER BY c.customerName) AS 'Nama Customer',
	COUNT(DISTINCT c.customerNumber) AS 'Jumlah Customer',
	SUM(od.quantityOrdered) AS 'Total Quantitas'
FROM products p
INNER JOIN orderdetails od
	USING(productCode)
INNER JOIN orders o
	USING(orderNumber)
INNER JOIN customers c
	USING(customerNumber)
GROUP BY p.productName;

#Nomor3
SELECT
	CONCAT(e.firstName," ",e.lastName) AS employeeName,
	COUNT(c.customerNumber) AS totalCustomers
FROM employees e
INNER JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
GROUP BY employeeName
ORDER BY employeeName DESC;

#Nomor4
SELECT
	CONCAT(e.firstName," ",e.lastName) AS 'Nama Karyawan',
	p.productName AS 'Nama Produk',
	SUM(od.quantityOrdered) AS 'Jumlah Pesanan'
FROM products p
JOIN orderdetails od USING(productCode)
JOIN orders o USING(orderNumber)
JOIN customers c USING(customerNumber)
RIGHT JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber 
JOIN offices oc USING(officeCode)
WHERE oc.country = 'Australia'
GROUP BY `Nama Karyawan`,`Nama Produk`
ORDER BY `Jumlah Pesanan` DESC;

#Nomor5
SELECT
	CONCAT(c.customerName) AS 'Nama Pelanggan',
	GROUP_CONCAT(p.ProductName ORDER BY p.productName) AS 'Nama Produk',
	COUNT(p.productName) AS 'Banyak Jenis Produk'
FROM products p
	JOIN orderdetails od USING(productCode)
JOIN orders o USING(orderNumber)
JOIN customers c USING(customerNumber)
WHERE o.shippedDate IS NULL 
GROUP BY `Nama Pelanggan`;


##soal tambahkan
SELECT 
   o.city AS 'Kota',
   COALESCE(o.addressLine2, o.country) AS 'Alamat Sekunder', 
   CONCAT(e.firstName, ' ', e.lastName) AS 'Nama Pegawai',
   o.postalCode AS 'Kode Pos'
FROM 
   offices o
LEFT JOIN 
   employees e ON o.officeCode = e.officeCode
WHERE 
   o.addressLine1 LIKE '%11%'
GROUP BY o.city;


