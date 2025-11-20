create table orders(Order_ID serial primary key,Customer_ID int,Book_ID int,
Order_Date date,Quantity int,Total_Amount
numeric (10,2));

select*from orders;

create table customers(Customer_ID serial primary key,Name varchar (50),
Email varchar(100),Phone varchar(10),City varchar(30),Country varchar(30)
);

create table books(Book_ID int,Title varchar(50),Author varchar (50),Genre varchar(50),Published_Year int,Price numeric(10,2),Stock int
);

select *from books;
select*from customers;
select*from orders;

1) Retrieve all books in the "Fiction" genre
SELECT * FROM Books
WHERE Genre='Fiction';

2) Find books published after the year 1950
SELECT * FROM Books
WHERE Published_year='1950';

3) Show orders placed in November 2023
SELECT * FROM Orders
 WHERE Order_date BETWEEN '2023-11-01' AND '2023-11-30';

 4) Calculate the total revenue generated from all orders:
SELECT SUM(total_amount) As Revenue 
FROM Orders;

 5) Find the details of the most expensive book
SELECT * FROM Books
ORDER BY Price DESC
LIMIT 1;

 6) the average price of books in the "Fantasy" genre
SELECT AVG(price) AS Average_Price
FROM Books
WHERE Genre = 'Fantasy';

7) List customers who have placed at least 2 orders
SELECT customer_id , COUNT (Order_id) AS Order_count
FROM Orders
GROUP BY customer_id
HAVING COUNT (Order_id)>=2;

USING JOINS

SELECT o.Customer_id,c.Name,COUNT (order_id)AS Order_count
from Orders o
JOIN customers c ON  c.customer_id=o.customer_id
GROUP BY o.customer_id,c.name

8) Find the most frequently ordered book
SELECT o.Book_id, b.title, COUNT(o.order_id) AS ORDER_COUNT
FROM orders o
JOIN books b ON o.book_id=b.book_id
GROUP BY o.book_id, b.title
ORDER BY ORDER_COUNT DESC LIMIT 1;

9) Retrieve the total quantity of books sold by each author

SELECT b.author, SUM(o.quantity) AS Total_Books_Sold
FROM orders o
JOIN books b ON o.book_id=b.book_id
GROUP BY b.Author;

10) List the cities where customers who spent over $30 are located

SELECT DISTINCT c.city, total_amount
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
WHERE o.total_amount > 30;

 11) Find the customer who spent the most on orders
 select c.customer_id,c.name,sum(o.total_amount) As total_spent
 FROM orders o
 JOIN customers c ON c.customer_id=o.customer_id
 GROUP BY c.customer_id,c.name
 ORDER BY total_spent DESC LIMIT 1;

12) Calculate the stock remaining after fulfilling all orders
SELECT b.book_id, b.title, b.stock, COALESCE(SUM(o.quantity),0) 
AS Order_quantity,  
b.stock- COALESCE(SUM(o.quantity),0) AS Remaining_Quantity
FROM books b
LEFT JOIN orders o ON b.book_id=o.book_id
GROUP BY b.book_id, b.title, b.stock ORDER BY b.book_id;





