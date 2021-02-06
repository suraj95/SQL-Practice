
# Introductory Problems

# 1. Which shippers do we have?

SELECT * FROM SHIPPERS;

# 2. Certain fields from Categories (Table does not exist, change categories to Inventory_transactions)

SELECT id, type_name FROM Inventory_transaction_types; 

# 3. We’d like to see just the FirstName, LastName, and HireDate of all the employees with the Title of Sales Representative. Write a SQL statement that returns only those employees.

SELECT first_name, last_name, company
FROM employees
WHERE job_title = "Sales Representative"; 

# 4. Now we’d like to see the same columns as above, but only for those employees that both have the title of Sales Representative, and also are in the United States.

SELECT first_name, last_name, company
FROM employees
WHERE job_title = "Sales Representative" AND country_region = "USA"; 

# 5. Show all the orders placed by a specific employee. The EmployeeID for this Employee (Nancy Freehafer) is 1.

SELECT *
FROM orders
WHERE employee_id = 1;

# 6. In the Suppliers table, show the SupplierID, ContactName, and ContactTitle for those Suppliers whose ContactTitle is not Marketing Manager.

SELECT id, first_name, last_name, job_title
FROM Suppliers
WHERE job_title != 'Marketing Manager';

# 7. In the products table, we’d like to see the ProductID and ProductName for those products where the ProductName includes the string "pea".

SELECT id, product_name
FROM products
WHERE product_name LIKE "%pea%"; #Mysql only has %(zero or more) or _(any single character)

# 8. Looking at the Orders table, there’s a field called Ship City. Write a query that shows the OrderID, CustomerID, and Ship City for the orders where the Ship City is either New York or Las Vegas.

SELECT id, customer_id, ship_city
FROM orders
WHERE ship_city = 'New York' OR ship_city = 'Las Vegas'; # since all records in our database are in USA

# 9. It doesn’t make sense to use multiple Or statements anymore, it would get too convoluted. Use the In statement.

SELECT id, customer_id, ship_city
FROM orders
WHERE ship_city IN ('New York', 'Las Vegas','Miami', 'Chicago');

# 10. For all the employees in the Employees table, show the FirstName, LastName and Title. Order the results by LastName name

SELECT first_name, last_name, job_title
FROM employees
ORDER BY last_name;

# 11. Show Orders by sorted by Order date (question changed; original question was about sorting employees by joining date)

SELECT id, employee_id, customer_id, order_date
FROM ORDERS
ORDER BY order_date;

# 12. Show the FirstName and LastName columns from the Employees table, and then create a new column called FullName, showing FirstName and LastName joined together in one column, with a space in-between.

SELECT first_name, last_name, CONCAT(first_name, " ", last_name) AS 'full_name'
FROM employees;

# 13. In the OrderDetails table, we have the fields UnitPrice and Quantity. Create a new field, TotalPrice, that multiplies these two together. We’ll ignore the Discount field for now.

SELECT unit_price, quantity, (unit_price*quantity) AS total_price
FROM order_details;

# 14. How many Customers do we have in the customers table

SELECT COUNT(id) AS number_of_customers
FROM customers;

# 15. Show the date of the first order ever made in the Orders table (all dates are NULL though).

SELECT MIN(date_allocated) AS first_order_ever
FROM order_details; 

# 16. Show a list of cities (changed from countries) where the Northwind company has customers.

SELECT DISTINCT city 
FROM customers; #list of cities

SELECT city, COUNT(id)
FROM customers
GROUP BY city; #list of cities and the number of orders from each city

# 17. Show a list of all the different values in the Customers table for ContactTitles. Also include a count for each ContactTitle.

SELECT job_title, COUNT(id)
FROM customers
GROUP BY job_title; #list of job titles and the count of each title

# 18. Show, for each product, the associated Supplier. Show the ProductID, ProductName, and the CompanyName of the Supplier. Sort by ProductID.

SELECT p.id, p.product_name, s.company
FROM products p, suppliers s 
WHERE p.supplier_ids = s.id
ORDER BY p.id;

	# This is basically an Inner Join. Putting a clause in the Join or the Where is equivalent.

SELECT products.id, products.product_name, suppliers.company
FROM products 
INNER JOIN suppliers ON products.supplier_ids = suppliers.id
ORDER BY products.id; 

	# Theoretically, one shouldn't be any faster. The query optimizer should be able to 
	# generate an identical execution plan. However, some database engines can produce better 
	# execution plans for one of them (not likely to happen for such a simple query but for 
	# complex enough ones). You should test both and see (on your database engine).

# 19. Show a list of the Orders that were made, including the Shipper that was used. Show the OrderID, OrderDate (date only), and CompanyName of the Shipper, and sort by OrderID.

SELECT o.id, o.order_date, s.company
FROM orders o, suppliers s
WHERE o.shipper_id = s.id
ORDER BY o.id;


# Intermediate Problems

# 20. Show the total number of products in each category. Sort the results by the total number of products, in descending order.

SELECT category, COUNT(id) AS COUNT
FROM products
GROUP BY category
ORDER by COUNT DESC;

# 21. Show the total number of customers per Country and City.

SELECT city, COUNT(id) AS COUNT
FROM customers
GROUP BY city
ORDER by COUNT; #default is ASC

# 22. What products do we have in our inventory that should be reordered?  For now, just use the fields UnitsInStock (not present) and ReorderLevel

SELECT id, product_name, reorder_level, target_level
FROM products
WHERE reorder_level < target_level;

# 23. Now we need to incorporate these fields—UnitsInStock (not present), UnitsOnOrder (not present), ReorderLevel, Discontinued—into our calculation.

SELECT id, product_name, reorder_level, target_level
FROM products
WHERE reorder_level + minimum_reorder_quantity <= target_level AND discontinued = 0;

# 24. A salesperson for Northwind is going on a business trip to visit customers, and would like to see a list of all customers, sorted by region, alphabetically.

SELECT id, company, city
FROM customers
ORDER by city, id; # order by city first, id second

# 25. Return the three ship countries with the highest average freight overall, in descending order by average freight.

SELECT ship_city, AVG(shipping_fee) AS avg_shipping_fee 
FROM orders
GROUP BY ship_city
ORDER BY avg_shipping_fee DESC LIMIT 3;

# 26. Now, instead of using all the orders we have, we only want to see orders from the year 2015.

SELECT ship_city, AVG(shipping_fee) AS avg_shipping_fee 
FROM orders
WHERE order_date BETWEEN '2006-01-15' AND '2006-03-22' #date changed according to data entered
GROUP BY ship_city
ORDER BY avg_shipping_fee DESC;

# 27 and 28 are similar so skipping

# 29. Sort inventory list by OrderID and Product ID.

SELECT * 
FROM order_details
ORDER BY order_id, product_id;  #order by order_id first, product_id second

# 30. There are some customers who have never actually placed an order. Show these customers

SELECT
customers.id AS Customers_ID,
orders.customer_id AS Orders_CustomerID 
FROM 
customers LEFT JOIN orders # because orders are the NULL values as we are finding customers with no orders
ON orders.customer_id = customers.id AND orders.customer_id = NULL;

	# See, with an Inner Join, putting a clause in the Join or the Where is equivalent. 	
	# However, with an Outer Join, they are vastly different.

	# Outer join produces super-set over inner join. A left outer join returns all the 
	# values from an inner join plus all values in the left table that do not match to the 
	# right table. To model it without using LEFT JOIN would be a combination of UNION AS 
	# well as INNER JOINS. 

# 31. One employee (Margaret Peacock, EmployeeID 4) has placed the most orders. However, there are some customers who've never placed an order with her. Show only those customers who have never placed an order with her.

SELECT
customers.id AS Customers_ID,
orders.customer_id AS Orders_CustomerID,
orders.employee_id AS Orders_EmployeeID 
FROM 
customers LEFT JOIN orders
ON orders.customer_id = customers.id AND orders.employee_id != 4; 

	# This will give the customers that have never placed orders (NULL values) + the customers
	# who have placed orders but the employee_id was not 4.


# Advanced Problems

# 32. We want to send all of our high-value customers a special VIP gift. We're defining high-value customers as those who've made at least 1 order with a total value (not including the discount) equal to $10,000 or more. We only want to consider orders made in the year 2016.

SELECT o.customer_id AS CustomerID, (od.unit_price * od.quantity) AS 'OrderAmount'
FROM orders o, order_details od
WHERE od.order_id = o.id AND od.unit_price * od.quantity >= 10000 AND order_date BETWEEN '2006-01-15' AND '2006-03-22';

# 33. The manager has changed his mind. Instead of requiring that customers have at least one individual orders totaling $10,000 or more, he wants to define high-value customers as those who have orders totaling $15,000 or more in 2016. How would you change the answer to the problem above?

SELECT CustomerID, SUM(OrderAmount)
FROM 
(
	SELECT o.customer_id AS CustomerID, od.unit_price * od.quantity AS 'OrderAmount'
	FROM orders o, order_details od
	WHERE od.order_id = o.id AND order_date BETWEEN '2006-01-15' AND '2006-03-22'
) 
AS subquery
WHERE OrderAmount > 10000 #changed from 15000 because the highest order value is 13800
GROUP BY CustomerID;

	# Inner query returns a list of Customers and their orders within the specified dates. 
	# Outer query aggregates them (calculates their sum after grouped by Customer ID).

# 34. Change the above query to use the discount when calculating high-value customers. Order by the total amount which includes the discount.

SELECT CustomerID, SUM(OrderAmount)
FROM 
(
	SELECT o.customer_id AS CustomerID, od.unit_price * od.quantity* (1 - od.discount) AS 'OrderAmount' #discount is applied as a percentage (for example, 0.15 means 15%)
	FROM orders o, order_details od
	WHERE od.order_id = o.id AND order_date BETWEEN '2006-01-15' AND '2006-03-22'
) 
AS subquery
WHERE OrderAmount > 10000 #changed from 15000 because the highest order value is 13800
GROUP BY CustomerID;



