--Create Tables and Import Data
CREATE TABLE departments (
     dept_no VARCHAR(4) NOT NULL,
     dept_name VARCHAR(40) NOT NULL,
     PRIMARY KEY (dept_no),
     UNIQUE (dept_name)
);

CREATE TABLE employees (
	 emp_no INT NOT NULL,
     birth_date DATE NOT NULL,
     first_name VARCHAR NOT NULL,
     last_name VARCHAR NOT NULL,
     gender VARCHAR NOT NULL,
     hire_date DATE NOT NULL,
     PRIMARY KEY (emp_no)
);

CREATE TABLE dept_manager (
dept_no VARCHAR(4) NOT NULL,
    emp_no INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE salaries (
  emp_no INT NOT NULL,
  salary INT NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  PRIMARY KEY (emp_no)
);


Create Table dept_emp (
  emp_no INT NOT NULL,
  dept_no varchar(4) NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
  PRIMARY KEY (emp_no,dept_no)
);

create table titles(
emp_no int NOT NULL,
	title varchar NOT Null,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  PRIMARY KEY (emp_no,title,from_date)
);


Select * from employees
Select * from titles

-- Deliverable 1 Retirement_title
SELECT e.emp_no,
	e.first_name, 
	e.last_name,
	tt.title,
    tt.from_date,
	tt.to_date
INTO retirement_titles
FROM employees as e
Left JOIN titles as tt
ON e.emp_no=tt.emp_no
Where (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER By e.emp_no, e.emp_no DESC;



-- Deliverable 1 unique_title

SELECT Distinct on (e.emp_no)e.emp_no,
	e.first_name, 
	e.last_name,
	tt.title,
    tt.from_date,
	tt.to_date
INTO unique_titles
FROM employees as e
Left JOIN titles as tt
ON e.emp_no=tt.emp_no
Where (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER By e.emp_no, e.emp_no DESC;


--Deliverable 1 retrieve the number of employees by their most recent job title who are able to retire 

SELECT COUNT(ut.emp_no),ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title
Order BY Count(ut.emp_no), Count(ut.emp_no) DESC;


--Deliverabe 2 Mentorship Eligibility
SELECT distinct on (e.emp_no)e.emp_no,
	e.first_name, 
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	tt.title
INTO mentorship_eligibility
FROM employees as e
	Left JOIN dept_emp as de
		ON (e.emp_no=de.emp_no)
	Left JOIN titles as tt
		ON (e.emp_no=tt.emp_no)
Where (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER By e.emp_no, e.emp_no DESC;