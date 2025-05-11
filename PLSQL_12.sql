--TEMA 12 Funciones
create or replace function f1 return varchar2 is
v_date date;
v_auxiliar varchar2(200);
begin
select sysdate into v_date from dual;
v_auxiliar := to_char(v_date, 'dd-mm-yyy hh:mi:ss');
return v_auxiliar;
end;



/
set serveroutput on
begin
dbms_output.put_line(f1);
end;
/


create or replace function f_display(v_reg  in  departments%rowtype)  return varchar2 is
v_aux varchar2(200);
begin

dbms_output.put_line(v_reg.department_id);
dbms_output.put_line(v_reg.department_name);
dbms_output.put_line(v_reg.manager_id);
dbms_output.put_line(v_reg.location_id);
dbms_output.put_line('------------------------------------------------------------------------------------');
end;
/



 SELECT text FROM  user_source WHERE type = 'FUNCTION' order BY line;
 desc user_objects;
 select object_name, status from user_objects;
 
 
 
 create table mon_diaria(
 nombre varchar2(100),
 tipo  varchar2(20),
 estado  varchar2(20));
 
create or replace function daily_check return number is
cursor recorrido is
    select object_name, object_type, status from user_objects where status='INVALID' and object_type in ('FUNCTION', 'PROCEDURE', 'INDEX');
begin
    for a in recorrido 
    loop
        if a.status='INVALID' then
            insert into mon_diaria values(a.object_name, a.object_type, a.status);
        end if;
    end loop;
    dbms_output.put_line('se encontraron '||SQL%ROWCOUNT||' invalidos. Revise la tabla mon_diaria');
    return 1;
exception
    when others then
    return 0;
end;
/



/

--PRACTICA 12
--1. Create and invoke the GET_JOB function to return a job title.
create or replace function get_job (p_jobid in jobs.job_id%TYPE) return jobs.job_id%TYPE is
v_title jobs.job_title%TYPE;
BEGIN
    select job_title into v_title from jobs where job_id= p_jobid;
    return v_title;
END;


--2. Create a function called GET_ANNUAL_COMP to return the annual salary computed from an 
employee’s monthly salary and commission passed as parameters. 
create or replace function get_annual_comp(p_empid in employees.employee_id%TYPE) return number is
v_annual_sal number;
BEGIN
    select (salary*12) + (commission_pct*salary*12) into v_annual_sal from employees where employee_id=p_empid;
    return v_annual_sal;
EXCEPTION
    WHEN value_error then
    return 0;
    DBMS_OUTPUT.PUT_LINE('No se puede calcular, hay valores NULL');
    when OTHERS THEn
    return 1;
    DBMS_OUTPUT.PUT_LINE('ha ocurrido algun problema');
END;
/
select employee_id, salary, commission_pct, get_annual_comp(employee_id)"Annual Comp" from employees where commission_pct is not null;




/*3. Create a procedure, ADD_EMPLOYEE, to insert a new employee into the EMPLOYEES table. 
The procedure should call a VALID_DEPTID function to check whether the department ID 
specified for the new employee exists in the DEPARTMENTS table. */


CREATE OR REPLACE FUNCTION VALID_DEPTID(p_deptid IN DEPARTMENTS.DEPARTMENT_ID%TYPE) RETURN BOOLEAN IS
v_exist NUMBER;
BEGIN
    select count(department_id) into v_exist from departments where department_id=p_deptid;
    if v_exist=1 then
        return true;
    else 
        return false;
    end if;
END;
/




CREATE OR REPLACE PROCEDURE add_employee(      
V_FNAME        employees.FIRST_NAME%type,     
V_LNAME         employees.LAST_NAME%type,        
V_JOBID            employees.JOB_ID%type           DEFAULT 'SA_REP',     
V_SALARY            employees.SALARY%type           DEFAULT 1000,      
V_COMMPCT    employees.COMMISSION_PCT%type   DEFAULT 0,       
V_MANAID        employees.MANAGER_ID%type       DEFAULT  145,   
V_DEPTID     employees.DEPARTMENT_ID%type    DEFAULT 30      
) IS
BEGIN
    if valid_deptid(V_DEPTID)  then
        insert into employees(employee_id, first_name, last_name, job_id, manager_id, hire_date, salary, commission_pct, department_id)
        values (employees_seq.NEXTVAL, V_FNAME, V_LNAME, V_JOBID, V_MANAID, sysdate, V_SALARY, V_COMMPCT, V_DEPTID);
    else
        RAISE_APPLICATION_ERROR (-20204, 'Invalid department ID. Try again.'); 
    end if; 
END;
/


execute ADD_EMPLOYEE('Joe', 'Harris', V_DEPTID=>80);



describe employees;