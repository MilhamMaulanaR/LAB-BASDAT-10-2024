USE classicmodels;


## Nomor 1
SELECT * FROM products;
SELECT productCode AS "Kode Produk",
productName AS "Nama Produk",
quantityInStock AS "Jumlah Stok"
FROM products
WHERE quantityInStock >= 5000 AND quantityInStock<= 6000;

## Nomor 2
SELECT * FROM orders;
SELECT orderNumber AS "Nomor Pesanan",
orderDate AS "Tanggal Pesanan",
status, customerNumber AS "Nomor Pelanggan"
FROM orders
WHERE STATUS <> "shipped"
ORDER BY customerNumber;

## Nomor 3
SELECT * FROM employees;
SELECT employeeNumber AS "Nomor Karyawan",
firstName, lastName, email, jobTitle AS "Jabatan" 
FROM employees
WHERE jobTitle = "Sales Rep"
ORDER BY firstName ASC
LIMIT 10;

## Nomor 4
SELECT * FROM products
SELECT productCode AS "Kode Produk",
ProductName AS "Nama Produk",
productLine AS "Lini Produk",
buyPrice AS "Harga Beli"
FROM products
ORDER BY buyPrice DESC
LIMIT 10 OFFSET 5;

## Nomor 5
SELECT * FROM customers
SELECT DISTINCT country, city 
FROM customers
ORDER BY  country, city;

## Study Case
SELECT * FROM products
SELECT productName, buyPrice FROM products
WHERE buyPrice > 30
ORDER BY buyPrice
LIMIT 15;

