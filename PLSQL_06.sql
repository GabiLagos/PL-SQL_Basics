/*Tema 6 Estructuras de control

 • Identificar los usos y tipos de estructuras de control
 • Construir una declaración IF
 • Utilizar instrucciones CASE y expresiones CASE
 • Construir e identificar los enunciados del bucle
 • Utilice pautas cuando use estructuras de control condicional
 
 
 SENTENCIA IF (sintaxis)
IF (condition1 and/or condition2, boolean ) THEN
     statements;
 [ELSIF condition THEN 
    statements;]
[ELSE 
    statements;]
END IF;
*/



DECLARE
    valor1 NUMBER := &valor1;
    valor2 NUMBER := &valor2;
BEGIN
    IF ( valor1 > valor2 ) THEN -- si el if es cualquier otra cosa dieferente de TRUE se va a else o elsif
        dbms_output.put_line(valor1
                             || ' es mayor que '
                             || valor2);
    ELSIF ( valor1 = valor2 ) THEN
        dbms_output.put_line(valor1
                             || ' es igual '
                             || valor2);
    ELSE
        dbms_output.put_line(valor2
                             || ' es mayor que '
                             || valor1);
    END IF;
END;
/
--REHACER LOS EJERCICIOS!!!!!!                                                                                        
/*EJERCICIO Nº1   
Actualizar los vendedores (SA_REP) con una comisión mayor que 0.30 con un incremento del 
15% de su salario. Si la operación afecta a más de tres empleados, deshacer la transacción, en 
cualquier otro caso validar la transacción.  
Introducir en la tabla temp (Tabla con dos columnas: una numérica y otra de caracteres) la 
operación que se ha realizado. 
CREATE TABLE temp ( 
Codigo NUMBER(6), 
Mensaje VARCHAR2(80));*/

SELECT * FROM employees WHERE job_id = 'SA_REP' AND commission_pct > 0.3;

SELECT COUNT(employee_id) FROM employees WHERE job_id = 'SA_REP' AND commission_pct > 0.3;

CREATE TABLE employees1 AS SELECT *  FROM employees;

CREATE TABLE temp (codigo  NUMBER(6), mensaje VARCHAR2(80));


DECLARE
v_cuenta_emp number;
v_mensaje varchar2(200);
v_numfilas number;
BEGIN
UPDATE employees1 SET  salary = salary*1.15 WHERE commission_pct > 0.3 and job_id = 'SA_REP';
v_numfilas := SQL%rowcount;
select count(employee_id) into v_cuenta_emp from employees where job_id = 'SA_REP' and commission_pct > 0.3;
if (v_cuenta_emp>3) then 
    ROLLBACK;
    v_mensaje := 'numero de filas cambiadas'; 
    --dbms_output.put_line(v_mensaje || '  '|| SQL%rowcount);
    INSERT INTO temp (mensaje, codigo) values (v_mensaje, 0); 
else
    COMMIT;
    v_mensaje := 'Numero de filas actualizadas'; 
    --dbms_output.put_line(v_mensaje || '  '|| SQL%rowcount);
    INSERT INTO temp (mensaje, codigo) values (v_mensaje, v_numfilas);
end if;
COMMIT;
END;

select * from temp;
rollback;
/



/*EJERCICIO Nº2 
Actualizar el trabajo de un empleado a director (AC_MGR) a todos los trabajadores cuyo salario 
sea mayor que 12000.  
Almacenar el número de empleados actualizados por la operación en temp.  
Si los afectados son más de cinco personas, borrar los empleados cuyo salario sea mayor de 
17000; si los afectados son más de tres personas, deshacer la transacción de cualquier cambio.  
En cualquier otro caso validar la transacción.*/

select * from employees1 where salary > 12000;
/
declare
v_filas_cambiadas number;
v_mensaje varchar2(200);
begin 
update employees1 set job_id='AC_MGR' where salary >17000;
v_filas_cambiadas:= SQL%rowcount;
v_mensaje:=('se han cambiado los job_id a ac_mgr de los salarios mayores de 17000');
insert into temp  (mensaje,codigo) values(v_mesaje, v_filas_cambiadas);
select * from employees1 where job_id='AC_MGR' and salary >17000;
/*if (v_filas_cambiadas>5) then
    delete from employees1 where salary>17000;
    v_filas_cambiadas:= SQL%rowcount;
    v_mensaje:=('se han borrado las filas con salarios mayores de 17000';
    insert temp into (mensaje,codigo) values(v_mesaje, v_filas_cambiadas);
elsif (v_filas_cambiadas>3) then*/
end;
/
select * from temp;
    
/
DECLARE 
v_total NUMBER := 0;
 BEGIN
 <<BeforeTopLoop>>
 FOR i IN 1..10 LOOP
 v_total := v_total + 1;
 dbms_output.put_line 
('Total is: ' || v_total);
 FOR j IN 1..10 LOOP
 CONTINUE BeforeTopLoop WHEN i + j > 5;
 v_total := v_total + 1;
 END LOOP;
 END LOOP BeforeTopLoop;
 END;
/



/*PRACTICA 6
1. Execute the command in the lab_06_01.sql file to create the messages table. Write a 
PL/SQL block to insert numbers into the messages table. 
a. Insert the numbers 1 through 10, excluding 6 and 8. 
b. Commit before the end of the block. 
c. Execute a SELECT statement to verify that your PL/SQL block worked.  
Result: You should see the following output: */

CREATE TABLE messages (results VARCHAR2(80));

begin
for i in 1..10 loop
insert into messages values(i);
end loop;
update messages set results=null where results in (6,8);
commit;
end;
/

select * from messages;



/*2. Execute the lab_06_02.sql script. This script creates an emp table that is a replica of the employees table. 
It alters the emp table to add a new column, stars, of VARCHAR2 data type and size 50. Create a PL/SQL block that
inserts an asterisk in the stars column for every $1000 of an employee’s salary. Save your script as lab_06_02_soln.sql.
a. In the declarative section of the block, declare a variable v_empno of type emp.employee_id and initialize it to 176. 
Declare a variable v_asterisk of type emp.stars and initialize it to NULL. Create a variable v_sal of type emp.salary.
b. In the executable section, write logic to append an asterisk (*) to the string for every $1,000 of the salary. 
For example, if the employee earns $8,000, the string of asterisks should contain eight asterisks. If the employee earns $12,500, 
the string of asterisks should contain 13 asterisks (rounded to the nearest whole number). 
c. Update the stars column for the employee with the string of asterisks. Commit before the end of the block. 
d. Display the row from the emp table to verify whether your PL/SQL block has executed successfully.  
e. Execute and save your script as lab_06_02_soln.sql. The output is as follows:*/
/
DROP TABLE emp;
CREATE TABLE emp AS SELECT * FROM employees;
ALTER TABLE    emp  ADD stars	VARCHAR2(50);

/
declare
v_empno 
