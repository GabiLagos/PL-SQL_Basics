/*TEMA 7 Trabajo con tipos de datos compuestos
DATOS COMPUESTOS:
variable que contiene campos --> registros ej: una fila de una tabla uqe contiene tanto registros como columnas tenga la tabla
variable (matrices) que contiene elemneto --> colecciones ej: cada elemento puede ser una fila de una tabla
    array asociativo o tabla indezada
    tabla anidada
    varray
 VARIABLE tabla.column%TYPE   
 
 1. crear tipo de registro
 2. crear variable de tipo anterior
 3. gestionar la variable

ej;
declare
1. TYPE mi_registro is record
    TYPE
    (
    ----, t
    ----, t
    ----, t
    )
2. V1 mi_regsitro*/

/
DECLARE
 TYPE t_rec IS RECORD
 (v_sal number(8),
 v_minsal number(8) default 1000,
 v_hire_date employees.hire_date%type,
 v_rec1 employees%rowtype);
 v_myrec t_rec;
 BEGIN
 v_myrec.v_sal := v_myrec.v_minsal + 500;
 v_myrec.v_hire_date := sysdate;
 SELECT * INTO v_myrec.v_rec1
 FROM employees WHERE employee_id = 100;
 DBMS_OUTPUT.PUT_LINE(v_myrec.v_rec1.last_name ||' '||
 to_char(v_myrec.v_hire_date) ||' '|| to_char(v_myrec.v_sal));
 END;
 /
 
 
 declare 
 type mi_tipo is record(
 v_date date,
 v_edad number,
 v_nombre varchar2(20),
 v_salario number (8,2)
 );
 v_rec mi_tipo;
 begin
 v_rec.v_date:= sysdate;
 v_rec.v_edad:=18;
 DBMS_OUTPUT.PUT_LINE(
v_rec.v_date||' y ademas '||v_rec.v_edad
);
 END;
 /
 
--Modifica lo anterior para que aparezcan los datos del empleado mas atiguo, la edad seran los alos trabajados 
SET SERVEROUTPUT ON
DECLARE
  type mi_tipo is record (
    v_date  date,
    v_edad  number,
    v_nombre  varchar2(20),
    v_salario number(8,2)
    );
    var_reg mi_tipo;
BEGIN
select min(hire_date) into var_reg.v_date from employees;
select round(months_between(sysdate ,min( hire_date))/12 ,0) into var_reg.v_edad from employees;
select first_name||' '||last_name into var_reg.v_nombre from employees where hire_date =( select min(hire_date) from employees);
select salary into var_reg.v_salario from employees where hire_date =( select min(hire_date) from employees) ;
dbms_output.put_line(var_reg.v_date);
dbms_output.put_line(var_reg.v_edad);
dbms_output.put_line(var_reg.v_nombre);
dbms_output.put_line(var_reg.v_salario);
END;
/


--otra manera (mejor y mas eficiente)


/*%ROWTYPE: es lo mismo que el %TYPE pero aplicado a un tipo de registro, copia la estructura de campos de una tabla y se la aplica, 
copiando tambien los nombre de los campos*/
/
declare
v_total employees%ROWTYPE;
begin
select * into v_total from employees where hire_date=(select min(hire_date) from employees);
dbms_output.put_line(v_total.employee_id);
dbms_output.put_line(v_total.hire_date);
dbms_output.put_line(v_total.last_name);
dbms_output.put_line(v_total.salary);
END;
/
 
/*COLECCIONES
recuerda que siempre:
1. crear el tipo de dato
2. crear variable del tipo
3. gestion de la variable
ARRAYS ASOCIATIVOS o TABLAS INDEXADAS (TABLAS INDEX BY)


*/

/*PRACTICA 7
Note: If you have executed the code examples for this lesson, make sure that you execute the  following code before starting this practice: 
DROP table retired_emps; 
DROP table empl;
1. Write a PL/SQL block to print information about a given country. 
a. Declare a PL/SQL record based on the structure of the COUNTRIES table. 
b. Declare a variable v_countryid. Assign CA to v_countryid.
c. In the declarative section, use the %ROWTYPE attribute and declare the  v_country_record variable of type countries. 
d. In the executable section, get all the information from the COUNTRIES table by using  v_countryid. Display selected information about the country. T
e. You may want to execute and test the PL/SQL block for countries with the IDs DE, UK, and US.*/
/
declare 
v_countryid varchar2(2) :='CA';
v_country_record countries%ROWTYPE;
begin
select * into v_country_record from countries  where country_id=v_countryid;
dbms_output.put_line(v_country_record.country_id);
dbms_output.put_line(v_country_record.country_name);
dbms_output.put_line(v_country_record.region_id);
end;
/


/*2. Create a PL/SQL block to retrieve the names of some departments from the DEPARTMENTS table and print each department name on the screen,
incorporating an associative array. Save the script as lab_07_02_soln.sql.  
a. Declare an INDEX BY table dept_table_type of type departments.department_name. Declare a variable my_dept_table of type dept_table_type 
to temporarily store the names of the departments. 
b. Declare two variables: f_loop_count and v_deptno of type NUMBER. Assign 10 to f_loop_count and 0 to v_deptno. 
c. Using a loop, retrieve the names of 10 departments and store the names in the associative array. 
Start with department_id 10. Increase v_deptno by 10 for every loop iteration.*/

/
declare 
type departments_table_type is table of departments.department_name%TYPE index by pls_integer;
departments_table departments_table_type;
f_loop number := 10;
v_deptno number := 0;
begin
FOR i IN 1..28
 LOOP
 v_deptno:=v_deptno+10;
SELECT * INTO departments_table(i) FROM departments
WHERE department_id = v_deptno;
END LOOP;

FOR i IN 1..28
 LOOP
 dbms_output.put_line(departments_table(i));
END LOOP;
end;
/



--3.
/
declare 
type departments_table_type is table of departments%ROWTYPE index by pls_integer;
departments_table departments_table_type;
f_loop number := 10;
v_deptno number := 0;
begin
FOR i IN 1..28
 LOOP
 v_deptno:=v_deptno+10;
SELECT * INTO departments_table(i) FROM departments
WHERE department_id = v_deptno;
END LOOP;

FOR i IN 1..28
 LOOP
 dbms_output.put_line('Department '||departments_table(i).department_id
 ||'  Name  '||departments_table(i).department_name
 ||'  Manager '||departments_table(i).manager_id
 ||'  Location  '||departments_table(i).location_id);
END LOOP;
end;
/