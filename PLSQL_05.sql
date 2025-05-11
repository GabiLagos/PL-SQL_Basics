/*Tema 5 Uso de sentencias SQL dentro de un bloque PL/SQL

• En un bloque PL/SQL, se utilizan sentencias SQL para recuperar y modificar datos de la tabla
de la base de datos.
    – PL/SQL soporta el lenguaje de manipulación de datos (DML) y los comandos de control de transacciones COMMIT,
    ROLLBACK, SAVEPOINT

• Sin embargo, recuerde los siguientes puntos mientras usa sentencias DML y comandos de
control de transacciones en bloques PL/SQL:
    – La palabra clave END indica el final de un bloque PL/SQL, no el final de una transacción.
    – PL/SQL no soporta directamente declaraciones de lenguaje de definición de datos (DDL) como CREATE
    TABLE, ALTER TABLE o DROP TABLE
    — Debe utilizar SQL dinámico para ejecutar las instrucciones DDL en PL/SQL
    – PL/SQL no admite directamente instrucciones de lenguaje de control de datos (DCL) como GRANT o REVOKE

• Cuando la consulta devuelve más de una fila hay que utilizar cursores, de lo contrario el SELECT...INTO va a dar error
: NO_DATA_FOUND y TOO_MANY_ROWS*/

/*PRACTICA 5
1. Create a PL/SQL block that selects the maximum department ID in the departments table and stores it in the v_max_deptno variable. Display the maximum department ID. 
a. Declare a variable v_max_deptno of type NUMBER in the declarative section. 
b. Start the executable section with the BEGIN keyword and include a SELECT statement to retrieve the maximum department_id from the departments table. 
c. Display v_max_deptno and end the executable block. 
d. Execute and save your script as lab_05_01_soln.sql. The sample output is as follows: */

DECLARE
v_max_deptno NUMBER; 

BEGIN
    SELECT max(department_id) INTO v_max_deptno
    FROM departments; 
    
    DBMS_OUTPUT.PUT_LINE(' The maximum department ID is;  '||v_max_deptno ); 
    
END;
/

/*2. Modify the PL/SQL block that you created in step 1 to insert a new department into the departments table.  
a. Load the lab_05_01_soln.sql script. Declare two variables:  
v_dept_name of type departments.department_name and 
v_dept_id of type NUMBER. 
Assign 'Education' to v_dept_name in the declarative section. 
b. You have already retrieved the current maximum department number from the departments table. Add 10 to it and assign the result to v_dept_id. 
c. Include an INSERT statement to insert data into the department_name, department_id, and location_id columns of the departments table.  
Use the values in v_dept_name and v_dept_id for department_name and department_id, respectively, and use NULL for location_id.
d. Use the SQL attribute SQL%ROWCOUNT to display the number of rows that are affected. 
e. Execute a SELECT statement to check whether the new department is inserted. You 
can terminate the PL/SQL block with “/” and include the SELECT statement in your script. 
f. Execute and save your script as lab_05_02_soln.sql. The sample output is as follows:*/  
describe departments;
select * from departments;
DECLARE
v_max_deptno NUMBER; 
v_dept_name  departments.department_name%TYPE :='Education';
v_dept_id NUMBER;
v_rows_afected VARCHAR2(30);
BEGIN
    SELECT max(department_id) INTO v_max_deptno FROM departments; 
    v_max_deptno := v_max_deptno + 10;
    INSERT INTO departments (department_id, department_name, location_id) values (v_max_deptno, v_dept_name, null);
     v_rows_afected := (SQL%ROWCOUNT ||' row changed.');
     DBMS_OUTPUT.PUT_LINE (v_rows_afected);
END;
/


/*3. In step 2, you set location_id to NULL. Create a PL/SQL block that updates location_id to 3000 for the new department.  
Note: If you successfully completed step 2, continue with step 3a. If not, first execute the solution script /soln/sol_05.sql.  (Task 2 in sol_05.sql)  
a. Start the executable block with the BEGIN keyword. Include the UPDATE statement to set location_id to 3000 for the new department (v_dept_id =280). 
b. End the executable block with the END keyword. Terminate the PL/SQL block with “/” and include a SELECT statement to display the department that you updated.
c. Include a DELETE statement to delete the department that you added. 
d. Execute and save your script as lab_05_03_soln.sql. The sample output is as follows: */

DECLARE
v_loc number :=3000;
v_rows_afected VARCHAR2(30);
BEGIN
        UPDATE departments
        SET  location_id = v_loc
        WHERE department_id = 280;
        v_rows_afected := (SQL%ROWCOUNT ||' row(s) changed.');
        DBMS_OUTPUT.PUT_LINE (v_rows_afected);
END;
/