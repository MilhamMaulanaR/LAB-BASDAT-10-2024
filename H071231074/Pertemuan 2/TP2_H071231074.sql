-- Nomor 1
SELECT productCode AS "Kode Produk", productName AS "Nama Produk", quantityInStock AS "Jumlah Stok"
FROM products
WHERE quantityInStock >= 5000 AND quantityInStock <= 6000
ORDER BY quantityInStocc;

-- Nomor 2
SELECT OrderNumber AS "Nomor Pesanan", orderDate AS "Tanggal Pesanan", customerNumber AS "Nomor Pelanggan", status
FROM orders
WHERE status <> "Shipped"
ORDER BY customerNumber;

-- Nomor 3
SELECT employeeNumber AS "Nomor Karyawan", firstName, lastName, email, jobTitle AS Jabatan
FROM employees
WHERE jobTitle = "Sales Rep"
ORDER BY firstName
LIMIT 10;

-- Nomor 4
SELECT productCode AS "Kode Produk", productName AS "Nama Produk", productLine AS "Lini Produk", buyPrice AS "Harga Beli"
FROM products
ORDER BY buyPrice DESC
LIMIT 5, 10;

-- Nomor 5
SELECT DISTINCT country, city
FROM customers
ORDER BY country, city;

-- Soal Tambahan
SELECT orderDate AS "Tanggal Pesanan", orderNumber AS "Nomor Pesanan", status
FROM orders
WHERE status = "Resolved"
ORDER BY orderNumber DESC;