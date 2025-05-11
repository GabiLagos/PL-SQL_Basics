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




