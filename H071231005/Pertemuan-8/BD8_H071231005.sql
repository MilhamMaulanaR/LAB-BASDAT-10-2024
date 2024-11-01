## Nomor 1
(SELECT 
p.productName, 
SUM(od.priceEach * od.quantityordered ) AS TotalRevenue, 
'Pendapatan Tertinggi' AS  pendapatan
FROM products AS p
JOIN orderdetails AS od
USING(productcode)
JOIN orders AS o
USING(orderNumber)
WHERE MONTH(o.orderDate) = 9
GROUP BY p.productName
ORDER BY  TotalRevenue DESC 
LIMIT 5
) 

UNION 

(SELECT 
p.productName, 
SUM(od.priceEach * od.quantityordered ) AS TotalRevenue, 
'Pendapatan Pendek' AS  pendapatan
FROM products AS p
JOIN orderdetails AS od
USING(productcode)
JOIN orders AS o
USING(orderNumber)
WHERE MONTH(o.orderDate) = 9
GROUP BY p.productName
ORDER BY  TotalRevenue ASC
LIMIT 5
);

## Nomor 2
SELECT productName
FROM products
WHERE productCode NOT IN (
    SELECT productCode
    FROM orderdetails
    JOIN orders 
	 USING (orderNumber)
    WHERE customerNumber IN
	 (SELECT customerNumber
	  FROM customers
	  JOIN orders
	  USING(customerNumber)
	  GROUP BY customerNumber
	  HAVING COUNT(orderNumber) > 10

	  INTERSECT 

	  SELECT customerNumber
	  FROM customers
	  JOIN orders
	  USING(customerNumber)
	  JOIN orderdetails
	  USING(orderNumber)
	  JOIN products
	  USING(productCode)
	  where buyPrice > (SELECT AVG(buyPrice) FROM products))
);


## Nomor 3
SELECT customername
FROM customers
JOIN payments
GROUP BY customername
HAVING SUM(amount) > (
	SELECT 2*AVG(amount)
	FROM payments
)

INTERSECT

SELECT customername
FROM payments
JOIN customers USING (customernumber)
JOIN orders USING (customernumber)
JOIN orderdetails USING(ordernumber)
JOIN products USING(productcode)
WHERE 
	productline IN ('Planes', 'Trains')
GROUP BY
customername
HAVING SUM(buyprice) > 20000;

## Nomor 4
SELECT Tanggal, customerNumber,
GROUP_CONCAT(DISTINCT riwayat SEPARATOR ' dan ') riwayat
FROM (
SELECT 	orderdate Tanggal,
			customerNumber, 
			'Memesan Barang' riwayat
FROM orders
WHERE orderdate LIKE '2003-09%'
UNION 
SELECT  paymentdate Tanggal,
customernumber,
'Membayar Pesanan' riwayat
FROM payments
WHERE paymentdate LIKE '2003-09%'
) yooo
GROUP BY Tanggal;


## Nomor 5
SELECT DISTINCT(p.productCode)
FROM products AS p
JOIN orderdetails AS od
USING(productcode)
JOIN orders AS o
USING(orderNumber)
WHERE od.priceEach > (
	SELECT AVG(od2.priceEach)
	FROM orderdetails AS od2
	JOIN orders AS o
	USING(ordernumber)
	WHERE o.orderDate BETWEEN '2001-01-01' AND '2004-05-31'
) AND od.quantityOrdered > 48 AND LEFT(p.productVendor, 1) IN ('a','i','u','e','o')


EXCEPT

(SELECT p.productCode
FROM products AS p
JOIN orderdetails AS od
USING(productcode)
JOIN orders AS o
USING(orderNumber)
JOIN customers AS c 
USING(customerNumber)
WHERE c.country IN ('jepang','jerman','italy')
ORDER BY p.productCode ASC )
LIMIT 3;

## Tugas Tambahan
SELECT  CONCAT(firstName,' ',lastName) AS 'Nama Karyawan/Pelanggan','karyawan' AS STATUS
FROM employees
JOIN offices
USING(officecode)
WHERE  officecode IN (
SELECT DISTINCT(officecode)
FROM offices 
JOIN employees 
USING(officecode)
GROUP BY officecode
HAVING COUNT(firstName) = 2)

UNION 

SELECT customername, 'pelanggan'
FROM customers c
JOIN employees e
ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE officecode IN  (
SELECT DISTINCT(officecode)
FROM offices 
JOIN employees 
USING(officecode)
GROUP BY officecode
HAVING COUNT(firstName) = 2)	
ORDER BY `Nama Karyawan/Pelanggan` ASC;












