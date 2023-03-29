-- table schemata 
-- creates each of the 6 tables & imports their respective information 
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
	hire_date DATE,
	foreign key(emp_title_id) REFERENCES titles(title_id)
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
