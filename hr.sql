-- view / 뷰에 데이터가 있냐?> 아니요 / 뷰는 테이블이 아니다. / 
-- 뷰는 쿼리의 별명일 뿐이다./ 뷰는 쿼리처럼 사용되고있어 버츄얼 테이블이라고 말하기도 한다.

--hr user
drop view empvu80;

create view empvu80 as
    select employee_id, last_name, department_id
    from employees
    where department_id = 80;
    
desc empvu80

select * from empvu80;
--만약 view를 안만들면 써야했을 코드이다.
select * from (
    select employee_id, last_name, department_id
    from employees
    where department_id = 80);
    
create or replace view empvu80 as
    select employee_id, job_id
    from employees
    where department_id = 80;
    
desc empvu80;
--=======================================--

drop table teams;
drop view team50;

create table teams as
    select department_id team_id, department_name team_name
    from departments;

create view team50 as
    select *
    from teams
    where team_id = 50;
    
select * from team50;

select count(*) from teams;

insert into team50
values(300, 'Marketing');
-- ㄴ view에 실제로는 teams에 insert함
select count(*) from teams;

create or replace view team50 as
    select *
    from teams
    where team_id = 50
    with check option; -- view에 만드는 제약조건 // team_id=50만 넣어

insert into team50 values(50, 'IT Support');
select count(*) from teams;

insert into team50 values(301, 'IT Support'); -- ERROR, view WITH CHECK OPTION where-clause violation

create or replace view empvu10(employee_num, employee_name, job_title) as
    select employee_id, last_name, job_id
    from employees
    where department_id = 10
    with read only;
    
insert into empvu10 values(501, 'abel', 'Sales'); --ERROR] read-only view


--과제] 50번 부서원들의 사번, 이름, 부서번호로 받는 DEPT50 view를 만들어라
-- view 구조는 EMPNO, EMPLOYEE, DEPTNO 이다
-- view 를 통해서 50번 부서 사원들이 다른 부서로 배치되지 않도록한다.
drop view DEPT50;

create or replace view DEPT50 as
    select employee_id, last_name, department_id
    from employees
    where department_id = 50
    --with check option;
    with check option constraint dept50_ck;
--과제] DEPT50 view의 구조를 조회하라.
desc DEPT50;
--과제] DEPT50 view의 data를 조회하라.
select * from DEPT50;

--=========================--

drop sequence team_teamid_seq;

create sequence team_teamid_seq;

select team_teamid_seq.nextval from dual;
select team_teamid_seq.nextval from dual;
select team_teamid_seq.currval from dual;

insert into teams
values(team_teamid_seq.nextval, 'Marketing');

select * from teams
where team_id = 3
--
create sequence x_xid_seq
    start with 10 -- 10에서 시작
    increment by 5 -- 5씩 증가
    maxvalue 20 -- 최대 20
    nocache -- (nocache)캐시메모리를 저장해두지 않는다.
    nocycle; -- 최대 20넘어가면 10부터 다시 돌아가는데 20 넘어가면 에러
    
select x_xid_seq.nextval from dual;
-- 1번 5/ 2번 10/ 3번 15/ 4번20/ 5번 ERROR[nocycle효과]

--과제] DEPT테이블의 DEPTID칼럼의 field vlaue로 사용할 sequence를 만들어라
--      sequence는 400이상 1000이하로 생성한다. 10씩증가한다.
drop  sequence dept_deptid_seq;

create sequence dept_deptid_seq
 start with 400
    increment by 10
    maxvalue 1000;

select dept_deptid_seq.nextval from dual;

--과제] 위sequence로, DEPT테이블에서, Education 부서를 insert하라
insert into dept(department_id, department_name)
values(dept_deptid_seq.nextval, 'Education');

commit;

--====================================================--
--index

drop index emp_lastname_idx;

create index emp_lastname_idx
on employees(last_name);

select last_name, rowid -- rowid는 만들지 않아도 생기는 인덱스/ 유일한 변수이다
from employees
where rowid = 'AAAEAbAAEAAAADNABK';

select index_name, index_type, table_owner, table_name
from user_indexes;

--과제] DEPT 테이블의 department_name에 대해 index를 만들어라
drop index dept_deptname_idx;

create index dept_deptname_idx
on dept(department_name);

--===================================================--
--synonym = 별명 붙이기

drop synonym team;

create synonym team
for departments;

select * from team; -- team으로 입력해서 departments 불러온다.

--과제] employees 테이블에 emps synonym을 만들어라

create synonym emps
for employees;

select * from emps;