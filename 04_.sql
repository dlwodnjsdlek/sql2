select hire_date || ''--��¥�� ���ڷ� ����
from employees;

select salary || ''--���ڸ� ���ڷ� ����
from employees;

--============FM (format model)================--
select to_char(hire_date)--hire_date�� ����������
from employees;

select 
    to_char(sysdate, 'yy-mm-dd')"��¥ ���ĺ���", --��¥ ���ĺ���
    to_char(sysdate,'Year Month Ddsp Day(Dy)')"�� �� �� ����", -- �� �� �� ����(����)
    to_char(sysdate,'hh24:mi:ss am')""--
from dual;

select 
    to_char(sysdate, 'yy-mm-dd') "��¥ ���ĺ���",
    to_char(sysdate, 'Year Month Ddsp Day(Dy)')"�� �� �� ����",
    to_char(sysdate, 'hh24:mi:ss am')"��24: ��: ��: ��������",
    to_char(sysdate, 'DD "of" Month')"�� of ��",
    to_char(sysdate, 'd')"���� ����",
    to_char(sysdate, 'day')"����",
    to_char(sysdate,'fmDD Month RR')"fill mode" -- fm(fillmode) �߰��� �����̽��� ����
from dual;
   
select
    '|' || to_char(salary, '99,999.99') || '|' "��ĭ�� ����",
    '|' || to_char(salary, '00,000.00') || '|' "��ĭ�� 0ä����",
    '|' || to_char(salary, 'fm99,999.99') || '|' "fm��ĭ �����",
    '|' || to_char(salary, 'fm00,000.00') || '|' "0���� ��ĭ�� ����"
from employees;


select 
    nvl(commission_pct, 0)"nvl(���ǹ�, ���ϰ�)", -- ���� �������� ���ϰ� ���
    nvl2(commission_pct, 'O', 'X')"nal2(����,true,false)", -- ���Ǹ�����O��� Ʋ����X��� 
    nullif(length(first_name),length(last_name)) "nullif", --nullif(1,2) ���� ������null / Ʋ���� 1���
    coalesce(to_char(commission_pct), to_char(manager_id), 'None')"coalesce",
--   �� coalsece(Į��1, Į��2,... Į��n)
--       Į��1 !null ���� 1 -> Į��2 !null ���� 2 -> ... -> Į��n !null ����n 
    decode(salary, -- decode(���ǹ�,
        9000 , 9,   --   ��, ����,
        10000 ,10,  --   ��, ����,
        11000 ,11, 
        12000 ,12,  -- ...
        13000 ,13,
                0) "decode", --  else ��) 
    case when job_id = 'IT_PROG' then 999999 * salary -- case when ���ǹ� then ���Ϲ�
    else salary end "case when then",                 -- else ���Ϲ� end 
    
    case job_id when 'IT_PROG' then 0 * salary  -- case Į�� when ���� then ����
    else salary end "case when then2"           -- else ���� end
from employees;


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

select last_name, hire_date, to_char(hire_date, 'fmd')day
from employees
order by case day
        when '2' then 1
        when '3' then 2
        when '4' then 3
        when '5' then 4
        when '6' then 5
        when '7' then 6
        when '1' then 7
    end;
