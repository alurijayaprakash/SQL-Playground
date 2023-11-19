-- JOINs
-- A JOIN clause is used to combine rows from two or more tables, based on a related column between them.

/*

(INNER) JOIN: Returns records that have matching values in both tables
LEFT (OUTER) JOIN: Returns all records from the left table, and the matched records from the right table
RIGHT (OUTER) JOIN: Returns all records from the right table, and the matched records from the left table
FULL (OUTER) JOIN: Returns all records when there is a match in either left or right table

*/


select count(*) from departments d ;
select count(*) from regions r ;

select count(*) 
from departments d join regions r 
on d.capital = r.capital ;


select count(*) 
from departments d right join regions r 
on d.capital = r.capital ;

select count(*) 
from departments d left join regions r 
on d.capital = r.capital ;

-- FULL OUTER JOIN/ FULL JOIN
select count(*) 
from departments d full join regions r 
on d.capital = r.capital ;

-- CROSS JOIN
select count(*) 
from departments d cross join regions r ;



----------------------------

-- ADVANCE JOINS

-- LEFT JOIN EXCLUDING INNER JOIN 
select count(*)
from departments d left join regions r 
on d.capital = r.capital 
where r.capital is null

-- RIGHT JOIN EXCLUDING INNER JOIN
select * 
from departments d right join regions r
on d.capital = r.capital 
where d.capital is null

-- FULL (OUTER) JOIN EXCLUDING INNER JOIN
select * 
from departments d full join regions r
on d.capital = r.capital 
where d.capital is null or r.capital is null

-- SELF JOIN

drop table empmanager;

CREATE TABLE empmanager (
    EmployeeID INT PRIMARY KEY,
    EmpName VARCHAR(50) NOT NULL,
    ManagerID INT,
    EmpSalary INT
);


   
insert into empmanager (EmployeeID, EmpName, ManagerID,EmpSalary)
values (1,'Prakash',3, 10000);

select * from empmanager e ;

insert into empmanager (EmployeeID, EmpName, ManagerID,EmpSalary)
values (2,'Hari',5, 20000),(3,'Bharat',1, 7000),(4,'John',2, 4000),(5,'Venu',null, 30000);


-- INNER SELF JOIN
-- Get the Employee name with manager name
select em.empname as EMName, mn.empname as MNGName
from empmanager em inner join empmanager mn 
on em.managerid = mn.employeeid;

-- Find the emlpoyees with salary more than their manager salary

select em.empname as EMName, mn.empname as MNGName, em.EmpSalary as EMP_S , mn.EmpSalary as MN_S
from empmanager em inner join empmanager mn 
on em.managerid = mn.employeeid
where em.EmpSalary > mn.EmpSalary;

-- LEFT SELF JOIN
-- Get the all Employee name with manager name
select em.empname as EMName, mn.empname as MNGName
from empmanager em left join empmanager mn 
on em.managerid = mn.employeeid;

-- RIGHT SELF JOIN
-- Get the Employee name with all manager name
select em.empname as EMName, mn.empname as MNGName
from empmanager em right join empmanager mn 
on em.managerid = mn.employeeid;

-- Group by
-- when we use "GROUP BY" - it will apply func per group, but not on the entire dataset
-- it's mainly used to reduce all records found for the matching "Group" to a single record
-- The GROUP BY statement is often used with aggregate functions (COUNT(), MAX(), MIN(), SUM(), AVG()) to group the result-set by one or more columns 

-- it's strategy of SPLIT-APPLY-COMBINE strategy

-- SPLIT – DEVIDE groups with values
-- Apply – apply aggregations against ungrouped data
-- Combine – combine groups with a single value in to single value

-- ORDER of Operations: -
-- FROM -> WHERE -> GROUP BY -> SELECT -> ORDER 

-- GROUP BY Syntax

SELECT column_name(s)
FROM table_name
WHERE condition
GROUP BY column_name(s)
ORDER BY column_name(s);

-- Get count of employees based on gender

select gender, count(gender) from customers
group by gender;


-- HAVING
-- The HAVING clause was added to SQL because the WHERE keyword cannot be used with aggregate functions.
-- ORDER of Operations: -
-- FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER 

-- Generally, WHERE applies on individual rows
-- But Having, applies to group as a whole. ie. filter data aginst groups

-- WHERE vs HAVING
-- where applies on individual rows but HAVING applies on whole group data


select * from customers

-- count employees by state
select state, count(state) 
from customers
group by state 

-- count employees statewise but interested states having more than 150 custmers
select state, count(state) 
from customers
group by state 
having count(state) > 150

-- count employees statewise but interested states having more than 100 Female custmers
select state, count(state) 
from customers
where gender = 'F'
group by state 
having count(state) > 100
order by state

-- same thing order by state desc
select state, count(state) 
from customers
where gender = 'F'
group by state 
having count(state) > 100
order by count(state) desc

-- alternative
select state, count(state) 
from customers
--where gender = 'F'
group by state , gender 
having count(state) > 100 and gender = 'F'
order by state


-- UNION
-- UNION used to combine result-set of two or more tables with disctict values
-- UNION ALL to combine result-set of two or more tables with all values

-- UNION ALL is faster than UNION, because union need to remove duplicates


-- UNION - only unique values
select id, name , email from Customers
UNION
select id, name, email from students

-- UNION ALL - contain duplicates
select id, name , email from Customers
UNION ALL
select id, name, email from students


-- UNION vs JOINs
-- Union combine rows from multiple tables
-- Joins combines columns from mutiple tables

