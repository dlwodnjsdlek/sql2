-- set
select employee_id, job_id
from employees
union -- 합집합, 중복데이터를 지운다
select employee_id, job_id
from job_history;

select employee_id, job_id
from employees
union all -- 집합 두개를 그냥 같이 가져다둔것 / 합집합인데, 겹치는 인수를 다 가져와
select employee_id, job_id
from job_history;

--과제] 과거 직업을 현재 갖고 있는 사원들의 사번,이름,직업을 조회하라.
select employee_id, last_name, job_id
from employees e
where EXISTS (select *
                from job_history j
                where e.job_id = j.job_id
                and e.employee_id = j.employee_id);
select e.employee_id, e.last_name, e.job_id -- 위와 동
from employees e, job_history j 
where e.employee_id = j.employee_id
    and e.job_id = j.job_id;
--=================================--
select location_id, department_name
from departments
union
select location_id, state_province
from locations;
-- 위 문장은 department_name과 satae_province가 같이 있어 작업시 좋지않다.
--과제] 위 문장을, service관점에서 고쳐라
--      union을 사용한다.
select location_id, department_name, null state_province 
from departments
union
select location_id, null, state_province 
from locations;

select employee_id, job_id, salary
from employees
union
select employee_id, job_id
from job_history; --ERROR] 칼럼의 개수가 맞지 않는다.
--과제] 위 문장을, persistence(지속)관점에서 고쳐라.
select employee_id, job_id, salary
from employees
union
select employee_id, job_id, 0
from job_history
order by salary;