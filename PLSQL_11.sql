-- Tema 10 Introducción a procedimientos y funciones almacenados
-- Tema 11 Creación de procedimientos
create or replace procedure  p_saludo  is --este procedimieto no tiene parametros y sustituye al DECLARE
begin
dbms_output.put_line('Hola Mundo! subprograma PLSQL');
end;



/*
CREATE OR REPLACE PROCEDURE proc1 (p_nombre varchar2)  <-- esto es el parametro formal
BEGIN....

luego llamo al procedimiento
proc1('Juan') <-- Juan es el parametro real
*/


create or replace procedure p_display(
v_reg  in departments%rowtype
) is
begin

dbms_output.put_line(v_reg.department_id);
dbms_output.put_line(v_reg.department_name);
dbms_output.put_line(v_reg.manager_id);
dbms_output.put_line(v_reg.location_id);
dbms_output.put_line('------------------------------------------------------------------------------------');
end;
/
show errors;

declare
v_reg departments%rowtype;
cursor c1 is 
    select * from departments;
begin
    for a in c1
    loop
    p_display(a);
    end loop;
end;



--PRACTICA 11
--1. Create, compile, and invoke the ADD_JOB procedure and review the results. 
create or replace procedure add_job(
v_jobid  in jobs.job_id%type,
v_jobtitle in jobs.job_title%type
) is
begin
insert into jobs(job_id, job_title)  values(v_jobid, v_jobid);
exception 
    WHEN DUP_VAL_ON_INDEX THEN
    DBMS_OUTPUT.PUT_LINE('Ya existe el registro con ese ID.');
end;
/
begin
add_job('IT_DBA', 'Administrador de Bases de Datos');
end;
/
begin
add_job('IT_WEB', 'Internet Admin');
end;


--2. Create a procedure called UPD_JOB to modify a job in the JOBS table. 

create or replace procedure upd_job(
v_jobid_old  in jobs.job_id%type,
v_jobid_new  in jobs.job_id%type,
v_jobtitle in jobs.job_title%type
)is
begin
update jobs set job_id = v_jobid_new, job_title = v_jobtitle where job_id = v_jobid_old;
end;


begin 
upd_job('IT_DBA', 'DBA_MAN', 'Database Master');
if SQL%ROWCOUNT=0 then
    dbms_output.put_line('No se cambio nada, probablemente no existe el JOB_ID');
else
    dbms_output.put_line('Se han cambiado '||SQL%ROWCOUNT||' registros' );
end if;
end;




--3. Create a procedure called DEL_JOB to delete a job from the JOBS table.

create or replace procedure del_job(
v_jobid in jobs.job_id%type
) is
begin
delete from  jobs  where job_id = v_jobid;
if SQL%NOTFOUND then
    raise_application_error (-20203, 'No job updated');
end if;
end;
/


begin
del_job('DBA_MAN');
dbms_output.put_line('Se han cambiado '||SQL%ROWCOUNT||' registros' );
end;



--4. Create a procedure called GET_EMPLOYEE to query the EMPLOYEES table, retrieving the salary and job ID for an employee when provided with the employee ID.

create or replace procedure get_employee (
v_empid in  employees.employee_id%type,
v_salary out employees.salary%type,
v_jobid out employees.job_id%type
) is
begin
select salary, job_id into v_salary, v_jobid from employees where employee_id=v_empid;
if SQL%ROWCOUNT=0 then
    dbms_output.put_line('No se cambio nada, probablemente no existe el JOB_ID');
end if;
end;
/

begin
get_employee(210);
end;

