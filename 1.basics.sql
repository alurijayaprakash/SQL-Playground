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

-- Checking for Empty Values - NULL (used for representing missing values)
-- Note : NULL is different from zero, spaces[empty string]
-- NULL is special value
SELECT NULL = NULL;
SELECT NULL <> NULL;
SELECT NULL != NULL;
-- NULL always null even if you subtract, multiply, devide, add etc..

-- IS operator allow you to filter on values that are NULL, NOT NULL, TRUE, FALSE

select * from customers c 
where c.phone  is not null;

-- Every one that is not 20
select * from customers c 
where c.age != 20 limit 10

-- Same Query using IS
select * from customers c 
where c.age = 20 is false limit 10

-- Cleanup your data - Replacing NULL's with not NULL values
-- COALESCE() Function : Return the first non-null value in a list
-- Syntax
SELECT COALESCE(<column>, 'Empty') AS column_alias
FROM table

-- Example - we know that name has null values but we intested in 
-- filling this null values with 'no name available'
SELECT COALESCE(name, 'no name available'), last_name from Student;
-- Note: 'no name available' is fall back value

-- Get sum of ages of students, if age is not available/empty/null fill with avg value 20
SELECT sum(COALESCE(age, 20)) from Student;
-- Note: 20 is fall back value


-- THREE Valued Logic
/*
Besides TRUE and FALSE , the result of logical expression can also be unknown
Check the doc for Pic
always problems with NULL values, what ever the opeation with NULL results UNKNOWN state
so we need null check to avoid null side effects

Example-1
(NULL = 1) OR (1 = 1) evaluated as NULL OR TRUE
here OR needed at least one TRUE to give results. 
only one side T is needed. it dont wait for another side so no problem

Example-2
(NULL = 1) AND (0 = 1) evaluated as NULL AND FALSE
here AND expression is needed LHS(T/F) and RHS(T/F) values to give results.
but in this case NULL is ambiguity state.
so no results here

Note : NULL is always UNKNOWN

because NULL is not even equal to NULL

Strange Scenarios-1

SELECT col
FROM table
WHERE (col = NULL) -- results NULL nothing to return
OR (NOT col = NULL) -- results NULL because anything null is null, nothing to return

-- overall no results

Strange Scenarios-2

SELECT col
FROM table
WHERE (col IS NULL) -- results data having null
OR (col IS NOT NULL) -- results data not having null

-- result is => having null + not having null = total data

*/

-- BETWEEN AND

-- The BETWEEN command is used to select values within a given range. 
-- The values can be numbers, text, or dates.

-- The BETWEEN command is inclusive: begin and end values are included. 

-- Get the customers who's age is inbetween 20 and 21
select * from customers c 
where c.age between 20 and 21

select * from customers c 
where c.age >= 20 and c.age <= 21

-- above two queries results same. so use between and operator wisely
-- Note : begin and end values are included

-- IN KEYWORD
-- The IN command allows you to specify multiple values in a WHERE clause.

-- The IN operator is a shorthand for multiple OR conditions.

SELECT * FROM Customers
WHERE Country IN ('Germany', 'France', 'UK');

select count(*) from customers c 
where c.age in (20,21);

-- PARTIAL LOOKUP - Pattern Matching
/*
The LIKE command is used in a WHERE clause to search for a specified pattern in a column.
LIKE is case sensitive
You can use two wildcards with LIKE:

% - Represents any numbe of character
_ - 1 character , acts as place holder


*/

-- Get everyone name starts with M
select * from customers c 
where firstname like 'M%'

/*

Pattern Matching example

LIKE '%2' - Fields that end with 2
LIKE '%2%' - Fields that have 2 anywhere in the value
LIKE '_00%' - Fields that have 2 zero's as the second and third character and anything after
LIKE '%200%' - Fields that have 200 anywhere in the value
LIKE '2_%_%' - Finds any values that start with 2 and are at least 3 characters in length
LIKE '2___3' - Finds any values in five digit number that starts with 2 and end with 3.

*/


-- LIKE - case sensitive
-- ILIKE - case In-sensitive

-- ILIKE keyword
-- Similar to LIKE but case in-sensitive 


select * from customers c 
where firstname ilike 'm%'

select * from customers c 
where firstname ilike 'm%T'

select count(*) from customers c 
where firstname ilike 'm%___%T'

select count(*) from customers c 
where firstname ilike 'm___%T'

select count(*) from customers c 
where firstname ilike 'm%___T'

-- DATES FILTERING

-- GET CURRENT TIMEZONE
SHOW TIMEZONE;

-- SET Time zone only for current session
SET TIME ZONE 'UTC';

-- SET Time zone only for all session
ALTER USER postgres SET TIMEZONE='UTC'
-- Note : after this must reconnect to DB


/*
POSTGRES uses time format ISO-8601 standard

YYYY-MM-DDTHH:MM:SS
2017-08-17T12:47:16+02:00

here +02:00 is offset means UTC + 2:00 hrs like UTC+5:30

NOTE : 
UTC - Time standard
ISO-8601 - is format standard

*/

-- CAST() Function : 
/* 
The CAST() function converts a value (of any type) into the specified datatype.

DATE	Converts value to DATE. Format: "YYYY-MM-DD"
DATETIME	Converts value to DATETIME. Format: "YYYY-MM-DD HH:MM:SS"
DECIMAL	Converts value to DECIMAL. Use the optional M and D parameters to specify the maximum number of digits (M) and the number of digits following the decimal point (D).
TIME	Converts value to TIME. Format: "HH:MM:SS"
CHAR	Converts value to CHAR (a fixed length string)
NCHAR	Converts value to NCHAR (like CHAR, but produces a string with the national character set)
SIGNED	Converts value to SIGNED (a signed 64-bit integer)
UNSIGNED	Converts value to UNSIGNED (an unsigned 64-bit integer)
BINARY	Converts value to BINARY (a binary string)
*/

-- Convert a value to a DATE datatype:
SELECT CAST("2017-08-29" AS DATE);

-- Convert a value to a CHAR datatype:
SELECT CAST(150 AS CHAR);

-- Convert a value to a TIME datatype:
SELECT CAST("14:06:10" AS TIME);


-- DATE Oprators

-- GET Current time -2 ways
SELECT now(); -- 2023-11-15 00:01:37.656 +0530
SELECT now()::date; --

SELECT CURRENT_DATE; -- 2023-11-15

-- Format date
SELECT TO_CHAR(CURRENT_DATE, 'dd/mm/yyyy')





select date '2003/12/22'  -- casting to date with format 2003-12-22


-- AGE calculation
select age(date '1993/09/26')  -- 30 years 1 mon 19 days
-- Note while we calculation age we should cast to date first


-- Day's differnece

-- Subtracting dates returns the difference in days
select age(date '2023/11/15', date '2022/07/01') -- 1 year 4 mons 14 days
-- age(big,small)

-- Extract the DAY/MONTH/YEAR from Date 
select extract (month from date '1993/09/26') -- month
select extract (day from date '1993/09/26')  -- day
select extract (year from date '1993/09/26') -- year

-- Time Interval

-- get purchases of last 30 days data

SELECT *
FROM orders
WHERE purchaseDate <= now() - interval '30 days'

-- similarly
Interval '1 year 2 months 3 days';
Interval '2 weeks ago';
Interval '1 year 3 hours 4 minutes'


-- Remove Duplicates - DISTINCT
-- we can give more than one column

-- get unique states list 
select distinct state from customers

select distinct state, first_name from customers

-- Sort Data

SELECT state, firstname  from customers
ORDER by state asc  limit 100 -- ascending

SELECT state, firstname  from customers
ORDER by state desc  limit 100 -- descending

-- asc or desc will apply beside column only not all

-- sort data by firstname and lastname in desc order
select * from customers
order  by firstname , lastname desc;

-- In above query we didn't mention asc/desc beside firstname 
-- so by default it will take asc  , so above one is WRONG

-- CORRECT one

select * from customers
order  by firstname desc  , lastname desc;

-- Sort based on length
select firstname , lastname from customers
order by LENGTH(lastname) desc;









*/

-- multi column
SELECT firs, firstname  from customers
ORDER by state desc  limit 100 -- descending




