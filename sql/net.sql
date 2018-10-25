------------------------------------------------------------------------
- Trivadis AG, Business Development & Support (BDS)
- Saegereistrasse 29, 8152 Glattbrugg, Switzerland
------------------------------------------------------------------------
- Name.......: net.sql
- Author.....: Stefan Oehrli (oes) stefan.oehrli@trivadis.com
- Usage......: net.sql
- Purpose....: List current session connection information
- Notes......: --
- Reference..: --
- License....: GPL-3.0+
------------------------------------------------------------------------
col net_sid head SID for 99999
col net_osuser head OS_USER for a10
col net_authentication_type head AUTH_TYPE for a10 
col net_network_service_banner head NET_BANNER for a100

select 
    sid                    net_sid, 
    osuser                 net_osuser, 
    authentication_type    net_authentication_type, 
    network_service_banner net_network_service_banner
from v$session_connect_info
where sid=(select sid from v$mystat where rownum = 1);
