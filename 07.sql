-- subquery
select last_name, salary
from employees
where salary > (select salary
                from employees
                where last_name = 'Abel');
    
select last_name, job_id, salary
from employees
where job_id = (select job_id
                from employees
                where last_name = 'Ernst')
and salary > (select salary
                from employees
                where last_name = 'Ernst');
                
--����] Abel�� ���� �μ����� ���ϴ� ������� �̸�,�Ի����� ��ȸ�϶�.
select last_name, hire_date
from employees
where department_id =(select department_id
                        from employees
                        where last_name = 'Abel')
and last_name <> 'Abel'
order by 1;

select last_name, job_id, salary
from employees
where salary = (select min(salary)
                from employees);

select department_id, min(salary)
from employees
group by department_id
having min(salary) > (select min(salary)
                        from employees
                        where department_id = 50)
order by department_id;

--����] ȸ�� ��� ���� �̻� ���� ������� ���, �̸�, ������ ��ȸ�϶�
-- ���� ������������ ����
select employee_id, last_name, salary
from employees
where salary >= (select avg(salary)
                from employees)
order by salary desc;

--------------------------
select employee_id, last_name
from employees
where salary = (select min(salary)
                from employees
                group by department_id); -- ERROR ���ڵ尡 1�� �̻��� �����ϰ��ִ�.

select employee_id, last_name, salary
from employees
where salary in (select min(salary)
                from employees
                group by department_id); -- sub������ ���� in�� �񱳰����� ���

select employee_id, last_name, salary
from employees
where salary =any (select min(salary) -- any�� �����ڵڿ� �پ� ���´�
                from employees        -- �����ڿ��� true���� ������ ��� / false�� �ȳ���
                group by department_id);

select employee_id, last_name, job_id, salary
from employees
where salary <any (select salary    -- any�� ���ǹ��� 1�� ������ true�� �ȴ�.
                    from employees
                    where job_id = 'IT_PROG')
and job_id <> 'IT_PROG' ;

select employee_id, last_name, job_id, salary
from employees
where salary <all (select salary    -- all�� ���ǹ��� ��� ������ true�����Ѵ�.
                    from employees
                    where job_id = 'IT_PROG')
and job_id <> 'IT_PROG' ;

--����] �̸��� u�� ���Ե� ����� �ִ� �μ����� ���ϴ� ������� ���,�̸��� ��ȸ�϶�.
select employee_id, last_name, department_id
from employees
where department_id in (select department_id
                    from employees
                    where last_name like '%u%' or last_name like 'U%')
order by department_id;

--����] 1700�� ������ ��ġ�� �μ����� ���ϴ� ������� �̸�, ����, �μ���ȣ�� ��ȸ�϶�.
select last_name, job_id, department_id
from employees
where department_id in (select department_id
                        from departments
                        where location_id = 1700)
order by department_id;

--����] Kochhar���� �����ϴ� ������� �̸�,����,�μ���ȣ�� ��ȸ�϶�.
select last_name, job_id, department_id
from employees
where manager_id in (select employee_id
                        from employees
                        where last_name = 'Kochhar');

--����] IT�μ����� ���ϴ� ������� �μ���ȣ,�̸�,������ ��ȸ�϶�.
select department_id, last_name, job_id
from employees
where department_id in(select department_id
                        from departments
                        where department_name like '%IT%');
 
 --����] 60�� �μ��� �Ϻ� ������� �޿��� ���� ������� �̸��� ��ȸ�϶�                       
select last_name
from employees
where salary >any (select salary 
                    from employees
                    where department_id = 60);
                    
                    
--����] ��� ���α׷��Ӻ��� ������ �� �ް�,
--      ȸ�� ��� ���޺��� ������ �� �޴� 
-- ����� �̸�,����,������ ��ȸ�϶�.
select last_name, job_id, salary
from employees
where salary >all (select salary 
                    from employees
                    where job_id like '%PROG')
    and salary > (select avg(salary) 
                    from employees);
--===============================================--
--no row

--sub ���� ��°��� ������ ����°��� ����.
select last_name
from employees
where salary in (select salary
                from employees
                where job_id = 'ITPROG');
--------------------------------------------------
-- EXISTS �����ڴ� ���������� 
-- �����Ͱ� �����ϴ��� üũ�ϰ� ������ ��� TRUE�� ��ȯ

select count(*) -- ����� �ִ� �μ�
from departments d
where exists (select *
                from employees e
                where e.department_id = d.department_id);
                
select count(*) -- ����� ���� �μ�
from departments d
where not exists (select *
                from employees e
                where e.department_id = d.department_id);
                
--����] ������ �ٲ� ���� �ִ� ������� ���,�̸�, ������ ��ȸ�϶�
select employee_id, last_name, job_id
from employees d 
where exists (select *
                from job_history c
                where d.employee_id = c.employee_id);
--=============================================--
--sub null
select last_name
from employees
where employee_id in (select manager_id
                        from employees);
                        
select last_name
from employees
where employee_id not in (select manager_id
                        from employees);
--����] �� ������ all �����ڷ� refactoring �϶�.

select last_name
from employees
where employee_id <>all(select manager_id
                        from employees);