----------------------------------------------------------------------------
--     $Id: df.sql 21 2009-09-16 09:11:28Z soe $
----------------------------------------------------------------------------
--     Trivadis AG, Infrastructure Managed Services
--     Europa-Strasse 5, 8152 Glattbrugg, Switzerland
----------------------------------------------------------------------------
--     File-Name........:  df.sql
--     Author...........:  tanel@tanelpoder.com
--     Editor...........:  Stefan Oehrli stefan.oehrli@trivadis.com
--     Date.............:  $LastChangedDate: 2009-09-16 11:11:28 +0200 (Mi, 16 Sep 2009) $
--     Revision.........:  $LastChangedRevision: 21 $
--     Purpose..........:  Show Oracle tablespace free space in Unix df style
--     Usage............:  @df
--     Group/Privileges.:  n/a
--     Input parameters.:  n/a
--     Called by........:  --
--     Restrictions.....:  --
--     Notes............:  --
----------------------------------------------------------------------------
--     Revision history.:  see svn log
----------------------------------------------------------------------------

col "% Used" for a6
col "Used" for a22

select t.tablespace_name, t.mb "TotalMB", t.mb - nvl(f.mb,0) "UsedMB", nvl(f.mb,0) "FreeMB", 
       lpad(ceil((1-nvl(f.mb,0)/t.mb)*100)||'%', 6) "% Used", t.ext "Ext", 
       '|'||rpad(lpad('#',ceil((1-nvl(f.mb,0)/t.mb)*20),'#'),20,' ')||'|' "Used"
from (
  select tablespace_name, trunc(sum(bytes)/1048576) MB
  from dba_free_space
  group by tablespace_name
 union all
  select tablespace_name, trunc(sum(bytes_free)/1048576) MB
  from v$temp_space_header
  group by tablespace_name
) f, (
  select tablespace_name, trunc(sum(bytes)/1048576) MB, max(autoextensible) ext
  from dba_data_files
  group by tablespace_name
 union all
  select tablespace_name, trunc(sum(bytes)/1048576) MB, max(autoextensible) ext
  from dba_temp_files
  group by tablespace_name
) t
where t.tablespace_name = f.tablespace_name (+)
order by t.tablespace_name;

