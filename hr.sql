-- view / �信 �����Ͱ� �ֳ�?> �ƴϿ� / ��� ���̺��� �ƴϴ�. / 
-- ��� ������ ������ ���̴�./ ��� ����ó�� ���ǰ��־� ����� ���̺��̶�� ���ϱ⵵ �Ѵ�.

--hr user
drop view empvu80;

create view empvu80 as
    select employee_id, last_name, department_id
    from employees
    where department_id = 80;
    
desc empvu80

select * from empvu80;
--���� view�� �ȸ���� ������� �ڵ��̴�.
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
-- �� view�� �����δ� teams�� insert��
select count(*) from teams;

create or replace view team50 as
    select *
    from teams
    where team_id = 50
    with check option; -- view�� ����� �������� // team_id=50�� �־�

insert into team50 values(50, 'IT Support');
select count(*) from teams;

insert into team50 values(301, 'IT Support'); -- ERROR, view WITH CHECK OPTION where-clause violation

create or replace view empvu10(employee_num, employee_name, job_title) as
    select employee_id, last_name, job_id
    from employees
    where department_id = 10
    with read only;
    
insert into empvu10 values(501, 'abel', 'Sales'); --ERROR] read-only view


--����] 50�� �μ������� ���, �̸�, �μ���ȣ�� �޴� DEPT50 view�� ������
-- view ������ EMPNO, EMPLOYEE, DEPTNO �̴�
-- view �� ���ؼ� 50�� �μ� ������� �ٸ� �μ��� ��ġ���� �ʵ����Ѵ�.
drop view DEPT50;

create or replace view DEPT50 as
    select employee_id, last_name, department_id
    from employees
    where department_id = 50
    --with check option;
    with check option constraint dept50_ck;
--����] DEPT50 view�� ������ ��ȸ�϶�.
desc DEPT50;
--����] DEPT50 view�� data�� ��ȸ�϶�.
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
    start with 10 -- 10���� ����
    increment by 5 -- 5�� ����
    maxvalue 20 -- �ִ� 20
    nocache -- (nocache)ĳ�ø޸𸮸� �����ص��� �ʴ´�.
    nocycle; -- �ִ� 20�Ѿ�� 10���� �ٽ� ���ư��µ� 20 �Ѿ�� ����
    
select x_xid_seq.nextval from dual;
-- 1�� 5/ 2�� 10/ 3�� 15/ 4��20/ 5�� ERROR[nocycleȿ��]

--����] DEPT���̺��� DEPTIDĮ���� field vlaue�� ����� sequence�� ������
--      sequence�� 400�̻� 1000���Ϸ� �����Ѵ�. 10�������Ѵ�.
drop  sequence dept_deptid_seq;

create sequence dept_deptid_seq
 start with 400
    increment by 10
    maxvalue 1000;

select dept_deptid_seq.nextval from dual;

--����] ��sequence��, DEPT���̺���, Education �μ��� insert�϶�
insert into dept(department_id, department_name)
values(dept_deptid_seq.nextval, 'Education');

commit;

--====================================================--
--index

drop index emp_lastname_idx;

create index emp_lastname_idx
on employees(last_name);

select last_name, rowid -- rowid�� ������ �ʾƵ� ����� �ε���/ ������ �����̴�
from employees
where rowid = 'AAAEAbAAEAAAADNABK';

select index_name, index_type, table_owner, table_name
from user_indexes;

--����] DEPT ���̺��� department_name�� ���� index�� ������
drop index dept_deptname_idx;

create index dept_deptname_idx
on dept(department_name);

--===================================================--
--synonym = ���� ���̱�

drop synonym team;

create synonym team
for departments;

select * from team; -- team���� �Է��ؼ� departments �ҷ��´�.

--����] employees ���̺� emps synonym�� ������

create synonym emps
for employees;

select * from emps;