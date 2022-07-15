select * from departments;

select department_id, location_id
from departments; 

select location_id, department_id --select���ϴ� ������
from departments;                 --from ~���� �����Ͷ�

desc departments -- ����Ȯ�� desc

--����] employees ������ Ȯ���϶�.
desc employees

select last_name, salary, salary + 300
from employees;

-- ����] ������� ����,������ ��ȸ�϶�.
select salary, salary * 12
from employees;

select last_name, salary, 12* salary +100
from employees;
--java�� ���� �����ڿ� ������ �ִ�.
select last_name, salary, 12* (salary +100)
from employees;

select last_name, salary, 100 + salary *12
from employees;

select last_name, job_id, commission_pct
from employees;
--����] Ŀ�̼��� ����ؼ� ����� �̸�, ������, ������ ��ȸ�϶�
select last_name, job_id, 12 * salary + (12 * salary * commission_pct) 
from employees;

-- �������� �̸���(����) �ٲ��� �� �ִ�. // ������ �빮�ڷ� ������, ����� �빮�ڷ� ���´�.
select last_name as name, commission_pct comm
from employees;

-- �������� �̸��� ��ҹ��� �� �ٲ��ֱ� ���ؼ��� ""�ȿ� �־��ָ� �ȴ�.
select last_name "Name", salary * 12 " Annual Salary"
from employees;

--����] ������� ���, �̸�, ����,�Ի����� ��ȸ�϶�.
--      �Ի��� Į������ STARTDATE�� �Ѵ�.
select employee_id, last_name, job_id, hire_date startdate
from employees;

--����] ������� ���(Emp #), �̸�(Name), ����(Job), �Ի���(Hire Date)�� ��ȸ�϶�.
select employee_id "Emp #", last_name "Name", job_id "Jab", hire_date "Hire Date"
from employees;

-- �ϳ��� Į������ ����� ||(���̱� ������)
-- ���̱� �����ڴ� ���ڸ� ���ڷ� ���� �а� �Ѵ�.
select last_name || job_id
from employees;

--�������� ���̱����� select�ȿ� '����' ���ڸ� ���� �� �ִ�.
select last_name || ' is ' || job_id
from employees;

select last_name || ' is ' || job_id employee
from employees;

select last_name || null
from employees;

select last_name || commission_pct
from employees;

select last_name || salary
from employees;

select last_name || hire_date
from employees;

select last_name || (salary *12)
from employees;

--����] ������� '�̸�, ����' (Emp and Title)�� ��ȸ�϶�.
select last_name || ', ' || job_id "Emp and Title"
from employees;