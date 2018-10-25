----------------------------------------------------------------------------
--     $Id: ua.sql 21 2009-09-16 09:11:28Z soe $
----------------------------------------------------------------------------
--     Trivadis AG, Infrastructure Managed Services
--     Europa-Strasse 5, 8152 Glattbrugg, Switzerland
----------------------------------------------------------------------------
--     File-Name........:  ua.sql
--     Author...........:  tanel@tanelpoder.com
--     Editor...........:  Stefan Oehrli stefan.oehrli@trivadis.com
--     Date.............:  $LastChangedDate: 2009-09-16 11:11:28 +0200 (Mi, 16 Sep 2009) $
--     Revision.........:  $LastChangedRevision: 21 $
--     Purpose..........:  Show active user sessions in database (no background procs)
--     Usage............:  @ua
--     Group/Privileges.:  n/a
--     Input parameters.:  n/a
--     Called by........:  --
--     Restrictions.....:  --
--     Notes............:  --
----------------------------------------------------------------------------
--     Revision history.:      see svn log
----------------------------------------------------------------------------
col u_username head USERNAME for a23
col u_sid head SID for a14 
col u_audsid head AUDSID for 9999999999
col u_osuser head OSUSER for a16
col u_machine head MACHINE for a18
col u_program head PROGRAM for a20

select s.username u_username, ' ''' || s.sid || ',' || s.serial# || '''' u_sid, 
       s.audsid u_audsid,
       s.osuser u_osuser, 
       substr(s.machine,instr(s.machine,'\')) u_machine, 
       substr(s.program,1,20) u_program,
       p.spid, 
       -- s.sql_address, 
       s.sql_hash_value, 
       s.last_call_et lastcall, 
       s.status 
       --, s.logon_time
from 
    v$session s,
    v$process p
where
    s.paddr=p.addr
and s.type!='BACKGROUND'
and s.status='ACTIVE'
/

