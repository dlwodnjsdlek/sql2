select hire_date || ''--날짜를 문자로 변경
from employees;

select salary || ''--숫자를 문자로 변경
from employees;

--============FM (format model)================--
select to_char(hire_date)--hire_date를 문자형으로
from employees;

select 
    to_char(sysdate, 'yy-mm-dd')"날짜 형식변경", --날짜 형식변경
    to_char(sysdate,'Year Month Ddsp Day(Dy)')"년 월 일 요일", -- 년 월 일 요일(요일)
    to_char(sysdate,'hh24:mi:ss am')""--
from dual;

select 
    to_char(sysdate, 'yy-mm-dd') "날짜 형식변경",
    to_char(sysdate, 'Year Month Ddsp Day(Dy)')"년 월 일 요일",
    to_char(sysdate, 'hh24:mi:ss am')"시24: 분: 초: 오전오후",
    to_char(sysdate, 'DD "of" Month')"일 of 월",
    to_char(sysdate, 'd')"요일 숫자",
    to_char(sysdate, 'day')"요일",
    to_char(sysdate,'fmDD Month RR')"fill mode" -- fm(fillmode) 중간에 스페이스바 없앰
from dual;
   
select
    '|' || to_char(salary, '99,999.99') || '|' "빈칸에 공백",
    '|' || to_char(salary, '00,000.00') || '|' "빈칸에 0채워짐",
    '|' || to_char(salary, 'fm99,999.99') || '|' "fm빈칸 사라짐",
    '|' || to_char(salary, 'fm00,000.00') || '|' "0으로 빈칸이 없음"
from employees;


select 
    nvl(commission_pct, 0)"nvl(조건문, 리턴값)", -- 조건 불충족시 리턴값 출력
    nvl2(commission_pct, 'O', 'X')"nal2(조건,true,false)", -- 조건맞으면O출력 틀리면X출력 
    nullif(length(first_name),length(last_name)) "nullif", --nullif(1,2) 값이 같으면null / 틀리면 1출력
    coalesce(to_char(commission_pct), to_char(manager_id), 'None')"coalesce",
--   ㄴ coalsece(칼럼1, 칼럼2,... 칼럼n)
--       칼럼1 !null 리턴 1 -> 칼럼2 !null 리턴 2 -> ... -> 칼럼n !null 리턴n 
    decode(salary, -- decode(조건문,
        9000 , 9,   --   비교, 리턴,
        10000 ,10,  --   비교, 리턴,
        11000 ,11, 
        12000 ,12,  -- ...
        13000 ,13,
                0) "decode", --  else 값) 
    case when job_id = 'IT_PROG' then 999999 * salary -- case when 조건문 then 리턴문
    else salary end "case when then",                 -- else 리턴문 end 
    
    case job_id when 'IT_PROG' then 0 * salary  -- case 칼럼 when 조건 then 리턴
    else salary end "case when then2"           -- else 리턴 end
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
