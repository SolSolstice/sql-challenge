-- All queries as instructed by the directions 


--  I started by creating a view named 'bulk_info' to assist with the first 2 questions

CREATE VIEW bulk_info AS 
SELECT 
	titles.title_id,
	titles.title, 
	employees.emp_no,
	employees.emp_title_id,
	employees.birth_date, 
	employees.first_name,
	employees.last_name,
	employees.sex,
	employees.hire_date,
	dept_emp.dept_no,
	salaries.salary,
	dept_name
FROM 
	titles 
INNER JOIN employees
	ON titles.title_id = employees.emp_title_id
INNER JOIN dept_emp
	ON dept_emp.emp_no = employees.emp_no
INNER JOIN salaries 
	ON salaries.emp_no = employees.emp_no
INNER JOIN departments
	ON departments.dept_no = dept_emp.dept_no
;	

-- Question 1: List the employee number, last name, first name, sex, and salary of each employee 

select emp_no, last_name, first_name, sex, salary from bulk_info
ORDER BY 
emp_no;


-- Question 2: List the first name, last name, and hire date for the employees who were hired in 1986 

select first_name, last_name, hire_date from bulk_info
WHERE 
hire_date between '1986-01-01' and '1986-12-31';


-- Question 3: List the manager of each department along with their department number, department name, employee number, last name, and first name
select 
	d.dept_no,
	dpt.dept_name,
	e.emp_no,
	e.last_name,
	e.first_name
FROM 
dept_manager d
INNER JOIN departments dpt
ON d.dept_no = dpt.dept_no
INNER JOIN employees e 
ON d.emp_no = e.emp_no 
;


-- Question 4: List the department number for each employee along with that employee’s employee number, last name, first name, and department name 

select 
	de.dept_no, 
	de.emp_no, 
	e.last_name,
	e.first_name,
	d.dept_name
FROM dept_emp de
LEFT JOIN employees e
ON de.emp_no = e.emp_no
LEFT JOIN departments d
ON d.dept_no = de.dept_no;


--Question 5: List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B

select 
	first_name,
	last_name,
	sex
FROM employees
WHERE first_Name = 'Hercules' AND last_name like 'B%'
ORDER BY last_name;


--Question 6: List each employee in the Sales department, including their employee number, last name, and first name 

select 
	emp_no,
	last_name,
	first_name
from bulk_info
WHERE dept_no = 'd007';


-- Question 7: List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name

select 
	emp_no,
	last_name,
	first_name,
	dept_name
FROM bulk_info
WHERE dept_no = 'd007' OR dept_no = 'd005';


-- Question 8: List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name)

select last_name, 
count(last_name)
FROM employees
GROUP BY last_name
ORDER BY count(last_name) DESC;
