-- #1 Customers USA & non-USA, kredit : >50k & <100k,Limit kredit 100k - 200k, Fokuskan pada costumer limit tertinggi
SELECT * FROM customers;
SELECT customernumber,
		 customername,
		 country
-- 		 creditlimit
	FROM customers
		 WHERE country = 'USA'
		 AND creditlimit > 50000
		 AND creditlimit < 100000 
		 OR country <>  'USA' 
		 AND creditlimit BETWEEN 100000 AND 200000
		 ORDER BY creditlimit DESC ;
		 
-- #2 Table product, harga stok between 1000 - 2000 unit, buyprice <50 dollar atau >150 dollar, kategori produk <> 'Vintage'
SELECT * FROM products;
SELECT 
	 productcode,
	 productname,
	 quantityinstock,
	 buyprice,
	 productline
FROM products
	 WHERE quantityinstock BETWEEN 1000 AND 2000
	 AND buyprice <50 OR buyprice >150
	 AND productline NOT LIKE '%Vintage%' ;
	 
-- #3 Table product, product line = classic, buy price > 50

SELECT * FROM products
SELECT 
	 productcode,
	 productname,
	 MSRP
-- 	 productline,
-- 	 buyprice
FROM products
	 WHERE productline LIKE '%Classic%' 
	 AND buyprice > 50 ;
	 
-- #4 Table orders, orders > 10250, status not like/ <> 'Shipped' or 'Cancelled', pesanan dibuat between 2004 and 2005 
SELECT * FROM orders
SELECT 
	 orderNumber,
	 orderDate,
	 STATUS,
	 customerNumber
FROM orders
	 WHERE orderNumber > 10250 AND
	 STATUS NOT IN ('Shipped','Cancelled')
	 AND orderDate BETWEEN '2004-01-01' AND '2005-12-31' ;
-- 	 AND orderDate NOT IN ('2004','2005') ;

-- #5 Table ordersDetails, quantityOrdered > 50 and priceEach > 100. Totalprice after diskon 5%, menurun berdasarkan totalharga after diskon 5%. ProductCode diawali S18 out.
SELECT * FROM orderdetails ;
SELECT 
    orderNumber,
    orderLineNumber,
    productCode,
    quantityOrdered,
    priceEach,
    (priceEach * quantityOrdered) * 0.95 AS discountedTotalPrice
FROM orderdetails
	 WHERE quantityOrdered > 50 
    AND priceEach > 100
    AND productCode NOT LIKE 'S18%'
    ORDER BY discountedTotalPrice DESC ;


-- #cara dua

SELECT 
	 orderNUmber,
	 orderLineNumber,
	 productCOde,
	 quantityOrdered,
	 priceEach,
    (priceEach * quantityOrdered) - (priceEach * quantityOrdered * 0.05)  AS discountedTotalPrice
FROM orderdetails
	 WHERE quantityOrdered > 50 
	 AND priceEach > 100
	 AND productCode NOT LIKE 'S18%'
	 ORDER BY discountedTotalPrice DESC ;

-- SELECT 
--     orderNumber,
--     orderLineNumber,
--     productCode,
--     quantityOrdered,
--     priceEach,
--     (priceEach * quantityOrdered) * 0.95 AS discountedTotalPrice
-- FROM orderdetails
-- WHERE quantityOrdered > 50 
--   AND priceEach > 100
--   AND productCode NOT LIKE 'S18%'
-- ORDER BY discountedTotalPrice DESC;


-- QUIZ TP 4
-- status pesanan, berlabel = in proses dan belum mencpai status pengiriman, pesanan 2005 - 31 des 2005, status != shipped cancelled
SELECT * FROM orders ;
SELECT 
	 orderNumber,
	 orderDate,
	 STATUS
-- 	 comments
FROM orders 
	 WHERE STATUS = 'in process' AND  STATUS NOT IN  ('Shipped', 'Cancelled') 
	 AND orderDate BETWEEN '2005-01-01' AND '2005-12-31'
	 AND comments IS NOT NULL 

	 
	 

	 
	 



	 

	 

	 
	 