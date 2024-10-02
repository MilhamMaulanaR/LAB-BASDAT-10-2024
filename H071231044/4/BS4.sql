USE classicmodels;

/*1*/
SELECT customerNumber, customerName, country FROM customers 
WHERE country = 'USA' AND creditLimit BETWEEN 50000 AND 100000 
OR country != 'USA' AND creditLimit BETWEEN 100000 AND 200000
order by creditLimit DESC;

/*2*/
SELECT productCode, productName, quantityInstock, buyPrice FROM products
WHERE quantityInStock BETWEEN 1000 AND 2000
AND buyPrice < 50 OR buyPrice > 150 
AND productLine NOT LIKE 'Vintage%';

/*3*/
SELECT productCode, productName, MSRP FROM products
WHERE productLine LIKE '%classic%' AND buyPrice >50
order by buyPrice DESC;

/*4*/
SELECT orderNumber, orderDate,`status`, customerNumber FROM orders
WHERE orderNumber > 10250 
AND `status` NOT IN  ('Shipped', 'Cancelled')
AND (orderDate BETWEEN '2004-01-01' AND '2005-12-31');

/*5*/
SELECT orderNumber, orderLineNumber, productCode, quantityOrdered, priceEach,quantityOrdered * priceEach * 19/20  AS discountedTotalPrice 
FROM orderdetails
WHERE quantityOrdered > 50 AND priceEach > 100
AND productCode NOT LIKE 'S18%'
ORDER BY discountedTotalPrice DESC;


/* extra */
SELECT customerNumber, customerName, contactFirstName, creditLimit, country FROM customers
WHERE (creditLimit > 20000 or country IN ('Germany', 'France')) 
and contactFirstName NOT LIKE 'A%' AND contactFirstName NOT LIKE 'c%'
ORDER BY creditLimit DESC;