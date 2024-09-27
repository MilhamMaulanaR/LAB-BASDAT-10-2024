USE library;

#Nomor 1
INSERT INTO authors (NAME, nationality)
VALUES ("Tere Liye", "Indonesian"),
		 ("J.K. Rowling", "British"),
		 ("Andrea Hirata", " ");

SELECT * FROM authors;
DELETE FROM authors;
ALTER TABLE authors
AUTO_INCREMENT = 1;

INSERT INTO books (isbn, title, author_id, published_year, genre, copies_available)
VALUES ('7040289780375', "Ayah", 3, 2015, "Fiction", 15),
		 ('9780375704025', "Bumi", 1, 2014, "Fantasy", 5),
		 ('8310371703024', "Bulan", 1, 2015, "Fantasy", 3),
		 ('9780747532699', "Harry Potter and The Philosopher's Stone", 2, 1997, " ", 10),
		 ('7210301703022', "The Running Grave", 2, 2016, "Fiction", 11);

SELECT * FROM books;
DELETE FROM books;
ALTER TABLE books
AUTO_INCREMENT = 1;

INSERT INTO members (first_name, last_name, email, phone_number, join_date, membership_type)
VALUES ("John", "Doe", "John.doe@example.com", " ", '2023-04-29', " "),
		 ("Alice", "Johnson", "alice.jhonson@example.com", 1231231231, '2023-05-01', "Standar"),
 		 ("Bob", "Williams", "bob.williams@example.com", 3213214321, '2023-06-20', "Premiun");

SELECT * FROM members;
DELETE FROM members;
ALTER TABLE members
AUTO_INCREMENT = 1;

INSERT INTO borrowings (member_id, book_id, borrow_date, return_date)
VALUES (1, 4, '2023-07-10', '2023-07-25'),
	 	 (3, 1, '2023-08-01', NULL),
		 (2, 5, '2023-09-06', '2023-09-09'),
		 (2, 3, '2023-09-08', NULL),
		 (3, 2, '2023-09-10', NULL);

SELECT * FROM borrowings;
DELETE FROM borrowings;
ALTER TABLE borrowings
AUTO_INCREMENT = 1;


#Nomor 2
SELECT * FROM borrowings WHERE return_date IS NULL;
UPDATE books
SET copies_available = copies_available - 1
WHERE id = 2 OR 4 OR 5;

#Nomor 3
SELECT member_id FROM borrowings WHERE return_date IS NULL;
SELECT membership_type FROM members  WHERE id = 3;
SELECT membership_type FROM members  WHERE id = 2;

UPDATE members
SET membership_type = "Standar"
WHERE id = 3

ALTER TABLE borrowings DROP FOREIGN KEY fk_member;

ALTER TABLE borrowings ADD FOREIGN KEY (member_id) REFERENCES members (id)
ON DELETE CASCADE;

DELETE FROM members
WHERE id = 2

SET foreign_key_checks = 0