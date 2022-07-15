desc dual

select * from dual;

select lower('LOWER'),
    upper('upper'),
    initcap('lower UPPER')
from dual;

select last_name
from employees
where last_name = 'higgins'; -- ���� Higgins���� ��¾ȵ�.
select last_name
from employees
where lower(last_name) = 'higgins'; --lower�� ���� higgins�� �ٲ�

select concat('�ȳ�?', ' ģ��')" ", -- ���̱�
    substr('�ȳ��ϼ���. ������Դϴ�.', 4,5)" ", -- 4��°���� 5��
    substr('�ȳ��ϼ���?', -3,3) " ",-- -3���� �ڷ� 3��
    length('�ȳ��ϼ���.')" ", -- ���� ����
    instr('�ȳ��ϼ���.', '��')" ", --���� ��ġã��
    instr('�ȳ��ϼ���.', '��')" ",--���� ��ġã�� ���±��ڴ� ��ġ�� 0���� ǥ��  
    replace('Jack and Jue', 'J', 'Bl')" ",
    '|' || trim(' ' from ' Hello ') || '|' " "--trim�糡�� Ȯ�� ����.
from dual;

select lpad(salary, 5, '*'), --���ʿ� ���̰�(�̰͵���, 5���ڷ�, ���ڸ��� *��)
    rpad(salary, 5, '*')
from employees;

select round(45.926, 2) "�ݿø�", --0.001 �ݿø�
    trunc(45.926,2) "����", --0.001 ����
    round(45.926) " ", --0.1���� �ݿø� 
    ceil(45.924) "�ø�", --
    mod(45.926, 22) "������" -- 22�� ������ ������
from dual;

select sysdate "����" ,
    sysdate + 1 "����" ,
    sysdate - 1 "����" ,
    sysdate - 1996/07/05 "��¥���� ���Ⱑ��", --
    months_between('2022/12/31', '2021/12/31') "����", -- ��¥ ���̿� ���� ���
    add_months('2022/07/14', 1) "�������ϱ�", --1���� ���ϱ�
    next_day ('2022/07/14',1 )"���� ã��", -- 1�Ͽ��� 2������~ 7����� ���� ���ϴ� ������ ���
    last_day('2022/07/14')"���� ��ĥ?" -- ������ ���
from dual;

--��¥������ �����ϱ�
select last_name, hire_date
from employees
where department_id = 100
order by hire_date;
--��¥ ���� �����ϱ�
select last_name, hire_date
from employees
where department_id = 100
order by hire_date desc;





