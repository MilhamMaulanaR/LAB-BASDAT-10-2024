## Nomor 1
CREATE DATABASE sepakbola;

CREATE TABLE klub (
	id INT PRIMARY KEY AUTO_INCREMENT,
	nama_klub VARCHAR(50) NOT NULL,
	kota_asal VARCHAR(20) NOT NULL
);

CREATE TABLE pemain (
	id INT(10) PRIMARY KEY AUTO_INCREMENT,
	nama_pemain VARCHAR(20) NOT NULL,
	posisi VARCHAR(20) NOT NULL,
	id_klub INT(10),
	FOREIGN KEY(id_klub) REFERENCES klub(id)
);

CREATE TABLE pertandingan (
	id INT(10) PRIMARY KEY AUTO_INCREMENT,
	id_klub_tuan_rumah INT(10),
	FOREIGN KEY(id_klub_tuan_rumah) REFERENCES klub(id),
	id_klub_tamu INT(10),
	FOREIGN KEY(id_klub_tamu) REFERENCES klub(id),
	tanggal_pertandinga DATE NOT NULL,
	skor_tuan_rumah INT(10) DEFAULT 0,
	skor_tamu INT(10) DEFAULT 0
);

ALTER TABLE pemain
ADD INDEX index_posisi(posisi);

ALTER TABLE klub
ADD INDEX index_kota_asal(kota_asal);

DESCRIBE klub;
DESCRIBE pemain;
DESCRIBE pertandingan;
SHOW INDEX FROM pemain;
SHOW INDEX FROM klub;

DROP DATABASE manajemen_tim_sepakbola;



## Nomor 2
SELECT customerName, 
country, SUM(p.amount) totalPayments,
ROUND(SUM(o.orderNumber), 2) orderCount,
MAX(p.paymentDate) lastPaymentDate,
case
when SUM(p.amount) > 100000 then 'VIP'
when SUM(p.amount) >= 5000 AND SUM(p.amount) <= 100000  then 'loyal'
ELSE 'New'
END AS 'status'
FROM customers c
LEFT JOIN payments p
USING(customerNumber)
LEFT JOIN orders o
USING(customerNumber)
GROUP BY customername;

## Nomor 3
SELECT c.customerNumber, 
c.customerName,
SUM(od.quantityOrdered) total_quantity,
case
when SUM(od.quantityOrdered) > (
		SELECT AVG(total) 
		FROM ( 
		SELECT SUM(od2.quantityOrdered) AS total
		FROM customers c2
		JOIN orders o2
		USING(customerNumber)
		JOIN orderdetails od2
		USING(ordernumber)
		GROUP BY c2.customerName
		) ratarata) then 'di atas rata-rata'
ELSE 'di bawah rata-rata'
END AS 'kategori_pembelian'
FROM customers c
JOIN orders o
USING(customerNumber)
JOIN orderdetails od
USING(ordernumber)
JOIN products p
USING(productcode)
GROUP BY c.customerName
ORDER BY SUM(od.quantityOrdered) DESC;


## Tugas tambahan
## Nomor 1
START TRANSACTION;
INSERT INTO klub (nama_klub, kota_asal)
VALUES	('Persija','Jakarta'),
			('Arema FC','Malang'),
			('Persebaya', 'Makassar'),
			('PSM Makassar', 'Makassar'),
			('Bali United', 'Bali');	


DESCRIBE klub;
SELECT * FROM klub;

ROLLBACK;
SET autocommit = 0;
COMMIT;

## Nomor 2
START TRANSACTION;
INSERT INTO pemain (nama_pemain, posisi, id_klub)
VALUES	('Evan Dimas', 'Midfielder', 01),
			('RikoSimanjuntak', 'Forward', 01),
			('Hanif Sjahbandi', 'Defender', 02),
			('MakanKonate', 'Midfielder', 02),
			('DaviddaSilva', 'Forward', 03),
			('Irfan Jaya', 'Forward', 04),
			('Rizky Pellu', 'Midfielder',04),
			('Ilija Spasojevic', 'Forward', 05),
			('Andhika Wijaya', 'Defender', 05);

DESCRIBE pemain;
SELECT * FROM pemain;
			
ROLLBACK;
SET autocommit = 0;
COMMIT;

## Nomor 3
START TRANSACTION;
INSERT INTO pertandingan (id_klub_tuan_rumah, id_klub_tamu, tanggal_pertandinga, skor_tuan_rumah, skor_tamu)
VALUES	(1,2, '2024-09-10', 2, 1 ),
			(3,4, '2024-09-12', 1, 1 ),
			(5, 1, '2024-09-15', 0, 3),
			(2, 5, '2024-09-20', 1, 2 ),
			(4, 3, '2024-09-25', 2, 0);
			
DESCRIBE pertandingan;
SELECT * FROM pertandingan;
			
ROLLBACK;
SET autocommit = 0;
COMMIT;