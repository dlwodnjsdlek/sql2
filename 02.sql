--���ڵ� ����

select employee_id, last_name, department_id
from employees
where department_id = 90; 

-- department_id �� �ʵ尪�� 90 �ΰ͸� ��´�.

select employee_id, last_name, department_id
from employees
where last_name = 'Whalen'; 

--���� > ȯ�漳�� > NLS���� ��¥���¸� ���氡��
select employee_id, last_name, hire_date
from employees
where hire_date = '08/02/06'; 

select last_name, salary
from employees
where salary <= 3000;

--���� > ȯ�漳�� > ���� > ��� > ��°��� ����
-- ������� �ִ밳���� ����
select last_name, job_id
from employees
where job_id != 'IT_PROG';

-- ����] 176�� ����� ���, �̸��� �μ���ȣ�� ��ȸ�϶�.
select employee_id, last_name, department_id
from employees
where employee_id = 176;

--����] $12,000 �̻� ���� ������� �̸�,������ ��ȸ�϶�.
select last_name, salary
from employees
where salary >= 12000;

--������ �������� between a and b . a�̻� b����
select last_name, salary
from employees
where salary between 2500 and 3500;

-- between a and b .  ���ڵ� ������ �ȴ�.
select first_name, last_name, job_id
from employees
where last_name between 'King' and 'Smith';

--����] 'King'����� first name, last name, ����,������ ��ȸ�϶�.
select first_name, last_name, job_id, salary
from employees
where last_name = 'King';

select last_name, hire_date
from employees
where hire_date between '2002/01/01' and '2002/12/31';
--=================================--
-- �Ŵ��� id�� 100,101,201�� ���� ���
select employee_id, last_name, manager_id
from employees
where manager_id in (100, 101, 201);

-- �Ŵ���id�� 100�̰ų�, 101�̰ų�, 201�̰ų�
select employee_id, last_name, manager_id
from employees
where manager_id = 100 or
    manager_id = 101 or
    manager_id = 201;
    
select employee_id, last_name
from employees
where last_name in('Hartstein', 'Vargas');

select last_name, hire_date
from employees
where hire_date in('2003/06/17', '2005/09/21');
--===========================================--

-- �۽�Ʈ������ ù���ڰ� s�� ���۵Ǵ� �ָ� ã�ڴ�.
select first_name
from employees
where first_name like 'S%';

-- �۽�Ʈ������ �������� r�� ������ �ָ� ã�ڴ�.
select first_name
from employees
where first_name like '%r';

--����] first_name�� s�� ���Ե� ������� ��ȸ�϶�. �׳� s�� ���ԵǸ� ��δ�.
select first_name
from employees
where first_name like '%s%';

--����] 2005�⿡ �Ի��� ������� �̸�,�Ի����� ��ȸ�ϼ���.
select last_name, hire_date
from employees
where hire_date like '2005%';
-- like�� ���������� ���ڿ����� ����� �����ϴ�.

-- _1���� ������ �� 1���� ���Ѵ�.
select last_name
from employees
where last_name like 'K___';
-- K + 3���ڸ� ã�´�.

--����] �̸��� �ι�° ���ڰ� o�� ����� �̸��� ��ȸ�϶�.
select last_name
from employees
where last_name like '_o%';

select job_id
from employees;

select last_name, job_id
from employees
where job_id like 'IT\_%' escape '\';

select last_name, job_id
from employees
where job_id like 'I_\_%' escape '\';

select last_name, job_id
from employees
where job_id like 'IT[_%' escape '['; 

select last_name, job_id
from employees
where job_id like 'IT_%';

--����] ������ _R�� ���Ե� ����� �̸�, ������ ��ȸ�϶�.
select last_name, job_id
from employees
where job_id like '%\_R%' escape'\';


select employee_id, last_name, manager_id
from employees;

select last_name, manager_id
from employees
where manager_id = null;

-- is null ��ü�� �ϳ��� ��������
select last_name, manager_id
from employees
where manager_id is null;
--================================--
-- and �� &&�� ����.
select last_name, job_id, salary
from employees
where salary >= 5000 and job_id like '%IT%';

-- or �� ||�� ����.
select last_name, job_id, salary
from employees
where salary >= 5000 or job_id like '%IT%';
-----------------------

select last_name, job_id
from employees
where job_id in ('IT_PROG', 'SA_REP');
--not�� �������� ���Ѵ�.
select last_name, job_id
from employees
where job_id not in ('IT_PROG', 'SA_REP');

select last_name, salary
from employees
where salary not between 10000 and 15000;

select last_name, job_id
from employees
where job_id not like '%IT%';

select last_name, job_id
from employees
where commission_pct is not null;

--����] ������ 20000�޷� �̻� �޴� ���� ��, ������� �̸�, ������ ��ȸ
select last_name, salary
from employees
where not (manager_id is null and salary >= 20000);

--����] ������ $5000 �̻� $12000 �����̰�,
--      20���̳� 50�� �μ����� ���ϴ� ������� �̸�, ����, �μ���ȣ
select last_name, salary, department_id
from employees
where (salary between 5000 and 12000)and department_id in(20, 50);

select last_name, salary, department_id
from employees
where not((salary between 5000 and 12000)and department_id in(20, 50));

--����] �̸��� a�� e�� ���Ե� ������� �̸��� ��ȸ�϶�.
select last_name
from employees
where last_name like '%a%' and last_name like '%e%';

-- ����] ������ �����̴�. �׸���, ������ 2500, 3500�� �ƴ� ������� �̸�,����, ���� 
select last_name, job_id, salary
from employees
where commission_pct is not null and not(salary between 2500 and 3500);

select last_name, job_id, salary
from employees
where job_id like'SA%' and not(salary in( 2500, 3500));
