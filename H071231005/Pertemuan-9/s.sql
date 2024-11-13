START TRANSACTION;
COMMIT;
ROLLBACK;
SET autocommit = 0;

CREATE DATABASE perpustakaan;
CREATE TABLE buku (
	id INT(11) PRIMARY KEY AUTO_INCREMENT,
	judul VARCHAR(225) NOT NULL ,
	pengarang VARCHAR(50) NOT NULL ,
	tahun_terbit YEAR(4) ,
	INDEX index_judul(judul)
);

DESCRIBE buku


CREATE 


SELECT p.productName, SUM(od.quantityOrdered) totalkuantitas,
case
when SUM(od.quantityOrdered) > 1000 then 'produk laris'
when SUM(od.quantityOrdered) < 1000 then 'produk biasa'
END  kategoriProduk
FROM products p
JOIN orderdetails AS od
USING(productcode)
GROUP BY (productname)

SET autocommit = 0;

SELECT c.customerNumber,c.customerName, 
FROM customers c