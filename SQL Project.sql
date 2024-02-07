CREATE DATABASE Library;

USE Library;

#TABLE 1: BRANCH
CREATE TABLE Branch(
	Branch_no INT PRIMARY KEY,
	Manager_Id INT,
	Branch_address VARCHAR(50),
	Contact_no INT
);

INSERT INTO Branch (Branch_no, Manager_Id, Branch_address, Contact_no) VALUES 
(001, 123, '123 Main Street', 555-1234),
(002, 456, '456 Elm Avenue', 555-5678),
(003, 789, '789 Oak Boulevard', 555-9012),
(004, 012, '012 Maple Lane', 555-3456),
(005, 345, '345 Pine Road', 555-6789);
    
#TABLE 2: EMPLOYEE
CREATE TABLE Employee(
	Emp_Id INT PRIMARY KEY,
	Emp_name VARCHAR(25),
	Position VARCHAR(30),
	Salary DECIMAL(8,2),
	Branch_no INT, FOREIGN KEY (Branch_no) REFERENCES Branch(Branch_no)
);

INSERT INTO Employee (Emp_Id, Emp_name, Position, Salary, Branch_no) VALUES 
(1001, 'John', 'Manager', 60000.00, 001),
(1002, 'Jane', 'Assistant', 40000.00, 002),
(1003, 'Mark', 'Salesperson', 35000.00, 001),
(1004, 'Emily', 'Accountant', 50000.00, 003),
(1005, 'Michael', 'Technician', 45000.00, 004),
(1006, 'Sarah', 'Salesperson', 36000.00, 003),
(1007, 'David', 'Technician', 46000.00, 001),
(1008, 'Jessica', 'Assistant', 38000.00, 002),
(1009, 'Kevin', 'Manager', 62000.00, 003),
(1010, 'Anna', 'Accountant', 51000.00, 005);

#TABLE 3: CUSTOMER
CREATE TABLE Customer(
	Customer_Id INT PRIMARY KEY,
	Customer_name VARCHAR(25),
	Customer_address VARCHAR(50),
	Reg_date DATE
);

INSERT INTO Customer (Customer_Id, Customer_name, Customer_address, Reg_date) VALUES 
(1, 'John Smith', '123 Main St', '2023-01-15'),
(2, 'Jane Doe', '456 Elm St', '2023-02-20'),
(3, 'Michael Johnson', '789 Oak St', '2023-03-25'),
(4, 'Emily Brown', '012 Maple St', '2023-04-30'),
(5, 'David Clark', '345 Pine St', '2023-05-05'),
(6, 'Sarah Adams', '678 Cedar St', '2023-06-10'),
(7, 'Daniel Wilson', '901 Walnut St', '2023-07-15'),
(8, 'Jessica White', '234 Birch St', '2023-08-20'),
(9, 'Christopher Lee', '567 Elm St', '2023-09-25'),
(10, 'Amanda Taylor', '890 Oak St', '2023-10-30');

#TABLE 4: BOOKS
CREATE TABLE Books(
	ISBN INT PRIMARY KEY,
	Book_title VARCHAR(50),
	Category VARCHAR(40),
	Rental_Price DECIMAL(8,2),
	Status VARCHAR(20),
	Author VARCHAR(40),
	Publisher VARCHAR(50)
);

INSERT INTO Books (ISBN, Book_title, Category, Rental_Price, Status, Author, Publisher) VALUES 
(978-0345339683, 'The Hobbit', 'Fantasy', 10.99, 'Yes', 'J.R.R. Tolkien', 'Ballantine Books'),
(978-1400079179, 'To Kill a Mockingbird', 'Fiction', 12.50, 'No', 'Harper Lee', 'Harper Perennial Modern Classics'),
(978-0061120084, 'The Catcher in the Rye', 'Fiction', 11.25, 'Yes', 'J.D. Salinger', 'Little, Brown and Company'),
(978-0439023481, 'The Hunger Games', 'Young Adult', 9.75, 'Yes', 'Suzanne Collins', 'Scholastic Press'),
(978-0547928227, 'Harry Potter and the Philosopher\'s Stone', 'Fantasy', 13.99, 'No', 'J.K. Rowling', 'Arthur A. Levine Books'),
(978-1451673319, '1984', 'Dystopian', 11.99, 'Yes', 'George Orwell', 'Houghton Mifflin Harcourt'),
(978-0060256654, 'Where the Wild Things Are', 'Children\'s', 8.99, 'Yes', 'Maurice Sendak', 'Harper & Row'),
(978-0062315007, 'The Fault in Our Stars', 'Young Adult', 10.25, 'No', 'John Green', 'Dutton Books'),
(978-0385510532, 'The Da Vinci Code', 'Mystery', 14.50, 'Yes', 'Dan Brown', 'Doubleday'),
(978-0060850524, 'The Alchemist', 'Fiction', 10.75, 'Yes', 'Paulo Coelho', 'HarperOne');

#TABLE 5: ISSUESTATUS
CREATE TABLE IssueStatus(
	Issue_Id INT PRIMARY KEY,
	Issued_cust INT, FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),
	Issued_book_name VARCHAR(50),
	Issue_date DATE,
	Isbn_book INT, FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN)
);

INSERT INTO IssueStatus (Issue_Id, Issued_cust, Issued_book_name, Issue_date, Isbn_book) VALUES 
(01, 1, 'The Hobbit', '2023-01-15', 978-0345339683),
(02, 3, 'The Catcher in the Rye', '2023-03-25', 978-0061120084),
(03, 6, '1984', '2023-06-10', 978-1451673319),
(04, 8, 'The Fault in Our Stars', '2023-08-20', 978-0062315007),
(05, 9, 'The Da Vinci Code', '2023-09-25', 978-0385510532),
(06, 10, 'The Alchemist', '2023-10-30', 978-0060850524);

#TABLE 6: RETURNSTATUS
CREATE TABLE ReturnStatus(
	Return_Id INT PRIMARY KEY,
	Return_cust INT,
	Return_book_name VARCHAR(50),
	Return_date DATE,
	Isbn_book2 INT, FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN)
);

INSERT INTO ReturnStatus (Return_Id, Return_cust, Return_book_name, Return_date, Isbn_book2) VALUES 
    (201, 1, 'The Hobbit', '2023-02-15', 978-0345339683),
    (202, 3, '1984', '2023-07-25', 978-1451673319),
    (203, 9, 'The Da Vinci Code', '2023-10-30', 978-0385510532);
   
#1. Retrieve the book title, category, and rental price of all available books.
   
SELECT Book_title, Category, Rental_Price FROM Books WHERE Status='Yes';

#2. List the employee names and their respective salaries in descending order of salary.

SELECT Emp_name, Salary FROM Employee ORDER BY Salary DESC;

#3. Retrieve the book titles and the corresponding customers who have issued those books.

SELECT IssueStatus.Issued_book_name AS Book_Title, Customer.Customer_name FROM IssueStatus JOIN Customer ON 
IssueStatus.Issued_cust = Customer.Customer_Id;  

#4. Display the total count of books in each category.
SELECT Category,COUNT(*) AS Total_Count FROM Books GROUP BY Category;

#5. Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000.
SELECT Emp_name, Position FROM Employee WHERE Salary > 50000.00;

#6. List the customer names who registered before 2022-01-01 and have not issued any books yet.

SELECT Customer.Customer_name FROM Customer LEFT JOIN IssueStatus ON Customer.Customer_Id = IssueStatus.Issued_cust
WHERE Customer.Reg_date < '2022-01-01' AND IssueStatus.Issued_cust IS NULL; 

#7. Display the branch numbers and the total count of employees in each branch.

SELECT Branch_no, COUNT(*) AS Total_Employees FROM Employee GROUP BY Branch_no;

#8. Display the names of customers who have issued books in the month of June 2023.

SELECT Customer.Customer_name FROM IssueStatus JOIN Customer ON IssueStatus.Issued_cust = Customer.Customer_Id
WHERE MONTH(IssueStatus.Issue_date) = 6 AND YEAR(IssueStatus.Issue_date) = 2023;

#9. Retrieve book_title from book table containing history.

SELECT Book_title FROM Books WHERE Category = 'History';

#10. Retrieve the branch numbers along with the count of employees for branches having more than 5 employees.

SELECT Branch_no, COUNT(*) AS Employee_Count FROM Employee GROUP BY Branch_no HAVING COUNT(*) > 5;

