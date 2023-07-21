create user c##superuser identified by asram default tablespace users temporary tablespace temp;
GRANT ALL PRIVILEGES to c##superuser;
alter user c##superuser quota unlimited on users;