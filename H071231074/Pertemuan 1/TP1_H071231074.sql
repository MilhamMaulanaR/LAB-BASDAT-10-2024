CREATE DATABASE library;
USE library;

CREATE TABLE authors (
	id INT AUTO_INCREMENT PRIMARY KEY,
	NAME VARCHAR(100) NOT NULL
);

CREATE TABLE books (
	id INT PRIMARY KEY AUTO_INCREMENT,
	isbn VARCHAR(13),
	title VARCHAR(100) NOT NULL,
	author_id INT NOT NULL,
	FOREIGN KEY (author_id) REFERENCES authors(id)
);

ALTER TABLE authors
ADD COLUMN nationality VARCHAR(50);

ALTER TABLE books
ADD UNIQUE(isbn);

SHOW TABLES;

DESCRIBE authors;
DESCRIBE books;

CREATE TABLE members (
	id INT AUTO_INCREMENT PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	email VARCHAR(100) UNIQUE,
	phone_number CHAR(10),
	join_date DATE,
	membership_type VARCHAR(50)
);

CREATE TABLE borrowings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT NOT NULL,
    book_id INT NOT NULL,
    borrow_date DATE NOT NULL,
    return_date DATE NOT NULL,
    CONSTRAINT FOREIGN KEY (member_id) REFERENCES members(id),
    CONSTRAINT FOREIGN KEY (book_id) REFERENCES books(id)
);

ALTER TABLE books
MODIFY COLUMN title VARCHAR(150),
ADD COLUMN published_year YEAR NOT NULL,
ADD COLUMN genre VARCHAR(50) NOT NULL,
ADD COLUMN copies_available INT;

DROP DATABASE;