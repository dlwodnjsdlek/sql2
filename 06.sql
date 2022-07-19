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
 where d.location_id = 1400;--error] using에 사용된 칼럼에는 접두사를 못붙인다.
 
 select e.last_name, d.department_name
 from employees e join departments d
 using (department_id)
 where d.manager_id = 100;
 --===============================================--
 -- using -> on
 
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

-- none equi join // =이 아니라 다른 값을 쓰면 none이다 
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
select c.last_name, c.hire_date
from employees e join employees c
on e.last_name = 'Davies'
    and e.hire_date < c.hire_date
order by hire_date;

--과제] 매니저보다 먼저 입사한 사원들의 이름, 입사일, 매니저명 매니저 입사일을 조회하라.
select e.last_name, e.hire_date, e.manager_id,
        m.employee_id, m.last_name, m.hire_date
from employees e join employees m
on e.manager_id = m.employee_id
    and e.hire_date < m.hire_date;
  
--=====================================--
--outer join 밖에있는걸 조인하라

select e.last_name, e.department_id, d.department_name
from employees e join departments d
on e.department_id = d.department_id;

-- 사원중 department_id가 없는 인원을 추가 (조인되지 않은 값까지 추가
select e.last_name, e.department_id, d.department_name
from employees e left outer join departments d
on e.department_id = d.department_id;

-- departments중 사원이 없는 부서까지 추가
select e.last_name, e.department_id, d.department_name
from employees e right outer join departments d
on e.department_id = d.department_id;

-- 부서가 없는직원과, 직원이 없는 부서 까지 모두 추가
select e.last_name, e.department_id, d.department_name
from employees e full outer join departments d
on e.department_id = d.department_id;

--과제] 사원들의 이름,사번,매니저명,매니저의 사번을 조회하라
--      king 사장도 테이블에 보함한다.
select e.last_name, e.employee_id, m.last_name, m.employee_id
from employees e left outer join employees m
on e.manager_id = m.employee_id
order by 2;
--=================================================--

select d.department_id, d.department_name, d.location_id, l.city
from departments d, locations l
where d.location_id = l.location_id
and d.department_id in(20,50);

select e.last_name,d.department_name, l.city
from employees e, departments d, locations l
where e.department_id = d.department_id
    and d.location_id = l.location_id;
  
select e.last_name, e.salary, e.job_id
from employees e, jobs j
where e.salary between j.min_salary and j.max_salary
    and j.job_id = 'IT_PROG';  

select e.last_name, e.department_id, d.department_name
from employees e, departments d
where e.department_id(+) = d.department_id; -- (+)를 넣음으로 right outer join

select e.last_name, e.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id(+); -- left outer join

select e.last_name, e.department_id, d.department_name
from employees e, departments d
where e.department_id(+) = d.department_id(+); -- ERROR] full outer join은 없다

select w.last_name || ' works for ' || m.last_name
from employees w, employees m -- self join 가능
where w.manager_id = m.employee_id;
  