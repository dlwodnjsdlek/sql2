--����]
-- ���� �ʰ� �Ի��� ����� ã�ƶ� / �̸�, �Ի���
select e.last_name ,e.hire_date
from employees e join employees m
on e.hire_date >= m.hire_date;

select last_name, hire_date
from employees
order by hire_date desc;