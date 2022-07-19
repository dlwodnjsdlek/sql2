--과제]
-- 가장 늦게 입사한 사람을 찾아라 / 이름, 입사일
select e.last_name ,e.hire_date
from employees e join employees m
on e.hire_date >= m.hire_date;

select last_name, hire_date
from employees
order by hire_date desc;