drop table if exists titles CASCADE; 
drop table if exists employees CASCADE;
drop table if exists departments CASCADE;
drop table if exists dept_manager CASCADE;
drop table if exists dept_emp CASCADE;
drop table if exists salaries CASCADE; 


create table titles(
	title_id VARCHAR(30) primary key,
	title VARCHAR(30)
);

create table employees(
	emp_no INT primary key, 
	emp_title_id VARCHAR(15),
	birth_date DATE, 
	first_name VARCHAR(20),
	last_name VARCHAR(20),
	sex VARCHAR(1),
	hire_date DATE
);

create table departments(
	dept_no VARCHAR(10) primary key, 
	dept_name VARCHAR(30)

);

create table dept_manager(
	dept_no VARCHAR(10),
	emp_no INT,
	foreign key (emp_no) REFERENCES employees(emp_no),
	foreign key (dept_no) REFERENCES departments(dept_no),
	primary key (emp_no,dept_no)

);

create table dept_emp(
	emp_no INT, 
	dept_no VARCHAR(10),
	foreign key (emp_no) REFERENCES employees(emp_no),
	foreign key (dept_no)REFERENCES departments(dept_no),
	primary key (emp_no, dept_no)

);

create table salaries(
	emp_no INT primary key, 
	salary INT,
	foreign key (emp_no) REFERENCES employees(emp_no)

);

-- Importing CSVs 
COPY titles FROM 'C:\Users\Matthew\OneDrive\Desktop\Bootcamp\Bootcamp Work\09 - SQL Unit\Module 09 Challenge - Due 03-28-2023\sql-challenge\data\titles.csv' WITH CSV HEADER;
COPY employees FROM 'C:\Users\Matthew\OneDrive\Desktop\Bootcamp\Bootcamp Work\09 - SQL Unit\Module 09 Challenge - Due 03-28-2023\sql-challenge\data\employees.csv' WITH CSV HEADER;
COPY departments FROM 'C:\Users\Matthew\OneDrive\Desktop\Bootcamp\Bootcamp Work\09 - SQL Unit\Module 09 Challenge - Due 03-28-2023\sql-challenge\data\departments.csv' WITH CSV HEADER;
COPY dept_manager FROM 'C:\Users\Matthew\OneDrive\Desktop\Bootcamp\Bootcamp Work\09 - SQL Unit\Module 09 Challenge - Due 03-28-2023\sql-challenge\data\dept_manager.csv' WITH CSV HEADER;
COPY dept_emp FROM 'C:\Users\Matthew\OneDrive\Desktop\Bootcamp\Bootcamp Work\09 - SQL Unit\Module 09 Challenge - Due 03-28-2023\sql-challenge\data\dept_emp.csv' WITH CSV HEADER;
COPY salaries FROM 'C:\Users\Matthew\OneDrive\Desktop\Bootcamp\Bootcamp Work\09 - SQL Unit\Module 09 Challenge - Due 03-28-2023\sql-challenge\data\salaries.csv' WITH CSV HEADER;

--  Create view

	
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

-- Question 1 
select emp_no, last_name, first_name, sex, salary from bulk_info
ORDER BY 
emp_no;

-- Question 2 
select first_name, last_name, hire_date from bulk_info
WHERE 
hire_date between '1986-01-01' and '1986-12-31';

-- Question 3 
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

-- Question 4 
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

--Question 5 

select 
	first_name,
	last_name,
	sex
FROM employees
WHERE first_Name = 'Hercules' AND last_name like 'B%'
ORDER BY last_name;

--Question 6

select 
	emp_no,
	last_name,
	first_name
from all_info
WHERE dept_no = 'd007';

-- Question 7


select 
	emp_no,
	last_name,
	first_name,
	dept_name
FROM bulk_info
WHERE dept_no = 'd007' OR dept_no = 'd005';

-- Question 8 
select last_name, 
count(last_name)
FROM employees
GROUP BY last_name
ORDER BY count(last_name) DESC;