USE library

#1
-- authors
INSERT INTO authors (NAME , nationality)
VALUES ('Tere Liye' , 'Indonesian'),
		 ('J.K. Rowling' , 'British');
		 
INSERT INTO authors (NAME)
VALUES ('andrea hirata');
		 	 
SELECT * FROM authors 

-- Books 
ALTER TABLE books
ADD author_name VARCHAR (150);

INSERT INTO books (Isbn,Title,author_id, author_name,Published_Year,Genre,Copies_Available)
VALUES (7040289780375, 'Ayah', 3, 'Andrea Hirata', 2015, 'Fiction', 15),
		 (9780375704025, 'Bumi', 1, 'Tere Liye', 2014, 'Fantasy', 5),
		 (8310371703024, 'Bulan', 1, 'Tere Liye', 2015, 'Fantasy', 10),
		 (9780747532699, "Harry Potter and the Philosopher's Stone", 2, 'J.K. Rowling', 1997, ' ', 10),
		 (7210301703022, 'The Running Grave', 2, 'J.K. Rowling', 2016, 'Fiction', 11);

INSERT INTO books (Isbn, Title, author_id, Published_year, Genre, Copies_Available)
VALUES (0987654322, "bunda", 1, 2023, "drama", 99);

UPDATE books
SET Title = 'ibu'
WHERE id = 6;

UPDATE books
SET Copies_Available = 123
WHERE id = 6;

SELECT * FROM books

-- members
ALTER TABLE members
ADD full_name VARCHAR (150);

INSERT INTO members (full_name, email, phone_number, join_date, membership_type)
VALUES ('John Doe', 'John.doe@exemple.com', NULL, '2023-04-29', ' '),
		 ('Alice John', 'alice.johnson@example.com', 1231231231, '2023-05-01', 'Standar'),
		 ('Bob Williams', 'bob.williams@example.com', 3213214321, '2023-06-20', 'Premium');

SELECT * FROM members

-- Borrowings
INSERT INTO members (member_id, book_title, borrow_date, return_date)
VALUES ('John Doe', "Harry Potter and the Philosopher's Stone", '2023-07-10', '2023-070-25'),
		 ('Bob Williams', 'Ayah', '2023-08-01', NULL),
		 ('Alice Jonhson', 'The Running Grave', '2023-09-06', '2023-09-09'),
		 ('Alice jonhson', 'Bulan', '2023-09-08', NULL),
		 ('Bob Williams', 'Bumi', '2023-09-10', NULL);
		 
SELECT * FROM borrowings


#Nomor 2
-- Cari dulu id buku yang hilang
SELECT book_id FROM borrowings 
WHERE return_date IS NULL; -- book_id = 1, 3, 2

-- Kurangi jumlah buku untuk masing-masing buku yang hilang
UPDATE books
SET copies_available = copies_available-1
WHERE id = 1;
UPDATE books
SET copies_available = copies_available-1
WHERE id = 3;
UPDATE books
SET copies_available = copies_available-1
WHERE id = 2;

SELECT * FROM books;


#Nomor 3
SELECT member_id FROM borrowings 
WHERE return_date IS NULL;

SELECT membership_type FROM members
WHERE id = 3; -- Premium
SELECT membership_type FROM members
WHERE id = 2; -- Standar

UPDATE members 
SET membership_type = 'Standar'
WHERE id = 3;


DELETE FROM members WHERE id = 2;

SELECT * FROM members;
SELECT * FROM borrowings;

ALTER TABLE borrowings DROP FOREIGN KEY borrowings_ibfk_1 ;

ALTER TABLE borrowings ADD FOREIGN KEY (member_id) REFERENCES members (id) 
ON DELETE CASCADE;

