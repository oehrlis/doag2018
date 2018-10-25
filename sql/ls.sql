----------------------------------------------------------------------------
--     $Id: ls.sql 21 2009-09-16 09:11:28Z soe $
----------------------------------------------------------------------------
--     Trivadis AG, Infrastructure Managed Services
--     Europa-Strasse 5, 8152 Glattbrugg, Switzerland
----------------------------------------------------------------------------
--     File-Name........:  ls.sql
--     Author...........:  tanel@tanelpoder.com
--     Editor...........:  Stefan Oehrli stefan.oehrli@trivadis.com
--     Date.............:  $LastChangedDate: 2009-09-16 11:11:28 +0200 (Mi, 16 Sep 2009) $
--     Revision.........:  $LastChangedRevision: 21 $
--     Purpose..........:  List datafiles belonging to tablespaces matching parameter
--     Usage............:  @ls <TABLESPACE_NAME>
--     Group/Privileges.:  n/a
--     Input parameters.:  n/a
--     Called by........:  --
--     Restrictions.....:  --
--     Notes............:  -- NVL(%&1%, '%')

----------------------------------------------------------------------------
--     Revision history.:      see svn log
----------------------------------------------------------------------------
col ls_file_name head FILE_NAME for a80
col ls_mb head MB
col ls_maxsize head MAXSZ

select 
    tablespace_name,
    file_id,
    file_name ls_file_name,
    autoextensible ext,
    round(bytes/1048576,2) ls_mb,
    decode(autoextensible, 'YES', round(maxbytes/1048576,2), null) ls_maxsize
from
    (select tablespace_name, file_id, file_name, autoextensible, bytes, maxbytes from dba_data_files where upper(tablespace_name) like upper('%&1%')
     union all
     select tablespace_name, file_id, file_name, autoextensible, bytes, maxbytes from dba_temp_files where upper(tablespace_name) like upper('%&1%')
    )
order by
    tablespace_name,
    file_name
;
