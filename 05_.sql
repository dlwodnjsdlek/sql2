--group function
-- �Ķ���� ���ڵ� ������ n���̴�.
-- singgle function / group function �� �������� ���ϰ��� 1����� ���̴�.

select count(*),
        count(distinct salary), -- distinct�� �ߺ����� �����Ѵ�.
        avg(commission_pct), -- null���� ��� ���� �ʴ´�.
        avg(nvl(commission_pct,0)), -- null���� 0���� �����.
        max(salary),
        min(salary),
        sum(salary)
from employees;

--��¥���� max min�� ��밡���ϴ�.
select MIN(hire_date), max(hire_date)
from employees;

select department_id, job_id, count(employee_id)
from employees
where department_id > 50
group by department_id, job_id
having count(employee_id) > 1 -- �׷������ where��� having�� ����Ѵ�.
order by 1;
