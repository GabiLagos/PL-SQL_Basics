--tema 19 TRIGGERS
/*Si un usuario intenta insertar 
una fila el sábado, se 
producirá un error y el 
trigger fallará y se 
deshace todo*/

CREATE OR REPLACE TRIGGER secure_emp
 BEFORE INSERT ON employees 
BEGIN
    IF (TO_CHAR(SYSDATE,'DY') IN ('SAB','DOM')) OR (TO_CHAR(SYSDATE,'HH24:MI’) NOT BETWEEN '08:00' AND '18:00') THEN
        RAISE_APPLICATION_ERROR(-20500, 'You may insert into EMPLOYEES table only during  normal business hours.');
    END IF;
END;
/

create or replace trigger trg_update_employees1
after update on employees1
--declare
begin
    insert into tab1 values(1);
end;
/

update employees1 set last_name=upper(last_name) where salary = 17000;
rollback;


--practica 19
/*1. The rows in the JOBS table store a minimum and maximum salary allowed for different 
JOB_ID values. You are asked to write code to ensure that employees’ salaries fall in the 
range allowed for their job type, for insert and update operations. 
a. Create a procedure called CHECK_SALARY as follows:  
    1) The procedure accepts two parameters, one for an employee’s job ID string and 
    the other for the salary.  
    2) The procedure uses the job ID to determine the minimum and maximum salary for 
    the specified job.
    3) If the salary parameter does not fall within the salary range of the job, inclusive of 
    the minimum and maximum, then it should raise an application exception, with the 
    message “Invalid salary <sal>. Salaries for job <jobid> must 
    be between <min> and <max>.”  Replace the various items in the message 
    with values supplied by parameters and variables populated by queries. Save the 
    file.
    */

