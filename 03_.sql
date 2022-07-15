desc dual

select * from dual;

select lower('LOWER'),
    upper('upper'),
    initcap('lower UPPER')
from dual;

select last_name
from employees
where last_name = 'higgins'; -- 값이 Higgins여서 출력안됨.
select last_name
from employees
where lower(last_name) = 'higgins'; --lower로 값을 higgins로 바꿈

select concat('안녕?', ' 친구')" ", -- 붙이기
    substr('안녕하세요. 이재원입니다.', 4,5)" ", -- 4번째부터 5개
    substr('안녕하세요?', -3,3) " ",-- -3부터 뒤로 3개
    length('안녕하세요.')" ", -- 글자 개수
    instr('안녕하세요.', '하')" ", --글자 위치찾기
    instr('안녕하세요.', '없')" ",--글자 위치찾기 없는글자는 위치가 0으로 표현  
    replace('Jack and Jue', 'J', 'Bl')" ",
    '|' || trim(' ' from ' Hello ') || '|' " "--trim양끝만 확인 삭제.
from dual;

select lpad(salary, 5, '*'), --왼쪽에 붙이고(이것들을, 5글자로, 빈자리는 *로)
    rpad(salary, 5, '*')
from employees;

select round(45.926, 2) "반올림", --0.001 반올림
    trunc(45.926,2) "내림", --0.001 내림
    round(45.926) " ", --0.1에서 반올림 
    ceil(45.924) "올림", --
    mod(45.926, 22) "나머지" -- 22로 나누고 나머지
from dual;

select sysdate "오늘" ,
    sysdate + 1 "내일" ,
    sysdate - 1 "어제" ,
    sysdate - 1996/07/05 "날짜끼리 빼기가능", --
    months_between('2022/12/31', '2021/12/31') "개월", -- 날짜 사이에 월만 계산
    add_months('2022/07/14', 1) "개월더하기", --1개월 더하기
    next_day ('2022/07/14',1 )"요일 찾기", -- 1일요일 2월요일~ 7토요일 다음 원하는 요일을 출력
    last_day('2022/07/14')"월말 며칠?" -- 월말을 출력
from dual;

--날짜순으로 정렬하기
select last_name, hire_date
from employees
where department_id = 100
order by hire_date;
--날짜 역순 정렬하기
select last_name, hire_date
from employees
where department_id = 100
order by hire_date desc;





