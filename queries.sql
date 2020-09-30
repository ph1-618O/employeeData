
--
--*** (1) List the following details of each employee: employee number, last name, first name, sex, and salary.
--SELECT *
--FROM employees
--LIMIT 3;

--SELECT COUNT(*)
--FROM employees;

--SELECT *
--FROM salaries
--LIMIT 3;

--SELECT COUNT(*)
--FROM salaries;

---***
SELECT 
employees.emp_no, employees.last_name, employees.first_name, employees.gender, 
salaries.salary 
FROM employees, salaries 
WHERE employees.emp_no = salaries.emp_no;

--***
SELECT e.emp_no, e.last_name, e.first_name, e.gender, 
s.salary
FROM "employees" e
LEFT JOIN "salaries" s ON e.emp_no = s.emp_no;

--Trying to get new count of total rows after left join
--This just gives a new row with 1's
--SELECT COUNT(*),
--e.emp_no, e.last_name, e.first_name, e.sex, 
--s.salary, s.emp_no
--FROM "employees" e
--LEFT JOIN "salaries" s ON e.emp_no = s.emp_no
--GROUP BY e.emp_no, s.salary, s.emp_no;

--Trying to get new count of total rows after left join
--SELECT e.emp_no, e.last_name, e.first_name, e.sex,
--s.salary, s.emp_no, 
--SUM((CASE WHEN s.emp_no IS NOT NULL THEN 1 ELSE 0 END))
--FROM "employee" e
--LEFT JOIN "salaries" s ON e.emp_no = s.emp_no
--GROUP BY e.emp_no;


--
--*** (2) List first name, last name, and hire date for employees who were hired in 1986.
--SELECT YEAR(hire_date), MONTH(hire_Date), DATEPART(WEEK,hire_date) From employees;
--SELECT DATEPART(year, hire_date) FROM employees;

--***
SELECT first_name, last_name, hire_date 
FROM employees 
WHERE EXTRACT(YEAR FROM employees.hire_date) = '1986';

--SELECT hire_date 
--FROM employees
--LIMIT 10;

--SELECT first_name, last_name, hire_date
--FROM employees
--WHERE employees.hire_date BETWEEN '1986-01-01' AND '1986-12-31';
--
--*** (3) List the manager of each department with the following information: department number, department name, 
-- the manager's employee number, last name, first name.
SELECT 
departments.dept_no, departments.dept_name, 
employees.emp_no, employees.first_name, employees.last_name 
FROM departments, dept_manager, employees 
WHERE departments.dept_no= dept_manager.dept_no 
AND dept_manager.emp_no = employees.emp_no;

SELECT
d.dept_no, d.dept_name, 
e.emp_no, e.last_name, e.first_name
FROM "departments" d
FULL OUTER JOIN "dept_manager" dm ON d.dept_no = dm.dept_no
LEFT JOIN "employees" e ON dm.emp_no = e.emp_no;


--
--*** (4) List the department of each employee with the following information: employee number, last name, first name, and department name.
--First select statment duplicates emp_no and dept_no, need to use joins to drop extra cols
--SELECT 
--employees.emp_no, employees.last_name, employees.first_name, 
--dept_employee.emp_no, dept_employee.dept_no, 
--departments.dept_no, departments.dept_name 
--FROM employees, dept_employee, departments 
--WHERE employees.emp_no = dept_employee.emp_no 
--AND dept_employee.dept_no = departments.dept_no;

SELECT  e.emp_no, e.last_name, e.first_name, 
d.dept_name
FROM "employees" e
LEFT JOIN "dept_employee" de ON e.emp_no = de.emp_no
LEFT JOIN "departments" d ON de.dept_no = d.dept_no;

--Select employees.emp_no, employees.last_name, employees.first_name,
--departments.dept_name
--FROM employees
--LEFT JOIN dept_employee ON employees.emp_no = dept_employee.emp_no
--LEFT JOIN departments ON dept_employee.dept_no = departments.dept_no;


--*** (5) List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT 
first_name, last_name, gender
FROM employees
WHERE first_name = 'Hercules' 
AND last_name LIKE 'B%';

---*** (6) List all employees in the Sales department, including their employee number, last name, first name, and department name.
--SELECT *
--FROM dept_employee
--LIMIT 3;

--***
SELECT
e.emp_no, e.last_name, e.first_name,
d.dept_name
FROM "employees" e
LEFT JOIN "dept_employee" de ON e.emp_no = de.emp_no
LEFT JOIN "departments" d ON d.dept_no = de.dept_no
WHERE d.dept_name = 'Sales';

--*** (7) List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

SELECT
e.emp_no, e.last_name, e.first_name,
de.emp_no, de.dept_no,
d.dept_no, d.dept_name
FROM "employees" e
LEFT JOIN "dept_employee" de ON e.emp_no = de.emp_no
LEFT JOIN "departments" d ON d.dept_no = de.dept_no
WHERE d.dept_name = 'Sales' AND d.dept_name = 'Development';

--***NO EMPLOYEES IN BOTH DEPT, LISTING SALES _OR_ DEVELOPMENT
SELECT
e.emp_no, e.last_name, e.first_name,
d.dept_name
FROM "employees" e
LEFT JOIN "dept_employee" de ON e.emp_no = de.emp_no
LEFT JOIN "departments" d ON d.dept_no = de.dept_no
WHERE d.dept_name = 'Sales' OR d.dept_name = 'Development';

--*** (8) Descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
--***
SELECT employees.last_name, COUNT(*)
FROM employees
GROUP BY employees.last_name
ORDER BY COUNT(*) DESC;

