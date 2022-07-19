select e.employee_id, e.last_name, e.department_id,
        d.department_id, d.location_id
from employees e join departments d
on (e.department_id = d.department_id);

--����] Toronto �� ��ġ�� �μ����� ���ϴ� �������
--      �̸�,����,�μ���ȣ,�μ����� ��ȸ�϶�.

select e.last_name, e.job_id, d.department_id, d.department_name,l.city
from employees e join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id
where city = 'Toronto';