-- PRACTICAS 14
/*1. Create a package specification and body called JOB_PKG, containing a copy of your 
ADD_JOB, UPD_JOB, and DEL_JOB procedures as well as your GET_JOB function. */

CREATE OR REPLACE PACKAGE job_pkg IS
    PROCEDURE add_job (p_jobid jobs.job_id%TYPE, p_jobtitle jobs.job_title%TYPE);
    PROCEDURE del_job (p_jobid jobs.job_id%TYPE);
    FUNCTION get_job (p_jobid IN jobs.job_id%TYPE) RETURN jobs.job_title%TYPE;
    PROCEDURE upd_job (p_jobid IN jobs.job_id%TYPE, p_jobtitle IN jobs.job_title%TYPE);
END;
/

CREATE OR REPLACE PACKAGE BODY job_pkg IS
    PROCEDURE add_job (p_jobid jobs.job_id%TYPE, p_jobtitle jobs.job_title%TYPE) IS
    BEGIN
        INSERT INTO jobs(job_id, job_title) VALUES (p_jobid, p_jobtitle);
        COMMIT;
    END;
    
    PROCEDURE del_job (p_jobid jobs.job_id%TYPE) IS
        BEGIN
            DELETE FROM jobs WHERE job_id = p_jobid;
            IF SQL%NOTFOUND THEN
                RAISE_APPLICATION_ERROR (-20203, 'No jobs deleted');
            END IF;
        END;
        
     FUNCTION get_job (p_jobid IN jobs.job_id%TYPE) RETURN jobs.job_title%TYPE IS
        v_title jobs.job_title%TYPE;
        BEGIN
            SELECT job_title into v_title FROM jobs WHERE job_id = p_jobid;
            RETURN v_title;
        END;
        
        
    PROCEDURE upd_job (p_jobid IN jobs.job_id%TYPE, p_jobtitle IN jobs.job_title%TYPE) IS
        BEGIN
            UPDATE jobs SET job_title = p_jobtitle WHERE job_id = p_jobid;
            IF SQL%NOTFOUND THEN
                RAISE_APPLICATION_ERROR (-20202, 'No jobs updated');
            END IF;
        END;
END;
/


-- d. Invoke your ADD_JOB package procedure by passing the values IT_SYSAN and SYSTEMS ANALYST as parameters.
BEGIN
    job_pkg.add_job('IT_SYSAN', 'System Analyst');
END;
/
SELECT * FROM jobs WHERE job_id = 'IT_SYSAN'; 