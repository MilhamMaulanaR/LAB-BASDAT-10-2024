-- nomor 1
SELECT customername, customernumber,country,creditlimit FROM customers 
WHERE country = 'USA' AND creditlimit BETWEEN  50000 AND 100000 
OR country != 'USA' AND creditlimit BETWEEN 100000 AND 200000
ORDER BY creditlimit DESC;

-- nomor 2
SELECT productcode,productname,quantityinstock,buyprice FROM products
WHERE quantityinstock BETWEEN 1000 AND 2000 
AND buyprice < 50 OR buyprice > 150 
AND productline NOT LIKE '%vintage%';

-- nomor 3
SELECT productcode,productname,MSRP FROM products
WHERE productline LIKE '%Classic__%' AND buyprice > 50; 

-- nomor 4
SELECT  ordernumber,orderdate,STATUS,customernumber FROM orders
WHERE ordernumber > 10250 AND STATUS NOT IN ('shipped' , 'cancelled')
AND orderdate BETWEEN '2004-01-01' AND '2005-12-31' ;

-- nomor 5
SELECT ordernumber,orderlinenumber,productcode,quantityordered,priceEach, 
(quantityordered * priceEach * 95/100) AS discountedTotalPrice 
FROM orderdetails WHERE quantityordered > 50 AND priceEach > 100 AND productcode NOT LIKE 'S18%' 
ORDER BY discountedTotalprice DESC;

-- soal tambahan
SELECT ordernumber,orderdate,STATUS FROM orders
WHERE orderdate > '2004-07-01'
AND STATUS != 'shipped' AND comments IS NOT NULL
ORDER BY orderdate DESC;
