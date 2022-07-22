--DDL (Data Definition Language)
drop table hire_dates;

create table hire_dates(
id number(8),
hire_date date default sysdate); -- default + 값 -> 기본값 설정

select tname -- hr에 소속된 테이블을 불러온다.
from tab; --data dictionary

--과제] drop table 후, 위 문장 실행 결과에서, 쓰레기는 제하고, 조회하라.

commit;

select tname -- hr에 소속된 테이블을 불러온다.
from tab
where tname not like 'BIN%';

insert into hire_dates values(1, to_date('2025/12/21'));
insert into hire_dates values(2, null);
insert into hire_dates(id) values(3);

commit;

select * from hire_dates;
--==========================--
-- DCL(Data Control Language)
-- system connection 으로 변경한다.( 우측상단 커넥션)

create user you identified by you;
grant connect, resource to you;

-- you 커넥션으로 바꾼다.
select tname 
from tab;

create table depts(
department_id number(3) constraint depts_deptid_pk primary key,
-- 프라이머리 키 만들기/ depts테이블에 department_id _ primary key
department_name varchar2(20));

--constraint 제약하다
desc user_constraints

select constraint_name, constraint_type, table_name
from user_constraints;


create table emps(
employee_id number(3) primary key,
emp_name varchar2(10) constraint emps_empname_nn not null, -- null값있으면 에러
email varchar2(20),
salary number(6) constraint emps_sal_ck check(salary > 1000), -- 급여가 1000이하면 에러
department_id number(3),
constraint emps_email_uk unique(email), --제약방법 중1 
constraint emps_deptid_fk foreign key(department_id)
    references depts(department_id));
--foreign 으로 join이 가능하게 됐다.

select constraint_name, constraint_type, table_name
from user_constraints;

insert into depts values(100, 'Development');
insert into emps values(500,'musk', 'musk@gmail.com', 5000, 100);
commit;

delete depts; -- ERROR integrity constraint
--integrity 무결성: 참된데이터는db안에 있고 거짓데이터는 없앤다.

insert into depts values(100, 'Marketing'); --ERROR,unique constraint (YOU.DEPTS_DEPTID_PK) violated
insert into depts values(null,'Marketing');-- ERROR, cannot insert NULL into ("YOU"."DEPTS"."DEPARTMENT_ID")
insert into emps values(501, null, 'good@gmail.com', 6000, 100); --ERROR,cannot insert NULL into ("YOU"."EMPS"."EMP_NAME")
insert into emps values(501, 'label', 'musk@gmail.com', 6000, 100);--ERROR, unique constraint (YOU.EMPS_EMAIL_UK) violated
insert into emps values(501, 'abel', 'good@gmail.com', 6000, 200);--ERROR, integrity constraint (YOU.EMPS_DEPTID_FK) violated - parent key not found

drop table emps cascade constraints; -- 테이블에 관계맺은 제약조건까지 다 삭제한다.

select constraint_name, constraint_type, table_name
from user_constraints;

create table employees(
employee_id number(6) constraint emp_empid_pk primary key, -- 프라이머리키는 테이블당 1개
first_name varchar2(20),
last_name varchar2(25) constraint emp_lastname_nn not null,
email  varchar2(25) constraint emp_email_nn not null
                    constraint emp_email_pk unique,
phone_number  varchar2(20),
hire_date date constraint emp_hiredate_nn not null,
job_id  varchar2(10) constraint emp_jobod_nn not null,
salary number(8) constraint emp_salary_ck check (salary > 0),
commission_pct number(2,2),
manager_id number(6) constraint emp_managerid_fk references employees(employee_id),
department_id number(4) constraint emp_dept_fk references hr.departments(department_id));
--constraint emp_dept_fk references hr.departments(department_id))
--다른 스키마에서 따올라면 허락을 받아야함

-- 다른 스키마의 권한을 모두 가져옴
grant all on hr.departments to you; -- system 커넥션으로 실행

--다시 실행하면 테이블 완성됨.
create table employees(
employee_id number(6) constraint emp_empid_pk primary key, -- 프라이머리키는 테이블당 1개
first_name varchar2(20),
last_name varchar2(25) constraint emp_lastname_nn not null,
email  varchar2(25) constraint emp_email_nn not null
                    constraint emp_email_pk unique,
phone_number  varchar2(20),
hire_date date constraint emp_hiredate_nn not null,
job_id  varchar2(10) constraint emp_jobod_nn not null,
salary number(8) constraint emp_salary_ck check (salary > 0),
commission_pct number(2,2),
manager_id number(6) constraint emp_managerid_fk references employees(employee_id),
department_id number(4) constraint emp_dept_fk references hr.departments(department_id));
--=============================================--

drop table gu cascade constraints;
drop table dong cascade constraints;
drop table dong2 cascade constraints;

create table gu(
gu_id number(3) primary key,
gu_name char(9) not null);

create table dong(
dong_id number(4) primary key,
dong_name varchar2(12) not null,
gu_id number(3) references gu(gu_id) on delete cascade);
-- on delete cascade 부모테이블이 삭제되면 자기도 삭제되겠다

create table dong2(
dong_id number(4) primary key,
dong_name varchar2(12) not null,
gu_id number(3) references gu(gu_id) on delete set null);
-- on delete set null / gu 테이블 삭제하면 필드를 null로 바꾼다

insert into gu values(100, '강남구'); 
insert into gu values(200, '노원구');

insert into dong values(5000, '압구정동', null);
insert into dong values(5001, '삼성동', 100);
insert into dong values(5002, '역삼동', 100);
insert into dong values(6001, '상계동', 200);
insert into dong values(6002, '중계동', 200);

insert into dong2 -- dong에 있는걸 모두 insert
select * from dong;

delete gu
where gu_id = 100;

select * from dong; --  on delete cascade 사용
select * from dong2; -- on delete set null 사용

commit;
--=========================================--

drop table a cascade constraints;
drop table b cascade constraints;

create table a(
aid number(1) constraint a_aid_pk primary key);

create table b(
bid number(2),
aid number(1),
constraint b_aid_fk foreign key(aid) references a(aid));

insert into a values(1);
insert into b values(31,1);
insert into b values(32,9); -- ERROR, parent key not found

alter table b disable constraint b_aid_fk; -- 제약조건을 없앤다.
insert into b values(32,9);

alter table b enable constraint b_aid_fk; -- 제약조건을 다시 살리겠다.
-- ERROR, parent keys not found
-- insert into b values(32,9)로 거짓데이터가 이미 생성되어있어 false
alter table b enable novalidate constraint b_aid_fk;
-- 기존데이터는 신경안쓰고 제약조건을 다시 걸겠다.

insert into b values(33,8); --따라서 parent key not found
--========================--

--외부에서 데이터 가져오기
drop table sub_departments;

create table sub_departments as
    select department_id dept_id, department_name dept_name
    from hr.departments;
    
desc sub_departments

select * from sub_departments;
--==========================--

--테이블 구조 수정방법
drop table users cascade constraints;

create table users(
user_id number(3));

desc users

--테이블에 칼럼 추가하기
alter table users add(user_name varchar2(10));
desc users

--테이블에 있는 칼럼 수정하기
alter table users modify(user_name number(7));
desc users

--테이블에서 칼럼 삭제하기
alter table users drop column user_name;
desc users

--=======================================--

insert into users values(1);

alter table users read only; --읽기전용으로 바꾼다.
insert into users values(2); --ERROR] update operation not allowed

alter table users read write; -- 읽기,쓰기 가능

commit;










