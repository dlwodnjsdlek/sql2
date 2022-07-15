-- single function
desc dual
select * from dual;

select lower('SQL Course') -- ��� �ҹ���
from dual;

select upper('SQL Course') -- ��� �빮��
from dual;

select initcap('SQL Course') -- ù��°�� �빮�ڷ� �ٲ�(������ �ҹ���)
from dual;

select last_name
from employees
where last_name = 'higgins';

select last_name
from employees
where last_name = 'Higgins';

select last_name
from employees
where lower(last_name) = 'higgins';

select concat ('Hello', 'World')-- ���� ���̱�
from dual;

select substr('HelloWirld', 2,5) -- ���� �����ϱ� (1H 2e 3l 4l 5o 6W 7i 8r 9l 10d)\
from dual; --  �� 2��°���� 5����

select length('Hello') -- ����ũ��
from dual;

select instr('Hello', 'l') -- ���� ��ġã��
from dual;

select instr('Hello', 'w') -- ���ڰ� ������ 0���� ���
from dual;

select lpad(salary, 5, '*') -- �������� ���̰� (�̰͵���, 5���ڷ�, ���ڸ��� *��ä���.
from employees;

select rpad(salary, 5, ' ') -- ���������� ���̰� (�̰͵���, 5���ڷ�, ���ڸ��� " "��ä���.
from employees;

select replace('JACK and JUE', 'J', 'BL')
from dual;

select trim('H' from 'Hello') -- trim�� �� ������ ����ȴ�.
from dual;

select trim('l' from 'Hello')
from dual;

select trim(' ' from ' Hello ')
from dual;
--����] �� query���� ' ' trim������ ������ Ȯ���� �� �ְ� ��ȸ�϶�.
select '|' || trim(' ' from ' Hello ') || '|'
from dual;

select trim(' Hello World ') -- �� ���� ��ĭ�� �������.
from dual;

select employee_id, concat(first_name, last_name) name,
    job_id, length(last_name), instr(last_name, 'a') "contains 'a'?"
from employees
where substr(job_id, 4) = 'PROG';

--����] �Ʒ����忡��, where ����  like�� refactoring �϶�.
select employee_id, concat(concat(first_name,' '), last_name) name,
    job_id, length(last_name), instr(last_name, 'a') "contains 'a'?"
from employees
where job_id like '%PROG';

--����] �̸��� J A M ���� �����ϴ� ������� �̸�, �̸��� ���ڼ��� ��ȸ�϶�.
-- �̸��� ù���ڴ� �빮�ڷ�, �ڴ� �ҹ��� ����Ѵ�.
select initcap(last_name), length(last_name)
from employees
where last_name like 'J%' or last_name like 'A%' or last_name like 'M%';

---------============----------------------==========================--------

select substr('HelloWorld' , 2,5)
from dual;
-- -1�� �ڿ��� ���� �д´�.
select substr('HelloWorld' , -1,2)
from dual;

select round(45.924, 2) -- 45.926�� �Ҽ��� 2�ڸ����� ���̰� �ݿø�
from dual;
select trunc(45.926, 2) -- ����
from dual;
select mod(45.926, 300)  -- ������
from dual;

select round(45.923, 0), round(45.923) -- �¿찡 ����
from dual;
select trunc(45.923, 0), trunc(45.923)
from dual;

--����] ������� �̸�,����,15.5%�λ�� ����(New Salary,����), �λ��
select last_name, salary, 
    round(1.155* salary)  "New Salary",
    round(salary *0.155) "Increase"
from employees;
--================================================--

select sysdate -- ���� ��¥
from dual;

select sysdate + 1 -- ����
from dual;
select sysdate - 1 -- ����
from dual;

select sysdate - sysdate -- ���� ��ĥ����
from dual;
select sysdate + sysdate -- ���ϴ°� ����
from dual;

select last_name, sysdate - hire_date -- �ټ��ϼ� ���ϱ�
from employees;

--����] �ټӳ���� ��ȸ�϶�
select last_name, trunc((sysdate - hire_date) / 365) "YEAR"
from employees
where department_id = 90;

--('2022/12/31'�� ��¥����, '2021/12/31'�� ���ڱ���)��� ������?
select months_between('2022/12/31', '2021/12/31')
from dual;

--('2022/07/14'�� ��¥����, 1���� ���ϸ�?)
select add_months ('2022/07/14', 1)
from dual;
--('2022/07/14'��¥���� ����ù��° �Ͽ���(1) ȭ2 ��3 ��4 ��5 ��6
select next_day('2022/07/14', 1)
from dual;
select next_day('2022/07/14', 'thursday')
from dual;
select next_day('2022/07/14', 'thu')
from dual;
--('2022/07/14' 7������ ����
select last_day('2022/07/14')
from dual;

--����]36���� �̻� ������ ������� ù �������� ��ȸ�϶�.
--         ������ �ſ� ���Ͽ� �����Ѵ�.
select last_name, last_day(hire_date)"First Salary"
from employees
where trunc(round(sysdate - hire_date)/365) >= 20;
--T
select last_name, last_day(hire_date)"First Salary"
from employees
where months_between(sysdate, hire_date) >= 12*20;

--����] ������� �̸�,���� �׷����� ��ȸ�϶�.
--      �׷����� $1000�� *�ϳ��� ǥ���Ѵ�.
select last_name,salary, lpad(trunc(salary/1000), salary/1000,'*')
from employees;
-- ���� ���� ���� ������������ �����϶�
select last_name, rpad(' ', salary / 1000 + 1, '*')
from employees
order by salary desc;

select last_name, hire_date
from employees
where department_id = 100
order by hire_date;