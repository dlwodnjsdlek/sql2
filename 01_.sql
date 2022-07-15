--select

select * from departments;

select department_id, location_id
from departments;

desc employees

select salary, salary * 12
from employees
where salary >= 10000;

select last_name, job_id, 12 * salary + (12 * salary * commission_pct) 
from employees;

select employee_id "Emp #", last_name "Name", job_id "Job", hire_date "Hire Date"
from employees;

select last_name || job_id 
from employees;

select last_name ||' is '|| job_id name_id 
from employees;

select last_name || null
from employees;

select last_name || ', ' || job_id "Emp and Title"
from employees;
