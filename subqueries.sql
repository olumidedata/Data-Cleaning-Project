select *
from
employee_demographics
where employee_id in ( select employee_id
from employee_salary
where dept_id = 1
)
;

select first_name, salary,
(select avg(salary) from employee_salary) AS AVG
from
employee_salary
;

select avg(max_age)
from
(select gender,
avg(age) AS avg_age,
max(age) AS max_age,
min(age) AS min_age,
count(age)
from employee_demographics
group by gender
) AS agg_table
;



