set serveroutput on
select * from employee;
 describe employee;
 select * from SYS.user_tables where table_name = 'EMPLOYEE';
 select * from SYS.user_objects where object_type = 'TRIGGER';
  select * from SYS.user_objects where object_type = 'VIEW' and status = 'VALID';

select user from dual;

declare 
v_emp employee.fname%type;
v_dname department.dname%type;
begin
select e.fname, d.dname into v_emp, v_dname
from employee e, department d
where e.fname = 'John' and e.dno = d.dnumber;
dbms_output.put_line ('Employee ' ||v_emp || ' ' || v_dname);
end;
/
show errors

SELECT cols.table_name, cols.column_name, cols.position, cons.status, cons.owner
FROM user_constraints cons, user_cons_columns cols
WHERE cols.table_name = 'EMPLOYEE'
AND cons.constraint_type = 'P';


select * from SYS.user_constraints where table_name = 'DEPARTMENT';
TRUNCATE TABLE DEPARTMENT
SELECT * FROM WORKS_ON
DROP TABLE WORKS_ON
FLASHBACK TABLE WORKS_ON TO BEFORE DROP
oerr ora 01422 --describes an error code

oerr ora 54

--Question 2 example: when indexed there's no table access; hash join performed with accessing indexes only-----
create index lname_ix20 on employee (lname, dno);
create index dname_ix20 on department(dname, dnumber);
create index lname_ix30 on employee (lname);

explain plan for
select lname
from e
where exists (select * from dependent de where e.ssn = de.essn);
SELECT * FROM TABLE(DBMS_XPLAN.display);
--End of 2-----------------------


----Question 4-----------------
create table demTable (
c number);
insert into demTable values (1);
insert into demTable values (2);
insert into demTable values (3);
set autotrace off
select * from demTable;


CREATE OR REPLACE TRIGGER trD
AFTER INSERT ON demTable
FOR EACH ROW
DECLARE
v_run_time demtable.c%TYPE:= :new.c;
invalidInsert EXCEPTION;
BEGIN
 IF v_run_time > 5 THEN
 DBMS_OUTPUT.PUT_LINE('Insert is valid');
  COMMIT;
ELSE
RAISE invalidInsert;
END IF;
END;

update demTable set c = 5 where c = 3;

insert into demTable VALUES (4);

select * from demTable;
-------------End of Q4------------

---Question 3-------

Create table T3 (
k number not null,
nk number,
primary key (k) DEFERRABLE INITIALLY Immediate);

insert into T3 values (1,1);
insert into T3 values (2,2);
insert into T3 values (1,3);
insert into T3 values (3,-3);
insert into T3 values (3,100);
commit

select constraint_name, status, invalid from user_constraints where table_name = 'T3'
and constraint_type = 'P';

create index lname_ix50 on employee (lname, salary) invisible;
alter index lname_ix50 visible
alter table t1 set unused (d);

select * from t1
select constraint_name, status, deferred from user_constraints where table_name = 'T3';

select * from T3;
-------End of Q3---------------------------------

SELECT NAME, REFERENCED_OWNER, REFERENCED_NAME, REFERENCED_TYPE
    FROM ALL_DEPENDENCIES
    SELECT * FROM ALL_DEPENDENCIES
    ----ONLY USED TO RECOMPILE ENABLE/DISABLE...MUST OWN PRIVILLEGES TO DO SO
ALTER TRIGGER Print_salary_changes COMPILE;


-------Question 1-------------

create table T1 (
c number);

insert into T1 values (20);
commit

select * from T1;

---body of .plsql---   
   Declare
   cursor c_f is 
    select c from T1 for update nowait;
    v_c T1.c%type;
    v_time varchar2(30);
    rowLocked EXCEPTION;
    PRAGMA EXCEPTION_INIT(rowLocked, -54);
begin
  open c_f;
  loop
    fetch c_f into v_c;
    exit when c_f%notfound;
    update T1 set c=v_c+11 where current of c_f;
  end loop;
  close c_f;
Exception
  WHEN rowLocked THEN
     v_time:= to_char (systimestamp, 'HH24:MM:SS');
     dbms_output.put_line('T1 row locked at ' || v_time);
end;
/
show errors
   
select * from T1;

--This block illustrates how the transaction can be rolled back to a pre set savepoint----
savepoint savepoint_before_update;
update employee set fname = 'Patrick' where fname  = 'John';
select * from e;
rollback to savepoint_before_update;
CREATE SYNONYM d  FOR department;
----------------------------------------------------------------------------------------------------
-----Dropping and recovering tables from the recyclebin ->synonum for user_recyclebin---
ALTER SESSION SET recyclebin = ON;
SELECT object_name, original_name FROM SYS.dba_recyclebin;
create table t8(
c number);
select * from t8;
insert into t8 values (5);
commit;
drop table t8;
FLASHBACK TABLE t8 TO BEFORE DROP
-----------------------------------------------------------------------------------------------------------
declare 
   loop_num number := 0;
   cursor c_products is
   select ssn from e;
   
   begin
   for i in c_products
      loop
         update e set ssn = ssn - 250;
         loop_num:= loop_num + 1;
         if mod(loop_num, 2) = 0 then
            commit;
        end if;
    end loop;
commit;
end;
/
show errors
select * from e;
--------------------------------------------------------------------

select * from v$log_history
select * from dba_tab_privs
select grantee, privilege from dba_sys_privs where grantee = 'RESOURCE';

create directory DATAPUMP_DIR as '/oraexport/db01/dpdump';
desc SYS.dba_recyclebin;
show recyclebin

alter session set plsql_warnings = 'enable:all';
alter session set plsql_optimize_level = 1;
select 'IT''s a bird, no plane, no it can''t be ice cream!' AS PHRASE from dual;
select q'(It's a bird, no plane, no it can't be ice cream!)' As phrase from dual;

----------------------------------------------------------------------------------------------
select object_name, object_type, status
from user_objects where object_type = 'VIEW';
select * from VX;
insert into dual values (33);
select * from dual;
desc dual;
create table t9 as (select distinct e.ssn, d.dname from e, d where e.dno = d.dnumber);
select * from USER_COL_COMMENTS where table_name = 'EMPLOYEES';
select * from t9
drop table t9 purge;
----------------------------------------------

create or replace force view foods fs as
select ds.a, ds.c, sw.e from sweets sw, donuts ds
with check option constraint primary key(ds.a);

select view_name  from user_views;
desc user_views;
desc user_objects;
select object_name, object_id, object_type, status from user_objects

declare
    cursor cur is select * from e;
    v_emp cur%rowtype;
begin
    open cur;
        fetch cur into v_emp;
        WHILE cur%FOUND LOOP	
    dbms_output.put_line ('SSN: '|| v_emp.ssn || ' Name: ' || v_emp.fname);
	        FETCH cur into v_emp;
	    END LOOP ;
end;
/
show errors

set serveroutput on


DECLARE
   cursor mycur is
   select fname, salary
   from e
   where ssn = 123454059;
   v_emp mycur%rowtype;

BEGIN
   open mycur;
   fetch mycur into v_emp;
   dbms_output.put_line (v_emp.fname);
   dbms_output.put_line (v_emp.salary);
   close mycur;
END;

select * from e;

select * from user_objects where object_type  = 'PROCEDURE';

create table t7 (
c number);

create or replace trigger trig7
before insert on t7
for each row
declare
v_new t7.c%type := 55;
begin
:new.c:= v_new;
end;
/
show errors

insert into t7 values (1);
insert into t7 values (2);
insert into t7 values (3);
insert into t7 values (4);
select * from t7;

create or replace trigger ttrig
before update on t7
for each row
declare
v_new t7.c%type := 100;
begin
:new.c := v_new;
end;
/
show errors
update t7 set c = 40 where c = 55;
rollback

select '4+NULL' from dual;
-------------------------------------

begin
null;
end;
/

declare
    v_name varchar2(10);
begin
    v_name:='&input';
    dbms_output.put_line ('Hello ' || v_name);
Exception
    when others then
        dbms_output.put_line(SQLERRM);

end;
/

declare
v_bool boolean:= FALSE;
begin
    if not nvl(v_bool, false) then
        dbms_output.put_line ('First option');
    else
       dbms_output.put_line ('Second option'); 
    end if;
end;
/


CREATE TABLE dogs (
  id INTEGER NOT NULL PRIMARY KEY, 
  name VARCHAR(50) NOT NULL
);

CREATE TABLE cats (
  id INTEGER NOT NULL PRIMARY KEY, 
  name VARCHAR(50) NOT NULL
);
update cats set name = 'Telly' where id = 2;
rollback
commit
select * from cats;
desc cats;
commit;

select name from cats union select name from dogs;

select * from dict
where table_name = 'ALL_TABLES';

select * from dict
where table_name like '%TRIGGER';

SELECT * FROM V$SESSION where username = 'SYSTEM' and status = 'ACTIVE';
SELECT * FROM V$instance;
select * from v$lock;
select * from all_users;

select username, program, machine from v$session;

rollback;

create table my_suppliers (suppier_id number (10),
supplier_name varchar2(50));

insert into my_suppliers values (my_seq1.nextval, 'Apple');

insert into my_suppliers values (my_seq1.nextval, 'Peach');

select * from my_suppliers;

begin
for i in 1..10 Loop
dbms_output.put_line ('Index: [' || i || ']');
end loop;
end;
/

declare
    cursor cur is select * from employee;
    v_emp employee%rowtype;
begin
    open cur;
    loop
    fetch cur into v_emp;
    Exit when cur%notfound;
        dbms_output.put_line ('Name: ' || v_emp.fname || ' ' ||v_emp.lname || ':  ' ||v_emp.ssn);
    end loop;
    close cur;
end;
/

create or replace function join_strings (p1 varchar2, p2 varchar2)
return varchar2 is
begin
    Return p1||' '||p2;
end;
/

select join_strings('Hello', 'DMV')
from dual;

CREATE INDEX idx_fname ON e (fname)
  GLOBAL PARTITION BY HASH (fname)
  PARTITIONS 2;
  
  explain plan for
  select * from e where lname= 'SMITH';
SELECT * FROM TABLE(DBMS_XPLAN.display);




declare
    cursor cur is select * from d;
    v_dep d%rowtype;
Begin
    Open cur;
    Loop
        Exit when cur%notfound;
        fetch cur into v_dep;
        DBMS_OUTPUT.PUT_LINE('Department: ' ||v_dep.dnumber||' ' || v_dep.dname);
    End loop;
Exception
    When Others then
    dbms_output.put_line(SQLERRM);
end;
/
show errors


declare
    cursor cur is select e.fname, e.lname, d.dname from employee e, department d where e.dno = d.dnumber;
    v_fname e.fname%type;
    v_lname e.lname%type;
    v_dname d.dname%type;
Begin
    open cur;
    loop
    exit when cur%notfound;
    fetch cur into v_fname, v_lname, v_dname;
    DBMS_OUTPUT.PUT_LINE(v_fname || '  '|| v_lname || '  '|| v_dname);
    end loop;
    close cur;
End;
/

select last_name, country from staff s, company_regions c where id<5 and s.region_id = c.region_id;
select last_name from staff where id <5

declare
cursor cur is
select last_name, company_division, country
from staff s, company_regions c, company_divisions cd
where id<5 and s.region_id = c.region_id and s.department = cd.department
order by last_name;
v_lname staff.last_name%type;
v_comdiv company_divisions.company_division%type;
v_country company_regions.country%type;
Begin
Open cur;
Loop
Exit when cur%notfound;
Fetch cur into v_lname, v_comdiv, v_country;
dbms_output.put_line(v_lname|| ' '||v_comdiv || ' '||v_country);
End loop;
Close cur;
end;
/
show errors;
--------------------------------------------------------
select * from t3;
---------------SQL injection-------------------------
select * from t3 where k = 1; DROP TABLE t3--'
-------------------------------------------------------

select * from staff where id<5;
select * from company_regions
desc COMPANY_DIVISIONS
desc staff
select id from staff

----Updatable cursor------------------------------------
Declare
cursor c_f is
select c from t1 for update nowait;
v_c t1.c%type;
v_time varchar2(30);
rowLocked EXCEPTION;
PRAGMA EXCEPTION_INIT(rowLocked, -54);
begin
open c_f;
loop
fetch c_f into v_c;
exit when c_f%notfound;
update t1 set c=c+11 where current of c_f;
end loop;
close c_f;
Exception
WHEN rowLocked THEN
v_time:= to_char (systimestamp, 'HH24:MM:SS');
dbms_output.put_line('T1 row locked at ' || v_time);
end;
/
show errors

select * from t1;

declare
    cursor cur is select c from t1 for update nowait;
Begin
    open cur;
    update t1
    set c= c+ 15;
    close cur;
end;
/

select substr(address, 1, 10) from e;
select fname, length(fname) from e;
select concat(concat(fname,'  '), lname) as Full_name from e;
select 'Full name: ' || fname || ' ' ||lname as Full_name from e;
select upper(fname) from e;
select fname, lname
from e 
where instr(address, '53')!=0;

select fname,lname from e
where address like '%53%';

select fname, lname, to_char(bdate, 'MM-DD-YYYY') from e;
select fname, lname, to_char(bdate, 'MM-DD-YYYY')
from e
where to_char(bdate, 'MON') = 'AUG';

select * from e;
commit

select systimestamp, to_char(sysdate, 'MM-DD-YYYY HH24:MM:SS') AS Time_stamp from dual;
select round(months_between(sysdate, bdate)/12, 0) AS Years_Emp from e;
select to_number(substr(ssn, 1, 5))+5 from e;
select fname, lname, dname
from e full join d on e.dno=d.dnumber;

alter table t1 add  b number;
select * from t1;

update t1 set b = 1 where c = 164;
rollback

declare
    cursor cur is select b from t1 for update nowait;
begin
    open cur;
        update t1 set b = 5;
        update t1 set b = b+ 20;
    close cur;
end;
/

select round(avg(salary)) as AvgSalary
from e
where address like '%TX%'
group by dno
having round(avg(salary)) >25000 ;

create table t4 (
name varchar2(20),
constraint check_UpperCase check (name = upper(name))
);

insert into t4 values ('TOM');
select * from t4
insert into t4 values ('Smith');
rollback
set transaction isolation level read committed

select * from e;

Create view e_view as
select fname, lname, sex, salary
from e;


update e_view
set fname = 'George'
where fname = 'Ramesh';

select fname, lname from e_view
group by fname, lname
create index ind_x on e_view (fname);

select * from e_view;
insert into e_view values ('Greg', 'Wild', 'M', 64000);
delete from e_view where fname = 'George'

select * from t1
ALTER TABLE t1 ADD d number
alter table t1 drop column d


SELECT fname, dno, salary,
       CASE dno WHEN 5 THEN 1.5*salary
                         WHEN 1 THEN 2.0*salary as Increase
       ELSE salary
       END
FROM Employee;

select fname from e minus select lname from e;

select * from user_tables order by table_name, last_analyzed desc


create table t9 (
id int not null,
lname varchar (20),
city varchar (30) default 'Wazoo'
);
insert into  t9 (id, lname, city)  values (1, 'Smith', 'Sacramento');
insert into  t9 (id, lname) values (2, 'Jakess');
insert into  t9  values(3, 'Jades', 'Angeles')

create table parent (
parent_id number,
parent_name varchar2 (30),
constraint parent_pk primary key (parent_id) using index);



create table children (
child_id number,
age number,
child_name varchar2(30),
p_id number default 7,
constraint child_pk primary key (child_id),
constraint p_fk foreign key (p_id) references
parent (parent_id)
on delete cascade);

ALTER TABLE children
ADD CONSTRAINT check_age CHECK (age between 1 and 21);

desc children
select * from SYS.user_constraints where table_name = 'CHILDREN';
drop table children purge

CREATE TABLE idTest (
  id          NUMBER GENERATED ALWAYS AS IDENTITY,
  description VARCHAR2(30)
);
insert into idTest values (6, 'Test');  --throws an error 
insert into idTest (description) values ('Test'); --Good insert
select * from idTest;

ALTER TABLE idTest
ADD CONSTRAINT u_cont UNIQUE (id, description);
commit
alter table idTest
drop constraint u_cont

WITH temT(averageValue) as
    (SELECT round(avg(Salary))
    from e), 
        SELECT ssn, fname, Salary 
        FROM e, temT 
        WHERE Employee.Salary > temT.averageValue;
        
create table t11(
a number,
b number);
insert into t11 values (1,1)
insert into t11 values (null,null)
insert into t11 values (1,1)
insert into t11 values (2,2)
insert into t11 values (3,3)
insert into t11 values (3,null)
select * from t11
select count (distinct a) from t11
where a>2

select &A, &B from "&t1"1 where &condition = &&cond

select distinct fname, lname from e

SELECT dno,
   PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY salary DESC) 
      "Median cont",
   PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY salary DESC) 
      "Median disc"
   FROM employee GROUP BY dno
   ORDER BY dno, "Median cont", "Median disc";
   
create table emt(
empid number(3),
empname varchar2(10),
salary number(10,2))

describe emt
select * from user_tables where table_name='EMT'
ALTER TABLE emt
ADD CONSTRAINT emp_id_pk PRIMARY KEY (empid)
USING INDEX emp_id_idx;

select * from USER_INDEXES where table_name = 'EMPLOYEE'
CREATE SEQUENCE customers_seq
select CUSTOMERS_SEQ.nextval from dual
select * from user_cons_columns where table_name in ('EMPLOYEE','CHILDREN')

CREATE TABLE digits
(id NUMBER(2),
description VARCHAR2(15));
INSERT INTO digits VALUES (1,'ONE');
UPDATE digits SET description ='TWO' WHERE id=1;
INSERT INTO digits VALUES (2, 'TWO');
COMMIT;
select * from digits
DELETE FROM digits;
SELECT description FROM digits
VERSIONS BETWEEN TIMESTAMP MINVALUE AND MAXVALUE;

SELECT * FROM ALL_CONSTRAINTS 
where table_name = 'EMPLOYEE'
WHERE constraint_type = 'R' AND r_constraint_name = 'PK_ACCES_TYPE';

desc e
alter table employee
add constraint dno_not_null not null (dno)
modify salary constraint salary_not_null not null

select * from SESSION_PRIVS

select max(salary), dno
from e where sex ='M'
group by dno
order by dno asc




--Getting ready for SQL Exam 1Z0-071 && Udemy course--------
create or replace synonym deps for departments
select * from user_tables where table_name = 'DEPARTMENTS'
drop synonym deps
select * from all_synonyms
--https://docs.oracle.com/cd/B19306_01/server.102/b14237/statviews_2091.htm#REFRN20273
--https://docs.oracle.com/cd/B19306_01/server.102/b14200/statements_7001.htm
--------------------------------------------------------------------------
select *from e
select fname, lname, salary,
   case
       when salary<40000 then 'Low'
       when (salary<65000 and salary>40000) then 'Average'
       else 'High'
    end "Salary range"
from e

CREATE TABLE vegies (
    vegie_name VARCHAR2(20) PRIMARY KEY,
    color VARCHAR2(20) NOT NULL
);
--https://www.oracletutorial.com/oracle-basics/oracle-insert-all/#
---------------------------------------------------------
select * from donuts
desc donuts
insert into donuts values (1,2,3)
savepoint a;
insert into donuts values (2,3,4)
savepoint b;
insert into donuts values (3,4,5)
select * from donuts
rollback to a;

rollback to b
rollback

select * from V$TRANSACTION
--https://docs.oracle.com/cd/B19306_01/server.102/b14220/transact.htm
--https://docs.oracle.com/cd/B19306_01/server.102/b14200/statements_10001.htm
--------------------------------------------------------
drop sequence my_seq1

create sequence my_seq1
start with 10
increment by 2
maxvalue 20
cycle
nocache

select my_seq1.nextval from dual;

select my_seq1.currval from dual;

create sequence my_seq2
select my_seq2.nextval from dual;
select my_seq2.currval from dual;
--https://docs.oracle.com/cd/B28359_01/server.111/b28286/statements_6015.htm#SQLRF01314
--https://docs.oracle.com/cd/B28359_01/server.111/b28286/statements_2011.htm#SQLRF00817
--https://docs.oracle.com/cd/B28359_01/server.111/b28286/statements_9001.htm#SQLRF01804
----------------------------------------------------------------------------------------------------------------
SET operators
https://www.databasestar.com/sql-set-operators/
https://docs.oracle.com/cd/B28359_01/server.111/b28286/queries004.htm#SQLRF52323
SELECT 3 FROM DUAL
   INTERSECT
SELECT 3S FROM DUAL;

----------------------------------------------------------------------------------------------------------------
SELECT TO_CHAR('01110' + 1) FROM dual;
--https://docs.oracle.com/cd/B19306_01/server.102/b14200/functions181.htm
--https://docs.oracle.com/cd/B19306_01/server.102/b14200/functions180.htm
--https://docs.oracle.com/cd/B19306_01/server.102/b14200/functions183.htm
----------------------------------------------------------------------------------------------------------------

create table orders1 (
orderId number(12) not null,
orderDate timestamp (6) not null,
order_mode varchar2(8),
customerId number (6) not null,
orderTotal number(8,2)
)

insert into orders1 values (1, '09-mar-2007', 'online', '', 1000) --element 4 is null but shouldn't be
insert into orders1 (orderID, orderDate, order_mode, customerId, orderTotal) values (1, to_date(null), 'online', 101, NULL)
insert into orders1 values (1, '09-mar-2007', default, 101, default)
drop table orders2 purge
create table orders2 (
a varchar2(20) default 'Dog',
resume clob
)
---------------------------------------------------------------------------------------

SELECT object_name, status
FROM user_objects
WHERE object_type = 'VIEW'

select * from session_privs

--Try something like that--
SELECT department_id "DEPT_ID", department_name , 'b'
FROM departments
WHERE department__id=90
UNION
SELECT department_id, department_name DEPT_NAME, 'a'
FROM departments
WHERE department_id=10

----------------------------------------------------------------------------------------------
SELECT * FROM v$version
select * from all_users
select * from user_users
select * from dba_users where account_status = 'OPEN'
----------------------------------------------------------------------------------------------
CREATE USER c##_john IDENTIFIED BY nomore1987;
GRANT CREATE SESSION TO c##_john;
Grant create table to c##_john
select * from C##_JOHN.johnytable
alter table c##_john.johnyTable
rename to jtab

ALTER USER c##_john QUOTA UNLIMITED ON USERS;
select * from user_constraints where  r_owner is not null
select * from all_synonyms
select object_type from user_objects
select * from user_objects
select table_name, comments from dictionary
select * from Catalog
select * from user_cons_columns where table_name = 'EMPLOYEE'
select * from user_tab_columns where table_name = 'T4'
select * from USER_UNUSED_COL_TABS

alter table T1 drop unused columns

SELECT * FROM GV$LOCK
select dno, sum(salary) "Total"
from e
group by dno
having (sum(salary)) > 50000
order by dno

select * from e
select m.lname "Manager", emps.lname "Employee"
from employee m join employee emps
on m.ssn = emps.super_ssn
where emps.super_ssn = 987654321

update e set ssn = 987654321 where ssn = 123454059

select * from USER_RECYCLEBIN

ALTER DATABASE ADD SUPPLEMENTAL LOG DATA
select * from t4
alter table t4 add nameID numeric

alter table t7 read write
insert into t7 values (75)
create index  e_indx on e(ssn)

create table myCust (
cust_id number (2) not null,
cust_name varchar2(15))
alter table myCust add constraint cust_id_pk
Primary key (cust_id) Deferrable initially deferred;
insert into myCust values (1, 'Peter');
insert into myCust values (1, 'Sam');
commit
select * from myCust

drop table t69

create table t69 (
a number,
b TIMESTAMP WITH LOCAL TIME ZONE)

insert into t69 values (3,'09 June 2015')
select * from t69 where b > '05 June 2015'

select lname, bdate, NEXT_DAY(bdate, 'MONDAY') "Next_Monday" from e
where lname = 'Smith'

select lname, bdate, Next_Day(Add_months(bdate, 3), 1) "Next_Monday" from e
where lname = 'Smith'

select * from nls_session_parameters
where parameter = 'NLS_DATE_LANGUAGE';

select next_day(sysdate, 1) from dual
select * from t69
delete from t69
desc t69
update t69 set a = null where a = 3
rollback
delete t69 where a = 3