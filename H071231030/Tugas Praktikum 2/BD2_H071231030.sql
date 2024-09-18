#Nomor 1
SELECT productcode AS 'Kode Produk', productName AS 'Nama Produk', 
quantityInStock AS 'Jumlah Stok'
FROM products
WHERE quantityInStock BETWEEN 5000 AND 6000;

#Nomor 2
SELECT orderNumber AS 'Nomor Pesanan', orderdate AS 'Tanggal Pesanan',
status AS 'Status Pesanan', customernumber AS 'Nomor Pelanggan'
FROM orders
WHERE status != 'Shipped'
ORDER BY customernumber;

#Nomor 3
SELECT employeenumber AS 'Nomor Karyawan', firstname, lastname,
email, jobtitle AS 'Jabatan' 
FROM employees
WHERE jobtitle = 'Sales Rep'
ORDER BY firstname ASC
LIMIT 10;

#Nomor 4
SELECT productcode AS 'Kode Produk', productname AS 'Nama Produk',
productline AS 'Lini Produk', buyprice AS 'Harga Beli'
FROM products
ORDER BY buyprice DESC 
LIMIT 10 OFFSET 5;


#Nomor 5
SELECT DISTINCT country, city 
FROM customers
ORDER BY country, city DESC;

#Nomor 6
SELECT amount, checkNumber
FROM payments
WHERE amount > 10000
ORDER BY amount DESC
LIMIT 5;