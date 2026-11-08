Enter password: ****
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 18
Server version: 8.0.45 MySQL Community Server - GPL

Copyright (c) 2000, 2026, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> create database librarydb;
Query OK, 1 row affected (0.00 sec)

mysql> use librarydb;
Database changed
mysql> CREATE TABLE Members (
    ->     member_id INT AUTO_INCREMENT PRIMARY KEY,
    ->     member_name VARCHAR(100) NOT NULL,
    ->     email VARCHAR(100) UNIQUE,
    ->     phone VARCHAR(15),
    ->     address VARCHAR(200),
    ->     join_date DATE NOT NULL,
    ->     status ENUM('Active','Inactive')
    ->     DEFAULT 'Active'
    -> );
Query OK, 0 rows affected (0.01 sec)

mysql> CREATE TABLE Books (
    ->     book_id INT AUTO_INCREMENT PRIMARY KEY,
    ->     book_name VARCHAR(150) NOT NULL,
    ->     author VARCHAR(100),
    ->     category VARCHAR(50),
    ->     price DECIMAL(10,2),
    ->     total_copies INT NOT NULL,
    ->     available_copies INT NOT NULL,
    ->     CHECK (price >= 0),
    ->     CHECK (total_copies >= 0),
    ->     CHECK (available_copies >= 0),
    ->     CHECK (available_copies <= total_copies)
    -> );
Query OK, 0 rows affected (0.02 sec)

mysql> CREATE TABLE Issue_Records (
    ->     issue_id INT AUTO_INCREMENT PRIMARY KEY,
    ->     member_id INT NOT NULL,
    ->     book_id INT NOT NULL,
    ->     issue_date DATE NOT NULL,
    ->     due_date DATE NOT NULL,
    ->     return_date DATE,
    ->     fine_amount DECIMAL(10,2) DEFAULT 0,
    ->     status ENUM('Issued','Returned')
    ->     DEFAULT 'Issued',
    ->
    ->     FOREIGN KEY (member_id)
    ->     REFERENCES Members(member_id),
    ->
    ->     FOREIGN KEY (book_id)
    ->     REFERENCES Books(book_id),
    ->
    ->     CHECK (fine_amount >= 0),
    ->     CHECK (due_date >= issue_date)
    -> );
Query OK, 0 rows affected (0.02 sec)

mysql> CREATE TABLE Fine_Payments (
    ->     payment_id INT AUTO_INCREMENT PRIMARY KEY,
    ->     issue_id INT NOT NULL,
    ->     amount_paid DECIMAL(10,2) NOT NULL,
    ->     payment_date DATE NOT NULL,
    ->     payment_mode ENUM('Cash','UPI','Card')
    ->     DEFAULT 'Cash',
    ->
    ->     FOREIGN KEY (issue_id)
    ->     REFERENCES Issue_Records(issue_id),
    ->
    ->     CHECK (amount_paid > 0)
    -> );
Query OK, 0 rows affected (0.01 sec)

mysql> INSERT INTO Members
    -> (member_name, email, phone, address, join_date)
    -> VALUES
    -> ('Arun', 'arun@gmail.com', '9876543210',
    ->  'Chennai', '2026-01-10'),
    ->
    -> ('Priya', 'priya@gmail.com', '9876543211',
    ->  'Chennai', '2026-01-12'),
    ->
    -> ('Rahul', 'rahul@gmail.com', '9876543212',
    ->  'Coimbatore', '2026-01-15'),
    ->
    -> ('Divya', 'divya@gmail.com', '9876543213',
    ->  'Madurai', '2026-02-01'),
    ->
    -> ('Karthik', 'karthik@gmail.com', '9876543214',
    ->  'Salem', '2026-02-05');
Query OK, 5 rows affected (0.01 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> INSERT INTO Books
    -> (book_name, author, category, price,
    ->  total_copies, available_copies)
    -> VALUES
    -> ('Database System', 'Korth', 'Database',
    ->  500, 5, 5),
    ->
    -> ('Python Programming', 'Guido', 'Programming',
    ->  450, 4, 4),
    ->
    -> ('Java Programming', 'James Gosling', 'Programming',
    ->  600, 3, 3),
    ->
    -> ('Computer Networks', 'Tanenbaum', 'Networking',
    ->  550, 4, 4),
    ->
    -> ('Operating System', 'Galvin', 'Computer Science',
    ->  400, 3, 3),
    ->
    -> ('Web Technology', 'Jon Duckett', 'Web Development',
    ->  350, 2, 2);
Query OK, 6 rows affected (0.01 sec)
Records: 6  Duplicates: 0  Warnings: 0

mysql> ^C
mysql> INSERT INTO Issue_Records
    -> (member_id, book_id, issue_date, due_date,
    ->  return_date, fine_amount, status)
    -> VALUES
    -> (1, 1, '2026-10-01', '2026-10-15',
    ->  '2026-10-18', 15, 'Returned'),
    ->
    -> (2, 2, '2026-10-10', '2026-10-24',
    ->  NULL, 0, 'Issued'),
    ->
    -> (3, 3, '2026-10-12', '2026-10-26',
    ->  '2026-10-25', 0, 'Returned'),
    ->
    -> (4, 4, '2026-10-15', '2026-10-29',
    ->  NULL, 0, 'Issued');
Query OK, 4 rows affected (0.01 sec)
Records: 4  Duplicates: 0  Warnings: 0

mysql> ^C
mysql> UPDATE Books
    -> SET available_copies = total_copies - 1
    -> WHERE book_id IN (1, 2, 3, 4);
Query OK, 4 rows affected (0.01 sec)
Rows matched: 4  Changed: 4  Warnings: 0

mysql> CREATE TABLE Test (
    ->     id INT PRIMARY KEY,
    ->     name VARCHAR(50)
    -> );
Query OK, 0 rows affected (0.02 sec)

mysql> ALTER TABLE Test
    -> ADD age INT;
Query OK, 0 rows affected (0.03 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> TRUNCATE TABLE Test;
Query OK, 0 rows affected (0.02 sec)

mysql> DROP TABLE Test;
Query OK, 0 rows affected (0.01 sec)

mysql> INSERT INTO Members
    -> (member_name, email, phone, address, join_date)
    -> VALUES
    -> ('Manoj', 'manoj@gmail.com', '9876500000',
    ->  'Chennai', '2026-03-01');
Query OK, 1 row affected (0.01 sec)

mysql> UPDATE Members
    -> SET address = 'Trichy'
    -> WHERE member_id = 1;
Query OK, 1 row affected (0.01 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> DELETE FROM Members
    -> WHERE member_id = 5;
Query OK, 1 row affected (0.01 sec)

mysql> select*from members;
+-----------+-------------+-----------------+------------+------------+------------+--------+
| member_id | member_name | email           | phone      | address    | join_date  | status |
+-----------+-------------+-----------------+------------+------------+------------+--------+
|         1 | Arun        | arun@gmail.com  | 9876543210 | Trichy     | 2026-01-10 | Active |
|         2 | Priya       | priya@gmail.com | 9876543211 | Chennai    | 2026-01-12 | Active |
|         3 | Rahul       | rahul@gmail.com | 9876543212 | Coimbatore | 2026-01-15 | Active |
|         4 | Divya       | divya@gmail.com | 9876543213 | Madurai    | 2026-02-01 | Active |
|         6 | Manoj       | manoj@gmail.com | 9876500000 | Chennai    | 2026-03-01 | Active |
+-----------+-------------+-----------------+------------+------------+------------+--------+
5 rows in set (0.00 sec)

mysql> select*from books;
+---------+--------------------+---------------+------------------+--------+--------------+------------------+
| book_id | book_name          | author        | category         | price  | total_copies | available_copies |
+---------+--------------------+---------------+------------------+--------+--------------+------------------+
|       1 | Database System    | Korth         | Database         | 500.00 |            5 |                4 |
|       2 | Python Programming | Guido         | Programming      | 450.00 |            4 |                3 |
|       3 | Java Programming   | James Gosling | Programming      | 600.00 |            3 |                2 |
|       4 | Computer Networks  | Tanenbaum     | Networking       | 550.00 |            4 |                3 |
|       5 | Operating System   | Galvin        | Computer Science | 400.00 |            3 |                3 |
|       6 | Web Technology     | Jon Duckett   | Web Development  | 350.00 |            2 |                2 |
+---------+--------------------+---------------+------------------+--------+--------------+------------------+
6 rows in set (0.00 sec)

mysql> select*from issue_records;
+----------+-----------+---------+------------+------------+-------------+-------------+----------+
| issue_id | member_id | book_id | issue_date | due_date   | return_date | fine_amount | status   |
+----------+-----------+---------+------------+------------+-------------+-------------+----------+
|        1 |         1 |       1 | 2026-10-01 | 2026-10-15 | 2026-10-18  |       15.00 | Returned |
|        2 |         2 |       2 | 2026-10-10 | 2026-10-24 | NULL        |        0.00 | Issued   |
|        3 |         3 |       3 | 2026-10-12 | 2026-10-26 | 2026-10-25  |        0.00 | Returned |
|        4 |         4 |       4 | 2026-10-15 | 2026-10-29 | NULL        |        0.00 | Issued   |
+----------+-----------+---------+------------+------------+-------------+-------------+----------+
4 rows in set (0.00 sec)

mysql> CREATE USER 'libraryuser'@'localhost'
    -> IDENTIFIED BY 'Library@123';
Query OK, 0 rows affected (0.01 sec)

mysql> GRANT SELECT, INSERT, UPDATE
    -> ON LibraryDB.*
    -> TO 'libraryuser'@'localhost';
Query OK, 0 rows affected (0.00 sec)

mysql> REVOKE UPDATE
    -> ON LibraryDB.*
    -> FROM 'libraryuser'@'localhost';
Query OK, 0 rows affected (0.01 sec)

mysql> start transaction;
Query OK, 0 rows affected (0.00 sec)

mysql> ^C
mysql> UPDATE Books
    -> SET price = 550
    -> WHERE book_id = 1;
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> savepoint s1;
Query OK, 0 rows affected (0.00 sec)

mysql> UPDATE Books
    -> SET price = 650
    -> WHERE book_id = 2;
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> rollback to s1;
Query OK, 0 rows affected (0.00 sec)

mysql> commit;
Query OK, 0 rows affected (0.00 sec)

mysql> SELECT book_name, price,
    -> price + 100 AS Increased_Price
    -> FROM Books;
+--------------------+--------+-----------------+
| book_name          | price  | Increased_Price |
+--------------------+--------+-----------------+
| Database System    | 550.00 |          650.00 |
| Python Programming | 450.00 |          550.00 |
| Java Programming   | 600.00 |          700.00 |
| Computer Networks  | 550.00 |          650.00 |
| Operating System   | 400.00 |          500.00 |
| Web Technology     | 350.00 |          450.00 |
+--------------------+--------+-----------------+
6 rows in set (0.00 sec)

mysql> SELECT * FROM Books
    -> WHERE price > 400;
+---------+--------------------+---------------+-------------+--------+--------------+------------------+
| book_id | book_name          | author        | category    | price  | total_copies | available_copies |
+---------+--------------------+---------------+-------------+--------+--------------+------------------+
|       1 | Database System    | Korth         | Database    | 550.00 |            5 |                4 |
|       2 | Python Programming | Guido         | Programming | 450.00 |            4 |                3 |
|       3 | Java Programming   | James Gosling | Programming | 600.00 |            3 |                2 |
|       4 | Computer Networks  | Tanenbaum     | Networking  | 550.00 |            4 |                3 |
+---------+--------------------+---------------+-------------+--------+--------------+------------------+
4 rows in set (0.00 sec)

mysql> SELECT * FROM Books
    -> WHERE price > 400
    -> AND category = 'Programming';
+---------+--------------------+---------------+-------------+--------+--------------+------------------+
| book_id | book_name          | author        | category    | price  | total_copies | available_copies |
+---------+--------------------+---------------+-------------+--------+--------------+------------------+
|       2 | Python Programming | Guido         | Programming | 450.00 |            4 |                3 |
|       3 | Java Programming   | James Gosling | Programming | 600.00 |            3 |                2 |
+---------+--------------------+---------------+-------------+--------+--------------+------------------+
2 rows in set (0.00 sec)

mysql> SELECT * FROM Books
    -> WHERE price BETWEEN 400 AND 600;
+---------+--------------------+---------------+------------------+--------+--------------+------------------+
| book_id | book_name          | author        | category         | price  | total_copies | available_copies |
+---------+--------------------+---------------+------------------+--------+--------------+------------------+
|       1 | Database System    | Korth         | Database         | 550.00 |            5 |                4 |
|       2 | Python Programming | Guido         | Programming      | 450.00 |            4 |                3 |
|       3 | Java Programming   | James Gosling | Programming      | 600.00 |            3 |                2 |
|       4 | Computer Networks  | Tanenbaum     | Networking       | 550.00 |            4 |                3 |
|       5 | Operating System   | Galvin        | Computer Science | 400.00 |            3 |                3 |
+---------+--------------------+---------------+------------------+--------+--------------+------------------+
5 rows in set (0.00 sec)

mysql> SELECT * FROM Books
    -> WHERE category IN ('Programming','Database');
+---------+--------------------+---------------+-------------+--------+--------------+------------------+
| book_id | book_name          | author        | category    | price  | total_copies | available_copies |
+---------+--------------------+---------------+-------------+--------+--------------+------------------+
|       1 | Database System    | Korth         | Database    | 550.00 |            5 |                4 |
|       2 | Python Programming | Guido         | Programming | 450.00 |            4 |                3 |
|       3 | Java Programming   | James Gosling | Programming | 600.00 |            3 |                2 |
+---------+--------------------+---------------+-------------+--------+--------------+------------------+
3 rows in set (0.00 sec)

mysql> SELECT * FROM Members
    -> WHERE member_name LIKE 'A%';
+-----------+-------------+----------------+------------+---------+------------+--------+
| member_id | member_name | email          | phone      | address | join_date  | status |
+-----------+-------------+----------------+------------+---------+------------+--------+
|         1 | Arun        | arun@gmail.com | 9876543210 | Trichy  | 2026-01-10 | Active |
+-----------+-------------+----------------+------------+---------+------------+--------+
1 row in set (0.01 sec)

mysql> SELECT * FROM Issue_Records
    -> WHERE return_date IS NULL;
+----------+-----------+---------+------------+------------+-------------+-------------+--------+
| issue_id | member_id | book_id | issue_date | due_date   | return_date | fine_amount | status |
+----------+-----------+---------+------------+------------+-------------+-------------+--------+
|        2 |         2 |       2 | 2026-10-10 | 2026-10-24 | NULL        |        0.00 | Issued |
|        4 |         4 |       4 | 2026-10-15 | 2026-10-29 | NULL        |        0.00 | Issued |
+----------+-----------+---------+------------+------------+-------------+-------------+--------+
2 rows in set (0.00 sec)

mysql> SELECT * FROM Books
    -> ORDER BY price DESC;
+---------+--------------------+---------------+------------------+--------+--------------+------------------+
| book_id | book_name          | author        | category         | price  | total_copies | available_copies |
+---------+--------------------+---------------+------------------+--------+--------------+------------------+
|       3 | Java Programming   | James Gosling | Programming      | 600.00 |            3 |                2 |
|       1 | Database System    | Korth         | Database         | 550.00 |            5 |                4 |
|       4 | Computer Networks  | Tanenbaum     | Networking       | 550.00 |            4 |                3 |
|       2 | Python Programming | Guido         | Programming      | 450.00 |            4 |                3 |
|       5 | Operating System   | Galvin        | Computer Science | 400.00 |            3 |                3 |
|       6 | Web Technology     | Jon Duckett   | Web Development  | 350.00 |            2 |                2 |
+---------+--------------------+---------------+------------------+--------+--------------+------------------+
6 rows in set (0.00 sec)

mysql> ^C
mysql> SELECT category, COUNT(*) AS Total_Books
    -> FROM Books
    -> GROUP BY category;
+------------------+-------------+
| category         | Total_Books |
+------------------+-------------+
| Database         |           1 |
| Programming      |           2 |
| Networking       |           1 |
| Computer Science |           1 |
| Web Development  |           1 |
+------------------+-------------+
5 rows in set (0.00 sec)

mysql> SELECT category, COUNT(*) AS Total_Books
    -> FROM Books
    -> GROUP BY category
    -> HAVING COUNT(*) > 1;
+-------------+-------------+
| category    | Total_Books |
+-------------+-------------+
| Programming |           2 |
+-------------+-------------+
1 row in set (0.01 sec)

mysql> SELECT * FROM Books
    -> LIMIT 3;
+---------+--------------------+---------------+-------------+--------+--------------+------------------+
| book_id | book_name          | author        | category    | price  | total_copies | available_copies |
+---------+--------------------+---------------+-------------+--------+--------------+------------------+
|       1 | Database System    | Korth         | Database    | 550.00 |            5 |                4 |
|       2 | Python Programming | Guido         | Programming | 450.00 |            4 |                3 |
|       3 | Java Programming   | James Gosling | Programming | 600.00 |            3 |                2 |
+---------+--------------------+---------------+-------------+--------+--------------+------------------+
3 rows in set (0.00 sec)

mysql> SELECT COUNT(*) AS Total_Members
    -> FROM Members;
+---------------+
| Total_Members |
+---------------+
|             5 |
+---------------+
1 row in set (0.00 sec)

mysql> SELECT SUM(price) AS Total_Book_Value
    -> FROM Books;
+------------------+
| Total_Book_Value |
+------------------+
|          2900.00 |
+------------------+
1 row in set (0.00 sec)

mysql> SELECT AVG(price) AS Average_Price
    -> FROM Books;
+---------------+
| Average_Price |
+---------------+
|    483.333333 |
+---------------+
1 row in set (0.01 sec)

mysql> SELECT AVG(price) AS Average_Price
    -> FROM Books;
+---------------+
| Average_Price |
+---------------+
|    483.333333 |
+---------------+
1 row in set (0.00 sec)

mysql> SELECT MAX(price) AS Highest_Price
    -> FROM Books;
+---------------+
| Highest_Price |
+---------------+
|        600.00 |
+---------------+
1 row in set (0.00 sec)

mysql> SELECT MIN(price) AS Lowest_Price
    -> FROM Books;
+--------------+
| Lowest_Price |
+--------------+
|       350.00 |
+--------------+
1 row in set (0.01 sec)

mysql> SELECT SUM(amount_paid) AS Total_Fine_Collected
    -> FROM Fine_Payments;
+----------------------+
| Total_Fine_Collected |
+----------------------+
|                 NULL |
+----------------------+
1 row in set (0.00 sec)

mysql> SELECT M.member_name, B.book_name,
    -> I.issue_date, I.due_date
    -> FROM Issue_Records I
    -> INNER JOIN Members M
    -> ON I.member_id = M.member_id
    -> INNER JOIN Books B
    -> ON I.book_id = B.book_id;
+-------------+--------------------+------------+------------+
| member_name | book_name          | issue_date | due_date   |
+-------------+--------------------+------------+------------+
| Arun        | Database System    | 2026-10-01 | 2026-10-15 |
| Priya       | Python Programming | 2026-10-10 | 2026-10-24 |
| Rahul       | Java Programming   | 2026-10-12 | 2026-10-26 |
| Divya       | Computer Networks  | 2026-10-15 | 2026-10-29 |
+-------------+--------------------+------------+------------+
4 rows in set (0.00 sec)

mysql> SELECT M.member_name, I.issue_id
    -> FROM Members M
    -> LEFT JOIN Issue_Records I
    -> ON M.member_id = I.member_id;
+-------------+----------+
| member_name | issue_id |
+-------------+----------+
| Arun        |        1 |
| Priya       |        2 |
| Rahul       |        3 |
| Divya       |        4 |
| Manoj       |     NULL |
+-------------+----------+
5 rows in set (0.00 sec)

mysql> SELECT B.book_name, I.issue_id
    -> FROM Issue_Records I
    -> RIGHT JOIN Books B
    -> ON I.book_id = B.book_id;
+--------------------+----------+
| book_name          | issue_id |
+--------------------+----------+
| Database System    |        1 |
| Python Programming |        2 |
| Java Programming   |        3 |
| Computer Networks  |        4 |
| Operating System   |     NULL |
| Web Technology     |     NULL |
+--------------------+----------+
6 rows in set (0.00 sec)

mysql> CREATE VIEW Book_Details AS
    -> SELECT book_id, book_name, author,
    -> category, price, available_copies
    -> FROM Books;
Query OK, 0 rows affected (0.01 sec)

mysql> SELECT * FROM Book_Details;
+---------+--------------------+---------------+------------------+--------+------------------+
| book_id | book_name          | author        | category         | price  | available_copies |
+---------+--------------------+---------------+------------------+--------+------------------+
|       1 | Database System    | Korth         | Database         | 550.00 |                4 |
|       2 | Python Programming | Guido         | Programming      | 450.00 |                3 |
|       3 | Java Programming   | James Gosling | Programming      | 600.00 |                2 |
|       4 | Computer Networks  | Tanenbaum     | Networking       | 550.00 |                3 |
|       5 | Operating System   | Galvin        | Computer Science | 400.00 |                3 |
|       6 | Web Technology     | Jon Duckett   | Web Development  | 350.00 |                2 |
+---------+--------------------+---------------+------------------+--------+------------------+
6 rows in set (0.00 sec)

mysql> CREATE VIEW Fine_Details AS
    -> SELECT
    -> I.issue_id,
    -> M.member_name,
    -> B.book_name,
    -> I.fine_amount
    -> FROM Issue_Records I
    -> JOIN Members M
    -> ON I.member_id = M.member_id
    -> JOIN Books B
    -> ON I.book_id = B.book_id;
Query OK, 0 rows affected (0.01 sec)

mysql> SELECT * FROM Fine_Details;
+----------+-------------+--------------------+-------------+
| issue_id | member_name | book_name          | fine_amount |
+----------+-------------+--------------------+-------------+
|        1 | Arun        | Database System    |       15.00 |
|        2 | Priya       | Python Programming |        0.00 |
|        3 | Rahul       | Java Programming   |        0.00 |
|        4 | Divya       | Computer Networks  |        0.00 |
+----------+-------------+--------------------+-------------+
4 rows in set (0.00 sec)

mysql> DELIMITER //
mysql>
mysql> CREATE PROCEDURE IssueBook(
    ->     IN p_member_id INT,
    ->     IN p_book_id INT
    -> )
    -> BEGIN
    ->     DECLARE v_count INT;
    ->
    ->     SELECT COUNT(*) INTO v_count
    ->     FROM Members
    ->     WHERE member_id = p_member_id
    ->     AND status = 'Active';
    -> IF v_count = 0 THEN
    ->         SIGNAL SQLSTATE '45000'
    ->         SET MESSAGE_TEXT = 'Member is not active or does not exist';
    ->     END IF;
    ->  SELECT COUNT(*) INTO v_count
    ->     FROM Books
    ->     WHERE book_id = p_book_id
    ->     AND available_copies > 0;
    -> IF v_count = 0 THEN
    ->         SIGNAL SQLSTATE '45000'
    ->         SET MESSAGE_TEXT = 'Book is not available';
    ->     ELSE
    ->         INSERT INTO Issue_Records
    ->         (member_id, book_id, issue_date, due_date)
    ->         VALUES
    ->         (p_member_id, p_book_id,
    ->          CURDATE(), DATE_ADD(CURDATE(), INTERVAL 14 DAY));
    ->     END IF;
    -> END //
Query OK, 0 rows affected (0.01 sec)

mysql> DELIMITER ;
mysql> CALL IssueBook(1, 5);
Query OK, 1 row affected (0.01 sec)

mysql> DELIMITER //
mysql>
mysql> CREATE PROCEDURE ReturnBook(
    ->     IN p_issue_id INT
    -> )
    -> BEGIN
    ->     DECLARE v_count INT;
    ->
    ->     SELECT COUNT(*) INTO v_count
    ->     FROM Issue_Records
    ->     WHERE issue_id = p_issue_id
    ->     AND status = 'Issued';
    ->
    ->     IF v_count = 0 THEN
    ->         SIGNAL SQLSTATE '45000'
    ->         SET MESSAGE_TEXT = 'Invalid issue ID or book already returned';
    ->     ELSE
    ->         UPDATE Issue_Records
    ->         SET return_date = CURDATE(),
    ->             status = 'Returned'
    ->         WHERE issue_id = p_issue_id;
    ->     END IF;
    -> END //
Query OK, 0 rows affected (0.01 sec)

mysql> DELIMETER ;
    -> CALL ReturnBook(2);
    -> ^C
mysql> DELIMITER ;
mysql> CALL ReturnBook(2);
Query OK, 1 row affected (0.01 sec)

mysql> DELIMITER //
mysql>
mysql> CREATE PROCEDURE PayFine(
    ->     IN p_issue_id INT,
    ->     IN p_amount DECIMAL(10,2),
    ->     IN p_mode VARCHAR(10)
    -> )
    -> BEGIN
    ->     DECLARE v_balance DECIMAL(10,2);
    ->
    ->     SELECT fine_amount -
    ->     COALESCE((
    ->         SELECT SUM(amount_paid)
    ->         FROM Fine_Payments
    ->         WHERE issue_id = p_issue_id
    ->     ), 0)
    ->     INTO v_balance
    ->     FROM Issue_Records
    ->     WHERE issue_id = p_issue_id
    ->     AND status = 'Returned';
    ->
    ->     IF v_balance IS NULL THEN
    ->         SIGNAL SQLSTATE '45000'
    ->         SET MESSAGE_TEXT = 'Invalid issue ID or book not returned';
    ->     ELSEIF p_amount <= 0 OR p_amount > v_balance THEN
    ->         SIGNAL SQLSTATE '45000'
    ->         SET MESSAGE_TEXT = 'Invalid payment amount';
    ->     ELSE
    ->         INSERT INTO Fine_Payments
    ->         (issue_id, amount_paid, payment_date, payment_mode)
    ->         VALUES
    ->         (p_issue_id, p_amount, CURDATE(), p_mode);
    ->     END IF;
    -> END //
Query OK, 0 rows affected (0.01 sec)

mysql> DELIMITER ;
mysql> CALL PayFine(1, 15, 'UPI');
Query OK, 1 row affected (0.01 sec)

mysql> DELIMITER //
mysql>
mysql> CREATE TRIGGER After_Book_Issue
    -> AFTER INSERT ON Issue_Records
    -> FOR EACH ROW
    -> BEGIN
    ->     UPDATE Books
    ->     SET available_copies = available_copies - 1
    ->     WHERE book_id = NEW.book_id;
    -> END //
Query OK, 0 rows affected (0.01 sec)

mysql> DELIMITER ;
mysql> DELIMITER //
mysql>
mysql> CREATE TRIGGER Calculate_Fine
    -> BEFORE UPDATE ON Issue_Records
    -> FOR EACH ROW
    -> BEGIN
    ->     IF OLD.status = 'Issued'
    ->        AND NEW.status = 'Returned' THEN
    ->
    ->         SET NEW.fine_amount =
    ->         GREATEST(
    ->             DATEDIFF(NEW.return_date, NEW.due_date),
    ->             0
    ->         ) * 5;
    ->
    ->     END IF;
    -> END //
Query OK, 0 rows affected (0.01 sec)

mysql>
mysql> DELIMITER ;
mysql> DELIMITER //
mysql>
mysql> CREATE TRIGGER After_Book_Return
    -> AFTER UPDATE ON Issue_Records
    -> FOR EACH ROW
    -> BEGIN
    ->     IF OLD.status = 'Issued'
    ->        AND NEW.status = 'Returned' THEN
    ->
    ->         UPDATE Books
    ->         SET available_copies = available_copies + 1
    ->         WHERE book_id = NEW.book_id;
    ->
    ->     END IF;
    -> END //
Query OK, 0 rows affected (0.01 sec)

mysql> DELIMITER ;
mysql> DELIMITER //
mysql>
mysql> CREATE TRIGGER Check_Book_Availability
    -> BEFORE INSERT ON Issue_Records
    -> FOR EACH ROW
    -> BEGIN
    ->     DECLARE v_available INT;
    ->
    ->     SELECT available_copies
    ->     INTO v_available
    ->     FROM Books
    ->     WHERE book_id = NEW.book_id;
    ->
    ->     IF v_available <= 0 THEN
    ->         SIGNAL SQLSTATE '45000'
    ->         SET MESSAGE_TEXT = 'No copies available';
    ->     END IF;
    -> END //
Query OK, 0 rows affected (0.01 sec)

mysql> DELIMITER ;
mysql> ^C
mysql> ^BCREATE VIEW Outstanding_Fines AS
    -> SELECT
    -> I.issue_id,
    -> M.member_name,
    -> B.book_name,
    -> I.fine_amount AS Total_Fine,
    ->
    -> COALESCE(SUM(P.amount_paid), 0)
    -> AS Paid_Amount,
    ->
    -> I.fine_amount -
    -> COALESCE(SUM(P.amount_paid), 0)
    -> AS Balance
    ->
    -> FROM Issue_Records I
    ->
    -> JOIN Members M
    -> ON I.member_id = M.member_id
    ->
    -> JOIN Books B
    -> ON I.book_id = B.book_id
    ->
    -> LEFT JOIN Fine_Payments P
    -> ON I.issue_id = P.issue_id
    ->
    -> GROUP BY
    -> I.issue_id,
    -> M.member_name,
    -> B.book_name,
    -> I.fine_amount;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'CREATE VIEW Outstanding_Fines AS
SELECT
I.issue_id,
M.member_name,
B.book_name,' at line 1
mysql> CREATE VIEW Outstanding_Fines AS
    -> SELECT
    -> I.issue_id,
    -> M.member_name,
    -> B.book_name,
    -> I.fine_amount AS Total_Fine,
    ->
    -> COALESCE(SUM(P.amount_paid), 0)
    -> AS Paid_Amount,
    ->
    -> I.fine_amount -
    -> COALESCE(SUM(P.amount_paid), 0)
    -> AS Balance
    ->
    -> FROM Issue_Records I
    ->
    -> JOIN Members M
    -> ON I.member_id = M.member_id
    ->
    -> JOIN Books B
    -> ON I.book_id = B.book_id
    ->
    -> LEFT JOIN Fine_Payments P
    -> ON I.issue_id = P.issue_id
    ->
    -> GROUP BY
    -> I.issue_id,
    -> M.member_name,
    -> B.book_name,
    -> I.fine_amount;
Query OK, 0 rows affected (0.01 sec)

mysql> SELECT * FROM Outstanding_Fines
    -> WHERE Balance > 0;
Empty set (0.00 sec)

mysql> SELECT * FROM Outstanding_Fines
    -> WHERE Balance = 0
    -> AND Total_Fine > 0;
+----------+-------------+-----------------+------------+-------------+---------+
| issue_id | member_name | book_name       | Total_Fine | Paid_Amount | Balance |
+----------+-------------+-----------------+------------+-------------+---------+
|        1 | Arun        | Database System |      15.00 |       15.00 |    0.00 |
+----------+-------------+-----------------+------------+-------------+---------+
1 row in set (0.00 sec)

mysql> SELECT SUM(Balance) AS Total_Outstanding_Fine
    -> FROM Outstanding_Fines;
+------------------------+
| Total_Outstanding_Fine |
+------------------------+
|                   0.00 |
+------------------------+
1 row in set (0.01 sec)

mysql> SELECT * FROM Books
    -> WHERE available_copies > 0;
+---------+--------------------+---------------+------------------+--------+--------------+------------------+
| book_id | book_name          | author        | category         | price  | total_copies | available_copies |
+---------+--------------------+---------------+------------------+--------+--------------+------------------+
|       1 | Database System    | Korth         | Database         | 550.00 |            5 |                4 |
|       2 | Python Programming | Guido         | Programming      | 450.00 |            4 |                3 |
|       3 | Java Programming   | James Gosling | Programming      | 600.00 |            3 |                2 |
|       4 | Computer Networks  | Tanenbaum     | Networking       | 550.00 |            4 |                3 |
|       5 | Operating System   | Galvin        | Computer Science | 400.00 |            3 |                3 |
|       6 | Web Technology     | Jon Duckett   | Web Development  | 350.00 |            2 |                2 |
+---------+--------------------+---------------+------------------+--------+--------------+------------------+
6 rows in set (0.00 sec)

mysql> ^C
mysql> SELECT M.member_name, B.book_name,
    -> I.issue_date, I.due_date
    -> FROM Issue_Records I
    -> JOIN Members M
    -> ON I.member_id = M.member_id
    -> JOIN Books B
    -> ON I.book_id = B.book_id
    -> WHERE I.status = 'Issued';
+-------------+-------------------+------------+------------+
| member_name | book_name         | issue_date | due_date   |
+-------------+-------------------+------------+------------+
| Divya       | Computer Networks | 2026-10-15 | 2026-10-29 |
| Arun        | Operating System  | 2026-11-09 | 2026-11-23 |
+-------------+-------------------+------------+------------+
2 rows in set (0.00 sec)

mysql> SELECT M.member_name, B.book_name,
    -> I.due_date,
    -> DATEDIFF(CURDATE(), I.due_date) AS Late_Days
    -> FROM Issue_Records I
    -> JOIN Members M
    -> ON I.member_id = M.member_id
    -> JOIN Books B
    -> ON I.book_id = B.book_id
    -> WHERE I.status = 'Issued'
    -> AND I.due_date < CURDATE();
+-------------+-------------------+------------+-----------+
| member_name | book_name         | due_date   | Late_Days |
+-------------+-------------------+------------+-----------+
| Divya       | Computer Networks | 2026-10-29 |        11 |
+-------------+-------------------+------------+-----------+
1 row in set (0.01 sec)

mysql> SELECT
    -> M.member_name,
    -> B.book_name,
    -> DATEDIFF(CURDATE(), I.due_date) * 5
    -> AS Expected_Fine
    -> FROM Issue_Records I
    -> JOIN Members M
    -> ON I.member_id = M.member_id
    -> JOIN Books B
    -> ON I.book_id = B.book_id
    -> WHERE I.status = 'Issued'
    -> AND I.due_date < CURDATE();
+-------------+-------------------+---------------+
| member_name | book_name         | Expected_Fine |
+-------------+-------------------+---------------+
| Divya       | Computer Networks |            55 |
+-------------+-------------------+---------------+
1 row in set (0.00 sec)

mysql> SELECT B.book_name,
    -> COUNT(I.issue_id) AS Times_Borrowed
    -> FROM Books B
    -> LEFT JOIN Issue_Records I
    -> ON B.book_id = I.book_id
    -> GROUP BY B.book_id, B.book_name
    -> ORDER BY Times_Borrowed DESC;
+--------------------+----------------+
| book_name          | Times_Borrowed |
+--------------------+----------------+
| Database System    |              1 |
| Python Programming |              1 |
| Java Programming   |              1 |
| Computer Networks  |              1 |
| Operating System   |              1 |
| Web Technology     |              0 |
+--------------------+----------------+
6 rows in set (0.00 sec)

mysql> SELECT M.member_name,
    -> SUM(P.amount_paid) AS Total_Paid
    -> FROM Members M
    -> JOIN Issue_Records I
    -> ON M.member_id = I.member_id
    -> JOIN Fine_Payments P
    -> ON I.issue_id = P.issue_id
    -> GROUP BY M.member_id, M.member_name;
+-------------+------------+
| member_name | Total_Paid |
+-------------+------------+
| Arun        |      15.00 |
+-------------+------------+
1 row in set (0.00 sec)

mysql> SELECT category,
    -> SUM(total_copies) AS Total_Copies
    -> FROM Books
    -> GROUP BY category;
+------------------+--------------+
| category         | Total_Copies |
+------------------+--------------+
| Database         |            5 |
| Programming      |            7 |
| Networking       |            4 |
| Computer Science |            3 |
| Web Development  |            2 |
+------------------+--------------+
5 rows in set (0.00 sec)

mysql> SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| librarydb          |
| mysql              |
| performance_schema |
| pfs1               |
| sys                |
+--------------------+
6 rows in set (0.00 sec)

mysql> USE LIBRABYDB;
ERROR 1049 (42000): Unknown database 'librabydb'
mysql> USE LIBRARYDB;
Database changed
mysql> SHOW TABLES;
+---------------------+
| Tables_in_librarydb |
+---------------------+
| book_details        |
| books               |
| fine_details        |
| fine_payments       |
| issue_records       |
| members             |
| outstanding_fines   |
+---------------------+
7 rows in set (0.00 sec)

mysql> DESC MEMBERS;
+-------------+---------------------------+------+-----+---------+----------------+
| Field       | Type                      | Null | Key | Default | Extra          |
+-------------+---------------------------+------+-----+---------+----------------+
| member_id   | int                       | NO   | PRI | NULL    | auto_increment |
| member_name | varchar(100)              | NO   |     | NULL    |                |
| email       | varchar(100)              | YES  | UNI | NULL    |                |
| phone       | varchar(15)               | YES  |     | NULL    |                |
| address     | varchar(200)              | YES  |     | NULL    |                |
| join_date   | date                      | NO   |     | NULL    |                |
| status      | enum('Active','Inactive') | YES  |     | Active  |                |
+-------------+---------------------------+------+-----+---------+----------------+
7 rows in set (0.00 sec)

mysql> DESC BOOKS;
+------------------+---------------+------+-----+---------+----------------+
| Field            | Type          | Null | Key | Default | Extra          |
+------------------+---------------+------+-----+---------+----------------+
| book_id          | int           | NO   | PRI | NULL    | auto_increment |
| book_name        | varchar(150)  | NO   |     | NULL    |                |
| author           | varchar(100)  | YES  |     | NULL    |                |
| category         | varchar(50)   | YES  |     | NULL    |                |
| price            | decimal(10,2) | YES  |     | NULL    |                |
| total_copies     | int           | NO   |     | NULL    |                |
| available_copies | int           | NO   |     | NULL    |                |
+------------------+---------------+------+-----+---------+----------------+
7 rows in set (0.00 sec)

mysql> SHOW TRIGGERS;
+-------------------------+--------+---------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------+------------------------+-----------------------------------------------------------------------------------------------------------------------+----------------+----------------------+----------------------+--------------------+
| Trigger                 | Event  | Table         | Statement                                                                                                                                                                                                                                                            | Timing | Created                | sql_mode                                                                                                              | Definer        | character_set_client | collation_connection | Database Collation |
+-------------------------+--------+---------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------+------------------------+-----------------------------------------------------------------------------------------------------------------------+----------------+----------------------+----------------------+--------------------+
| Check_Book_Availability | INSERT | issue_records | BEGIN
    DECLARE v_available INT;

    SELECT available_copies
    INTO v_available
    FROM Books
    WHERE book_id = NEW.book_id;

    IF v_available <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No copies available';
    END IF;
END | BEFORE | 2026-11-09 00:29:11.89 | ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION | root@localhost | utf8mb4              | utf8mb4_0900_ai_ci   | utf8mb4_0900_ai_ci |
| After_Book_Issue        | INSERT | issue_records | BEGIN
    UPDATE Books
    SET available_copies = available_copies - 1
    WHERE book_id = NEW.book_id;
END                                                                                                                                                          | AFTER  | 2026-11-09 00:27:46.52 | ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION | root@localhost | utf8mb4              | utf8mb4_0900_ai_ci   | utf8mb4_0900_ai_ci |
| Calculate_Fine          | UPDATE | issue_records | BEGIN
    IF OLD.status = 'Issued'
       AND NEW.status = 'Returned' THEN

        SET NEW.fine_amount =
        GREATEST(
            DATEDIFF(NEW.return_date, NEW.due_date),
            0
        ) * 5;

    END IF;
END                                       | BEFORE | 2026-11-09 00:28:13.67 | ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION | root@localhost | utf8mb4              | utf8mb4_0900_ai_ci   | utf8mb4_0900_ai_ci |
| After_Book_Return       | UPDATE | issue_records | BEGIN
    IF OLD.status = 'Issued'
       AND NEW.status = 'Returned' THEN

        UPDATE Books
        SET available_copies = available_copies + 1
        WHERE book_id = NEW.book_id;

    END IF;
END                                                           | AFTER  | 2026-11-09 00:28:35.72 | ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION | root@localhost | utf8mb4              | utf8mb4_0900_ai_ci   | utf8mb4_0900_ai_ci |
+-------------------------+--------+---------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------+------------------------+-----------------------------------------------------------------------------------------------------------------------+----------------+----------------------+----------------------+--------------------+
4 rows in set (0.01 sec)

mysql> SHOW PROCEDURE STATUS
    -> WHERE DB='LIBRARYDB';
+-----------+------------+-----------+----------------+---------------------+---------------------+---------------+---------+----------------------+----------------------+--------------------+
| Db        | Name       | Type      | Definer        | Modified            | Created             | Security_type | Comment | character_set_client | collation_connection | Database Collation |
+-----------+------------+-----------+----------------+---------------------+---------------------+---------------+---------+----------------------+----------------------+--------------------+
| librarydb | IssueBook  | PROCEDURE | root@localhost | 2026-11-09 00:22:49 | 2026-11-09 00:22:49 | DEFINER       |         | utf8mb4              | utf8mb4_0900_ai_ci   | utf8mb4_0900_ai_ci |
| librarydb | PayFine    | PROCEDURE | root@localhost | 2026-11-09 00:27:11 | 2026-11-09 00:27:11 | DEFINER       |         | utf8mb4              | utf8mb4_0900_ai_ci   | utf8mb4_0900_ai_ci |
| librarydb | ReturnBook | PROCEDURE | root@localhost | 2026-11-09 00:23:50 | 2026-11-09 00:23:50 | DEFINER       |         | utf8mb4              | utf8mb4_0900_ai_ci   | utf8mb4_0900_ai_ci |
+-----------+------------+-----------+----------------+---------------------+---------------------+---------------+---------+----------------------+----------------------+--------------------+
3 rows in set (0.00 sec)

mysql> SHOW FULL TABLES WHERE TABLE_TYPE='VIEW';
+---------------------+------------+
| Tables_in_librarydb | Table_type |
+---------------------+------------+
| book_details        | VIEW       |
| fine_details        | VIEW       |
| outstanding_fines   | VIEW       |
+---------------------+------------+
3 rows in set (0.00 sec)

mysql>
