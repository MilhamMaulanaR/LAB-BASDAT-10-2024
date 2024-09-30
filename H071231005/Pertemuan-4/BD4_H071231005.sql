## Nomor 1
SELECT * FROM customers
SELECT customernumber, customername, country
FROM customers
WHERE country = 'usa' AND creditLimit > 50000 AND creditLimit < 100000
OR country <> 'usa' AND creditLimit >= 100000 AND creditLimit <= 200000
ORDER BY creditlimit DESC;

## Nomor 2
SELECT * FROM products 
SELECT productcode, productname, quantityinstock, buyprice
FROM products
WHERE quantityinstock > 1000 AND quantityinstock < 2000
AND buyprice < 50 OR  buyprice > 150 
AND productline NOT LIKE '%vintage%';

## Nomor 3
SELECT * FROM products
SELECT productcode, productname, msrp
FROM products
WHERE productline LIKE '%classic%'
AND buyprice > 50;

## Nomor 4
SELECT * FROM orders
SELECT ordernumber, orderdate, Status, customernumber
FROM orders
WHERE ordernumber > 10250
AND status NOT IN  ('Shipped','Cancelled') 
AND orderdate BETWEEN '2004-01-01' AND '2005-12-31';

## Nomor 5
SELECT * FROM orderdetails
SELECT*, (priceeach * quantityordered * 0.95) discountedTotalPrice FROM orderdetails
WHERE quantityordered > 50 AND priceEach > 100
AND productcode NOT LIKE 'S18%'
ORDER BY discountedTotalPrice DESC;








