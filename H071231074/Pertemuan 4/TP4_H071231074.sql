-- Tuprak Nomor 1
SELECT * FROM customers
SELECT customerNumber, customerName, country, creditLimit
FROM customers
WHERE (country = "USA" AND creditLimit BETWEEN 50000 AND 100000)
OR country <> "USA" AND creditLimit BETWEEN 100000 AND 200000
ORDER BY creditLimit DESC

-- Tuprak Nomor 2
SELECT * FROM products
SELECT productCode, productName, quantityInStock, buyPrice
FROM products
WHERE (quantityInStock BETWEEN 1000 AND 2000) AND (buyPrice < 50 or buyPrice > 150)
AND NOT productLine LIKE '%Vintage%'

-- Tuprak Nomor 3
SELECT productCode, productName, MSRP
FROM products
WHERE productLine LIKE '%Classic%' AND buyPrice > 50

-- Tuprak Nomor 4
SELECT orderNumber, orderDate, status, customerNumber FROM orders
WHERE orderNumber > 10250 
AND STATUS NOT IN ("Cancelled", "Shipped")
AND orderDate BETWEEN "2004-01-01" AND "2005-12-31"

-- Tuprak Nomor 5
SELECT * FROM orderDetails
SELECT orderNumber, orderLineNumber, productCode, quantityOrdered, priceEach, (quantityOrdered * priceEach * 0.95) AS discountedTotalPrice
FROM orderdetails
WHERE (quantityOrdered > 50 AND priceEach > 100) AND productCode NOT LIKE 'S18%'
ORDER BY discountedTotalPrice DESC

-- Tuprak