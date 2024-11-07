#1
CREATE DATABASE sepakBola;

USE sepakBola;

CREATE TABLE klub(
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

CREATE TABLE pertandingan(
	id INT AUTO_INCREMENT PRIMARY KEY,
	id_klub_tuan_rumah INT,
	id_klub_tamu INT,
	tanggal_pertandingan DATE NOT NULL,
	skor_tuan_rumah INT DEFAULT(0),
	skor_tamu INT DEFAULT(0),
	FOREIGN KEY(id_klub_tuan_rumah) REFERENCES pemain(id_klub),
	FOREIGN KEY(id_klub_tamu) REFERENCES klub(id)
);

ALTER TABLE pemain
ADD INDEX posisi (posisi);

ALTER TABLE klub
ADD INDEX kota_asal (kota_asal);

DESCRIBE klub;
DESCRIBE pemain;
DESCRIBE pertandingan;

###########

USE classicmodels;
SELECT * FROM customers;
SELECT * FROM employees;
SELECT * FROM offices;
SELECT * FROM orderdetails;
SELECT * FROM orders;
SELECT * FROM payments;
SELECT * FROM products;
SELECT * FROM productlines;

###########

#2
SELECT
	customerName,
	country,
	ROUND(SUM(amount),2) AS totalPayment,
	COUNT(orderNumber) AS orderCount,
	MAX(paymentDate) AS LastPaymentDate,
	case
		when SUM(amount) > 100000 then 'VIP'
		when SUM(amount) < 5000 then 'New'
		ELSE 'Loyal'
	END AS `status`
FROM customers
left JOIN orders USING (customerNumber)
left JOIN payments USING (customerNumber)
GROUP BY customerName;

#3
SELECT
	customerNumber,
	customerName,
	SUM(quantityOrdered) AS total_quantity,
	case
		when sum(quantityOrdered)  > (SELECT AVG(total_quantity) FROM (SELECT
																								customerNumber,
																								SUM(quantityOrdered) AS total_quantity
																							FROM orders
																							JOIN orderdetails USING (orderNumber)
																							GROUP BY customerNumber)AS o) then 'di atas rata-rata'
		ELSE 'di bawah rata-rata'
	END AS kategori_pembelian
FROM customers
JOIN orders USING (customerNumber)
JOIN orderdetails USING (orderNumber)
GROUP by customerNumber
ORDER BY total_quantity DESC;
	

#++
set autocommit = 0;
START TRANSACTION;
ROLLBACK;

INSERT INTO klub(nama_klub, kota_asal)
VALUES
('Persija', 'Jakarta'),
('Arema FC', 'Malang'),
('Persebaya', 'Surabaya'),
('PSM Makassar', 'Makassar'),
('Bali United', 'Bali');

INSERT INTO pemain(nama_pemain, posisi, id_klub)
VALUES
('Evan Dimas', 'Midfielder', 1),
('Riko Simanjuntak', 'Forward',1),
('Hanif Sjahbandi', 'Defender', 2),
('Makan Konate', 'Midfielder', 2),
('David da Silva', 'Forward', 3),
('Irfan Jaya', 'Forward',4),
('Rizky Pellu', 'Midfielder',4),
('Ilija Spasojevic', 'Forward', 5),
('Andhika Wijaya', 'Defender',5),
('Mohammad Abdul Razaq', 'Cadangan',1),
('Muh. Aipun Pratama', 'Cadangan',2),
('Reynaldy Arunglabi', 'Cadangan',3),
('Rezka Wildan Nurhadi Bakri', 'Cadangan',4),
('Nurul Wahdania', 'Cadangan',5),
('Muh. Fauzan', 'Cadangan',1),
('Muh. Rinaldi Ruslan', 'Cadangan',2);

INSERT INTO pertandingan(tanggal_pertandingan,id_klub_tuan_rumah, skor_tuan_rumah, skor_tamu, id_klub_tamu)
VALUES
('2024-09-10', 1, 2 ,1, 2),
('2024-09-12', 3 ,1, 1, 4),
('2024-09-15', 5, 0, 3, 1),
('2024-09-20', 2, 1, 2, 5),
('2024-09-25', 4, 2, 0, 2);

COMMIT;

SELECT * FROM klub;
SELECT * FROM pemain;
SELECT * FROM pertandingan;

##
