/*1. Create a package called TABLE_PKG that uses Native Dynamic SQL to create or drop a 
table, and to populate, modify, and delete rows from the table. The subprograms should 
manage optional default parameters with NULL values.  
a. Create a package specification with the following procedures:
    PROCEDURE make(p_table_name VARCHAR2, p_col_specs VARCHAR2) 
    PROCEDURE add_row(p_table_name VARCHAR2, p_col_values VARCHAR2, p_cols VARCHAR2 := NULL) 
    PROCEDURE upd_row(p_table_name VARCHAR2, p_set_values VARCHAR2, p_conditions VARCHAR2 := NULL) 
    PROCEDURE del_row(p_table_name VARCHAR2, p_conditions VARCHAR2 := NULL); 
    PROCEDURE remove(p_table_name VARCHAR2) */


create or replace package TABLE_PKG  AUTHID CURRENT_USER is 
    PROCEDURE make(p_table_name VARCHAR2, p_col_specs VARCHAR2) ;
   -- PROCEDURE add_row(p_table_name VARCHAR2, p_col_values VARCHAR2, p_cols VARCHAR2 := NULL); 
   -- PROCEDURE upd_row(p_table_name VARCHAR2, p_set_values VARCHAR2, p_conditions VARCHAR2 := NULL) ;
   -- PROCEDURE del_row(p_table_name VARCHAR2, p_conditions VARCHAR2 := NULL); 
   -- PROCEDURE remove(p_table_name VARCHAR2);
end TABLE_PKG;
/
show errors

create or replace package body TABLE_PKG is 
    procedure make (p_table_name VARCHAR2, p_col_specs VARCHAR2) is 
    v_cursor  integer;
    v_execute number;
    begin
        dbms_output.put_line( 'create table '||p_table_name|| ' ('||p_col_specs||')');
        v_cursor := DBMS_SQL.OPEN_CURSOR;
        DBMS_SQL.PARSE(
            v_cursor,   
            'create table '||p_table_name|| ' ('||p_col_specs||')', 
            DBMS_SQL.NATIVE
            );
        v_execute := DBMS_SQL.EXECUTE(v_cursor);
        DBMS_SQL.CLOSE_CURSOR(v_cursor);
        
    end;
end  TABLE_PKG;   
/
show errors
set serveroutput on

begin
TABLE_PKG.make('tab1', 'id number');
end;
/


create table tab1 (id number);