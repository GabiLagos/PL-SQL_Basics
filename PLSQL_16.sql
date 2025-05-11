/*1. Create a package called TABLE_PKG that uses Native Dynamic SQL to create or drop a 
table, and to populate, modify, and delete rows from the table. The subprograms should 
manage optional default parameters with NULL values.  
a. Create a package specification with the following procedures:
    PROCEDURE make(p_table_name VARCHAR2, p_col_specs VARCHAR2) 
    PROCEDURE add_row(p_table_name VARCHAR2, p_col_values VARCHAR2, p_cols VARCHAR2 := NULL) 
    PROCEDURE upd_row(p_table_name VARCHAR2, p_set_values VARCHAR2, p_conditions VARCHAR2 := NULL) 
    PROCEDURE del_row(p_table_name VARCHAR2, p_conditions VARCHAR2 := NULL); 
    PROCEDURE remove(p_table_name VARCHAR2) */

declare
v1 varchar2(200);    

begin
v1:='&procedimiento_dame_un_nombre';
execute immediate ('create table ' ||v1||'(c1 varchar2(20))');
end;
/

drop table tabla_prueba;
drop table t1;
    
    
    
CREATE PROCEDURE compile_plsql(p_name VARCHAR2,
p_plsql_type VARCHAR2, p_options VARCHAR2 := NULL) IS
v_stmt varchar2(200) := 'ALTER '|| p_plsql_type || ' '|| p_name || ' COMPILE';
BEGIN
    IF p_options IS NOT NULL THEN
        v_stmt := v_stmt || ' ' || p_options;
    END IF;
    
    EXECUTE IMMEDIATE v_stmt;
END;
 /    
 
begin
compile_plsql('f1', 'function');
end;
/


CREATE or replace PROCEDURE compile_plsql_1(p_name VARCHAR2,
p_plsql_type VARCHAR2, p_options VARCHAR2 := NULL) IS
v_stmt varchar2(200) := 'ALTER :1 :2  COMPILE :3';
BEGIN
    IF p_options IS NOT NULL THEN
        execute immediate v_stmt using p_plsql_type, p_name, p_options;
    ELSE 
        execute immediate v_stmt using p_plsql_type, p_name;
    END IF;
    
    EXECUTE IMMEDIATE v_stmt;
END;
 /
 
begin
compile_plsql_1('f1', 'function');
end;
/
    