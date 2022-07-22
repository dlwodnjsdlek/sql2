-- DML(Data Manipulation Language) - 데이터를 조작하는 언어 (insert, update, delete ..)

-- 테이블 없애기
drop table emp;
drop table dept;

-- 테이블 만들기
create table emp(
employee_id number(6),
first_name varchar2(20),
last_name varchar2(25),
email varchar2(25),
phone_number varchar2(20),
hire_date date,
job_id varchar2(10),
salary number(8),
commission_pct number(2,2),
manager_id number(6),
department_id number(4)
);

create table dept(
department_id number(4),
department_name varchar2(30),
manager_id number(6),
location_id number(4)
);

-- 필드의 순서 및 레코드 값 만들기 
insert into dept(department_id, department_name, 
                manager_id, location_id)
values(300, 'Public Relation', 100 ,1700);

insert into dept (department_id, department_name)
values (310, 'Purchasing');

--과제] row 2건이 insert 성공됐는지, 확인하라.
select * from dept ; -- 필드 벨류는 기본적으로 null이다

commit; -- transaction : DML문장들만 포함이고, select~~는 아니다,
        --                 commit으로 DML문장의 끝이 난다.
        -- 위 값들은 메모리에 저장이되고, 디스크에 저장하려면 commit해야한다

insert into emp( employee_id, first_name, last_name,
                email, phone_number, hire_date,
                job_id, salary, commission_pct,
                manager_id, department_id)
values(300, 'Louis', 'Pop',
        'Pop@gmail.com', '010-378-1278', sysdate, -- 리턴값을 저장
        'AC_ACCOUNT', 6900, null,
        205, 110);

insert into emp -- emp 필드의 순서 개수만 같게 써주면 된다.
values(310, 'Jark', 'Kelin',
        'Klein@gmail,com', '010-753-4635', to_date('2022/06/15', 'YYYY/MM/DD'),
        'IT_PROG', 8000, null,
        120,190);

insert into emp
values(320, 'Terry', 'Benard',
        'Benard@gmail', '010-632-0972', '2022/07/20',
        'AD_PRES', 5000, .2,
        100,300);
       
drop table sa_reps;

create table sa_reps(
id number(6),
name varchar2(25),
salary number(8,2),
commission_pct number(2,2));

--다른 레코드에서 가져오는방법 // 다른 레코드와 데이터 타입이 같아야한다.
insert into sa_reps(id, name, salary, commission_pct) 
    select employee_id, last_name, salary, commission_pct
    from employees
    where job_id like '%REP%';
commit;

--procedure 프로시져? 작성하기
declare 
    base number(6) := 400;  -- 초기값을 400준다
begin
    for i in 1..10 loop-- i를 1부터 10까지 loop하겠다 
        insert into sa_reps(id,name, salary, commission_pct)
        values(base+i, 'n' || (base + i), base * i, i * 0.01);
    end loop;
end;
/
-- / 까지가 끝이다.

select * from sa_reps;

--과제] procedure로 insert한 row들을 조회하라.
select * 
from sa_reps
where id > 400;

--===========================================--
--update

select employee_id, salary, job_id
from emp
where employee_id = 300;

update emp
set salary = 9000, job_id = null
where employee_id = 300;

commit;

update emp
set job_id = (select job_id
                from employees
                where employee_id = 205),
    salary = (select salary
                from employees
                where employee_id = 205)
where employee_id = 300;

select job_id, salary
from emp
where employee_id = 300;

rollback; -- 돌아가기

select job_id, salary
from emp
where employee_id = 300;

update emp
set (job_id, salary) = (
    select job_id, salary
    from employees
    where employee_id = 205)
where employee_id = 300;

commit;
--====================================--
--delete

delete dept
where department_id =300;

select *
from dept;

rollback;

select *
from dept;

delete emp
where department_id = (
    select department_id
    from departments
    where department_name = 'Contracting');
    
select *
from emp;

rollback;

select *
from emp;

commit;