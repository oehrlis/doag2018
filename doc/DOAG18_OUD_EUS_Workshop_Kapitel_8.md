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

```sql
create user vpd_admin identified by vpd_admin;

User created.

SQL> grant CONNECT,RESOURCE,EXECUTE_CATALOG_ROLE TO vpd_admin;

select department_id from employees where manager_id = (select employee_id from employees where manager_id is null) and upper(last_name)='RIDER';

DEPARTMENT_ID
-------------
	   70
select last_name,department_id,manager_id from employees where employee_id = (select employee_id from employees where upper(last_name)='BOND');

```

## Oracle Unified Directory Server

Generell wichtig

### Trivadis OUD Base

Wie wo was ist basenv

## MS Active Directory Server

AD VM ist hier

### AD Domain TRIVADISLAB

Die Domain
