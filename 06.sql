--join // ���ڵ带 ���ս�Ŵ

select department_id, department_name, location_id
from departments;

select location_id, city
from locations;


--equi join // ���� ��� ���̺��� ������ ���� ���� ���� ���� ������ ���� �����Ͽ� ����� �����ϴ� ���� ���
--
select department_id, department_name, location_id, city
from departments natural join locations;

select department_id, department_name, location_id, city
from departments natural join locations
where department_id in (20,50);
-- ���� ���̺��� ���ڵ带 ���ؼ� ����Į���� ã�´�.
-- ����Į���� �ʵ尪�� ���ƾ��Ѵ�.

-- �����̵Ǵ� ���̺��� ����
-- �Ѱ��� �����̸Ӹ�Ű(�������ؼ�) �Ѱ��� ����Ű(�ٿ��ֱ�)
-- �����̸Ӹ�Ű ���̺����� ������ ���� ������ ���� �߿��� Į��
-- �����ʵ��� ������ Ÿ���� ���ƾ��Ѵ�.

--natural join 
-- ���� ������ ���ϴ�
-- ����

select employee_id, last_name, department_id, location_id
from employees join departments
using (department_id);

--����] ������ ������ 1���� �̸�, �μ���ȣ�� ��ȸ�϶�
select last_name, department_id
from employees
where department_id is null;
--����] ������ ������ 1���� �̸�, �μ���ȣ�� ��ȸ�϶�
select last_name, nvl2(department_id, 'O','X')
from employees;

select employee_id, last_name, department_id, location_id
from employees join departments
using (department_id);

select employee_id, last_name, department_id, location_id
from employees natural join departments;
 
 select locations.city, departments.department_name
 from locations join departments
 using (location_id)
 where location_id = 1400;
 
 select l.city, d.department_name
 from locations l join departments d -- ����ֱ� ����
 using (location_id)
 where location_id = 1400;
 
  select l.city, d.department_name, d.location_id --error] using Į������ ���λ縦 �����δ�.
 from locations l join departments d 
 using (location_id)
 where d.location_id = 1400;--error] using�� ���� Į������ ���λ縦 �����δ�.
 
 select e.last_name, d.department_name
 from employees e join departments d
 using (department_id)
 where d.manager_id = 100;
 --===============================================--
 -- using -> on
 
 select e.employee_id, e.last_name, e.department_id,
    d.department_id, d.location_id
from employees e join departments d
on (e.department_id = d.department_id);
 
select e.employee_id, city, department_name
from employees e join departments d
on e.department_id = d. department_id
join locations l
on d.location_id = l.location_id;
--����]�� ������, using���� refactoring�϶�.
select e.employee_id, city, department_name
from employees e join departments d
using (department_id)
join locations l
using (location_id);
 
select e.employee_id, e.last_name, e.department_id,
    d.department_id, d.location_id
from employees e join departments d
on e.department_id = d.department_id
where e.manager_id = 149;

--����] Toronto �� ��ġ�� �μ����� ���ϴ� �������
--      �̸�,����,�μ���ȣ,�μ����� ��ȸ�϶�.
select e.last_name, e.job_id, d.department_name, l.city
from employees e join departments d
using (department_id)
join locations l
using (location_id)
where city = 'Toronto';

-- none equi join // =�� �ƴ϶� �ٸ� ���� ���� none�̴� 
select e.last_name, e.salary, e.job_id
from employees e join jobs j
on e.salary between j.min_salary and j.max_salary
    and j.job_id = 'IT_PROG';
--�̰� �����
--=============================================--    
-- self join
select worker.last_name emp, manager.last_name mgr
from employees worker join employees manager
on worker.manager_id = manager.employee_id;

select worker.last_name emp, last_name mgr -- ERROR] self join���� ���λ簡 �ʼ��̴�.
from employees worker join employees manager -- ��� Į���� �ʼ� 2���� Į����ô
on manager_id = employee_id; -- ERROR] self join���� ���λ簡 �ʼ��̴�.

--����] ���� �μ����� ���ϴ� ������� �̸�, �μ���ȣ, ������ �̸��� ��ȸ�϶�.
select my.last_name, my.department_id, friend.last_name
from employees my join employees friend
on my.department_id = friend.department_id
where my.employee_id <> friend.employee_id -- �ٸ��� ������ <>
order by 2,1,3;

--����] Davies ���� �Ŀ� �Ի��� ������� �̸�,�Ի����� ��ȸ�϶�.
--      
select c.last_name, c.hire_date
from employees e join employees c
on e.last_name = 'Davies'
    and e.hire_date < c.hire_date
order by hire_date;

--����] �Ŵ������� ���� �Ի��� ������� �̸�, �Ի���, �Ŵ����� �Ŵ��� �Ի����� ��ȸ�϶�.
select e.last_name, e.hire_date, e.manager_id,
        m.employee_id, m.last_name, m.hire_date
from employees e join employees m
on e.manager_id = m.employee_id
    and e.hire_date < m.hire_date;
  
--=====================================--
--outer join �ۿ��ִ°� �����϶�

select e.last_name, e.department_id, d.department_name
from employees e join departments d
on e.department_id = d.department_id;

-- ����� department_id�� ���� �ο��� �߰� (���ε��� ���� ������ �߰�
select e.last_name, e.department_id, d.department_name
from employees e left outer join departments d
on e.department_id = d.department_id;

-- departments�� ����� ���� �μ����� �߰�
select e.last_name, e.department_id, d.department_name
from employees e right outer join departments d
on e.department_id = d.department_id;

-- �μ��� ����������, ������ ���� �μ� ���� ��� �߰�
select e.last_name, e.department_id, d.department_name
from employees e full outer join departments d
on e.department_id = d.department_id;

--����] ������� �̸�,���,�Ŵ�����,�Ŵ����� ����� ��ȸ�϶�
--      king ���嵵 ���̺� �����Ѵ�.
select e.last_name, e.employee_id, m.last_name, m.employee_id
from employees e left outer join employees m
on e.manager_id = m.employee_id
order by 2;
--=================================================--

select d.department_id, d.department_name, d.location_id, l.city
from departments d, locations l
where d.location_id = l.location_id
and d.department_id in(20,50);

select e.last_name,d.department_name, l.city
from employees e, departments d, locations l
where e.department_id = d.department_id
    and d.location_id = l.location_id;
  
select e.last_name, e.salary, e.job_id
from employees e, jobs j
where e.salary between j.min_salary and j.max_salary
    and j.job_id = 'IT_PROG';  

select e.last_name, e.department_id, d.department_name
from employees e, departments d
where e.department_id(+) = d.department_id; -- (+)�� �������� right outer join

select e.last_name, e.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id(+); -- left outer join

select e.last_name, e.department_id, d.department_name
from employees e, departments d
where e.department_id(+) = d.department_id(+); -- ERROR] full outer join�� ����

select w.last_name || ' works for ' || m.last_name
from employees w, employees m -- self join ����
where w.manager_id = m.employee_id;
  