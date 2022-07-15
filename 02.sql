--레코드 고르기

select employee_id, last_name, department_id
from employees
where department_id = 90; 

-- department_id 의 필드값이 90 인것만 담는다.

select employee_id, last_name, department_id
from employees
where last_name = 'Whalen'; 

--도구 > 환경설정 > NLS에서 날짜형태를 변경가능
select employee_id, last_name, hire_date
from employees
where hire_date = '08/02/06'; 

select last_name, salary
from employees
where salary <= 3000;

--도구 > 환경설정 > 인출 > 고급 > 출력개수 변경
-- 출력행의 최대개수를 변경
select last_name, job_id
from employees
where job_id != 'IT_PROG';

-- 과제] 176번 사원의 사번, 이름과 부서번호를 조회하라.
select employee_id, last_name, department_id
from employees
where employee_id = 176;

--과제] $12,000 이상 버는 사원들의 이름,월급을 조회하라.
select last_name, salary
from employees
where salary >= 12000;

--범위를 가져오는 between a and b . a이상 b이하
select last_name, salary
from employees
where salary between 2500 and 3500;

-- between a and b .  문자도 포함이 된다.
select first_name, last_name, job_id
from employees
where last_name between 'King' and 'Smith';

--과제] 'King'사원의 first name, last name, 직업,월급을 조회하라.
select first_name, last_name, job_id, salary
from employees
where last_name = 'King';

select last_name, hire_date
from employees
where hire_date between '2002/01/01' and '2002/12/31';
--=================================--
-- 매니저 id가 100,101,201인 것을 출력
select employee_id, last_name, manager_id
from employees
where manager_id in (100, 101, 201);

-- 매니저id가 100이거나, 101이거나, 201이거나
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

-- 퍼스트네임의 첫글자가 s로 시작되는 애를 찾겠다.
select first_name
from employees
where first_name like 'S%';

-- 퍼스트네임의 마지막이 r로 끝나는 애를 찾겠다.
select first_name
from employees
where first_name like '%r';

--과제] first_name에 s가 포함된 사원들을 조회하라. 그냥 s가 포함되면 모두다.
select first_name
from employees
where first_name like '%s%';

--과제] 2005년에 입사한 사원들의 이름,입사일을 조회하세요.
select last_name, hire_date
from employees
where hire_date like '2005%';
-- like는 언제까지나 문자에서나 사용이 가능하다.

-- _1개가 미지의 값 1개를 말한다.
select last_name
from employees
where last_name like 'K___';
-- K + 3글자를 찾는다.

--과제] 이름의 두번째 글자가 o인 사원의 이름을 조회하라.
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

--과제] 직업에 _R이 포함된 사원의 이름, 직업을 조회하라.
select last_name, job_id
from employees
where job_id like '%\_R%' escape'\';


select employee_id, last_name, manager_id
from employees;

select last_name, manager_id
from employees
where manager_id = null;

-- is null 자체가 하나의 연산자임
select last_name, manager_id
from employees
where manager_id is null;
--================================--
-- and 는 &&와 같다.
select last_name, job_id, salary
from employees
where salary >= 5000 and job_id like '%IT%';

-- or 는 ||와 같다.
select last_name, job_id, salary
from employees
where salary >= 5000 or job_id like '%IT%';
-----------------------

select last_name, job_id
from employees
where job_id in ('IT_PROG', 'SA_REP');
--not은 여집합을 구한다.
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

--과제] 월급을 20000달러 이상 받는 사장 외, 사원들의 이름, 월급을 조회
select last_name, salary
from employees
where not (manager_id is null and salary >= 20000);

--과제] 월급이 $5000 이상 $12000 이하이고,
--      20번이나 50번 부서에서 일하는 사원들의 이름, 월급, 부서번호
select last_name, salary, department_id
from employees
where (salary between 5000 and 12000)and department_id in(20, 50);

select last_name, salary, department_id
from employees
where not((salary between 5000 and 12000)and department_id in(20, 50));

--과제] 이름에 a와 e가 포함된 사원들의 이름을 조회하라.
select last_name
from employees
where last_name like '%a%' and last_name like '%e%';

-- 과제] 직업이 영업이다. 그리고, 월급이 2500, 3500가 아닌 사원들의 이름,직업, 월급 
select last_name, job_id, salary
from employees
where commission_pct is not null and not(salary between 2500 and 3500);

select last_name, job_id, salary
from employees
where job_id like'SA%' and not(salary in( 2500, 3500));
