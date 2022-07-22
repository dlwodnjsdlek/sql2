--join

-- equi join // ���� ��� ���̺��� ������ ���� ���� ���� ���� ������ ���� �����Ѵ�.
-- �� ���̺��� Į�� �ʵ尳���� ���ƾ��Ѵ�.
-- ���� ���̺��� ���ڵ带 ���ؼ� ����Į���� ã�� �ִ´�
select department_id, department_name, location_id, city
from departments natural join locations;

-- join using, using���� (����� Į��) primary key�� �ۼ��Ѵ�.
-- �̶� using�� ���� Į���� ���λ縦 ������ ���Ѵ�.
select employee_id, city, department_name
from employees join departments
using (department_id)
join locations
using (location_id);

--join on
-- on�� ���̴� ���� ���λ縦 �ٿ����Ѵ�.
-- ���� ���λ�� ���� �������� �þ��. (Į���� �ʵ�Ȯ��)
select employee_id, city, department_name
from employees e join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id;

--����] Toronto�� ��ġ�� �μ����� ���ϴ� �������
--      �̸�,����,�μ���ȣ,�μ����� ��ȸ�϶�.
select e.last_name, e.job_id, d.department_name, l.city
from employees e join departments d
using (department_id)
join locations l
using (location_id)
where city = 'Toronto';

--none equi join // on������ =�� �ƴ϶� �ٸ� ���� ����ϸ� none�̴�
select e.last_name, e.salary, e.job_id
from employees e join jobs j
on e.salary between j.min_salary and j.max_salary
    and j.job_id = 'IT_PROG';
    
--== self join / select�� ���λ縦 �ٿ��� ��ġ �ٸ� ���̺��� ���ΰ� ó�� ���δ�.
-- ���� �μ����� ���ϴ� ����� �̸� �μ� ���� �̸��� ��ȸ�϶�.
select m.department_id || '�� �μ���', m.last_name || ' ����� ', f.last_name || ' �̴�.'
from employees m join employees f
on m.department_id = f.department_id
where m.employee_id <> f.employee_id
order by 1,2,3;

--self join�� �̷��� ǥ�����Ѵ�.
select w.last_name || ' works for ' || m.last_name
from employees w, employees m
where w.manager_id = m.employee_id;


--== outer join / join�� null�� ������ ��� �ҷ��� �� �ִ�.
-- left / right / full ���ִµ� �� ������ ���� ��� �����´�.

-- �����ʿ� ���µ� ���ʿ� �ִ°� ������
select e.last_name, e.department_id, d.department_name
from employees e left outer join departments d
on e.department_id = d.department_id
order by 2 desc;
--where ,, (+)�ε� ǥ������
    select e.last_name, e.department_id, d.department_name
    from employees e, departments d
    where e.department_id = d.department_id(+); -- left outer join
    
-- �����ʿ� �ִµ� ���ʿ� �ִ°� ������
select e.last_name, e.department_id, d.department_name
from employees e right outer join departments d
on e.department_id = d.department_id;
    select e.last_name, e.department_id, d.department_name
    from employees e, departments d
    where e.department_id(+) = d.department_id; -- right outer join


-- ���� �� ������
select e.last_name, e.department_id, d.department_name
from employees e full outer join departments d
on e.department_id = d.department_id;
    select e.last_name, e.department_id, d.department_name
    from employees e, departments d
    where e.department_id(+) = d.department_id(+); -- ERROR] full outer join�� ����
