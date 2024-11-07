-- TUPRAK Nomor 1
-- Tugas Anda adalah menampilkan produk-produk yang memiliki harga beli
-- (buyPrice) lebih tinggi dari rata-rata harga semua produk yang ada di
-- database. Dalam hal ini, Anda perlu menggunakan tabel products.
-- Gunakan subquery untuk menghitung rata-rata harga beli dan kemudian
-- filter produk berdasarkan harga beli yang lebih tinggi dari nilai rata-rata
-- tersebut. Tampilkan hasilnya dengan mencantumkan productCode,
-- productName, dan buyPrice
SELECT productCode, productName, buyPrice
FROM products
WHERE buyPrice > (
	SELECT AVG(buyprice) 
	FROM products
);
	
-- TUPRAK Nomor 2
-- Tugas ini meminta Anda untuk menampilkan nomor dan tanggal pesanan
-- (orderNumber, orderDate) dari pelanggan yang ditangani oleh sales
-- representative yang bekerja di kantor Tokyo. Gunakan tabel employees
-- dan offices untuk mengidentifikasi sales rep yang bertugas di Tokyo.
-- Buatlah subquery untuk menemukan employeeNumber dari sales rep yang
-- bekerja di kantor tersebut, dan kemudian tampilkan pesanan dari
-- pelanggan yang ditangani oleh mereka.
SELECT * FROM offices;
SELECT * FROM employees;
SELECT * FROM orders;
SELECT * FROM orderdetails;

SELECT o.orderNumber, o.orderDate
FROM orders o
JOIN customers c
USING(customerNumber)
JOIN employees emplo
ON c.salesRepEmployeeNumber = emplo.employeeNumber
WHERE emplo.employeeNumber IN (SELECT e.employeeNumber
	FROM employees e
	JOIN offices offi
	USING(officeCode)
	WHERE offi.city = 'Tokyo'
);

-- TUPRAK Nomor 3
-- Buatlah query SQL untuk mengambil informasi terkait semua pesanan
-- yang terlambat, termasuk data pelanggan, nomor pesanan, tanggal
-- pengiriman, tanggal yang diminta, produk yang dipesan, jumlah total
-- produk yang dipesan, dan nama karyawan yang menangani penjualan.
-- Informasi ini akan sangat berguna untuk analisis kinerja pengiriman dan
-- pemantauan ketepatan waktu pesanan.
SELECT c.customerName, o.orderNumber, o.shippedDate, o.requiredDate,
	(SELECT GROUP_CONCAT(p.productName ORDER BY p.productName) FROM products p
	JOIN orderdetails od_sub
	USING(productCode)
	WHERE od_sub.orderNumber = od.orderNumber) product,
	SUM(od.quantityOrdered) total_quantity_ordered,
	CONCAT(e.firstName, ' ', e.lastName) employeeName
FROM customers c
JOIN orders o
USING(customerNumber)
JOIN orderdetails od
USING(orderNumber)
JOIN employees e
ON e.employeeNumber = c.salesRepEmployeeNumber
WHERE o.shippedDate > o.requiredDate
GROUP BY c.customerName, o.orderNumber;


-- TUPRAK Nomor 4
-- Buatlah query SQL untuk menampilkan nama produk, kategori produk,
-- serta jumlah total produk yang dipesan dari tiga kategori produk teratas
-- berdasarkan jumlah total produk yang dipesan tertinggi. Urutkan hasil
-- berdasarkan kategori produk dan jumlah total produk yang dipesan di
-- setiap kategori secara menurun
SELECT * FROM products;
SELECT * FROM orderdetails;

SELECT 
   p.productName,
   p.productLine,
   SUM(od.quantityOrdered) AS total_quantity_ordered
FROM products p
JOIN orderdetails od
USING(productCode)
JOIN orders o 
USING(orderNumber)
GROUP BY p.productLine, p.productName
HAVING p.productLine IN (
   SELECT productLine 
   FROM (
      SELECT productLine, SUM(od.quantityOrdered) AS total_ordered
      FROM products p
      JOIN orderdetails od ON p.productCode = od.productCode
      GROUP BY p.productLine
      ORDER BY total_ordered DESC
      LIMIT 3
   ) AS top_categories
)
ORDER BY p.productLine ASC, total_quantity_ordered DESC;

-- Soal Tambahan
SELECT * FROM orders;
SELECT * FROM orderdetails;

SELECT p.productName, p.productLine, SUM(od.quantityOrdered) totalQuantityOrdered
FROM products p
JOIN orderdetails od
USING(productCode)
GROUP BY p.productLine
HAVING p.productLine IN (
	SELECT productLine
	FROM products p1
	JOIN orderdetails od1
	USING(productCode)
	GROUP BY p1.productLine
	HAVING SUM(od1.quantityOrdered) > (
		SELECT AVG(totalOrdered)
		FROM (
			SELECT SUM(od2.quantityOrdered) totalOrdered
			FROM products p2
			JOIN orderdetails od2
			USING(productCode)
			GROUP BY p2.productLine) avgOrderPerLine
	)
);



-- Soal Tambahan HARD
SELECT p.productName, p.productLine, od.quantityOrdered totalQuantityOrdered
FROM products p
JOIN orderdetails od
USING(productCode);

SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM orderdetails;
SELECT * FROM payments;

SELECT c.customerNumber, c.customerName, SUM(p.amount) totalPayment, (SUM(p.amount) * 0.95) discountedPayment
FROM customers c
JOIN payments p
USING(customerNumber)
GROUP BY c.customerName
HAVING totalPayment > (
	SELECT AVG(total)
	FROM (SELECT SUM(amount) total
		FROM payments
		GROUP BY customerNumber) sub);

SELECT c.customerNumber, .customerName, 
       SUM(p.amount) AS totalPayment, 
       (SUM(p.amount) * 0.95) AS discountedPayment
FROM customers c
JOIN payments p ON c.customerNumber = p.customerNumber
GROUP BY c.customerNumber
HAVING totalPayment > (
    SELECT AVG(totalAmount) 
    FROM (SELECT SUM(amount) AS totalAmount 
          FROM payments 
          GROUP BY customerNumber) AS avgPayments);

SELECT SUM(
FROM 
SELECT AVG(p1.amount)
	FROM customers c1
	JOIN payments p1
	USING(customerNumber))


SELECT * FROM customers
ORDER BY customerName;









