/*  Dataset - Employees  */

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10,2),
    experience_years INT
);

INSERT INTO employees VALUES
(1, 'Arun',  'IT',      60000, 3),
(2, 'Bala',  'IT',      75000, 5),
(3, 'Cathy', 'IT',      90000, 7),
(4, 'Deepa', 'HR',      50000, 2),
(5, 'Eshan', 'HR',      65000, 6),
(6, 'Farah', 'HR',      55000, 4),
(7, 'Ganesh','Sales',   45000, 2),
(8, 'Hari',  'Sales',   70000, 5),
(9, 'Isha',  'Sales',   80000, 8),
(10,'John',  'Finance', 100000, 10);

/* Q1. Find employees earning more than the overall average salary. */
SELECT  employee_name
FROM employees 
WHERE salary > (SELECT  AVG(salary)
FROM employees)

/* Q2. Find employees earning less than the overall average salary.*/
SELECT  employee_name
FROM employees 
WHERE salary < (SELECT  AVG(salary)
FROM employees)

/* Q3. Find the employee(s) earning the highest salary. */
SELECT  employee_name
FROM employees 
WHERE salary =  (SELECT  MAX(salary)
FROM employees)

/* Q4. Find the employee(s) earning the lowest salary */
SELECT  employee_name
FROM employees 
WHERE salary =  (SELECT  MIN(salary)
FROM employees)

/* Q5. Find employees who have more experience than the average experience.*/

SELECT  employee_name
FROM employees 
WHERE experience_years > (SELECT  AVG(experience_years)
FROM employees)

/* Q6. Find employees earning more than John. */

SELECT  employee_name
FROM employees 
WHERE salary >  (SELECT  salary
FROM employees
WHERE employee_name ="John")

/* Q7. Find employees earning less than Cathy.*/

SELECT  employee_name
FROM employees 
WHERE salary <  (SELECT  salary
FROM employees
WHERE employee_name ="Cathy")

/* Q8. Find employees whose salary is equal to the maximum salary */
SELECT  employee_name
FROM employees 
WHERE salary =  (SELECT  MAX(salary)
FROM employees)


 /* Category 2: HAVING Single-Row Subqueries */

/* Q9. Find departments whose average salary is greater than the overall average salary. */
SELECT department, AVG(salary) as average_salary 
FROM employees 
GROUP BY department 
HAVING AVG(salary) > (SELECT AVG(salary) FROM employees)


/* Q10. Find departments whose average salary is less than the overall average salary. */

SELECT department, AVG(salary) as average_salary 
FROM employees 
GROUP BY department 
HAVING AVG(salary) < (SELECT AVG(salary) FROM employees)


/* Q11. Find departments whose maximum salary is greater than the overall average salary. */

SELECT department, MAX(salary) as average_salary 
FROM employees 
GROUP BY department 
HAVING MAX(salary) > (SELECT AVG(salary) FROM employees)


/* Q12. Find departments whose average experience is greater than the overall average experience. */

SELECT  department , AVG(experience_years)
FROM employees 
GROUP BY department
HAVING  AVG(experience_years) > (SELECT  AVG(experience_years)
FROM employees)


/* Q13. Find departments whose employee count is greater than the average number of employees per department. */

SELECT  department , COUNT(employee_id) as total_employees
FROM employees 
GROUP BY department
HAVING COUNT(employee_id) > (SELECT  department, AVG(COUNT(employee_id))
FROM employees
GROUP BY department )


/* Q14. Find departments whose maximum salary is equal to the highest salary in the company. */

SELECT  department , MAX(salary)
FROM employees 
GROUP BY department
HAVING  MAX(salary) = (SELECT  MAX(salary)
FROM employees)


/* Q15. Display every employee along with the overall average salary. */

SELECT employee_name , salary,  (select AVG(salary) FROM employees ) as average_salary
FROM employees 

/* Q16. Display every employee's salary and the difference between their salary and the company average. */

SELECT employee_name , salary,  (select salary - AVG(salary) FROM employees ) as difference
FROM employees 

/* Q17. Display every employee along with the company's highest salary. */

SELECT employee_name , salary,  (select MAX(salary) FROM employees ) as Highest_salary
FROM employees


/* Q18. Display every employee and how far their salary is from the highest salary */

SELECT employee_name , salary,  (select salary - MAX(salary) FROM employees ) as difference 
FROM employees




