--join // 레코드를 결합시킴

select department_id, department_name, location_id
from departments;

select location_id, city
from locations;


--equi join // 조인 대상 테이블에서 공통인 열을 통해 같은 값을 가지는 행을 연결하여 결과를 생성하는 조인 방법
--
select department_id, department_name, location_id, city
from departments natural join locations;

select department_id, department_name, location_id, city
from departments natural join locations
where department_id in (20,50);
-- 양쪽 테이블의 레코드를 비교해서 공통칼럼을 찾는다.
-- 공통칼럼의 필드값이 같아야한다.

-- 조인이되는 테이블을 보면
-- 한개는 프라이머리키(를복사해서) 한개에 폴인키(붙여넣기)
-- 프라이머리키 테이블내에서 유일한 값을 가지고 제일 중요한 칼럼
-- 양쪽필드의 데이터 타입은 같아야한다.

--natural join 
-- 장점 개발이 편하다
-- 단점

select employee_id, last_name, department_id, location_id
from employees join departments
using (department_id);

--과제] 위에서 누락된 1인의 이름, 부서번호를 조회하라
select last_name, department_id
from employees
where department_id is null;
--과제] 위에서 누락된 1인의 이름, 부서번호를 조회하라
select last_name, nvl2(department_id, 'O','X')
from employees;

select employee_id, last_name, department_id, location_id
from employees join departments
using (department_id);

select employee_id, last_name, department_id, location_id
from employees natural join departments;
 
 select locations.city, departments.department_name
 from locations join departments
 using (location_id)
 where location_id = 1400;
 
 select l.city, d.department_name
 from locations l join departments d -- 별명넣기 가능
 using (location_id)
 where location_id = 1400;
 
  select l.city, d.department_name, d.location_id --error] using 칼럼에는 접두사를 못붙인다.
 from locations l join departments d 
 using (location_id)
 where d.location_id = 1400;--error] using 칼럼에는 접두사를 못붙인다.
 
 select e.last_name, d.department_name
 from employees e join departments d
 using (department_id)
 where d.manager_id = 100;
 --===============================================--
 select e.employee_id, e.last_name, e.department_id,
    d.department_id, d.location_id
from employees e join departments d
on (e.department_id = d.department_id);
 
select e.employee_id, city, department_name
from employees e join departments d
on e.department_id = d. department_id
join locations l
on d.location_id = l.location_id;
--과제]위 문장을, using으로 refactoring하라.
select e.employee_id, city, department_name
from employees e join departments d
using (department_id)
join locations l
using (location_id);
 
select e.employee_id, e.last_name, e.department_id,
    d.department_id, d.location_id
from employees e join departments d
on e.department_id = d.department_id
where e.manager_id = 149;

--과제] Toronto 에 위치한 부서에서 일하는 사원들의
--      이름,직업,부서번호,부서명을 조회하라.
select e.last_name, e.job_id, d.department_name, l.city
from employees e join departments d
using (department_id)
join locations l
using (location_id)
where city = 'Toronto';

--IT_PROG, 4200<= salary <= 9000
-- 출력값중4000 10000 있다.
select e.last_name, e.salary, e.job_id
from employees e join jobs j
on e.salary between j.min_salary and j.max_salary
    and j.job_id = 'IT_PROG';
--이거 물어보기
--=============================================--    
-- self join
select worker.last_name emp, manager.last_name mgr
from employees worker join employees manager
on worker.manager_id = manager.employee_id;

select worker.last_name emp, last_name mgr -- ERROR] self join에는 접두사가 필수이다.
from employees worker join employees manager -- 모든 칼럼에 필수 2개의 칼럼인척
on manager_id = employee_id; -- ERROR] self join에는 접두사가 필수이다.

--과제] 같은 부서에서 일하는 사원들의 이름, 부서번호, 동료의 이름을 조회하라.
select my.last_name, my.department_id, friend.last_name
from employees my join employees friend
on my.department_id = friend.department_id
where my.employee_id <> friend.employee_id -- 다르다 연산자 <>
order by 2,1,3;

--과제] Davies 보다 후에 입사한 사원들의 이름,입사일을 조회하라.
--      
select e.last_name, c.last_name, c.hire_date
from hire_date e join hire_date c
on e.hire_date = c.hire_date
where e.hire_date 'Davies' < c.hire_date;

select last_name, hire_date
from employees
where last_name = 'Davies' > ;