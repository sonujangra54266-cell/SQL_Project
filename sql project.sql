create database online_books_store;


drop table book;

create table book(
Book_ID	serial primary key,
Title varchar(70),
Author varchar(90),
Genre varchar(90),
Published_Year int,
Price numeric(10,2),
Stock int
);


create table customers(
Customer_ID	serial primary key,
Name varchar(78),
Email varchar(78),
Phone varchar(78),
City varchar(78),
Country	varchar(78)
);

create table orders(
Order_ID serial primary key,
Customer_ID	int references customers(customer_id),
Book_ID	int  references orders(order_id),
Order_Date date,
Quantity numeric,
Total_Amount numeric(10,2)
);

select * from book;
select * from customers;
select * from orders;

--1) Retrieve all the books in 'fiction' genre:
select * from book
where genre='Fiction';

--2) Find book published after year 1950:
select * from book
where published_year>1950;

--3) List all the customer from canada:
   select * from customers
   where country='Canada';

--4) Show order placed in november 2023:
 select * from orders
 where order_date between '2023-11-01' and '2023-11-30';

--5) Retrieve the total stock of book available:
select sum(stock) as total_stock
from book ;

--6) Find the detail of most expensive book:
select * from book
order by price desc
limit 1;

--7) Show all customers who ordered more than 1 quantity of book:
select * from orders
where quantity>1;

--8) Retrieve all orders where total amount exceeds $20:
select * from orders
where total_amount>20;

--9)List all genre available in book table:
select  distinct genre from book;

--10) Find the book with lowest stock:
select * from book
order by stock
limit 1;

--11) Calculated the total revenue generated from all orders
select sum(total_amount) as total_revenue
from orders;

--Advance question

--1) Retrieve the total number of book sold for each genre:
select b.genre,sum(o.quantity) as total_sold_book
from book b
join
orders o
on b.book_id=o.book_id
group by genre;

--2) Find the average price of book in 'Fantasy' genre:
select avg(price) as avg_price
from book
where genre='Fantasy';

--3)List customers who have placed at least 2 orders:
SELECT c.name, COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.name
HAVING COUNT(o.order_id) >= 2;

--4) Find the most frequently ordered book:
select o.book_id, b.title, count(o.order_id) as order_count
from orders o
join book b on o.book_id=b.book_id
group by o.book_id,b.title
order by order_count desc
limit 1;

--5) Show the top 3 most expensive book of 'Fantasy' genre:
select * from book
where genre='Fantasy'
order by price desc
limit 3;

--6) Retrieve the total quantity of book sold by each author:
select b.author,sum(o.quantity) as sold_book
from orders o
join book b 
on o.book_id=b.book_id
group by b.author;

--7) List the cities where customer who spent over $30 are located:
select c.city,o.total_amount as spend_over
from orders o
join customers c
on o.customer_id=c.customer_id
where o.total_amount>30;

--8) Find the customer who spent the most on orders:
select c.name,c.customer_id, sum(o.total_amount) as total_spend
from orders o
join customers c on o.customer_id=c.customer_id
group by c.name,c.customer_id
order by total_spend desc
limit 1;

--9) Calculate the stock remaining after fulfiliing all orders:
select b.book_id,b.title,b.stock,Coalesce(SUM(o.quantity),0) as order_quantity,
b.stock-Coalesce(SUM(o.quantity),0) as remaining_stock
from book b
left join orders o on o.book_id=b.book_id
group by b.book_id;









 





























