/* 2. Create and invoke a package that contains private and public constructs. 
a. Create a package specification and a package body called EMP_PKG that contains the following procedures and function that you created earlier:  
    1) ADD_EMPLOYEE procedure as a public construct 
    2) GET_EMPLOYEE procedure as a public construct  
    3) VALID_DEPTID function as a private construct */
    
CREATE OR REPLACE PACKAGE emp_pkg is
    PROCEDURE add_employee(
        p_fname employees.first_name%TYPE,
        p_lname employees.last_name%TYPE,
        p_email employees.email%TYPE,
        p_job employees.job_id%TYPE DEFAULT 'SA_REP',
        p_mgr employees.manager_id%TYPE DEFAULT 145,
        p_sal employees.salary%TYPE DEFAULT 1000,
        p_comm employees.commission_pct%TYPE DEFAULT 0,
        p_deptid employees.department_id%TYPE DEFAULT 30
    );  
    
    
    PROCEDURE get_employee(
    p_empid IN employees.employee_id%TYPE,
    p_sal OUT employees.salary%TYPE,
    p_job OUT employees.job_id%TYPE
    );
END;
/ 
SHOW ERRORS


CREATE OR REPLACE PACKAGE BODY emp_pkg IS
    PROCEDURE add_employee(
        p_fname employees.first_name%TYPE,
        p_lname employees.last_name%TYPE,
        p_email employees.email%TYPE,
        p_job employees.job_id%TYPE DEFAULT 'SA_REP',
        p_mgr employees.manager_id%TYPE DEFAULT 145,
        p_sal employees.salary%TYPE DEFAULT 1000,
        p_comm employees.commission_pct%TYPE DEFAULT 0,
        p_deptid employees.department_id%TYPE DEFAULT 30
    ) IS
    BEGIN
        IF valid_deptid(p_deptid) THEN
            INSERT INTO employees (employee_id, first_name, last_name, email, job_id, manager_id, hire_date, salary, commission_pct, department_id)
                VALUES(employees_seq.NEXTVAL, p_fname, p_lname, p_email, p_job, p_mgr, TRUNC(SYSDATE), p_sal, p_comm, p_deptid);
        ELSE
            RAISE_APPLICATION_ERROR (-20204, 'Invalid Department ID');
        END IF;
    END;
    
    
    PROCEDURE get_employee(
    p_empid IN employees.employee_id%TYPE,
    p_sal OUT employees.salary%TYPE,
    p_job OUT employees.job_id%TYPE
    ) IS
    BEGIN
        SELECT salary, job_id INTO p_sal, p_job FROM employees WHERE employee_id = p_empid;
    END;
END;
/
SHOW ERRORS


EXECUTE emp_pkg.add_employee('Jane', 'Harris','JAHARRIS', p_deptid => 15)

