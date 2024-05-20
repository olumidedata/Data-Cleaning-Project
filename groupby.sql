select * from employee_demographics;

select gender,
avg(age)
from employee_demographics
group by gender;

select *
from employee_salary
;

select 
gender, 
avg(age), 
max(age), 
min(age), 
count(age)
from employee_demographics
group by gender
;

-- ORDER BY
select * 
from employee_demographics
order by first_name desc
;

select gender
from employee_demographics
group by gender
;

-- Having vs Where
select 
 gender, 
 avg(age)
 from
 employee_demographics
 group by gender
 having avg(age) > 40
 ;
 
 select 
 occupation, avg(salary)
 from employee_salary
 group by occupation
 ;
 
 select 
 occupation, avg(salary)
 from employee_salary
 where occupation like '%manager%'
 group by occupation
 having avg(salary) > 75000
 ;
 
 -- Limit and aliasing
 select *
 from employee_demographics
 order by age desc
 limit 3
 ;
 
 select gender, avg(age) as avg_age
 from employee_demographics
 group by gender
 having avg_age > 40
 ;