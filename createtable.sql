create table users(aid number primary key, name varchar(20), age number, houseno varchar(5), street varchar(20), city varchar(20), pin number, uname varchar(20) not null unique, password varchar(20) not null);

create table property(pid number primary key, oid number not null, total_area number not null, plinth_area number not null, available_from date not null, available_till date, address varchar(50) not null, locality varchar(20) not null, type varchar(20) not null, bedroomsno number, construction_year number not null, annual_hike number not null, foreign key(oid) references users(aid));

create table user_phone(userid number, phone number, primary key(userid, phone), foreign key(userid) references users(aid));

create table rent(tid number, pid number, start_date date, end_date date, rentpm number not null, yearly_hike number not null, commission number, primary key(tid, pid, start_date), foreign key(pid) references property(pid), foreign key(tid) references users(aid));

create table rent_history(pid number, start_date date, tid number, total_rent number not null, primary key(tid, pid, start_date), foreign key(tid, pid, start_date) references rent(tid, pid, start_date));