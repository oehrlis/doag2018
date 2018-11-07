# Kerberos Authentifizierung

- Einrichten keytab file
- DB user erstellen
- okinit auf db server
- kerkberos login auf DB server
- User informationen
- kerberos login remote vom AD domain
- bestehendne benutzer anpassen
- Kerberos mit Proxy kombinieren

Kurs Agenda
Einleitung
DB Authentifizierung und Password Verifier
Einführung Übungsumgebung
- wie ist die Umgebung aufgebaut (Architektur, Software, Zugriff)
- TRIVADISLAB Domain
- Firma Born Inc.
- passwörter
- Zugriff via ssh / putty
- Zugriff via Remote Desktop
- Trivadis Basenv und OUD Base
Übungen Password Verifier
Kerberos Authentifizierung
Übungen Kerberos Authentifizierung

User anlegen

krb5 file auf dem server anlegen
####krb5.conf DB Server

```bash
[libdefaults]
 default_realm = TRIVADISLABS.COM
 clockskew=300
 ticket_lifetime = 24h
 renew_lifetime = 7d
 forwardable = true

[realms]
 TRIVADISLABS.COM = {
   kdc = ad.trivadislabs.com
   admin_server = ad.trivadislabs.com
}

[domain_realm]
.trivadislabs.com = TRIVADISLABS.COM
trivadislabs.com = TRIVADISLABS.COM
```

sqlnet.ora file

```bash
##########################################################################
# Kerberos Configuration
##########################################################################
SQLNET.AUTHENTICATION_SERVICES = (BEQ,KERBEROS5)
SQLNET.FALLBACK_AUTHENTICATION = TRUE
SQLNET.KERBEROS5_KEYTAB = /u00/app/oracle/network/admin/db.trivadislabs.com.keytab
SQLNET.KERBEROS5_REALMS = /u00/app/oracle/network/admin/krb.realms
SQLNET.KERBEROS5_CC_NAME = /u00/app/oracle/network/admin/krbcache
SQLNET.KERBEROS5_CONF = /u00/app/oracle/network/admin/krb5.conf
SQLNET.KERBEROS5_CONF_MIT=TRUE
SQLNET.AUTHENTICATION_KERBEROS5_SERVICE = oracle

```

Create the keytab file

```batch
ktpass.exe -princ oracle/db.trivadislabs.com@TRIVADISLABS.COM \
    -mapuser db.trivadislabs.com -pass manager \
    -crypto ALL -ptype KRB5_NT_PRINCIPAL \
    -out C:\u00\app\oracle\network\db.trivadislabs.com.keytab
```

```bash
ktpass.exe -princ oracle/db.trivadislabs.com@TRIVADISLABS.COM -mapuser db.trivadislabs.com -pass manager -crypto ALL -ptype KRB5_NT_PRINCIPAL  -out C:\u00\app\oracle\network\db.trivadislabs.com.keytab
```

Kaffeepause Vormittag
Kerberos Troubleshooting
- was gibts so für Probleme
    - Namesauflösung und DNS Probleme
    - Zeit Differenzen
    - Keytab File falsch z.B. falscher Algorithmus, vno Nummer etc
    - 
- welche Möglichkeiten für die Problemanalyse stehen zur Verfügung
- SQLNet Trace
- Wireshark
- TRACE File

