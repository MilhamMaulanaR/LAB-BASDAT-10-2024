#NOMOR 1
CREATE DATABASE library;
USE library;

CREATE TABLE authors (
	id INT AUTO_INCREMENT PRIMARY KEY,
	NAME VARCHAR (100) NOT NULL
);

CREATE TABLE books (
	id INT AUTO_INCREMENT PRIMARY KEY,
	isbn VARCHAR(13) NOT NULL,
	title VARCHAR(100) NOT NULL,
	author_id INT,
	FOREIGN KEY (author_id)REFERENCES authors(id)	
);

#NOMOR 2
ALTER TABLE authors
ADD nationality VARCHAR(50) NOT NULL;

#NOMOR 3
ALTER TABLE books
MODIFY isbn CHAR (13) NOT NULL UNIQUE;

#NOMOR 4
SHOW TABLES;
DESCRIBE authors;
DESCRIBE books;

#NOMOR 5
ALTER TABLE books
MODIFY title VARCHAR(150) NOT NULL,
ADD published_year DATE NOT NULL,
ADD genre VARCHAR(50) NOT NULL,
ADD copies_available INT NOT NULL;

ALTER TABLE authors
MODIFY nationality VARCHAR(50) NOT NULL;

CREATE TABLE members (
	id INT PRIMARY KEY AUTO_INCREMENT,
	first_name VARCHAR(50),
	last_name VARCHAR(50) NOT NULL,
   email VARCHAR(100) UNIQUE NOT NULL,
   phone_number CHAR(10),
   join_date DATE NOT NULL,
   membership_type VARCHAR(50) NOT NULL
);


CREATE TABLE borrowings (
	id INT PRIMARY KEY AUTO_INCREMENT,
   member_id INT NOT NULL,
   book_id INT NOT NULL,
   borrow_date DATE NOT NULL,
   return_date DATE NOT NULL,
   
   constraint fk_member FOREIGN KEY (member_id) REFERENCES members(id),
   constraint fk_book FOREIGN KEY (book_id) REFERENCES books(id)
);


DESCRIBE authors;
DESCRIBE books;
DESCRIBE borrowings;
DESCRIBE members;

DROP DATABASE library;