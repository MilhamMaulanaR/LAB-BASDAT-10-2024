-- number 1 produk, nama produk, jumlah stok, 5000 - 6000
SELECT * FROM products;
SELECT productCode AS 'Kode Produk',
		 productName AS 'Nama Produk',
		 quantityInStock AS 'Jumlah Stok'
FROM products
WHERE quantityInStock BETWEEN 5000 AND 6000
ORDER BY quantityInStock ASC ;

-- number 2 tidak berstatus shipped, urutan nomor pelanggan, nomor,tanggal,status, dan nomor pelanggan
SELECT * FROM orders;
SELECT orderNumber AS 'Nomor Pesanan',
		 orderDate AS 'Tanggal Pesanan',
		 STATUS,
		 customerNumber AS 'Nomor Pelanggan'
FROM orders
WHERE STATUS <> 'Shipped'
ORDER BY customerNumber;

-- number 3 Sales Rep, 10 karyawan pertama first name, tabel employees
SELECT * FROM employees;
SELECT employeeNumber AS 'Nomor Karyawan',
		 firstName,
		 lastName,
		 email,
		 jobTitle AS 'Jabatan'
FROM employees
WHERE jobTitle = 'Sales Rep'
ORDER BY firstName ASC 
LIMIT 10;

-- number 4 kode produk, nama produk, lini produk, harga beli, 6-15
-- urutan harga beli secara menurun

SELECT * FROM products;
SELECT productCode AS 'Kode Produk',
		 productName AS 'Nama Produk',
		 productLine AS 'Lini Produk',
		 buyPrice AS 'Harga Beli'
FROM products
ORDER BY buyPrice DESC
LIMIT 10 OFFSET 5;

-- number 5 DISTINCT
-- COUNTRY. CITY
SELECT * FROM customers;
SELECT DISTINCT country, city FROM customers
ORDER BY country,city ASC;

-- live code by kak ilham 
SELECT * FROM customers;
SELECT customerName, state, city
FROM customers
WHERE state = 'CA'
ORDER BY customerName ASC



SELECT customerNumber, paymentDate, amount
FROM payments
WHERE amount > 100000
ORDER BY  customerNumber ASC ;

SELECT * from customers
WHERE customerNumber = 124 OR customerNumber = 141 OR customerNumber = 148;
