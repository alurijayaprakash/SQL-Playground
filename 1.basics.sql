/*
Note :
1. "" is for tables/column names,  '' is for only text
2. 

*/

-- List of Employees
SELECT * FROM employees LIMIT 10;


-- How many dept do you have
select * from departments;

-- How many times has employee 10001 had a salary raise ?
select count(*) from salaries s 
where s.emp_no = 10001;

-- What title does 10006 has ?
select * from titles t
where t.emp_no = 10006;

-- RENAMING COLUMNS
-- For the better readability, format
select emp_no as "EmployeeNO", birth_date as "BirthDay", first_name as "First Name" from employees e 

-- Note : rename should be in Double quotes



-- COLUMN CONCATINATION ( Column A + Column B)
-- data should be show simpler

-- Excersize Concat first and last name 

select concat(emp_no, ' ', title)  from titles t;
-- need to rename new column
select concat(emp_no, ' ', title) as "EmployeeWithTitle" 
from titles t;

-- Note : When you use concat func, use saparator in single quotes 

/*
Two types of functions available
1. Aggregate functions : The Aggregate Functions in SQL perform calculations on
                        a group of values and then return a single value.  
    ex : sum of all salaries
    COUNT(), AVG(), MIN(), MAX(), FIRST(), LAST(), SUM()
    
    SUM()	Used to return the sum of a group of values.
    COUNT() 	Returns the number of rows either based on a condition, or without a condition.
    AVG()	Used to calculate the average value of a numeric column.
    MIN()	This function returns the minimum value of a column. 
    MAX()	Returns a maximum value of a column. 
    FIRST()	Used to return the first value of the column.
    LAST() 	This function returns the last value of the column.

2. Scalar functions : The Scalar Functions in SQL are used to return a 
                        single value from the given input value.Run againest each row.
    ex : FORMAT(), LCASE(), UCASE(), LEN(), MID(), ROUND(), NOW()
    LCASE() : Used to convert string column values to lowercase
    UCASE() : This function is used to convert a string column values to Uppercase.
    LEN() : Returns the length of the text values in the column.
    MID() : Extracts substrings in SQL from column values having String data type.
    ROUND() : Rounds off a numeric value to the nearest integer.
    NOW() : This function is used to return the current system date and time.
    FORMAT() : Used to format how a field must be displayed.

*/

--  How many people working at this company
select count(*) from employees;

-- min, max, emp no
select min(emp_no) from employees;
select max(emp_no) from employees;

-- Get the highest salary available
select max(salary) from salaries s

-- Get the total amount of the salaries paid
select sum(salary) from salaries s 

--  Check the employee name is Sumant and DOB is 1957-10-01
select * from employees e 
where e.first_name ='Sumant' and birth_date ='1957-10-01'


-- AND/OR Keyword
-- SQL follows order of operations
/*
AND will chining further oprations
OR will starts new filtering

in simple
when ever OR there, it will consider new filter chain

AND will check the columns, OR will check the rows

Hint : you can saparate data with brackets()
*/

select first_name , last_name , hire_date  from employees
where first_name = 'Georgi' and last_name = 'Facello' and hire_date = '1986-06-26'
AND first_name = 'Bezalel' OR last_name = 'Simmel'

select first_name , last_name , hire_date  from employees
where (first_name = 'Georgi' and last_name = 'Facello' and hire_date = '1986-06-26')
or (first_name = 'Bezalel' and last_name = 'Simmel')

-- NOT keyword

-- get all male employees
select * from employees e where not gender  = 'M'

-- How many customers are not 55 and 20
select count(age) from customers c
where not c.age = 55 and not c.age = 20

-- Order of Operations
-- FROM -> WHERE -> SELECT

-- Order of Operations (high to low)
-- () -> * / -> -+ -> NOT -> AND -> OR


-- Get me state and gender where you are : 
-- a female from oregon or you are from ny

select * from customers c 
where c.gender = 'F'and (state = 'OR' or state = 'NY')

