-- subquery

select last_name, salary
from employees
where salary > (select salary
                from employees
                where last_name = 'Abel')
    and department_id = (select department_id
                        from employees
                        where last_name = 'Abel')
order by salary;

select employee_id, last_name, salary
from employees
where salary in (select min(salary)
                from employees
                group by department_id);

select employee_id, last_name, salary
from employees
where salary =any (select min(salary)
                from employees
                group by department_id);
                
select employee_id, last_name, salary
from employees
where salary <>all (select min(salary) -- <> not
                from employees
                group by department_id);