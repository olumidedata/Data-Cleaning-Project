-- Triggers

DELIMITER $$
CREATE TRIGGER employee_insert
	after insert on employee_salary
    for each row 
BEGIN
	insert into employee_demographics (employee_id, first_name,last_name)
    values (new.employee_id, new.first_name, new.last_name);
END $$
DELIMITER ;

insert into employee_salary (employee_id, first_name, last_name, occupation, salary, dept_id)
values (13, 'Olumide', 'Kolawole', 'IT', 95000, null);

select * from employee_salary;

select * from employee_demographics;
