CREATE DATABASE library;
USE library;

CREATE TABLE authors(
	id INT PRIMARY KEY AUTO_INCREMENT,
	NAME VARCHAR(100) NOT NULL
);

CREATE TABLE books(
	id INT PRIMARY KEY AUTO_INCREMENT,
	isbn CHAR(13) NOT NULL,
	title VARCHAR(100) NOT NULL,
	author_id INT NOT NULL,
	FOREIGN KEY (author_id) REFERENCES authors(id)
);
-- -- SOAL 2
ALTER TABLE authors
ADD nationality VARCHAR(50);

-- -- SOAL 3
ALTER TABLE books
MODIFY isbn CHAR(13) UNIQUE;

-- -- SOAL 4
SHOW TABLES;
DESCRIBE authors;
DESCRIBE books;


-- SOAL 5
-- Modifikasi tabel `books`
ALTER TABLE books
MODIFY title VARCHAR(150) NOT NULL,
ADD published_year YEAR NOT NULL,
ADD genre VARCHAR(50) NOT NULL,
ADD copies_available INT NOT NULL;

ALTER TABLE authors
MODIFY nationality VARCHAR(50) NOT NULL;

-- Membuat tabel `members`
CREATE TABLE members(
	id INT AUTO_INCREMENT PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL ,
	email VARCHAR(100) UNIQUE,
	phone_number CHAR(10),
	join_date DATE NOT NULL,
	membership_type VARCHAR(50) NOT NULL 
);
	
-- Membuat tabel `borrowings`
CREATE TABLE borrowings(
	id INT AUTO_INCREMENT PRIMARY KEY,
	member_id INT NOT NULL ,
	book_id INT NOT NULL ,
	borrow_date DATE NOT NULL ,
	return_date DATE,
   CONSTRAINT	FOREIGN KEY (member_id) REFERENCES members(id),
	CONSTRAINT  FOREIGN KEY (book_id) REFERENCES books(id)
);

DESCRIBE members;
DESCRIBE borrowings;


SELECT * FROM authors;
SELECT * FROM books;
SELECT * FROM members;
SELECT * FROM borrowings;

-- nomor 1
INSERT  INTO authors (id,NAME, nationality)  
VALUES 
(1,"tere liye", "indonesia"),
(2,"J.K. Rowling", "British"),
(3,"Andrea Hirata", NULL);


       
INSERT INTO books (id,ISBN, title, author_id, published_year, copies_available, genre) 
VALUES
(1,'7040289780375', 'Ayah', 3, 2015, 15, 'Fiction'), 
(2,'9780375704025', 'Bumi',1, 2014,5, 'Fantasy'), 
(3,'8310371703024', 'Bulan', 1, 2015 , 3, 'Fantasy' ), 
(4,'9780747532699', "Harry Potter and the Philosopher's Stone", 2, 1997, 10, NULL),
(5,'7210301703022', 'The Running Grave', 2, 2016, 11, 'Finction');
       
INSERT INTO members (first_name, last_name, email, phone_number, join_date, membership_type)
VALUES
("John","Doe","John.doe@example.com",NULL,'2023-04-29',NULL),
("Alice","Johnson","Alice.johnson@example.com",1231231231,'2023-05-01',"Standar"),
("Bob","Williams","bob.williams@example.com",3213214321,'2023-06-20',"Premium");
			
INSERT INTO borrowings (id,member_id,book_id,borrow_date,return_date)
VALUES
(1,1,4,'2023-07-10','2023-07-25'),
(2,3,1,'2023-08-01',NULL),
(3,2,5,'2023-09-06','2023-09-09'),
(4,2,3,'2023-09-08',NULL),
(5,3,2,'2023-09-10',NULL);
			
SELECT * FROM borrowings WHERE return_date IS NULL;
UPDATE books
SET copies_available = copies_available - 1
WHERE id IN(1,2,3);

UPDATE members 
SET membership_type = "standar"
WHERE id = 3

DELETE from members
WHERE id = 2

SET FOREIGN_KEY_CHECKS =  0



 





