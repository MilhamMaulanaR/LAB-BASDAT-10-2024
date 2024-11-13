-- #TP-3

CREATE DATABASE library;
USE library;

-- #1 CREATE DATABASE LIBRARY, Masukkan data keempat kolom
-- Author
CREATE TABLE Authors (
	 id INT PRIMARY KEY AUTO_INCREMENT,
	 NAME VARCHAR(100) NOT NULL ,
	 nationality VARCHAR(50) NOT NULL 
);
-- books
CREATE TABLE books (
	 id INT PRIMARY KEY AUTO_INCREMENT,
	 title VARCHAR(150) NOT NULL ,
	 isbn CHAR(13) UNIQUE ,
	 author_id INT NOT NULL,
	 published_year YEAR NOT NULL,
	 genre VARCHAR(50) NOT NULL,
	 copies_available INT NOT NULL,
	 FOREIGN KEY (author_id) REFERENCES authors(id)
);
-- members
CREATE TABLE members (
    id INT  PRIMARY KEY AUTO_INCREMENT ,
    first_name VARCHAR(50) NOT NULL ,
    last_name VARCHAR(50) NOT NULL ,
    email VARCHAR(100) UNIQUE ,
    phone_number CHAR(10) ,
    join_date DATE NOT NULL ,
    membership_type VARCHAR(50) NOT NULL 
);
-- borrowings
CREATE TABLE borrowings (
    id INT PRIMARY KEY AUTO_INCREMENT ,
    member_id INT NOT NULL ,
    book_id INT NOT NULL ,
    borrow_date DATE NOT NULL ,
    return_date DATE,
    FOREIGN KEY (member_id) REFERENCES members(id),
    FOREIGN KEY (book_id) REFERENCES books(id)
);

-- insert 
-- authors
INSERT INTO authors (NAME,nationality)
VALUES 
	 ("Tere Liye", "Indoensia"),
	 ("J.K. Rowling", "British"),
 	 ("Andrea Hirata", "");

-- books
INSERT INTO books (isbn, title,author_id, published_year, genre, copies_available )
VALUES
    ('7040289780375', 'Ayah', 3, 2015, 'Fiction', 15),
    ('9780375704025', 'Bumi', 1, 2014, 'Fantasy', 5),
    ('8310371703024', 'Bulan', 1, 2015, 'Fantasy', 3),
    ('9780747532699', 'Harry Potter and the Philosopher\'s Stone', 2, 1997, 'Fantasy', 10),
    ('7210301703022', 'The Running Grave', 2, 2016, 'Fiction', 11);

-- members
INSERT INTO members (first_name, last_name, email, phone_number, join_date, membership_type)
VALUES 
	 ('John', 'Doe', 'John.doe@example.com', NULL, '2023-04-29', NULL),
    ('Alice', 'Johnson', 'alice.johnson@example.com', '1231231231', '2023-05-01', 'Standar'),
    ('Bob', 'Williams', 'bob.williams@example.com', '3213214321', '2023-06-20', 'Premium');

-- ALTER TABLE members 
-- MODIFY membership_type VARCHAR(50);

-- //ini melihat id 
SELECT id, first_name, last_name FROM members;
-- SELECT id, NAME FROM authors;
-- SELECT id, title, isbn FROM books;

-- borrowings
INSERT INTO borrowings (member_id, book_id, borrow_date, return_date)
VALUES
    (1, 4, '2023-07-10', '2023-07-25'),  -- John Doe pinjam buku 'herpot'
    (3, 1, '2023-08-01', NULL),          -- Bob Williams pinjam buku 'ayah'
    (2, 5, '2023-09-06', '2023-09-09'),  -- Alice Johnson pinjam buku 'the running grave'
    (2, 3, '2023-09-08', NULL),          -- Alice Johnson pinjam buku 'Bulan'
    (3, 2, '2023-09-10', NULL);          -- Bob Williams pinjam buku 'Bumi'

-- #2 buku hilang memperbarui table books = kurangi jumlah copies_available AYAH|BULAN|BUMI HILANG!
UPDATE books
SET copies_available = copies_available - 1
	 WHERE id = 1;

UPDATE books
SET copies_available = copies_available - 1
	 WHERE id = 3;
	 
UPDATE books
SET copies_available = copies_available - 1
	 WHERE id = 2;
	 
-- #3 member menghilangkan buku kena sanksi, maka Premium = standar, Standar = dihapus
SELECT * FROM members;
SELECT * FROM borrowings;
SELECT * FROM books;
-- Ayah\'s books = bob
UPDATE members
	 SET membership_type = "Standar"
	 WHERE id = 3;

-- Bulan\'s books = Alice | Standar = delete | id = 2
ALTER TABLE borrowings
DROP FOREIGN KEY borrowings_ibfk_1;

ALTER TABLE borrowings
ADD CONSTRAINT borrowings_ibfk_1
FOREIGN KEY (member_id) REFERENCES members(id)
ON DELETE CASCADE;

-- cek id alice | id alice = 2
-- cek data pinjaman alice
SELECT * FROM borrowings WHERE member_id = 2;
-- Hapus ALICE
DELETE FROM members
WHERE id = 2;


