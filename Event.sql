--- Events

select * 
from
employee_demographics
;

DELIMITER $$
create event delete_retirees2
on schedule every 30 second
do
BEGIN
	DELETE
	FROM employee_demographics
	where age >= 60;
END $$
DELIMITER ;

show variables like 'event%';