---
title: "DOAG Schulungstag 2018"
subtitle: "Übungen zum Workshop Oracle EUS mit OUD und AD Integration"
author: [Stefan Oehrli]
date: "02 November 2018"
tvddocversion: 0.1
papersize: a4 
listings-disable-line-numbers: true
titlepage: true
toc: true
toc-own-page: true
logo: "images/logo.eps"
...

# Einleitung DOAG Schulungstag 2018

Lirum larum lipsum

# Demo und Übungsumgebung

## Architektur

!["Training Environment"](images/training_env.png)
*Abb. 1: Architektur Schulungsumgebung*

## Oracle Datenbank Server

### Trivadis BasEnv

### Übungschema TVD_HR

VPD Mitarbeiter.

- Jeder Mitarbeiter sieht nur
    - Seinen kompleten Eintrag
    - Sein Team ohne Lohn / Kommission
    - Nicht die ganze Firma

- Jeder Manager sieht nur
    - Seinen kompleten Eintrag
    - Alles von Seinem Team
    - Ganze Firma aber ohne Lohn / Kommission

- CEO Sieht alles

- HR Manager sieht alles
    - HR Clerk 1 sieht alles aber nur Lohn / Kommission von der 1 Gruppe
    - HR Clerk 2 sieht alles aber nur Lohn / Kommission von der 2 Gruppe

create user vpd_admin identified by vpd_admin;

User created.

SQL> grant CONNECT,RESOURCE,EXECUTE_CATALOG_ROLE TO vpd_admin;

select department_id from employees where manager_id = (select employee_id from employees where manager_id is null) and upper(last_name)='RIDER';

DEPARTMENT_ID
-------------
	   70
select last_name,department_id,manager_id from employees where employee_id = (select employee_id from employees where upper(last_name)='BOND');


## Oracle Unified Directory Server

### Trivadis OUD Base

## MS Active Directory Server

### AD Domain TRIVADISLAB

# Datenbank Authentifizierung und Password Verifier

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

sqlnet.ora file

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



Create the keytab file

```batch
ktpass.exe -princ oracle/db.trivadislabs.com@TRIVADISLABS.COM \
    -mapuser db.trivadislabs.com -pass manager \
    -crypto ALL -ptype KRB5_NT_PRINCIPAL \
    -out C:\u00\app\oracle\network\db.trivadislabs.com.keytab
```
ktpass.exe -princ oracle/db.trivadislabs.com@TRIVADISLABS.COM -mapuser db.trivadislabs.com -pass manager -crypto ALL -ptype KRB5_NT_PRINCIPAL  -out C:\u00\app\oracle\network\db.trivadislabs.com.keytab

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
Centrally Managed User 18c
Übung Centrally Managed User 18c
Einführung OUD
Mittagessen
OUD Directroy Server und AD Proxy
Übung Unified Directory
Enterprise User Security
Übungen Enterprise User Security
Kaffeepause Nachmittag
Übungen Enterprise User Security
OUD HA und BR
EUS Troubleshooting
Zusammenfassung


Kursagenda
Einleitung
Datenbank Authentifizierung und Password Verifier
Einführung in die Cloud Übungsumgebung
Übungen Password Verifier
Kerberos Authentifizierung
Übungen Kerberos Authentifizierung
Kaffeepause Vormittag
Kerberos Troubleshooting
Oracle Centrally Managed User 18c
Übung Oracle Centrally Managed User 18c
Einführung Oracle Unified Directory
Mittagessen
Oracle Unified Directory, Directroy Server, Proxy Server und Active Directory Proxy
Übung Oracle Unified Directory
Oracle Enterprise User Security
Übungen Oracle Enterprise User Security Teil 1
Kaffeepause Nachmittag
Übungen Oracle Enterprise User Security Teil 2
Oracle Unified Directory, Hochverfügbarkeit und Backup & Recovery
Troubleshooting Enterprise User Security
Zusammenfassung und Abschluss