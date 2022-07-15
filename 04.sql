-- datatype conversion

--���ڸ� ��¥�� ����
select hire_date
from employees
where hire_date = '2003/06/17';

--���ڸ� ���ڷ� ����
select salary
from employees
where salary = '7000';

-- ��¥�� ���ڷ� ����
select hire_date || ''
from employees;

--  ���ڸ� ���ڷ� ����
select salary || ''
from employees;

--===============================================--
-- FM (format model)
select to_char(hire_date)
from employees;

select to_char(sysdate, 'yyyy-mm-dd')
from dual;

-- �빮�ڷ� ���⿡ �빮�ڷ� ��µȴ�. DDsp�� '��' day�� '����'
select to_char(sysdate, 'YEAR MONTH DDsp DAY(DY)')
from dual;

select to_char(sysdate, 'Year Month Ddsp Day(Dy)')
from dual;

select to_char(sysdate, 'hh24:mi:ss am')
from dual;

select to_char(sysdate, 'DD "of" Month')
from dual;

select to_char(hire_date, 'DD Month RR')
from employees;
--fill mode (�����̽��ٸ� ���ֹ���)
select to_char(hire_date, 'fmDD Month RR')
from employees;

--��¥�� ���ڷ� �ٲ� 'd'�� ����
select to_char(sysdate, 'd'),
    to_char(sysdate, 'day')   
from dual;

--����] ������� �̸�,�Ի���,�λ������� ��ȸ�϶�.
--       �λ������� �Ի����� 3���� �� ù��° �������̴�.
--��¥�� YYYY.MM.DD�� ǥ���Ѵ�.
select last_name, to_char(hire_date, 'YYYY.MM.DD')hire_date, 
    to_char(next_day(add_months(last_day(hire_date),3),2),'YYYY.MM.DD')Personnel_evaluation 
from employees;

--����] ���̺��� �����Ϻ��� �������� �����϶�.
select last_name, hire_date, 
    to_char(hire_date, 'day'), 
    to_char(hire_date,'d')
from employees;

select last_name, hire_date, 
    to_char(hire_date, 'day')
from employees
order by to_char((hire_date - 1),'d');

--==========================--

select to_char(salary)
from employees;

select to_char(salary,'$99,999.99') -- ������ ���ڸ�ŭ�� ĭ�� ä��
from employees
where last_name = 'Ernst';
select to_char(salary,'$00,000.00') -- ������� 0���� ä���.
from employees
where last_name = 'Ernst';

select '|' || to_char(12.12, '9999.999') || '|'
from dual;
select '|' || to_char(12.12, '0000.000') || '|'
from dual;

--fm���� ��ĭ �����
select '|' || to_char(12.12, 'fm9999.999') || '|'
from dual;
select '|' || to_char(12.12, 'fm0000.000') || '|'
from dual;

select to_char(1237, 'L9999')
from dual;
--======================================--

select last_name, hire_date
from employees
where hire_date = to_date('Sep 21, 2005', 'Mon dd, yyyy');

--������ ��¦ �޶����� �� �¾Ƶ���.
select last_name, hire_date
from employees
where hire_date = to_date('Sep 21, 2005', 'Mon         dd yy');

-- fx�� �߰������� ������ �Ϻ��� ����� �Ѵ�.
select last_name, hire_date
from employees
where hire_date = to_date('Sep 21, 2005', 'fxMon         dd yy');
select last_name, hire_date
from employees
where hire_date = to_date('Sep 21, 2005', 'fxMon dd, yyyy');
--==============================================--

select to_number('1237')
from dual;

select to_number('1,237') -- �������
from dual;
select to_number('1,237.12' , '9,999.99') -- �ڿ� ������ ������ִ� �����
from dual;

--����] <�̸�> earns <$,����> monthly but wants <$,����x3>. �� ��ȸ�϶�.
select last_name || ' earns ' || 
    to_char(salary, 'fm$9,999,999') || 
    ' monthly but wants ' ||
    to_char(salary*3, 'fm$9,999,999') || '.'
from employees;

--=============================--
--null !�߿�

-- ������� null�� null�̴�
select to_char(null), to_number(null), to_date(null)
from dual;

-- nvl(������ �� , ������ ���� �ٲܰ�)
-- nvl(a , b) ���⼭ a�� b�� ���� Ÿ���� �־���Ѵ�.
-- ��? �ϳ��� Į���� �����ϱ� �����̴�. // ���ڵ�� ������������ Į���� ���� Ÿ��
select nvl(null,0)
from dual;

select job_id, nvl(commission_pct, 0)
from employees;

--����] ������� �̸�,����,������ ��ȸ�϶�
select last_name, job_id, salary*12, 
    salary *(1 + nvl(commission_pct, 0)) *12 "����" 
from employees
order by "����" desc;

select last_name, job_id,
    12 * (salary + (salary * nvl(commission_pct,0))) "����" 
from employees;

--nvl2(�Ķ����1 , 2 ,3) �Ķ����1�� �ֳ�?, �ִ�=2���, ����=3���) 
select job_id, nvl2(commission_pct, 'SAL+COMM', 'SAL')
from employees;

--    nullif(�Ķ����1, �Ķ����2) return���� null �ƴϸ� �Ķ����1�̴�. 
select first_name, last_name,
    nullif(length(first_name),length(last_name))
from employees;

-- coalesce ó������ null�� �ƴѰ��� �����Ѵ�.
select last_name,
    coalesce(to_char(commission_pct), to_char(manager_id), 'None')
from employees;

--����] ������� �̸�, Ŀ�̼����� ��ȸ�϶�.
--      Ŀ�̼��� ������, No Commission�� ǥ���Ѵ�.
select last_name, nvl(to_char(commission_pct), 'No Commission')
from employees;

select last_name, nvl2(commission_pct, 
    to_char(commissiopn_pct), 'No Commission')
from employees;
    --�̰� �ȵǳ�
--=====================================--
--

select last_name, salary,
    decode(trunc(salary / 2000),  -- ���ذ�
        0, 0.00,  -- �񱳰�, ���ϰ�
        1, 0.09,
        2, 0.20,
        3, 0.30,
        4, 0.40,
        5, 0.42,
        6, 0.44,
            0.45) tax_rate
from employees;

select decode(salary, 'a', 1)
from employees;

select last_name, 
    decode(last_name, '%a%', 1, 0)
from employees;

select decode(job_id, 1, 1)
from employees;

select decode(hire_date, 'a', 1)
from employees;

select decode(hire_date, 1, 1)
from employees;

--����] ������� ����, ������ ����� ��ȸ�϶�.
-- IT_PROG  A
-- AD_PRES  B
-- ST_MAN   C
-- ST_CLERK D
-- �⺻����� null�̴�.
select job_id, decode((job_id),
    'IT_PROG',  'A',
    'AD_PRES',  'B',
    'ST_MAN',   'C',
    'ST_CLERK', 'D') grade
from employees;

-- case �Ķ���� when ���ǹ� then ���Ϲ�
-- else ������ end
select last_name, job_id, salary,
    case job_id when 'IT_PROG' then 1.10 * salary
                when 'AD_PRES' then 1.05 * salary
    else salary end revisod_salary
from employees;

select case job_id when '1' then 1
                    when '2' then 2
                    else 0
        end garde
from employees;

select department_id, 
    case department_id when 90 then 1
                      when 100 then 2
                     else 0
        end garde
from employees;


select case salary when 1 then '1'
                    when 2 then '2'
                    else '0'
        end garde
from employees;

select case salary when '1' then '1'
                    when '2' then '2'
                    else '0'
        end garde
from employees; -- error salart�� ���� Ÿ�԰� ����ġ

select case salary when 1 then '1'
                    when 2 then '2'
                    else 0
        end garde
from employees; -- error ���ϳ��� Ÿ�԰� ����ġ

select last_name, salary,
    case when salary < 5000 then 'low'
        when salary < 10000 then 'medium'
        when salary < 20000 then 'high'
        else 'good'
    end grade
from employees;

--����] �̸�,�Ի���,������ �����Ϻ��� ���ϼ����� ��ȸ�϶�.
select last_name, hire_date || ' ' || to_char(hire_date, 'day') hire_date, 
    case to_char(hire_date, 'd') when '1' then '7'
                                 when '2' then '1'
                                 when '3' then '2'
                                 when '4' then '3'
                                 when '5' then '4'
                                 when '6' then '5'
                                 when '7' then '6'
    end day
from employees
order by  day;
--T
select last_name, hire_date, to_char(hire_date, 'fmday')day
from employees
order by case day
        when 'monday' then 1
        when 'tuesday' then 2
        when 'wednesday' then 3
        when 'thursday' then 4
        when 'friday' then 5
        when 'saturday' then 6
        when 'sunday' then 7
    end;

--����] 2005�� ������ �Ի��� ����鿡�� 100���� ��ǰ��,
--      2005�� ���� �Ի� 10���� ��ǰ�� ����
--      ������� �̸�,�Ի���,��ǰ�Ǳݾ��� ��ȸ�϶�

select last_name, hire_date, 
    case when hire_date < '2006/01/01' then '100����'
         else '10����'
    end "Gift Card"
from employees
order by hire_date;