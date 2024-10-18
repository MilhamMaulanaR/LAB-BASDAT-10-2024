## Nomor 1
SELECT c.customerName, 
CONCAT(e.firstName, " ", e.lastName) AS SalesRep,
c.creditLimit -  SUM(p.amount) AS reminingCredit
FROM customers AS c
JOIN employees AS e
ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN payments AS p
USING (customerNumber)
GROUP BY c.customerName
HAVING reminingCredit > 0;

## Nomor 2
SELECT p.productName AS 'Nama Produk',
GROUP_CONCAT(DISTINCT c.customerName) AS 'Nama Customer',
COUNT(DISTINCT c.customerName)  AS 'Jumlah Customer',
SUM(od.quantityOrdered) AS 'Total Quantitas'
FROM customers AS c
JOIN orders AS o
USING (customerNumber)
JOIN orderdetails AS od
USING (ordernumber)
JOIN products AS p
USING (productcode)
GROUP BY p.productName;


## Nomor 3
SELECT CONCAT(e.firstName,' ', e.lastName) AS 'employeeName',
COUNT(c.customerName) AS 'totalCustomers'
FROM customers AS c
JOIN employees AS e
ON c.salesRepEmployeeNumber = e.employeeNumber
GROUP BY employeeName
ORDER BY totalCustomers DESC;


## Nomor 4
SELECT CONCAT(e.firstName,' ', e.lastName) AS 'Nama Karyawan',
p.productName AS 'Nama Produk', 
SUM(od.quantityOrdered) AS 'Jumlah Pesanan'
FROM products AS p
JOIN orderdetails AS od
USING (productcode)
JOIN orders AS o
USING (orderNumber)
JOIN customers AS c
USING (customerNumber)
RIGHT JOIN employees AS e
ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN offices AS ofs
USING (officeCode)
WHERE ofs.country = 'Australia'
GROUP BY  CONCAT(e.firstName,' ', e.lastName), p.productName
ORDER BY SUM(od.quantityOrdered) DESC;

## Nomor 5
SELECT c.customerName AS 'Nama Pelanggan',
GROUP_CONCAT(DISTINCT  p.productName) AS 'Nama Produk',
COUNT(p.productLine)  AS 'Banyak Jenis Produk'
FROM customers AS c
JOIN orders AS o
USING (customerNumber)
JOIN orderdetails AS od
USING (ordernumber)
JOIN products AS p
USING (productcode)
WHERE o.shippedDate IS NULL
GROUP BY c.customerName;


## Soal Tambahan
SELECT c.customerNumber AS 'Nomor Pelanggan', 
c.customerName AS 'Nama Pelanggan', 
MONTH(o.orderDate) AS 'Bulan',
o.`status` AS 'status',
DATEDIFF(o.shippedDate, o.orderDate) AS 'Lama Pengiriman', 
MAX(c.creditLimit) - AVG(c.creditLimit) AS 'Rasio CreditLimit'
FROM customers AS c
JOIN orders AS o
USING (customerNumber)










