-- Tuprak Nomor 1
CREATE DATABASE db_sepakbola;
USE db_sepakbola;

CREATE TABLE klub (
	id INT AUTO_INCREMENT PRIMARY KEY,
	nama_klub VARCHAR(50) NOT NULL,
	kota_asal VARCHAR(20) NOT NULL
);

CREATE TABLE pemain (
	id INT AUTO_INCREMENT PRIMARY KEY,
	nama_pemain VARCHAR(50) NOT NULL,
	posisi VARCHAR(20) NOT NULL,
	id_klub INT,
	FOREIGN KEY (id_klub) REFERENCES klub(id)
);

CREATE TABLE pertandingan (
	id INT AUTO_INCREMENT PRIMARY KEY,
	id_klub_tuan_rumah INT REFERENCES klub(id),
	id_klub_tamu INT REFERENCES klub(id),
	tanggal_pertandingan DATE NOT NULL,
	skor_tuan_rumah INT DEFAULT 0,
	skor_tamu INT DEFAULT 0
);

CREATE INDEX idx_posisi ON pemain(posisi);
CREATE INDEX idx_kota_asal ON klub(kota_asal);

DESCRIBE klub;
DESCRIBE pemain;
DESCRIBE pertandingan;

SHOW INDEX FROM pemain;
SHOW INDEX FROM klub;

DROP DATABASE db_sepakbola;

-- Tuprak Nomor 2
USE classicmodels;

SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM orderdetails;
SELECT * FROM payments;

SELECT c.customerName,
	c.country, 
	ROUND(SUM(od.quantityOrdered * od.priceEach), 6) TotalPayment,
	(COUNT(DISTINCT o.orderNumber) * COUNT(DISTINCT o.orderNumber)) orderCount,
	MAX(paymentDate) LastPaymentDate, 
	CASE
		WHEN SUM(quantityOrdered * priceEach) > 100000 THEN "VIP"
		WHEN SUM(quantityOrdered * priceEach) > 5000 THEN "Loyal"
		ELSE "New"
	END AS 'status'
FROM customers c
LEFT JOIN orders o
USING(customerNumber)
LEFT JOIN orderdetails od
USING(orderNumber)
LEFT JOIN payments p
USING(customerNumber)
GROUP BY customerNumber
ORDER BY customerName;

-- SELECT c.customerName,
-- 	country, 
-- 	SUM(quantityOrdered * priceEach) TotalPayment,
-- 	COUNT(orderNumber) orderCount,
-- 	orderNumber
-- FROM customers c
-- LEFT JOIN orders
-- USING(customerNumber)
-- LEFT JOIN orderdetails
-- USING(orderNumber)
-- LEFT JOIN payments
-- USING(customerNumber)
-- GROUP BY orderNumber
-- ORDER BY customerName;

-- WHEN SUM(IF(quantityOrdered * priceEach IS NULL, 0, quantityOrdered * priceEach)) > 100000 THEN 'VIP'

-- Tuprak Nomor 3
SELECT * FROM products;

SELECT customerNumber, customerName, SUM(quantityOrdered) total_quantity,
	CASE
		WHEN SUM(quantityOrdered) > sub.ratarata THEN "di atas rata-rata"
		ELSE "di bawah rata-rata"
	END AS "kategori_pembelian"
FROM customers
JOIN orders USING(customerNumber)
JOIN orderdetails USING(orderNumber)
JOIN products USING(productCode)
JOIN (SELECT AVG(subsub.rata) ratarata
	FROM (SELECT productCode , SUM(quantityOrdered) rata
	FROM orderdetails
	JOIN orders USING(orderNumber)
	GROUP BY customerNumber) subsub) AS sub
GROUP BY customerNumber
ORDER BY total_quantity DESC;

-- Tuprak Soal Tambahan
USE db_sepakbola;
SELECT * FROM klub;
SELECT * FROM pemain;
SELECT * FROM pertandingan;

START TRANSACTION;

SELECT * FROM klub;

INSERT INTO klub (nama_klub, kota_asal)
VALUES ("Persija", "Jakarta"),
	("Arema FC", "Malang"),
	("Persebaya", "Surabaya"),
	("PSM Makassar", "Makassar"),
	("Bali United", "Bali");

SELECT * FROM klub;
SELECT * FROM pemain;

INSERT INTO pemain (nama_pemain, posisi, id_klub)
VALUES ("Evan Dimas", "Midfielder", 1),
	("Riko Simanjuntak", "Forward", 1),
	("Hanif Sjahbandi", "Defender", 2),
	("Makan Konate", "Midfielder", 2),
	("David da Silva", "Forward", 3),
	("Irfan Jaya", "Forward", 4),
	("Rizky Pellu", "Midfielder", 4),
	("Ilija Spasojevic", "Forward", 5),
	("Andhika Wijaya", "Defender", 5);

SELECT * FROM klub;
SELECT * FROM pemain;
SELECT * FROM pertandingan;
	
INSERT INTO pertandingan (tanggal_pertandingan, id_klub_tuan_rumah, skor_tuan_rumah, skor_tamu, id_klub_tamu)
VALUES ("2024-09-10", 1, 2, 1, 2),
	("2024-09-12", 3, 1, 1, 4),
	("2024-09-15", 5, 0, 3, 1),
	("2024-09-20", 2, 1, 2, 5),
	("2024-09-25", 4, 2, 0, 3);
	
SELECT * FROM klub;
SELECT * FROM pemain;
SELECT * FROM pertandingan;

ROLLBACK;

SELECT * FROM klub;
SELECT * FROM pemain;
SELECT * FROM pertandingan;

COMMIT;