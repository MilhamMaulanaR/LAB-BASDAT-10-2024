CREATE DATABASE sepakbola

USE sepakbola


CREATE TABLE club (
id INT PRIMARY KEY AUTO_INCREMENT,
nama_club VARCHAR(50) NOT NULL,
kota_asal VARCHAR(20) NOT NULL);

CREATE TABLE pemain (
id INT PRIMARY KEY AUTO_INCREMENT,
nama_pemain VARCHAR(50) NOT NULL, 
posisi VARCHAR(20) NOT NULL,
id_club INT,
FOREIGN KEY (id_club) REFERENCES club(id));

CREATE TABLE pertandingan (
id INT PRIMARY KEY AUTO_INCREMENT,
id_club_tuan_rumah INT,
FOREIGN KEY (id_club_tuan_rumah) REFERENCES club(id),
id_club_tamu INT,
FOREIGN KEY (id_club_tamu) REFERENCES club(id),
tanggal_pertandingan DATE NOT NULL,
skor_tuan_rumah INT DEFAULT 0,
skor_tamu INT DEFAULT 0);

DESCRIBE club;
DESCRIBE pemain;
DESCRIBE pertandingan;
-- membuat index
CREATE INDEX idx_posisi ON pemain(posisi);

CREATE INDEX idx_kotaAsal ON club(kota_asal);

USE classicmodels

SELECT 
c.customerName, 
c.country, 
SUM(p.amount) AS totalPayment, 
COUNT(DISTINCT o.orderNumber) AS total_orders,
MAX(paymentDate) AS latest_payment_date,
case 
	when SUM(p.amount)  > 100000 then 'VIP'
	when SUM(p.amount)  BETWEEN 5000 AND 100000 then 'Loyal'
	ELSE 'New'
END AS status
FROM customers c
LEFT JOIN orders o ON c.customerNumber = o.customerNumber
LEFT JOIN payments p ON c.customerNumber = p.customerNumber
GROUP BY c.customerName;
    
    
-- Nomor 3
SELECT customerNumber,customerName, SUM(quantityOrdered) `total`,
case 
when SUM(quantityordered) > (SELECT AVG(total_hasil)
	FROM (SELECT  SUM(quantityOrdered) AS total_hasil
	FROM orderdetails GROUP BY orderNumber) AS total)
	then 'di atas rata-rata'
ELSE 'di bawah rata rata'
end AS kategori
FROM customers c
JOIN orders 
USING(customerNumber)
JOIN orderdetails od
USING(orderNumber)
GROUP BY c.customerNumber
ORDER BY total desc





