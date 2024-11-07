-- no1 --
SELECT productcode AS 'Kode Produk' , productName AS 'Nama Produk' , quantityInStock AS 'Jumlah Stok'
FROM products
WHERE quantityInStock BETWEEN 5000 AND 6000;

-- no2 --
SELECT orderNumber AS 'Nomor Pesanan' , orderDate AS 'Tanggal Pesanan', STATUS , customerNumber AS 'Nomor Pelanggan'
FROM ORDERS
WHERE STATUS != 'shipped'
ORDER BY customerNumber DESC;

-- no3 --
SELECT employeeNumber 'nomor karyawan' , firstName , lastName, email , jobTitle
FROM employees
WHERE jobTitle = 'Sales Rep'
ORDER BY firstName ASC
LIMIT 10;

-- no4 --
SELECT productCode AS'Kode Produk' , productName AS 'Nama Produk' , productLine AS 'Lini Produk' , buyPrice AS 'harga beli'
FROM products
ORDER BY buyPrice DESC 
LIMIT 10 OFFSET 5;

-- no5 --
SELECT DISTINCT country , city
FROM customers
ORDER BY country , city ;

-- no6 --
SELECT amount , checkNumber
FROM payments
WHERE amount > 10000
ORDER BY amount DESC
LIMIT 5 ;

-- soal tambahan
#1
SELECT * FROM products

SELECT productName, buyPrice
FROM Products
WHERE buyPrice BETWEEN 50 AND 100
ORDER BY buyPrice ASC;