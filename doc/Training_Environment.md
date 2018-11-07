# Setup Oracle Security Training LAB

## Todo Test Umgebungen

### DB Server

* yum upgrade => erledigt
* passwort reset root/oracle => erledigt
* DOAG SSH key => erledigt

### OUD Server

* yum upgrade => erledigt
* passwort reset root/oracle => erledigt
* DOAG SSH key => erledigt

### AD Server

* Windows Update => erledigt
* DNS Alias für db.trivadislabs.com => erledigt


## Configure SSH

Create local ssh configuration.

```bash
# -------------------------------------------------------------------------------------
# Oracle Security Training
# -------------------------------------------------------------------------------------
Host database.tvdlab.com
   HostName db-appoehrlsecfromblu-ulqznhek.srv.ravcloud.com
   ForwardAgent yes
   ForwardX11Trusted yes
   Compression yes
   User oracle

Host oud.tvdlab.com
   HostName oud-appoehrlsecfromblu-4sf8ojti.srv.ravcloud.com
   ForwardAgent yes
   ForwardX11Trusted yes
   Compression yes
   User oracle
```

Copy the SSH ID's to the servers

```bash
ssh-copy-id root@35.234.65.198
ssh-copy-id oracle@35.234.65.198
ssh-copy-id root@35.234.65.198
ssh-copy-id oracle@35.234.65.198
```


ssh root@oud.tvdlab.com

curl -f https://codeload.github.com/oehrlis/oradba_init/zip/master -o /tmp/oradba_init.zip
unzip -o /tmp/oradba_init.zip -d /opt
mv /opt/oradba_init-master /opt/oradba
mv /opt/oradba/README.md /opt/oradba/doc
rm -rf /tmp/oradba_init.zip

cd /opt/oradba/bin
./00_setup_os_oud.sh

ssh-copy-id oracle@oud.tvdlab.com

ssh oud.tvdlab.com

```bash
for i in p27412890_180172_Linux-x86-64.zip \
         p26270957_122130_Generic.zip \
         p28245820_122130_Generic.zip \
         p26269885_122130_Generic.zip \
         p27342434_122130_Generic.zip \
         p27912627_122130_Generic.zip; do
    scp $i oud.tvdlab.com:/opt/stage/
done
```

```bash
for i in LINUX.X64_180000_db_home.zip \
         LINUX.X64_180000_examples.zip \
         p6880880_122010_Linux-x86-64.zip \
         linuxx64_12201_database.zip \
         linuxx64_12201_examples.zip \
         p28163133_122010_Linux-x86-64.zip \
         p27923353_122010_Linux-x86-64.zip; do
    scp -C $i database.tvdlab.com:/opt/stage/
done
```


OJVM RELEASE UPDATE 12.2.0.1.180717 (Patch)
https://updates.oracle.com/Orion/Services/download/p27923353_122010_Linux-x86-64.zip?aru=22237223&patch_file=p27923353_122010_Linux-x86-64.zip

SHA-256	66557BBE053D100FFB540C9D02D8E80E23D51DFBC94E77D2E99A984259F18937
SHA-1	AB14E7DBFE33ABCC30708F0AB7B32F3C1D3D0E35


Patch 28163133: DATABASE JUL 2018 RELEASE UPDATE 12.2.0.1.180717

https://updates.oracle.com/Orion/Services/download/p28163133_122010_Linux-x86-64.zip?aru=22313390&patch_file=p28163133_122010_Linux-x86-64.zip
DATABASE JUL 2018 RELEASE UPDATE 12.2.0.1.180717 (Patch)
p28163133_122010_Linux-x86-64.zip	258.7 MB	(271289497 bytes)
SHA-1	ADA5E6C7AD07F357C3CDAC52236EEA09AB0530FF
SHA-256	529F5D9FD7112640E1B41F0DE70CCDEF83865ADC86D2CB60190CA90330F9074E

```bash
MOS_USER="cpureport@trivadis.com"
MOS_PASSWORD="tr1vad1$"
echo "machine login.oracle.com login ${MOS_USER} password ${MOS_PASSWORD}" >/opt/stage/.netrc
echo "machine updates.oracle.com login ${MOS_USER} password ${MOS_PASSWORD}" >>/opt/stage/.netrc

echo "https://updates.oracle.com/Orion/Services/download/p26270957_122130_Generic.zip?aru=21504981&patch_file=p26270957_122130_Generic.zip" >/opt/stage/oracle_downloads.txt
echo "https://updates.oracle.com/Orion/Services/download/p28245820_122130_Generic.zip?aru=22286689&patch_file=p28245820_122130_Generic.zip" >>/opt/stage/oracle_downloads.txt
echo "https://updates.oracle.com/Orion/Services/download/p26269885_122130_Generic.zip?aru=21502041&patch_file=p26269885_122130_Generic.zip" >>/opt/stage/oracle_downloads.txt
echo "https://updates.oracle.com/Orion/Services/download/p27912627_122130_Generic.zip?aru=22170259&patch_file=p27912627_122130_Generic.zip" >>/opt/stage/oracle_downloads.txt
echo "https://updates.oracle.com/Orion/Services/download/p27412890_180172_Linux-x86-64.zip?aru=22095211&patch_file=p27412890_180172_Linux-x86-64.zip" >>/opt/stage/oracle_downloads.txt
for i in $(cat /opt/stage/oracle_downloads.txt); do
    o=$(echo $i| cut -d= -f3 )
    curl --netrc-file /opt/stage/.netrc --cookie-jar /opt/stage/cookie-jar.txt \
        --location-trusted ${i} -o /opt/stage/${o}
done
```

```bash
MOS_USER="cpureport@trivadis.com"
MOS_PASSWORD="tr1vad1$"
echo "machine login.oracle.com login ${MOS_USER} password ${MOS_PASSWORD}" >/opt/stage/.netrc
echo "machine updates.oracle.com login ${MOS_USER} password ${MOS_PASSWORD}" >>/opt/stage/.netrc

echo "" >/opt/stage/oracle_downloads.txt
echo "" >>/opt/stage/oracle_downloads.txt
echo "" >>/opt/stage/oracle_downloads.txt
echo "" >>/opt/stage/oracle_downloads.txt
echo "" >>/opt/stage/oracle_downloads.txt
echo "https://updates.oracle.com/Orion/Services/download/p6880880_122010_Linux-x86-64.zip?aru=22116395&patch_file=p6880880_122010_Linux-x86-64.zip" >>/opt/stage/oracle_downloads.txt
for i in $(cat /opt/stage/oracle_downloads.txt); do
    o=$(echo $i| cut -d= -f3 )
    curl --netrc-file /opt/stage/.netrc --cookie-jar /opt/stage/cookie-jar.txt \
        --location-trusted ${i} -o /opt/stage/${o}
done
```


curl "http://download.oracle.com/otn/linux/oracle18c/180000/LINUX.X64_180000_db_home.zip?AuthParam=1538054529_925d7cd3bbf4201083be479959eed1e1" -o LINUX.X64_180000_db_home.zip
curl "http://download.oracle.com/otn/linux/oracle18c/180000/LINUX.X64_180000_examples.zip?AuthParam=1538054582_617314d6ee43b5f22aea592ab3801a74" -o LINUX.X64_180000_examples.zip
curl "http://download.oracle.com/otn/linux/oracle12c/122010/linuxx64_12201_database.zip?AuthParam=1538055864_bd6c90b1ee2baff82f23900564648364" -o linuxx64_12201_database.zip
curl "http://download.oracle.com/otn/linux/oracle12c/122010/linuxx64_12201_examples.zip?AuthParam=1538055911_1b449407c7a9ef27fe138e9beb3f6ae4" -o linuxx64_12201_examples.zip
curl "https://aru-akam.oracle.com/adcarurepos/vol/patch41/PLATFORM/CORE/Linux-x86-64/R600000000018520/p27923353_122010_Linux-x86-64.zip?FilePath=/adcarurepos/vol/patch41/PLATFORM/CORE/Linux-x86-64/R600000000018520/p27923353_122010_Linux-x86-64.zip&File=p27923353_122010_Linux-x86-64.zip&params=aHNaZnFERFZEczVXRm9uTU5MS2t6ZzphcnU9MjIyMzcyMjMmZW1haWw9c3RlZmFuLm9laHJsaUB0cml2YWRpcy5jb20mZmlsZV9pZD0xMDA1Mzg3ODYmcGF0Y2hfZmlsZT1wMjc5MjMzNTNfMTIyMDEwX0xpbnV4LXg4Ni02NC56aXAmdXNlcmlkPW8tc3RlZmFuLm9laHJsaUB0cml2YWRpcy5jb20mc2l6ZT0xMTQyNzM4NDImY29udGV4dD1BQDEwK0hAYWFydXZtdHAwMy5vcmFjbGUuY29tK1BAJmRvd25sb2FkX2lkPTM4ODEyMjc3OQ@@&AuthParam=1538063864_e12dc427f706ce43d156a9920d28390e" -o p27923353_122010_Linux-x86-64.zip
curl "https://aru-akam.oracle.com/adcarurepos/vol/patch37/PLATFORM/CORE/Linux-x86-64/R600000000018520/p28163133_122010_Linux-x86-64.zip?FilePath=/adcarurepos/vol/patch37/PLATFORM/CORE/Linux-x86-64/R600000000018520/p28163133_122010_Linux-x86-64.zip&File=p28163133_122010_Linux-x86-64.zip&params=eUhxQVVvVXJKVjJ2NnpKb0xkK0ZqZzphcnU9MjIzMTMzOTAmZW1haWw9c3RlZmFuLm9laHJsaUB0cml2YWRpcy5jb20mZmlsZV9pZD0xMDA3MjU3MjUmcGF0Y2hfZmlsZT1wMjgxNjMxMzNfMTIyMDEwX0xpbnV4LXg4Ni02NC56aXAmdXNlcmlkPW8tc3RlZmFuLm9laHJsaUB0cml2YWRpcy5jb20mc2l6ZT0yNzEyODk0OTcmY29udGV4dD1BQDEwK0hAYWFydXZtdHAwNy5vcmFjbGUuY29tK1BAJmRvd25sb2FkX2lkPTM4ODEyMzYyNA@@&AuthParam=1538063955_38390381d05dfe35782b7473bc66edc1" -o p28163133_122010_Linux-x86-64.zip