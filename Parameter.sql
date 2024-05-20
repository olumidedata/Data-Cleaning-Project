

DELIMITER $$
create procedure large_salaries4(H int)
BEGIN
select * 
from employee_salary
where employee_id = H
;
END $$
DELIMITER ;

CALL large_salaries4(3);
