-- subquery
select last_name, salary
from employees
where salary > (select salary
                from employees
                where last_name = 'Abel');
    
select last_name, job_id, salary
from employees
where job_id = (select job_id
                from employees
                where last_name = 'Ernst')
and salary > (select salary
                from employees
                where last_name = 'Ernst');
                
--과제] Abel과 같은 부서에서 일하는 동료들의 이름,입사일을 조회하라.
select last_name, hire_date
from employees
where department_id =(select department_id
                        from employees
                        where last_name = 'Abel')
and last_name <> 'Abel'
order by 1;

select last_name, job_id, salary
from employees
where salary = (select min(salary)
                from employees);

select department_id, min(salary)
from employees
group by department_id
having min(salary) > (select min(salary)
                        from employees
                        where department_id = 50)
order by department_id;

--과제] 회사 평균 월급 이상 버는 사원들의 사번, 이름, 월급을 조회하라
-- 월급 내림차순으로 정렬
select employee_id, last_name, salary
from employees
where salary >= (select avg(salary)
                from employees)
order by salary desc;

--------------------------
select employee_id, last_name
from employees
where salary = (select min(salary)
                from employees
                group by department_id); -- ERROR 레코드가 1개 이상을 리턴하고있다.

select employee_id, last_name, salary
from employees
where salary in (select min(salary)
                from employees
                group by department_id); -- sub에서의 값을 in의 비교값으로 사용

select employee_id, last_name, salary
from employees
where salary =any (select min(salary) -- any는 연산자뒤에 붙어 나온다
                from employees        -- 연산자에서 true값이 나오면 출력 / false면 안나옴
                group by department_id);

select employee_id, last_name, job_id, salary
from employees
where salary <any (select salary    -- any는 조건문의 1개 값에서 true면 된다.
                    from employees
                    where job_id = 'IT_PROG')
and job_id <> 'IT_PROG' ;

select employee_id, last_name, job_id, salary
from employees
where salary <all (select salary    -- all은 조건문의 모든 값에서 true여야한다.
                    from employees
                    where job_id = 'IT_PROG')
and job_id <> 'IT_PROG' ;

--과제] 이름에 u가 포함된 사원이 있는 부서에서 일하는 사원들의 사번,이름을 조회하라.
select employee_id, last_name, department_id
from employees
where department_id in (select department_id
                    from employees
                    where last_name like '%u%' or last_name like 'U%')
order by department_id;

--과제] 1700번 지역에 위치한 부서에서 일하는 사원들의 이름, 직업, 부서번호를 조회하라.
select last_name, job_id, department_id
from employees
where department_id in (select department_id
                        from departments
                        where location_id = 1700)
order by department_id;

--과제] Kochhar에게 보고하는 사원들의 이름,직업,부서번호를 조회하라.
select last_name, job_id, department_id
from employees
where manager_id in (select employee_id
                        from employees
                        where last_name = 'Kochhar');

--과제] IT부서에서 일하는 사원들의 부서번호,이름,직업을 조회하라.
select department_id, last_name, job_id
from employees
where department_id in(select department_id
                        from departments
                        where department_name like '%IT%');
 
 --과제] 60번 부서의 일부 사원보다 급여가 많은 사원들의 이름을 조회하라                       
select last_name
from employees
where salary >any (select salary 
                    from employees
                    where department_id = 60);
                    
                    
--과제] 모든 프로그래머보다 월급을 더 받고,
--      회사 평균 월급보다 월급을 더 받는 
-- 사원의 이름,직업,월급을 조회하라.
select last_name, job_id, salary
from employees
where salary >all (select salary 
                    from employees
                    where job_id like '%PROG')
    and salary > (select avg(salary) 
                    from employees);
--===============================================--
--no row

--sub 에서 출력값이 없으면 본출력값도 없다.
select last_name
from employees
where salary in (select salary
                from employees
                where job_id = 'ITPROG');
--------------------------------------------------
-- EXISTS 연산자는 서브쿼리에 
-- 데이터가 존재하는지 체크하고 존재할 경우 TRUE를 반환

select count(*) -- 사원이 있는 부서
from departments d
where exists (select *
                from employees e
                where e.department_id = d.department_id);
                
select count(*) -- 사원이 없는 부서
from departments d
where not exists (select *
                from employees e
                where e.department_id = d.department_id);
                
--과제] 직업을 바꾼 적이 있는 사원들의 사번,이름, 직업을 조회하라
select employee_id, last_name, job_id
from employees d 
where exists (select *
                from job_history c
                where d.employee_id = c.employee_id);
--=============================================--
--sub null
select last_name
from employees
where employee_id in (select manager_id
                        from employees);
                        
select last_name
from employees
where employee_id not in (select manager_id
                        from employees);
--과제] 위 문장을 all 연산자로 refactoring 하라.

select last_name
from employees
where employee_id <>all(select manager_id
                        from employees);