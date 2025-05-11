/* Tema 4 Escribir declaraciones ejecutables

Nota: RECORDAR
DECLARE
Todo lo que esta declarado debe estar separado por ;
BEGIN

EXCEPTION
Todas las excepciones deben estar separadas por ;

END; <-siempre termina en;
*/

/*PRACTICA 4*/
DECLARE
    v_weight  NUMBER(3) := 600;
    v_message VARCHAR2(255) := 'Product 11001';
BEGIN
    DECLARE
        v_weight   NUMBER(3) := 1;
        v_message  VARCHAR2(255) := 'Product 10012';
        v_new_locn VARCHAR2(50) := 'Europe';
    BEGIN
        v_weight := v_weight + 1;
        v_new_locn := 'Western ' || v_new_locn;
    --position 1
    END;

    v_weight := v_weight + 1;
    v_message := v_message || ' is in stock';
    v_new_locn := 'Western ' || v_new_locn;
    --position 2
END;
/

/*1. Evaluate the preceding PL/SQL block and determine the data type and value of each of the 
following variables, according to the rules of scoping. 
a. The value of v_weight at position 1 is: 2
b. The value of v_new_locn at position 1 is: Western Europe
c. The value of v_weight at position 2 is: 601
d. The value of v_message at position 2 is: Product 10012  is in stock
e. The value of v_new_locn at position 2 is: ERROR
*/

--2.
DECLARE
    v_customer      VARCHAR2(50) := 'Womansport';
    v_credit_rating VARCHAR2(50) := 'EXCELLENT';
BEGIN
    DECLARE
        v_customer NUMBER(7) := 201;
        v_name     VARCHAR2(25) := 'Unisports';
    BEGIN
        v_credit_rating := 'GOOD';
    --… 
    END;
--… 
END;

/*In the preceding PL/SQL block, determine the value and data type of each of the following 
cases: 
a. The value of v_customer in the nested block is: 201
b. The value of v_name in the nested block is: Unisports
c. The value of v_credit_rating in the nested block is: GOOD 
d. The value of v_customer in the main block is: Womansport
e. The value of v_name in the main block is: ERROR
f. The value of v_credit_rating in the main block is: EXCELLENT
 */
 
 /*3. Use the same session that you used to execute the practices in the lesson titled “Declaring 
PL/SQL Variables.” If you have opened a new session, execute lab_03_05_soln.sql. 
Then, edit lab_03_05_soln.sql as follows: 
a. Use single-line comment syntax to comment the lines that create the bind variables, 
and turn on SERVEROUTPUT.*/
set serveroutput on
--variable b_pf_percent number
--variable b_basic_percent number

DECLARE
v_basic_percent NUMBER:=45; 
v_pf_percent NUMBER:=12; 
v_fname VARCHAR2(15); 
v_emp_sal NUMBER(10); 

BEGIN
    SELECT first_name, salary INTO v_fname, v_emp_sal 
    FROM employees WHERE employee_id=110; 
    /*:b_pf_percent := 12;
    :b_basic_percent := 45;*/
    DBMS_OUTPUT.PUT_LINE(' Hello '|| v_fname); 
    DBMS_OUTPUT.PUT_LINE('YOUR SALARY IS : '||v_emp_sal); 
    DBMS_OUTPUT.PUT_LINE('YOUR CONTRIBUTION TOWARDS PF:  '||v_emp_sal*v_basic_percent/100*v_pf_percent/100);
END;
/

--print b_basic_percent
--print b_pf_percent




--EJERCICIOS INTRODUCCION y CONCEPTOS 
/*EJERCICIO Nº1   
Crear un bloque pl/sql que devuelva el nombre del empleado que tiene su comisión con el valor 
0,4.*/

DECLARE
    v_nombre   employees.first_name%TYPE; 
    v_salario  NUMBER(8,2);
    v_comision employees.commission_pct%TYPE;
BEGIN
    SELECT first_name ||' '|| last_name, salary, nvl(commission_pct, 0)
    INTO v_nombre, v_salario, v_comision
    FROM employees
    WHERE  commission_pct = 0.4;

    dbms_output.put_line(v_nombre || ' tiene un salario de ' || v_salario || '$ y una comison de ' || v_comision || '%');
END;


/*EJERCICIO Nº2  
Crear un bloque pl/sql que devuelva la diferencia de salario existente entre el salario del 
empleado Steven King y la media de los salarios de los empleados de la tabla EMPLOYEES.*/
select salary from employees where first_Name='Steven' and last_name='King';
DECLARE
    v_salario_king  NUMBER(8,2)  ;
    v_salario_avg  NUMBER(8,2);
    v_dif_sal NUMBER(8,2) ;
BEGIN
    SELECT  salary INTO v_salario_king   FROM employees WHERE first_Name='Steven' and last_name = 'King';
    SELECT round(avg(salary),0) into v_salario_avg  FROM employees;
    v_dif_sal := v_salario_king-v_salario_avg;
    dbms_output.put_line('El salario d Steven King es: '||v_salario_king);
    dbms_output.put_line('La media de los salarios es: '||v_salario_avg);
    dbms_output.put_line('La diferencia de los salarios es: '||v_dif_sal );
END;

