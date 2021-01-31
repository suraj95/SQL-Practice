
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


