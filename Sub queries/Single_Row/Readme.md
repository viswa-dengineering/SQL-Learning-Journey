# SQL Practice: Single-Row Subqueries

## 📌 Learning Objective

The goal of this practice was to understand and apply **Single-Row Subqueries** in SQL.

A Single-Row Subquery returns **one usable value**, which can then be used by the outer query for comparison, filtering, displaying, or calculation.

---

# 🧠 Core Concept

A Single-Row Subquery generally follows this pattern:

```text
SUBQUERY
   ↓
Returns ONE value
   ↓
Used by the OUTER QUERY
```

I practiced Single-Row Subqueries in three major SQL clauses:

```text
WHERE
  ↓
Compare outer rows with one subquery value

HAVING
  ↓
Compare grouped results with one subquery value

SELECT
  ↓
Display or calculate using one subquery value
```

---

# 📂 Practice Categories

## 1. WHERE Clause Subqueries

The subquery returns one value, and the outer query compares that value with multiple rows.

### Practice Questions

| Question                                               | Result                    |
| ------------------------------------------------------ | ------------------------- |
| Q1. Employees earning more than overall average salary | ✅ Correct                 |
| Q2. Employees earning less than overall average salary | ✅ Correct                 |
| Q3. Employee(s) earning the highest salary             | ✅ Correct                 |
| Q4. Employee(s) earning the lowest salary              | ✅ Correct                 |
| Q5. Employees with more than average experience        | ✅ Correct                 |
| Q6. Employees earning more than John                   | ⚠️ Syntax issue corrected |
| Q7. Employees earning less than Cathy                  | ⚠️ Syntax issue corrected |
| Q8. Employees whose salary equals maximum salary       | ✅ Correct                 |

### Result

```text
WHERE Category: 8 / 8 ⭐
```

---

# 2. HAVING Clause Subqueries

The subquery returns one value, and the outer query compares grouped or aggregated results with that value.

### Practice Questions

| Question                                                                            | Result                            |
| ----------------------------------------------------------------------------------- | --------------------------------- |
| Q9. Departments with average salary greater than company average                    | ✅ Correct                         |
| Q10. Departments with average salary less than company average                      | ✅ Correct                         |
| Q11. Departments whose maximum salary is greater than company average               | ✅ Correct                         |
| Q12. Departments with average experience greater than company average               | ✅ Correct                         |
| Q13. Departments with employee count greater than average department employee count | ❌ Incorrect initially → Corrected |
| Q14. Department containing the company's highest salary                             | ✅ Correct                         |

### Result

```text
HAVING Category: 5 / 6
```

---

# 3. SELECT Clause Subqueries

The subquery returns one value that can be displayed or used in a calculation for every row.

### Practice Questions

| Question                                                    | Result                            |
| ----------------------------------------------------------- | --------------------------------- |
| Q15. Display every employee with overall average salary     | ✅ Correct                         |
| Q16. Display salary difference from company average         | ❌ Incorrect initially → Corrected |
| Q17. Display every employee with company highest salary     | ✅ Correct                         |
| Q18. Display how far each salary is from the highest salary | ❌ Incorrect initially → Corrected |

### Result

```text
SELECT Category: 2 / 4
```

---

# 🐛 Mistakes Found and Corrected

## Mistake 1: String Quotation

### Incorrect

```sql
WHERE employee_name = "John"
```

### Correct

```sql
WHERE employee_name = 'John'
```

### Lesson

String values should be written using single quotes.

Example:

```sql
WHERE employee_name = 'John'
WHERE employee_name = 'Cathy'
```

---

# Mistake 2: Subquery Returning More Than One Value

### Initial Problem

For Q13, the requirement was:

> Find departments whose employee count is greater than the average number of employees per department.

My initial approach attempted to calculate department information and the average count incorrectly in the same subquery.

### Important Rule

```text
SINGLE-ROW SUBQUERY
        ↓
Must return ONE usable value
```

### Correct Approach

Step 1: Count employees in each department.

```text
IT       → 3 employees
HR       → 3 employees
Sales    → 3 employees
Finance  → 1 employee
```

Step 2: Calculate the average of those department counts.

```text
3, 3, 3, 1
```

Step 3: Compare each department's employee count with the calculated average.

### Correct Query

```sql
SELECT department, COUNT(employee_id) AS total_employees
FROM employees
GROUP BY department
HAVING COUNT(employee_id) > (
    SELECT AVG(department_employee_count)
    FROM (
        SELECT COUNT(employee_id) AS department_employee_count
        FROM employees
        GROUP BY department
    ) AS department_counts
);
```

### Lesson Learned

Sometimes an aggregate calculation requires two stages:

```text
GROUP DATA
    ↓
Calculate aggregate for each group
    ↓
Calculate another aggregate from those results
```

---

# Mistake 3: Outer Row Value vs Subquery Value

This mistake occurred in Q16 and Q18.

## Incorrect Mental Model

```text
Inside Subquery:

Outer Row Value - Aggregate Value
```

This is incorrect because the subquery should return the aggregate value independently.

## Correct Mental Model

```text
Outer Row Value
        -
One Value Returned by Subquery
```

---

## Q16: Difference Between Employee Salary and Company Average

### Incorrect

```sql
SELECT employee_name,
       salary,
       (
           SELECT salary - AVG(salary)
           FROM employees
       ) AS difference
FROM employees;
```

### Correct

```sql
SELECT
    employee_name,
    salary,
    salary - (
        SELECT AVG(salary)
        FROM employees
    ) AS difference
FROM employees;
```

### Lesson

```text
OUTER ROW SALARY
        -
SUBQUERY RESULT
```

---

## Q18: Difference Between Employee Salary and Highest Salary

### Incorrect

```sql
SELECT employee_name,
       salary,
       (
           SELECT salary - MAX(salary)
           FROM employees
       ) AS difference
FROM employees;
```

### Correct

```sql
SELECT
    employee_name,
    salary,
    (
        SELECT MAX(salary)
        FROM employees
    ) - salary AS difference
FROM employees;
```

### Lesson

```text
HIGHEST SALARY
       -
EMPLOYEE SALARY
```

---

# 📊 Practice Result

```text
WHERE Category:   8 / 8 ⭐

HAVING Category:  5 / 6 ⭐

SELECT Category:  2 / 4

OVERALL:          15 / 18
```

---

# 🎯 Final Understanding

## WHERE

```text
Outer ROW
   vs
ONE Subquery Value
```

Used for filtering individual rows.

---

## HAVING

```text
Outer GROUP
   vs
ONE Subquery Value
```

Used for filtering grouped or aggregated results.

---

## SELECT

```text
Outer ROW Calculation / Display
              +
ONE Subquery Value
```

Used to display a scalar value or perform calculations using a scalar subquery.

---

# 🚀 Key Takeaways

Through this practice, I learned:

* How Single-Row Subqueries return one usable value.
* How to use Single-Row Subqueries in the `WHERE` clause.
* How to compare aggregate results using `HAVING`.
* How to use scalar subqueries in the `SELECT` clause.
* The importance of ensuring a Single-Row Subquery returns one usable value.
* The difference between an outer row value and a subquery result.
* How to identify, debug, and correct SQL query mistakes.
* How nested aggregation can be used to calculate values across grouped results.

---

# 📈 Learning Method

```text
LEARN CONCEPT
      ↓
UNDERSTAND PATTERN
      ↓
PRACTICE QUESTIONS
      ↓
MAKE MISTAKES
      ↓
DEBUG MISTAKES
      ↓
CORRECT THE QUERY
      ↓
DOCUMENT THE LEARNING
```

This repository documents my hands-on SQL practice and learning process for Data Engineering.
