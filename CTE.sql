-- CTE

WITH CTE_Example AS 
(
select 
gender, 
avg(salary) AS avg_salary, 
max(salary) AS max_sal, 
min(salary) AS min_sal, 
count(salary) AS count_sal
from employee_demographics dem
join
employee_salary sal
	on dem.employee_id = sal.employee_id
    group by gender
    )
    
    select *
    from CTE_Example
;

WITH CTE_Example AS 
(
select 
employee_id, gender, birth_date
from employee_demographics
where birth_date > '1985-01-01'

    ),
    CTE_example2 AS
    (
    select employee_id
    from employee_salary
    )
    select *
    from CTE_Example
    join
    CTE_Example2
     on CTE_Example.employee_id = CTE_Example2.employee_id
;

WITH CTE_Example (Gender, AVG_SAL, MAX_SAL, MIN_SAL, COUNT_SAL) AS 
(
select 
gender, 
avg(salary) AS avg_salary, 
max(salary) AS max_sal, 
min(salary) AS min_sal, 
count(salary) AS count_sal
from employee_demographics dem
join
employee_salary sal
	on dem.employee_id = sal.employee_id
    group by gender
    )
    
    select *
    from CTE_Example
;