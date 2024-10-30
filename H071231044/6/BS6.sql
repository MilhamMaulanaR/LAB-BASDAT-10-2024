USE classicmodels;

##1
SELECT 
    c.customerName, 
    CONCAT(s.firstName, ' ', s.lastName) AS salesRepName, 
    c.creditLimit - SUM(p.amount) AS remainingCredit
FROM 
    customers AS c
JOIN 
    employees AS s 
    ON c.salesRepEmployeeNumber = s.employeeNumber
JOIN 
    payments AS p 
    ON c.customerNumber = p.customerNumber
GROUP BY 
    c.customerName, salesRepName, c.creditLimit
HAVING 
    remainingCredit >= 0
ORDER BY 
    c.customerName;

##2
SELECT
    p.productName AS 'Nama Produk',
    GROUP_CONCAT(DISTINCT c.customerName SEPARATOR '|') AS 'Nama Kostumer',
    COUNT(DISTINCT c.customerName) AS 'Total Kostumer',
    SUM(od.quantityOrdered) AS 'Total Kuantitas'
FROM
    products AS p
JOIN orderdetails AS od
    ON od.productCode = p.productCode
JOIN orders AS o
    ON o.orderNumber = od.orderNumber
JOIN customers AS c
    ON c.customerNumber = o.customerNumber
GROUP BY
    p.productName
ORDER BY
    p.productName ASC;

##3
SELECT
	CONCAT(e.firstName, ' ', e.lastName) AS employeeName, 
	count(c.customerName) AS totalCustomers
FROM
	employees AS e
JOIN
	customers AS c
	ON e.employeeNumber = c.salesRepEmployeeNumber
GROUP BY
	employeeName
ORDER BY
	totalCustomers DESC;
	
##4
SELECT CONCAT(e.firstName, ' ', e.lastName) AS 'Nama Karyawan', 
       p.ProductName AS 'Nama Produk', 
       SUM(od.QuantityOrdered) AS 'Jumlah Pesanan'
FROM employees e
left JOIN 
    customers AS c 
	 ON e.employeeNumber = c.salesRepEmployeeNumber
left JOIN 
    orders AS o 
	 ON c.customerNumber = o.customerNumber
left JOIN 
    orderdetails AS od 
	 ON o.orderNumber = od.orderNumber
left JOIN 
    products AS p 
	 ON od.productCode = p.productCode
WHERE e.officeCode = 6
GROUP BY `Nama Karyawan`, `Nama Produk`
ORDER BY `Jumlah Pesanan` DESC;

##5
SELECT
    c.customerName AS 'Nama Pelanggan',
    GROUP_CONCAT(DISTINCT p.productName SEPARATOR ', ') AS 'Nama Produk',
    COUNT(DISTINCT p.productCode) AS 'Banyak Jenis Produk'
FROM customers AS c
JOIN orders AS o ON c.customerNumber = o.customerNumber
JOIN orderdetails AS od ON o.orderNumber = od.orderNumber
JOIN products AS p ON od.productCode = p.productCode
WHERE o.shippedDate IS null
GROUP BY c.customerName;

#++
SELECT
	c.customerNumber AS 'Nomor Pelanggan',
	c.customerName AS 'Nama Pelanggan',
	month(o.orderDate) AS 'bulan',
	o.`status`,
	CONCAT(DATEDIFF(o.shippedDate, o.orderdate), 'hari') AS 'lama Pengiriman',
	MAX(creditLimit)-AVG(creditLimit)AS 'Rasio Credit Limit'
FROM
	orders AS o
JOIN
	customers AS c
	on c.customerNumber = o.customerNumber;

	
	
	


	
