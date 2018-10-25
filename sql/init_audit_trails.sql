----------------------------------------------------------------------------
--     $Id: $
----------------------------------------------------------------------------
--     Trivadis AG, Infrastructure Managed Services
--     Europa-Strasse 5, 8152 Glattbrugg, Switzerland
----------------------------------------------------------------------------
--     File-Name........:  init_audit_trails.sql
--     Author...........:  Stefan Oehrli (oes) stefan.oehrli@trivadis.com
--     Editor...........:  $LastChangedBy:   $
--     Date.............:  $LastChangedDate: $
--     Revision.........:  $LastChangedRevision: $
--     Purpose..........:  init audit trails
--     Usage............:  @br
--     Group/Privileges.:  SYS (or grant manually to a DBA)
--     Input parameters.:  none
--     Called by........:  as DBA or user with access to v$rman_backup_jobs
--     Restrictions.....:  unknown
--     Notes............:--
----------------------------------------------------------------------------
--		 Revision history.:      see svn log
----------------------------------------------------------------------------

BEGIN
  DBMS_AUDIT_MGMT.INIT_CLEANUP(
    AUDIT_TRAIL_TYPE => DBMS_AUDIT_MGMT.AUDIT_TRAIL_DB_STD,
    DEFAULT_CLEANUP_INTERVAL => 240 /*hours*/
  );
END;
/

BEGIN
  DBMS_AUDIT_MGMT.INIT_CLEANUP(
    AUDIT_TRAIL_TYPE => DBMS_AUDIT_MGMT.AUDIT_TRAIL_FILES,
    DEFAULT_CLEANUP_INTERVAL => 240 /*hours*/
  );
END;
/

col PARAMETER_NAME FOR a30
col PARAMETER_VALUE FOR a15
col AUDIT_TRAIL FOR a20
SELECT PARAMETER_NAME, PARAMETER_VALUE, AUDIT_TRAIL 
FROM DBA_AUDIT_MGMT_CONFIG_PARAMS ;

BEGIN
  DBMS_SCHEDULER.CREATE_JOB (
    job_name   => 'DAILY_AUDIT_TIMESTAMP_AUD',
    job_type   => 'PLSQL_BLOCK',
    job_action => 'BEGIN DBMS_AUDIT_MGMT.SET_LAST_ARCHIVE_TIMESTAMP(AUDIT_TRAIL_TYPE => 
                   DBMS_AUDIT_MGMT.AUDIT_TRAIL_AUD_STD,LAST_ARCHIVE_TIME => sysdate-7); END;', 
    start_date => sysdate, 
    repeat_interval => 'FREQ=HOURLY;INTERVAL=24', 
    enabled    =>  TRUE,
    comments   => 'Create an archive timestamp for standard audit'
  );
END;
/


BEGIN
  DBMS_SCHEDULER.CREATE_JOB (
    job_name   => 'DAILY_AUDIT_TIMESTAMP_FGA',
    job_type   => 'PLSQL_BLOCK',
    job_action => 'BEGIN DBMS_AUDIT_MGMT.SET_LAST_ARCHIVE_TIMESTAMP(AUDIT_TRAIL_TYPE => 
                   DBMS_AUDIT_MGMT.AUDIT_TRAIL_FGA_STD,LAST_ARCHIVE_TIME => sysdate-7); END;',
    start_date => sysdate,
    repeat_interval => 'FREQ=HOURLY;INTERVAL=24',
    enabled    =>  TRUE,
    comments   => 'Create an archive timestamp for FGA audit'
  );
END;
/

BEGIN
  DBMS_SCHEDULER.CREATE_JOB (
    job_name   => 'DAILY_AUDIT_TIMESTAMP_UNIFIED',
    job_type   => 'PLSQL_BLOCK',
    job_action => 'BEGIN DBMS_AUDIT_MGMT.SET_LAST_ARCHIVE_TIMESTAMP(AUDIT_TRAIL_TYPE => 
                   DBMS_AUDIT_MGMT.AUDIT_TRAIL_UNIFIED,LAST_ARCHIVE_TIME => sysdate-7); END;',
    start_date => sysdate,
    repeat_interval => 'FREQ=HOURLY;INTERVAL=24',
    enabled    =>  TRUE,
    comments   => 'Create an archive timestamp for unified audit'
  );
END;
/

BEGIN
  DBMS_SCHEDULER.CREATE_JOB (
    job_name   => 'DAILY_AUDIT_TIMESTAMP_OS',
    job_type   => 'PLSQL_BLOCK',
    job_action => 'BEGIN DBMS_AUDIT_MGMT.SET_LAST_ARCHIVE_TIMESTAMP(AUDIT_TRAIL_TYPE => 
                   DBMS_AUDIT_MGMT.AUDIT_TRAIL_OS,LAST_ARCHIVE_TIME => sysdate-7); END;',
    start_date => sysdate,
    repeat_interval => 'FREQ=HOURLY;INTERVAL=24',
    enabled    =>  TRUE,
    comments   => 'Create an archive timestamp for OS audit'
  );
END;
/

BEGIN
  DBMS_SCHEDULER.CREATE_JOB (
    job_name   => 'DAILY_AUDIT_TIMESTAMP_XML',
    job_type   => 'PLSQL_BLOCK',
    job_action => 'BEGIN DBMS_AUDIT_MGMT.SET_LAST_ARCHIVE_TIMESTAMP(AUDIT_TRAIL_TYPE => 
                   DBMS_AUDIT_MGMT.AUDIT_TRAIL_XML,LAST_ARCHIVE_TIME => sysdate-7); END;',
    start_date => sysdate,
    repeat_interval => 'FREQ=HOURLY;INTERVAL=24',
    enabled    =>  TRUE,
    comments   => 'Create an archive timestamp for XML audit'
  );
END;
/

BEGIN
  DBMS_AUDIT_MGMT.CREATE_PURGE_JOB(
    AUDIT_TRAIL_TYPE           => DBMS_AUDIT_MGMT.AUDIT_TRAIL_ALL,
    AUDIT_TRAIL_PURGE_INTERVAL => 24 /* hours */,
    AUDIT_TRAIL_PURGE_NAME     => 'Daily_Audit_Purge_Job',
    USE_LAST_ARCH_TIMESTAMP    => TRUE
  );
END;
/

col JOB_NAME FOR a30
col JOB_FREQUENCY FOR a40
SELECT JOB_NAME,JOB_STATUS,AUDIT_TRAIL,JOB_FREQUENCY FROM DBA_AUDIT_MGMT_CLEANUP_JOBS;
