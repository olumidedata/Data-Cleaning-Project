-- Case statement

-- when salary > 50000 then salary + (salary * 0.07)
-- when department_name = Finance then salary + (salary * 0.10)
-- Video 13 Subqueries

select * from employee_salary;
select * from parks_departments;

select 
first_name,
last_name,
age,
CASE
 when age < 30 THEN 'Young'
 when age between 30 and 50 then 'Old'
 when age >= 60 then 'Retire'
END AS 'Age Bracket'
from employee_demographics
;

select 
first_name,
last_name,
salary,
CASE 
	when salary < 50000 then salary + (salary * 0.05)
    when salary > 50000 then salary + (salary * 0.07)
END as increase,
case
	when dept_id = 6 then salary + (salary * 0.10) 
end AS bonus
from employee_salary 
;
