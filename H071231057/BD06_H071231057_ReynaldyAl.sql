-- TUGAS PRAKTIKUM 6

SELECT * FROM customers ;
SELECT * FROM employees ;
SELECT * FROM offices ;
SELECT * FROM orderdetails ;
SELECT * FROM orders ;
SELECT * FROM payments ;
SELECT * FROM productlines ;
SELECT * FROM products ;




-- #1 customer yang kreditnya masih ada, customerName, salesrepemployee, total kredit limit tersisa
SELECT 
    c.customerName AS 'Nama Customer', 
    CONCAT(e.firstName, ' ', e.lastName) AS 'Sales Representative', 
    c.creditLimit - sum(p.amount) AS 'Sisa Kredit'
FROM 
    customers c
jOIN 
    payments p USING (customerNumber)
JOIN 
    employees e ON c.salesRepEmployeeNumber = e.employeeNumber
GROUP BY 
    c.customerName
HAVING 
    -- (c.creditLimit - IFNULL(SUM(p.amount), 0)) > 0;
     `sisa kredit`  > 0;
    



-- #2 productName, customerName, count(customerNUmber), sum(quantityOrdered), customer > 1 produk keep it one!
SELECT 
    p.productName AS 'Nama Produk', 
    GROUP_CONCAT(DISTINCT c.customerName ORDER BY c.customerName SEPARATOR ', ') AS 'Nama Customer',
    COUNT(DISTINCT c.customerNumber) AS 'Jumlah Customer',
    SUM(od.quantityOrdered) AS 'Total Quantitas'
FROM 
    products p
JOIN 
    orderdetails od USING (productCode)
JOIN 
    orders o USING (orderNumber)
JOIN 
    customers c USING (customerNumber)
GROUP BY 
    p.productName
ORDER BY 
    p.productName;
    
    
-- #3 siapa employee, count(customerNumber)
SELECT 
    CONCAT(e.firstName, ' ', e.lastName) AS 'employeeName',
    COUNT(c.customerNumber) AS 'totalCustomers'
FROM 
    employees e
JOIN 
    customers c ON e.employeeNumber = c.salesRepEmployeeNumber
GROUP BY 
    e.employeeNumber
ORDER BY 
    totalCustomers DESC
-- LIMIT 15;

-- #4 employee where office = australia, nama produk,  sum(quantityOrdered), jumlah pesanan terbesar
SELECT 
    CONCAT(e.firstName, ' ', e.lastName) AS 'Nama Karyawan',
    p.productName AS 'Nama Produk',
    SUM(od.quantityOrdered) AS 'Jumlah Pesanan'
FROM 
    employees e
LEFT JOIN offices fice USING (officeCode)
LEFT  JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
LEFT  JOIN orders o USING (customerNumber)
LEFT  JOIN orderdetails od USING (orderNumber)
LEFT  JOIN products p USING (productCode)
WHERE fice.country = 'Australia'
GROUP BY e.employeeNumber, p.productName
ORDER BY `Jumlah Pesanan` DESC
-- LIMIT 181;



-- #5

-- cek status
-- SELECT DISTINCT 
--     o.status AS 'Status Pesanan'
-- FROM 
--     orders o
-- ORDER BY 
--     o.status;  

-- cek shipped date (ada null)
SELECT
    c.customerName AS 'Nama Pelanggan',
    o.shippedDate AS 'Tanggal Pengiriman',
    o.status AS 'Status Pesanan'
FROM
    customers AS c
JOIN
    orders AS o USING (customerNumber)  
WHERE 
	o.shippedDate IS NULL 
ORDER BY
    c.customerName;  

    
-- ini agak benar
SELECT
    c.customerName AS 'Nama Pelanggan',
    GROUP_CONCAT(DISTINCT p.productName) AS 'Nama Produk',
    COUNT(DISTINCT p.productCode) AS 'Banyak Jenis Produk'  
FROM
    customers AS c
JOIN
    orders AS o USING (customerNumber) 
JOIN
    orderdetails AS od USING (orderNumber) 
JOIN
    products AS p USING (productCode)  
WHERE
	 -- o.status != 'shipped' 
	 -- o.status IN ('In Process', 'Cancelled') 
    o.shippedDate IS NULL  -- Hanya pesanan yang belum dikirim/batal
GROUP BY
    c.customerName  
ORDER BY
    c.customerName; 


-- #Soal Tambahan
-- #sudah benarrr
SELECT 
	 c.customerNUmber AS 'Nomor Pelanggan',
	 c.customerName AS 'Nama Pelanggan',
	 month(o.shippedDate) AS 'Bulan',
	 o.status AS 'status' ,
	 DATEDIFF(o.shippedDate,o.orderDate) AS 'Lama pengiriman',
	 MAX(c.creditLimit) - AVG(c.creditLimit) AS 'Rasio CreditLimit'
FROM customers AS c
JOIN orders AS o USING(customerNumber)


--     c.creditLimit - sum(p.amount) AS 'Sisa Kredit'
	

	 












