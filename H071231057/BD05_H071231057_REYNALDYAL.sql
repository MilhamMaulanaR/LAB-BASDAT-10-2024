
SELECT * FROM customers;
SELECT * FROM products ;
SELECT * FROM orders ;
SELECT * FROM employees ;


-- #1 produk titanic beserta pelanggan, nama pelanggan = unique, order by desc, deskripsi produk as informasi tambahan
SELECT DISTINCT 
    c.customerName AS 'namaKustomer',
    p.productName AS 'namaProduk',
    pl.textDescription 
FROM productlines AS pl
INNER JOIN products AS p
    ON pl.productLine = p.productLine
INNER JOIN orderdetails AS od
    ON p.productCode = od.productCode
INNER JOIN orders AS o
    ON od.orderNumber = o.orderNumber
INNER JOIN customers AS c
	 ON o.customerNumber = c.customerNumber
   
WHERE p.productName LIKE '%Titanic%'
ORDER BY c.customerName;


-- #2 penjualan miniatur mobil Ferrari, status pesanan sudah dikirim, periode waktu 1 tahun dari bulan 10 2003, order by tanggal terbaru
SELECT DISTINCT 
    c.customerName AS 'customerName',
    p.productName AS 'productName',
    o.status AS 'status',
    o.shippedDate AS 'shippedDate'
FROM products AS p
INNER JOIN orderdetails AS od
    ON p.productCode = od.productCode
INNER JOIN orders AS o
    ON od.orderNumber = o.orderNumber
INNER JOIN customers AS c
    ON o.customerNumber = c.customerNumber
WHERE p.productName LIKE '%Ferrari%'
    AND o.status = 'Shipped'
    AND o.shippedDate BETWEEN '2003-10-01' AND '2004-10-01'
ORDER BY o.shippedDate DESC;

-- #3 daftar karyawan di bawah supervisi Gerard, nama karyawan diurutkan sesuai abjad

SELECT 
    s.firstName AS 'Supervisor',
    e.firstName AS 'Karyawan'

FROM employees AS e
INNER JOIN employees AS s
    ON e.reportsTo = s.employeeNumber
WHERE s.firstName = 'Gerard'
ORDER BY e.firstName, e.lastName;


SELECT 
    CONCAT(s.firstName, ' ', s.lastName) AS 'Supervisor',
    CONCAT(e.firstName, ' ', e.lastName) AS 'Karyawan'
FROM employees AS e
INNER JOIN employees AS s
    ON e.reportsTo = s.employeeNumber
WHERE s.firstName = 'Gerard'
ORDER BY e.firstName, e.lastName;


-- #4
-- #4-A: Mendapatkan data lengkap tentang pelanggan yang melakukan transaksi di bulan November, termasuk pelanggan, tanggal pembayaran, nama karyawan yang terlibat, dan jumlah.
SELECT 
    customerName, 
    paymentDate, 
    e.firstName AS 'employeeName', 
    amount
FROM payments AS p
INNER JOIN customers AS c
    ON c.customerNumber = p.customerNumber
INNER JOIN employees AS e
    ON e.employeeNumber = c.salesRepEmployeeNumber
WHERE p.paymentDate LIKE '_____11%'

-- #4-B Mengetahui siapa pelanggan dengan jumlah transaksi terbanyak di bulan Nov
ORDER BY p.amount DESC LIMIT 1;

-- #4-C produk apa saja yang dibeli beliau alias gift ideas yang dilauyani sama lesley
SELECT 
    c.customerName, 
    pd.productName
FROM payments AS p
INNER JOIN customers AS c
    ON c.customerNumber = p.customerNumber
INNER JOIN orders AS o
    ON c.customerNumber = o.customerNumber
INNER JOIN orderdetails AS od
    ON o.orderNumber = od.orderNumber
INNER JOIN products AS pd
    ON od.productCode = pd.productCode
WHERE c.customerName = 'Corporate Gift Ideas Co.'
  AND p.paymentDate LIKE '_____11%';
  
-- #5 tambahan. status pesanan = on hold if pesanan belum dikirim (no shipped date), tampilkan : no pesanan,tanggal pesanan, tanggal pengiriman, nama pelanggan, nama produk, status that's been updated
UPDATE orders 
SET status = 'On Hold' 
WHERE shippedDate IS NULL;

SELECT 
    o.orderNumber, 
    o.orderDate, 
    o.shippedDate, 
    c.customerName, 
    p.productName, 
    o.status
FROM orders AS o
INNER JOIN customers AS c
    ON o.customerNumber = c.customerNumber
INNER JOIN orderdetails AS od
    ON o.orderNumber = od.orderNumber
INNER JOIN products AS p
    ON od.productCode = p.productCode
WHERE o.status = 'On Hold'
ORDER BY c.customerName;



-- # QUIZ
SELECT DISTINCT 
	 od.orderNumber AS 'nomor order',
	 o.orderDate AS 'tanggal order',
	 c.customerName AS 'nama pelanggan',
	 pm.amount AS 'pembayaran'
FROM products AS p
INNER JOIN orderdetails AS od
	ON p.productCode = od.productCode
INNER JOIN orders AS o
	 ON od.orderNumber = o.orderNumber
INNER JOIN customers AS c
	 ON o.customerNumber = c.customerNumber
INNER JOIN payments AS pm
	 ON c.customerNumber = pm.customerNumber
WHERE pm.amount <50000
	 AND o.status = 'Cancelled' ;

SELECT * FROM payments
SELECT * FROM orders

-- #coba quiz 
-- start from 1 dan diakhiri r = '1%r%'
-- customerName, orderNumber,orderDate,shippedDate,productName,quantity ordered

SELECT DISTINCT 
	c.customerName AS 'Nama Pelanggan',
	o.orderNumber AS 'Nomor Pesanan',
	o.shippedDate AS 'Tanggal Pengiriman',
	p.productName AS 'Nama Barang',
	od.quantityOrdered AS 'Kuantitas orderan',
	od.priceEach AS 'Harga Each',
	office.city AS 'Kota Sales',
	e.firstName AS 'Nama depan',
	e.lastName AS 'Nama belakang',
	o.orderDate AS 'Tanggal Order'
FROM products AS p
INNER JOIN orderdetails AS od
	ON p.productCode = od.productCode
INNER JOIN orders AS o
	ON od.orderNumber = o.orderNumber
INNER JOIN customers AS c
	ON o.customerNumber = c.customerNumber
INNER JOIN payments AS pm
	ON c.customerNumber = pm.customerNumber
INNER JOIN employees AS e
	ON c.salesRepEmployeeNumber = e.employeeNumber
INNER JOIN offices AS office
	ON e.officeCode = office.officeCode

WHERE 
	o.shippedDate < '2004-12-25'
	AND od.quantityOrdered > 10
	AND c.city = 'NYC'
	AND od.priceEach BETWEEN 20 AND 100              
	AND p.productName LIKE '1%R';
	
SELECT * FROM customers
SELECT * FROM products

	



