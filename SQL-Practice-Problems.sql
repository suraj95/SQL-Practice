
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




