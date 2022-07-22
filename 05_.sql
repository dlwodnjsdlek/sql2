--group function
-- 파라미터 레코드 개수가 n개이다.
-- singgle function / group function 의 공통점은 리턴값이 1개라는 것이다.

select count(*),
        count(distinct salary), -- distinct는 중복값을 제외한다.
        avg(commission_pct), -- null값은 고려 하지 않는다.
        avg(nvl(commission_pct,0)), -- null값을 0으로 만든다.
        max(salary),
        min(salary),
        sum(salary)
from employees;

--날짜에는 max min이 사용가능하다.
select MIN(hire_date), max(hire_date)
from employees;

select department_id, job_id, count(employee_id)
from employees
where department_id > 50
group by department_id, job_id
having count(employee_id) > 1 -- 그룹펑션은 where대신 having을 사용한다.
order by 1;
