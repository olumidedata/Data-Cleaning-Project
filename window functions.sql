-- window functions

select gender, avg(salary) AS avg_salary
from employee_demographics dem
join
employee_salary sal
	on dem.employee_id = sal.employee_id
    group by gender
;


select gender, avg(salary) over(partition by gender)
from employee_demographics dem
join
employee_salary sal
	on dem.employee_id = sal.employee_id
;

select dem.first_name, dem.last_name, gender, salary,
sum(salary) over(partition by gender order by dem.employee_id) AS Rolling_Total
from employee_demographics dem
join
employee_salary sal
	on dem.employee_id = sal.employee_id
;


select dem.employee_id, dem.first_name, dem.last_name, gender, salary,
row_number() over(partition by gender order by salary desc) AS row_num,
rank() over(partition by gender order by salary desc) AS rank_num,
dense_rank() over(partition by gender order by salary desc) AS denserank_num
from employee_demographics dem
join
employee_salary sal
	on dem.employee_id = sal.employee_id
;