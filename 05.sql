--group function
-- 파라미터 레코드 개수가 n개
--single function / group function 공통점 리턴값은 1개이다
select avg(salary), max(salary), min(salary), sum(salary)
from employees;

select min(hire_date), max(hire_date) -- 날짜에 사용가능
from employees;

select count(*) -- 레코드 개수 세는법
from employees;

--과제] 70번부서원이 몇명인 지 조회
select count(department_id)
from employees
where department_id = 70;

select count (manager_id) -- 사장님때문에 106 // null은 무시한다
from employees;

select avg(commission_pct)-- null값은 고려가 안되어있다.
from employees;

--과제] 조직의 평균 커미션율을 조회하라.
select avg(nvl(commission_pct, 0))
from employees;

--과제] 최고월급과 최소얼급의 차액을 조회하라.
select max(salary)"최고 월급", min(salary)"최소 월급", max(salary) - min(salary)"차액"
from employees;
--============================================--

select avg(salary), -- 그룹함수 파라미터 가장 앞에는 all이 숨겨져있다.
        avg(distinct salary), -- distinct는 중복값을 제외하고 보여준다.
        avg (all salary)
from employees;

--과제] 직원이 배치된 부서 개수를 조회하라.
select count(distinct department_id)
from employees;

select count(distinct manager_id)
from employees;

select department_id, count(employee_id)
from employees
group by department_id -- 그룹별로 
order by department_id;

select department_id,job_id ,count(employee_id) -- group by에 없는 칼럼은 못들어간다.
from employees                                  -- group by절에 있는 칼럼이 select절에 들어갈 수 있다.
group by department_id -- 그룹별로                --count(employee_id) 같은경우 count의 리턴값이 들어온 것
order by department_id;                         -- 그룹명을 레이블이라 칭한다.

--과제] 직업별 사원수를 조회하라.
select job_id, count(employee_id)
from employees
group by job_id  
order by job_id;

select department_id, max(salary)
from employees
group by department_id
having department_id > 50; -- having으로 group을 골라낸다.

select department_id, max(salary)
from employees
where department_id > 50 -- where은 group by 앞에
group by department_id;     -- 레코드를 골라내고 , 그룹핑

select department_id, max(salary)
from employees
group by department_id
having max(salary) > 10000; 

select department_id, max(salary)
from employees
where max(salary) > 10000 -- 그룹펑션은 where사용 x
group by department_id; --error


select department_id, max(salary) max_sal 
from employees
group by department_id
having max_sal > 10000;--error  -- order by에서는 별명으로 실행됐는데, having은 안됨.




