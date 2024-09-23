-- Tuprak Nomor 1
INSERT INTO authors(Name, Nationality)
VALUES ("Tere Liye", "Indonesian"),
	("J.K. Rowling", "British"),
	("Andrea Hirata", "");
SELECT * FROM authors;
	
INSERT INTO books(isbn, title, author_id, published_year, genre, copies_available)
VALUES (7040289780375, "Ayah", 3, 2015, "Fiction", 15),
	(9780375704025, "Bumi", 1, 2014, "Fantasy", 5),
	(8310371703024, "Bulan", 1, 2015, "Fantasy", 3),
	(9780747532699, "Harry Potter and the Philosopher's Stone", 2, 2016, "", 10),
	(7210301703022, "The Running Grave", 2, 2016, "Fiction", 11);
SELECT * FROM books;

INSERT INTO members(first_name, last_name, email, phone_number, join_date, membership_type)
VALUES ("John", "Doe", "John.doe@example.com", NULL, "2023-04-29", ""),
	("Alice", "Jhonson", "alice.jhonson@example.com",1231231231, "2023-05-01", "Standar"),
	("Bob", "Williams", "bob.williams@example.com", 3213214321, "2023-06-20", "Premium");
SELECT * FROM members;

INSERT INTO borrowings(member_id, book_id, borrow_date, return_date)
VALUES (1, 4, "2023-07-10", "2023-07-25"),
	(3, 1, "2023-08-01", NULL),
	(2, 5, "2023-09-06", "2023-09-09"),
	(2, 3, "2023-09-10", NULL),
	(3, 2, "2023-09-10", NULL);
SELECT * FROM borrowings;
	
-- Tuprak Nomor 2
SELECT * FROM books;
SELECT book_id FROM borrowings
WHERE return_date IS NULL;
UPDATE books
SET copies_available = copies_available - 1
WHERE id = 1 OR id = 2 OR id = 3
SELECT * FROM books;

-- Tuprak Nomor 3
-- Query dibawah belum kita pelajari (Materi Sub-Query)
SELECT * FROM members;
UPDATE members
SET membership_type = "Standar"
WHERE id IN (
	SELECT member_id
	FROM borrowings
	WHERE return_date IS NULL
	) AND membership_type = "Premium";
SELECT * FROM members;
	
SELECT * FROM borrowings;
DELETE FROM borrowings
WHERE member_id IN (
    SELECT id
    FROM members
    WHERE membership_type = 'Standar'
) AND return_date IS NULL;
SELECT * FROM borrowings;

SELECT * FROM members;
DELETE FROM members
WHERE membership_type = 'Standar'
  AND id NOT IN (
      SELECT member_id
      FROM borrowings
  );
SELECT * FROM members;
-- Karena Sub_Query belum dipelajari di Praktikum, maka kita harus coba cara lain selain kode di atas

SELECT * FROM members;
SELECT * FROM books;

SELECT member_id FROM borrowings
WHERE return_date IS NULL;

SELECT 
	CONSTRAINT_NAME,
	TABLE_NAME,
	referenced_table_name,
	referenced_column_name
FROM 
	information_schema.KEY_COLUMN_USAGE
WHERE 
	TABLE_NAME = 'borrowings' AND
	CONSTRAINT_SCHEMA = 'library' AND
	referenced_table_name IS NOT NULL;

-- Hapus Foreign Key nya
ALTER TABLE borrowings DROP FOREIGN KEY borrowings_ibfk_1;

-- Tambahkan kembali foreign key dengan mengubah On Delete menjadi Cascade
ALTER TABLE borrowings ADD FOREIGN KEY (member_id) REFERENCES members(id)
ON DELETE CASCADE;

-- Jalanakan kembali Query ini
DELETE FROM members
WHERE id = 2;

UPDATE members
SET membership_type = "Standar"
WHERE id = 3;
SELECT * FROM members;

SHOW TABLES
USE library
DELETE FROM borrowings;
DELETE FROM books;
DELETE FROM authors;
DELETE FROM mahasiswa;
DELETE FROM members;

ALTER TABLE authors AUTO_INCREMENT = 1;
ALTER TABLE books AUTO_INCREMENT = 1;
ALTER TABLE members AUTO_INCREMENT = 1;
ALTER TABLE borrowings AUTO_INCREMENT = 1;
