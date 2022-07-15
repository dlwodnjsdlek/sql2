--where

select employee_id, last_name, department_id
from employees
where department_id = 90;

select employee_id, last_name, department_id
from employees
where last_name = 'Whalen'; 

select last_name, salary
from employees
where salary <= 3000;

select last_name,job_id
from employees
where job_id != 'IT_PROG';

select last_name,job_id
from employees
where job_id = 'IT_PROG';

select employee_id, last_name, department_id
from employees
where employee_id = 176;

select first_name, last_name, job_id
from employees
where last_name between 'King' and 'Smith';

select first_name, last_name, job_id
from employees
where hire_date between '2002/01/01' and '2002/12/31';

select employee_id, last_name, manager_id
from employees
where manager_id in (100, 101, 201);

--================================================--

select last_name, department_id
from employees
order by department_id;

select last_name, department_id
from employees
order by department_id desc;

select last_name, department_id
from employees
order by 2 desc;

select last_name, department_id dept_id
from employees
order by dept_id desc;

select last_name, department_id, salary
from employees
where department_id > 80
order by department_id asc,salary desc;