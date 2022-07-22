--join

-- equi join // 조인 대상 테이블에서 공통인 열을 통해 같은 값을 가지는 행을 연결한다.
-- 양 테이블의 칼럼 필드개수가 같아야한다.
-- 양쪽 테이블의 레코드를 비교해서 공통칼럼을 찾아 넣는다
select department_id, department_name, location_id, city
from departments natural join locations;

-- join using, using에는 (공통된 칼럼) primary key을 작성한다.
-- 이때 using에 사용된 칼럼은 접두사를 붙이지 못한다.
select employee_id, city, department_name
from employees join departments
using (department_id)
join locations
using (location_id);

--join on
-- on에 쓰이는 값은 접두사를 붙여야한다.
-- 또한 접두사로 인해 가독성이 늘어난다. (칼럼과 필드확인)
select employee_id, city, department_name
from employees e join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id;

--과제] Toronto에 위치한 부서에서 일하는 사원들의
--      이름,직업,부서번호,부서명을 조회하라.
select e.last_name, e.job_id, d.department_name, l.city
from employees e join departments d
using (department_id)
join locations l
using (location_id)
where city = 'Toronto';

--none equi join // on절에서 =이 아니라 다른 값을 사용하면 none이다
select e.last_name, e.salary, e.job_id
from employees e join jobs j
on e.salary between j.min_salary and j.max_salary
    and j.job_id = 'IT_PROG';
    
--== self join / select에 접두사를 붙여서 마치 다른 테이블의 것인거 처럼 속인다.
-- 같은 부서에서 일하는 사원의 이름 부서 동료 이름을 조회하라.
select m.department_id || '번 부서의', m.last_name || ' 동료는 ', f.last_name || ' 이다.'
from employees m join employees f
on m.department_id = f.department_id
where m.employee_id <> f.employee_id
order by 1,2,3;

--self join을 이렇게 표현도한다.
select w.last_name || ' works for ' || m.last_name
from employees w, employees m
where w.manager_id = m.employee_id;


--== outer join / join시 null인 값까지 모두 불러올 수 있다.
-- left / right / full 이있는데 각 방향의 값을 모두 가져온다.

-- 오른쪽에 없는데 왼쪽에 있는걸 가져옴
select e.last_name, e.department_id, d.department_name
from employees e left outer join departments d
on e.department_id = d.department_id
order by 2 desc;
--where ,, (+)로도 표현가능
    select e.last_name, e.department_id, d.department_name
    from employees e, departments d
    where e.department_id = d.department_id(+); -- left outer join
    
-- 오른쪽에 있는데 왼쪽에 있는걸 가져옴
select e.last_name, e.department_id, d.department_name
from employees e right outer join departments d
on e.department_id = d.department_id;
    select e.last_name, e.department_id, d.department_name
    from employees e, departments d
    where e.department_id(+) = d.department_id; -- right outer join


-- 모든걸 다 가져옴
select e.last_name, e.department_id, d.department_name
from employees e full outer join departments d
on e.department_id = d.department_id;
    select e.last_name, e.department_id, d.department_name
    from employees e, departments d
    where e.department_id(+) = d.department_id(+); -- ERROR] full outer join은 없다
