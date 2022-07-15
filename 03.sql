-- single function
desc dual
select * from dual;

select lower('SQL Course') -- 모두 소문자
from dual;

select upper('SQL Course') -- 모두 대문자
from dual;

select initcap('SQL Course') -- 첫번째를 대문자로 바꿈(나머지 소문자)
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

select concat ('Hello', 'World')-- 글자 붙이기
from dual;

select substr('HelloWirld', 2,5) -- 글자 추출하기 (1H 2e 3l 4l 5o 6W 7i 8r 9l 10d)\
from dual; --  ㄴ 2번째부터 5글자

select length('Hello') -- 글자크기
from dual;

select instr('Hello', 'l') -- 글자 위치찾기
from dual;

select instr('Hello', 'w') -- 글자가 없으면 0으로 출력
from dual;

select lpad(salary, 5, '*') -- 왼쪽으로 붙이고 (이것들을, 5글자로, 빈자리는 *로채운다.
from employees;

select rpad(salary, 5, ' ') -- 오른쪽으로 붙이고 (이것들을, 5글자로, 빈자리는 " "로채운다.
from employees;

select replace('JACK and JUE', 'J', 'BL')
from dual;

select trim('H' from 'Hello') -- trim은 양 끝에만 적용된다.
from dual;

select trim('l' from 'Hello')
from dual;

select trim(' ' from ' Hello ')
from dual;
--과제] 위 query에서 ' ' trim됐음을 눈으로 확인할 수 있게 조회하라.
select '|' || trim(' ' from ' Hello ') || '|'
from dual;

select trim(' Hello World ') -- 양 끝의 빈칸만 사라진다.
from dual;

select employee_id, concat(first_name, last_name) name,
    job_id, length(last_name), instr(last_name, 'a') "contains 'a'?"
from employees
where substr(job_id, 4) = 'PROG';

--과제] 아래문장에서, where 절을  like로 refactoring 하라.
select employee_id, concat(concat(first_name,' '), last_name) name,
    job_id, length(last_name), instr(last_name, 'a') "contains 'a'?"
from employees
where job_id like '%PROG';

--과제] 이름이 J A M 으로 시작하는 사원들의 이름, 이름의 글자수를 조회하라.
-- 이름은 첫글자는 대문자로, 뒤는 소문자 출력한다.
select initcap(last_name), length(last_name)
from employees
where last_name like 'J%' or last_name like 'A%' or last_name like 'M%';

---------============----------------------==========================--------

select substr('HelloWorld' , 2,5)
from dual;
-- -1은 뒤에서 부터 읽는다.
select substr('HelloWorld' , -1,2)
from dual;

select round(45.924, 2) -- 45.926을 소숫점 2자리까지 보이게 반올림
from dual;
select trunc(45.926, 2) -- 내림
from dual;
select mod(45.926, 300)  -- 나머지
from dual;

select round(45.923, 0), round(45.923) -- 좌우가 같음
from dual;
select trunc(45.923, 0), trunc(45.923)
from dual;

--과제] 사원들의 이름,월급,15.5%인상된 월급(New Salary,정수), 인상액
select last_name, salary, 
    round(1.155* salary)  "New Salary",
    round(salary *0.155) "Increase"
from employees;
--================================================--

select sysdate -- 오늘 날짜
from dual;

select sysdate + 1 -- 내일
from dual;
select sysdate - 1 -- 어제
from dual;

select sysdate - sysdate -- 빼서 며칠인지
from dual;
select sysdate + sysdate -- 더하는건 없네
from dual;

select last_name, sysdate - hire_date -- 근속일수 구하기
from employees;

--과제] 근속년수를 조회하라
select last_name, trunc((sysdate - hire_date) / 365) "YEAR"
from employees
where department_id = 90;

--('2022/12/31'이 날짜에서, '2021/12/31'이 날자까지)몇개월 지났니?
select months_between('2022/12/31', '2021/12/31')
from dual;

--('2022/07/14'이 날짜에서, 1개월 더하면?)
select add_months ('2022/07/14', 1)
from dual;
--('2022/07/14'날짜에서 다음첫번째 일요일(1) 화2 수3 목4 금5 토6
select next_day('2022/07/14', 1)
from dual;
select next_day('2022/07/14', 'thursday')
from dual;
select next_day('2022/07/14', 'thu')
from dual;
--('2022/07/14' 7월달의 말일
select last_day('2022/07/14')
from dual;

--과제]36개월 이상 재직한 사원들의 첫 월급일을 조회하라.
--         월급을 매월 말일에 지급한다.
select last_name, last_day(hire_date)"First Salary"
from employees
where trunc(round(sysdate - hire_date)/365) >= 20;
--T
select last_name, last_day(hire_date)"First Salary"
from employees
where months_between(sysdate, hire_date) >= 12*20;

--과제] 사원들의 이름,월급 그래프를 조회하라.
--      그래프는 $1000당 *하나를 표시한다.
select last_name,salary, lpad(trunc(salary/1000), salary/1000,'*')
from employees;
-- 위를 월급 기준 내림차순으로 정렬하라
select last_name, rpad(' ', salary / 1000 + 1, '*')
from employees
order by salary desc;

select last_name, hire_date
from employees
where department_id = 100
order by hire_date;