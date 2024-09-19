-- NOMOR 1
SELECT productcode AS 'kode produk',productname AS 'nama produk',quantityinstock AS 'jumlah stok'
FROM products
WHERE quantityInStock >= 5000 AND quantityInStock <= 6000 ORDER BY quantityInStock ASC

-- NOMOR 2
SELECT ordernumber AS 'nomor pesanan',
orderdate AS 'tanggal pesanan',STATUS,
customernumber AS 'nomor pelanggan' 
FROM orders
WHERE STATUS <> 'Shipped'
ORDER BY customernumber ASC

-- NOMOR 3
SELECT employeeNumber AS 'nomor karyawan',firstName,lastName,email,jobTitle AS 'jabatan' FROM employees
WHERE jobTitle = 'Sales Rep'
ORDER BY firstname ASC
LIMIT 10;

-- NOMOR 4
SELECT productCode AS 'kode produk',
productName AS 'nama produk',
productLine AS 'lini produk',
buyPrice AS 'harga beli' FROM products
ORDER BY buyprice DESC
LIMIT 10 OFFSET 5


-- NOMOR 5
SELECT DISTINCT country, city FROM customers
ORDER BY country, city;

SELECT customerNumber,paymentDate,amount FROM payments
WHERE amount > 100000
ORDER BY amount DESC
LIMIT 1