
-- Union ALL 

select first_name, last_name, 'Old man' AS Label
from employee_demographics
where age > 40 and gender = 'Male'
union
select first_name, last_name, 'Old Lady' AS Label
from employee_demographics
where age > 40 and gender = 'Female'
union
select first_name, last_name, 'Highly Paid' AS Label
from employee_salary
where salary > 70000
order by first_name, last_name
;