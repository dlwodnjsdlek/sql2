-- datatype conversion

--문자를 날짜로 변경
select hire_date
from employees
where hire_date = '2003/06/17';

--문자를 숫자로 변경
select salary
from employees
where salary = '7000';

-- 날짜를 문자로 변경
select hire_date || ''
from employees;

--  숫자를 문자로 변경
select salary || ''
from employees;

--===============================================--
-- FM (format model)
select to_char(hire_date)
from employees;

select to_char(sysdate, 'yyyy-mm-dd')
from dual;

-- 대문자로 썻기에 대문자로 출력된다. DDsp는 '일' day는 '요일'
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
--fill mode (스페이스바를 없애버림)
select to_char(hire_date, 'fmDD Month RR')
from employees;

--날짜를 문자로 바꿈 'd'는 요일
select to_char(sysdate, 'd'),
    to_char(sysdate, 'day')   
from dual;

--과제] 사원들의 이름,입사일,인사평가일을 조회하라.
--       인사평가일은 입사한지 3개월 후 첫번째 월요일이다.
--날짜는 YYYY.MM.DD로 표시한다.
select last_name, to_char(hire_date, 'YYYY.MM.DD')hire_date, 
    to_char(next_day(add_months(last_day(hire_date),3),2),'YYYY.MM.DD')Personnel_evaluation 
from employees;

--과제] 테이블을 월요일부터 오름차순 정렬하라.
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

select to_char(salary,'$99,999.99') -- 지정된 숫자만큼의 칸에 채움
from employees
where last_name = 'Ernst';
select to_char(salary,'$00,000.00') -- 빈공간을 0으로 채운다.
from employees
where last_name = 'Ernst';

select '|' || to_char(12.12, '9999.999') || '|'
from dual;
select '|' || to_char(12.12, '0000.000') || '|'
from dual;

--fm쓰면 빈칸 사라짐
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

--형식이 살짝 달라져도 다 맞아들어간다.
select last_name, hire_date
from employees
where hire_date = to_date('Sep 21, 2005', 'Mon         dd yy');

-- fx를 추가함으로 형식을 완벽히 맞춰야 한다.
select last_name, hire_date
from employees
where hire_date = to_date('Sep 21, 2005', 'fxMon         dd yy');
select last_name, hire_date
from employees
where hire_date = to_date('Sep 21, 2005', 'fxMon dd, yyyy');
--==============================================--

select to_number('1237')
from dual;

select to_number('1,237') -- 실행오류
from dual;
select to_number('1,237.12' , '9,999.99') -- 뒤에 형식을 만들어주니 실행됨
from dual;

--과제] <이름> earns <$,월급> monthly but wants <$,월급x3>. 로 조회하라.
select last_name || ' earns ' || 
    to_char(salary, 'fm$9,999,999') || 
    ' monthly but wants ' ||
    to_char(salary*3, 'fm$9,999,999') || '.'
from employees;

--=============================--
--null !중요

-- 어딜가나 null은 null이다
select to_char(null), to_number(null), to_date(null)
from dual;

-- nvl(조사할 값 , 조사할 값을 바꿀값)
-- nvl(a , b) 여기서 a와 b의 같은 타입을 넣어야한다.
-- 왜? 하나의 칼럼을 구성하기 때문이다. // 레코드는 제각각이지만 칼럼은 같은 타입
select nvl(null,0)
from dual;

select job_id, nvl(commission_pct, 0)
from employees;

--과제] 사원들의 이름,직업,연봉을 조회하라
select last_name, job_id, salary*12, 
    salary *(1 + nvl(commission_pct, 0)) *12 "연봉" 
from employees
order by "연봉" desc;

select last_name, job_id,
    12 * (salary + (salary * nvl(commission_pct,0))) "연봉" 
from employees;

--nvl2(파라미터1 , 2 ,3) 파라미터1이 있냐?, 있다=2출력, 없다=3출력) 
select job_id, nvl2(commission_pct, 'SAL+COMM', 'SAL')
from employees;

--    nullif(파라미터1, 파라미터2) return값은 null 아니면 파라미터1이다. 
select first_name, last_name,
    nullif(length(first_name),length(last_name))
from employees;

-- coalesce 처음으로 null이 아닌값을 리턴한다.
select last_name,
    coalesce(to_char(commission_pct), to_char(manager_id), 'None')
from employees;

--과제] 사원들의 이름, 커미션율을 조회하라.
--      커미션이 없으면, No Commission을 표시한다.
select last_name, nvl(to_char(commission_pct), 'No Commission')
from employees;

select last_name, nvl2(commission_pct, 
    to_char(commissiopn_pct), 'No Commission')
from employees;
    --이거 안되네
--=====================================--
--

select last_name, salary,
    decode(trunc(salary / 2000),  -- 기준값
        0, 0.00,  -- 비교값, 리턴값
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

--과제] 사원들의 직업, 직업별 등급을 조회하라.
-- IT_PROG  A
-- AD_PRES  B
-- ST_MAN   C
-- ST_CLERK D
-- 기본등급은 null이다.
select job_id, decode((job_id),
    'IT_PROG',  'A',
    'AD_PRES',  'B',
    'ST_MAN',   'C',
    'ST_CLERK', 'D') grade
from employees;

-- case 파라미터 when 조건문 then 리턴문
-- else 나머지 end
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
from employees; -- error salart와 조건 타입값 불일치

select case salary when 1 then '1'
                    when 2 then '2'
                    else 0
        end garde
from employees; -- error 리턴끼리 타입값 불일치

select last_name, salary,
    case when salary < 5000 then 'low'
        when salary < 10000 then 'medium'
        when salary < 20000 then 'high'
        else 'good'
    end grade
from employees;

--과제] 이름,입사일,요일을 월요일부터 요일순으로 조회하라.
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

--과제] 2005년 이전에 입사한 사원들에게 100만원 사품권,
--      2005년 이후 입사 10만원 상품권 지급
--      사원들의 이름,입사일,상품권금액을 조회하라

select last_name, hire_date, 
    case when hire_date < '2006/01/01' then '100만원'
         else '10만원'
    end "Gift Card"
from employees
order by hire_date;