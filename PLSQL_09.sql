--TEMA 9 Manejo de excepciones
 DECLARE
 v_lname VARCHAR2 (15);
 BEGIN
 SELECT last_name INTO v_lname
 FROM employees
 WHERE first_name = 'John';
 DBMS_OUTPUT.PUT_LINE ('Last name is :'|| v_lname);
 EXCEPTION
 WHEN TOO_MANY_ROWS THEN
 DBMS_OUTPUT.PUT_LINE (' Your SELECT statement 
Consider using a cursor.');
 WHEN NO_DATA_FOUND THEN
 DBMS_OUTPUT.PUT_LINE (' Not Data Found');
 END;
 /
 
 
 
 declare
 v_fisrt_name employees.first_name%TYPE;
 begin
 select first_name into v_fisrt_name from employees where salary=17000;
 dbms_output.put_line(v_fisrt_name);
 exception
    when too_many_rows then
    dbms_output.put_line('Se ha devuelto mas de una fila');
end;
/


/*https://www.msn.com/es-es/estilo/shopping/9-plantas-que-deber%C3%ADas-empezar-a-multiplicar-con-esquejes/ss-AA1pM0sC?ocid=msedgntp&pc=U531&cvid=1912effa240148ab8bf19fc9ec4dc420&ei=85#image=2*/
 



declare
v_ename employees.last_name%TYPE;
v_emp_sal  employees.salary%TYPE :=5800;
begin
select last_name into v_ename from employees where salary= v_emp_sal;
insert into messages values( v_ename ||' tiene un salario de: '||v_emp_sal);
exception
    when no_data_found then
        insert into messages values ('No hay empleados con un salario de: '||' '||to_char(v_emp_sal));
    when too_many_rows then
        insert into messages values ('Hay mas de un empleado con un salario de: '||' '||to_char(v_emp_sal));
    when others then
        insert into messages values('Ha ocurrido algun otro error');
end;
/



--EJERCICIOS NO GUIADOS
/*Para un número de empleado dado incrementar su salario en un 10%. Deberemos preguntar el número del empleado por medio de variables BIND. 
En este bloque tendremos que controlar dos excepciones predefinidas de ORACLE: 
NO_DATA_FOUND  Tratamiento  
insertar en la table Temp ( 0 , ‘empleado no encontrado’) 
TOO_MANY_ROWS    Tratamiento  
insertar en la table Temp ( 1 , ‘muchos empleados’) */

declare
v_empid number;
begin
select employee_id into v_empid from employees where employee_id=&ID;
update employees set salary = salary*1.1 where employee_id=v_empid;
dbms_output.put_line(SQL%ROWCOUNT||' '||'filas actualizadas');
exception
    when no_data_found then
        insert into messages values ('0, No hay empleado encontrado');
        dbms_output.put_line('No existe el empleado con ID: '||v_empid);
    when too_many_rows then
        insert into messages values ('1, Muchos empleados');
         dbms_output.put_line('Hay mas de un empleado con el ID: '||v_empid);
end;
/
select * from messages;


/*Por medio de variables BIND aceptaremos tres valores que correspondan a un número de departamento, un nombre de un departamento y una ubicacion. 
Realizamos un bloque PL/SQL en el cual inserte en la tabla departments1 los valores que hemos introducido anteriormente. 
Deberemos controlar los siguientes errores: 
• Si ya existe, insertaremos en temp un error. ( 3 , ‘El departamento ya existe’) 
• Si ya existe, insertaremos en temp un error. ( 3 , ‘El departamento ya existe’) 
• Si ponemos un dato en una columna de menor longitud entonces insertamos un error en temp. ( 4 , ‘Error de tamaño) 
• Si se producen otros errores entonces insertar en temp el número y el mensaje del error. 
NOTA: El error ORACLE de longitud del dato fuera del rango es el - 1438. */
describe departments;
declare
v_deptid number := &v_deptid;
v_deptname varchar2(25) := &v_deptname;
v_locid number := &v_locid;
begin
insert into  departments(department_id, department_name, location_id) values(v_deptid, v_deptname, v_locid);
exception
end;

