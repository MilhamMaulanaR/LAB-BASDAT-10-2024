USE library;

SELECT * from authors;
SELECT * FROM books;
SELECT * FROM members;
SELECT * FROM borrowings;

INSERT INTO authors (NAME,nationality)
VALUES ('Tere Liye', 'Indonesian'), ('J. K Rowling', 'British'), ('Andrea Hirata','');

DELETE from books;

INSERT INTO books (id, ISBN, title, author_id, published_year, copies_available, genre) 
VALUES (1, '7040289780375', 'Ayah', 3, 2015, 15, 'Fiction'), (2, '9780375704025', 'Bumi',1, 2014,5, 'Fantasy'), 
(3, '8310371703024', 'Bulan', 1, 2015 , 3, 'Fantasy' ), (4, '9780747532699', "Harry Potter and the Philosopher's Stone", 2, 1997, 10, ''),
(5, '7210301703022', 'The Running Grave', 2, 2016, 11, 'Finction');

INSERT INTO members (first_name, last_name, email, phone_number, join_date, membership_type)
VALUES ('John', 'Doe', 'John.doe@example.com', null, '2023-04-29',''), ('Alice', 'Johnson', 'alice.johnson@example.com', '123123231' ,'2023-05-01', 'Standar'),
('Bob', 'Williams', 'bob.williams@example.com', '3213214321', '2023-06-20', 'Premium');

INSERT INTO borrowings (id, member_id, book_id, borrow_date, return_date)
VALUES  (1, 1, 4, '2023-07-10', '2023-07-25'), (2, 3, 1, '2023-08-01', null), (3, 2, 5, '2023-09-08', '2023-09-09'),
(4, 2, 3,'2023-09-08', null), (5, 3, 2, '2023-09-10', NULL);

#Buku Ayah hilang
UPDATE books
SET copies_available = copies_available-1
WHERE id = 1;

#Buku Bulan hilang
UPDATE books
SET copies_available = copies_available-1
WHERE id = 2;

#Buku Bumi hilang
UPDATE books
SET copies_available = copies_available-1
WHERE id = 3;

#Bob Williams menghilangkan buku Premium ke Standar
UPDATE members
SET membership_type = 'Standar'
WHERE id = 3;

#Alice & John menghilangkan buku Keluarkan dari membership
DELETE FROM members 
WHERE id = 2;

SELECT
    CONSTRAINT_NAME, 
    TABLE_NAME, 
    COLUMN_NAME, 
    REFERENCED_TABLE_NAME, 
    REFERENCED_COLUMN_NAME
FROM
    INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE
    TABLE_NAME = 'borrowings' AND
    CONSTRAINT_SCHEMA = 'library' AND
    REFERENCED_TABLE_NAME IS NOT NULL;

ALTER TABLE borrowings DROP FOREIGN KEY borrowings_ibfk_2;

ALTER TABLE borrowings ADD FOREIGN KEY (member_id) REFERENCES members (id) 
ON DELETE CASCADE;

DELETE FROM members 
WHERE id = 2;

INSERT INTO books (id, ISBN, title, author_id, published_year, copies_available, genre) 
VALUES (6, '003', 'Ibu', 3, 2019, 69, 'Drama');

UPDATE books SET title = "bunda" WHERE id = 6;
DROP DATABASE library;