select e.employee_id, e.last_name, e.department_id,
        d.department_id, d.location_id
from employees e join departments d
on (e.department_id = d.department_id);

--과제] Toronto 에 위치한 부서에서 일하는 사원들의
--      이름,직업,부서번호,부서명을 조회하라.

select e.last_name, e.job_id, d.department_id, d.department_name,l.city
from employees e join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id
where city = 'Toronto';