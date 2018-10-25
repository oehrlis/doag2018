----------------------------------------------------------------------------
--     $Id: jobs.sql 21 2009-09-16 09:11:28Z soe $
----------------------------------------------------------------------------
--     Trivadis AG, Infrastructure Managed Services
--     Europa-Strasse 5, 8152 Glattbrugg, Switzerland
----------------------------------------------------------------------------
--     File-Name........:  jobs.sql
--     Author...........:  tanel@tanelpoder.com
--     Editor...........:  Stefan Oehrli stefan.oehrli@trivadis.com
--     Date.............:  $LastChangedDate: 2009-09-16 11:11:28 +0200 (Mi, 16 Sep 2009) $
--     Revision.........:  $LastChangedRevision: 21 $
--     Purpose..........:  list db jobs
--     Usage............:  @jobs
--     Group/Privileges.:  n/a
--     Input parameters.:  n/a
--     Called by........:  --
--     Restrictions.....:  --
--     Notes............:  --
----------------------------------------------------------------------------
--     Revision history.:      see svn log
----------------------------------------------------------------------------
col jobs_what head WHAT for a50
col jobs_interval head INTERVAL for a40

prompt "DBA Jobs"
select job, what jobs_what, last_date, next_date, interval jobs_interval, failures, broken from dba_jobs;

prompt "DBA Scheduler Jobs"
col PROGRAM_NAME head PROGRAM for a40
col next_run_date head NEXT_RUN_DATE for a40
select job_name, program_name, next_run_date, state, enabled from dba_scheduler_jobs;
