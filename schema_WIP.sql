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
CREATE VIEW all_info AS 
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
	salaries.salary
FROM 
	titles 
INNER JOIN employees
	ON titles.title_id = employees.emp_title_id
INNER JOIN dept_emp
	ON dept_emp.emp_no = employees.emp_no
INNER JOIN salaries 
	ON salaries.emp_no = employees.emp_no;
	
-- Question 1 
select emp_no, last_name, first_name, sex, hire_date, salary from all_info;

-- Question 2 
select 