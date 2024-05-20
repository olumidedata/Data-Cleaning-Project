select * from employee_demographics;

select * from employee_salary;

select * 
from employee_demographics
	inner join employee_salary
    on employee_demographics.employee_id = employee_salary.employee_id
    ;
    
    -- Outer Join
    
    select * 
from employee_demographics
	left join employee_salary
    on employee_demographics.employee_id = employee_salary.employee_id
    ;
    
       select * 
from employee_demographics
	right join employee_salary
    on employee_demographics.employee_id = employee_salary.employee_id
    ;
    
       select * 
from employee_demographics
	left join employee_salary
    on employee_demographics.employee_id = employee_salary.employee_id
    ;
    
    
    -- Joining multiple table
    
    select * 
from employee_demographics AS dem
	inner join employee_salary AS sal
    on dem.employee_id = sal.employee_id
    inner join parks_departments AS pd
    on sal.dept_id = pd.department_id
    ;
    
    