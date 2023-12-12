USE bestbuy;

/* joins: select all the computers from the products table:
using the products table and the categories table, return the product name and the category name */
SELECT products.name, categories.name
FROM products
LEFT JOIN categories ON products.CategoryID = categories.CategoryID
WHERE categories.name = 'Computers';

/* joins: find all product names, product prices, and products ratings that have a rating of 5 */
SELECT name, price, rating
FROM products
LEFT JOIN reviews ON products.productID = reviews.productID
WHERE reviews.rating = 5;

/* joins: find the employee with the most total quantity sold.  use the sum() function and group by */
SELECT employees.employeeID, employees.FirstName, employees.LastName, SUM(sales.quantity) AS total_sold
FROM employees
INNER JOIN sales ON employees.employeeID = sales.employeeID
GROUP BY employees.employeeID, employees.LastName
having SUM(quantity) = (
select SUM(quantity)
from sales
group by sales.EmployeeID
order by SUM(quantity) desc
limit 1
);

/* joins: find the name of the department, and the name of the category for Appliances and Games */
SELECT departments.name, categories.name
FROM departments
INNER JOIN categories ON departments.DepartmentID = categories.DepartmentID
WHERE categories.Name = 'Appliances' or categories.name =  'games';

/* joins: find the product name, total # sold, and total price sold,
 for Eagles: Hotel California --You may need to use SUM() */
 SELECT products.name 'AS Product Name',SUM(sales.quantity), SUM(sales.PricePerUnit), SUM(sales.quantity * sales.PricePerUnit) as 'Total Sales'
 FROM products
 INNER JOIN sales ON products.ProductID = sales.ProductID
 WHERE products.name LIKE '%Hotel%California%'
 GROUP BY products.ProductID; 

/* joins: find Product name, reviewer name, rating, and comment on the Visio TV. (only return for the lowest rating!) */
SELECT products.Name, Reviewer, Rating, Comment
FROM products
INNER JOIN reviews ON products.ProductID = reviews.ProductID
WHERE products.Name LIKE '%Visio%TV%' AND Rating = 1;
-- ------------------------------------------ Extra - May be difficult

/* Your goal is to write a query that serves as an employee sales report.
This query should return the employeeID, the employee's first and last name, the name of each product, how many of that product they sold */
SELECT employees.EmployeeID, CONCAT(FirstName, ' ', LastName) AS 'Employee Name', products.name, SUM(sales.Quantity)
FROM employees
INNER JOIN sales ON employees.EmployeeID = sales.EmployeeID
INNER JOIN products ON products.ProductID = sales.ProductID
GROUP BY employees.EmployeeID, products.ProductID;
