select *
from employee_salary
where salary >= 50000
;

create procedure large_salaries()
select * 
from employee_salary
where salary >= 50000;

call large_salaries();

DELIMITER $$
create procedure large_salaries3()
BEGIN
select * 
from employee_salary
where salary >= 50000;
select * 
from employee_salary
where salary >= 10000;
END $$

DELIMITER ;

CALL large_salaries3()

