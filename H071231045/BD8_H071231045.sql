## Nomor 1
(SELECT p.productName, SUM(od.priceEach * od.quantityordered ) AS TotalRevenue, 'Pendapatan Tertinggi' AS  pendapatan
FROM products AS p
	JOIN orderdetails AS od USING(productcode)
	JOIN orders AS o USING(orderNumber)
	WHERE MONTH(o.orderDate) = 9
	GROUP BY p.productName
	ORDER BY  TotalRevenue DESC 
	LIMIT 5)

	UNION 

	(SELECT p.productName, SUM(od.priceEach * od.quantityordered ) AS TotalRevenue, 'Pendapatan Pendek (kayak kamu)' AS  pendapatan
	FROM products AS p
	JOIN orderdetails AS od USING(productcode)
	JOIN orders AS o USING(orderNumber)
	WHERE MONTH(o.orderDate) = 9
	GROUP BY p.productName
	ORDER BY  TotalRevenue ASC
	LIMIT 5);

## Nomor 2
SELECT productName
FROM products
WHERE productCode NOT IN (
   SELECT productCode
   FROM orderdetails
   JOIN orders USING (orderNumber)
   WHERE customerNumber IN (
		SELECT customerNumber
   	FROM customers
      JOIN orders USING (customerNumber)
      GROUP BY customerNumber
      HAVING(orderNumber) > 10
        
      INTERSECT 
        
      SELECT customerNumber
      FROM customers
      JOIN orders USING (customerNumber)
      JOIN orderdetails USING (orderNumber)
      JOIN products USING (productCode)
      WHERE buyPrice > (SELECT AVG(buyPrice) FROM products)
    )
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
	WHERE productline IN ('Planes', 'Trains')
	GROUP BY customername
	HAVING SUM(buyprice) > 20000;

## Nomor 4
SELECT Tanggal, customerNumber, GROUP_CONCAT(DISTINCT riwayat SEPARATOR ' dan ') AS riwayat
FROM (SELECT orderdate AS Tanggal, customerNumber, 'Memesan Barang' AS riwayat
	FROM orders
	WHERE orderdate LIKE '2003-09%'

	UNION 

	SELECT  paymentdate AS Tanggal, customernumber, 'Membayar Pesanan' riwayat
	FROM payments
	WHERE paymentdate LIKE '2003-09%'
	) tt
	GROUP BY Tanggal;


## Nomor 5
SELECT (p.productCode)
FROM products AS p
JOIN orderdetails AS od USING(productcode)
JOIN orders AS o USING(orderNumber)
WHERE od.priceEach > (
	SELECT AVG(od2.priceEach)
	FROM orderdetails AS od2
	JOIN orders AS o USING(ordernumber)
	WHERE o.orderDate BETWEEN '2001-01-01' AND '2004-05-31'
	) AND od.quantityOrdered > 48 AND LEFT(p.productVendor, 1) IN ('a','i','u','e','o')


	EXCEPT

	(SELECT p.productCode
	FROM products AS p
	JOIN orderdetails AS od USING(productcode)
	JOIN orders AS o USING(orderNumber)
	JOIN customers AS c USING(customerNumber)
	WHERE c.country IN ('jepang','jerman','italy')
	ORDER BY p.productCode ASC )
	LIMIT 3;


#Soal Tambahan 	
SELECT productName
FROM products

EXCEPT

SELECT DISTINCT p.productName
FROM products p
JOIN orderdetails od USING(productCode)
JOIN orders o USING(orderNumber)
JOIN customers c USING(customerNumber)
WHERE o.customerNumber IN (
		SELECT customerNumber
   	FROM customers
      JOIN orders USING (customerNumber)
      GROUP BY customerNumber
      HAVING COUNT(orderNumber) > 10)
        
      AND
      
      o.customerNumber IN ( 
      SELECT customerNumber
      FROM customers
      JOIN orders USING (customerNumber)
      JOIN orderdetails  USING (orderNumber)
      JOIN products  USING (productCode)
      WHERE buyPrice > (SELECT AVG(buyPrice) FROM products)
    );
