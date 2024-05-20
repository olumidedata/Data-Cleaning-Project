-- String Functions ( length, upper, lower, trim

select length('skyfall');

select first_name, length(first_name)
from employee_demographics
order by 2
;

select first_name, length(first_name)
from employee_demographics
order by 2
;

select first_name, 
left(first_name, 4),
right(first_name, 4),
substring(birth_date,6,2) AS Birth_Month
from employee_demographics
;

-- replace

Select first_name, replace(first_name, 'a' , 'z') AS C
from employee_demographics
;

Select first_name, last_name,
concat(first_name, ' ', last_name) AS Full_Name
from employee_demographics;

