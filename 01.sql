select * from departments;

select department_id, location_id
from departments; 

select location_id, department_id --select원하는 데이터
from departments;                 --from ~에서 가져와라

desc departments -- 구조확인 desc

--과제] employees 구조를 확인하라.
desc employees

select last_name, salary, salary + 300
from employees;

-- 과제] 사원들의 월급,연봉을 조회하라.
select salary, salary * 12
from employees;

select last_name, salary, 12* salary +100
from employees;
--java와 같이 연산자에 순서가 있다.
select last_name, salary, 12* (salary +100)
from employees;

select last_name, salary, 100 + salary *12
from employees;

select last_name, job_id, commission_pct
from employees;
--과제] 커미션을 고려해서 사원의 이름, 직업명, 연봉을 조회하라
select last_name, job_id, 12 * salary + (12 * salary * commission_pct) 
from employees;

-- 데이터의 이름을(별명) 바꿔줄 수 있다. // 별명은 대문자로 썻지만, 출력은 대문자로 나온다.
select last_name as name, commission_pct comm
from employees;

-- 데이터의 이름을 대소문자 로 바꿔주기 위해서는 ""안에 넣어주면 된다.
select last_name "Name", salary * 12 " Annual Salary"
from employees;

--과제] 사원들의 사번, 이름, 직업,입사일을 조회하라.
--      입사일 칼럼명은 STARTDATE로 한다.
select employee_id, last_name, job_id, hire_date startdate
from employees;

--과제] 사원들의 사번(Emp #), 이름(Name), 직업(Job), 입사일(Hire Date)를 조회하라.
select employee_id "Emp #", last_name "Name", job_id "Jab", hire_date "Hire Date"
from employees;

-- 하나의 칼럼으로 만들기 ||(붙이기 연산자)
-- 붙이기 연산자는 숫자를 글자로 만들어서 읽게 한다.
select last_name || job_id
from employees;

--가독성을 높이기위해 select안에 '글자' 글자를 넣을 수 있다.
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

--과제] 사원들의 '이름, 직업' (Emp and Title)을 조회하라.
select last_name || ', ' || job_id "Emp and Title"
from employees;