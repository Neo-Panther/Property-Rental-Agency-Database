create or replace procedure CreateNewUser(id in number, uname in varchar2, pword in varchar2, phone in number, name in varchar2 default null, age in number default null, hno in number default null, street in varchar2 default null, city in varchar2 default null, pin in number default null) as
begin
insert into users values(id, name, age, hno, street, city, pin, uname, pword);
insert into user_phone values(id, phone);
dbms_output.put_line('User added successfully');
end;
/

create or replace procedure InsertUserPhone(id in number, phone in number) as
begin
insert into user_phone values(id, phone);
dbms_output.put_line('Phone number added');
end;
/

create or replace procedure InsertPropertyRecord(id in number, oid in number, tarea in number, parea in number, address in varchar2, locality in varchar2, type in varchar2, cyear in number, afrom in date default null, atill in date default null, bno in number default null, ahike in number default 0) as
frm date;
begin
select current_date into frm from dual;
if afrom is not NULL then
  frm := afrom;
end if;
insert into property values(id, oid, tarea, parea, frm, atill, address, locality, type, bno, cyear, ahike);
dbms_output.put_line(' Property added successfully');
end;
/

create or replace procedure GetPropertyRecords(ownerid in number) as
p number;
id number;
tarea number;
parea number;
afrom date;
atill date;
addr varchar2(50);
loc varchar2(30);
tp varchar2(20);
bno number;
cyear number;
ahike number;
cursor props is
select pid, total_area, plinth_area, available_from, available_till, address, locality, type, bedroomsno, construction_year, annual_hike from property where oid = ownerid;
begin
p := 0;
open props;
dbms_output.put_line('::::Owner with id: '||ownerid||' has the following properties::::');
loop
fetch props into id, tarea, parea, afrom, atill, addr, loc, tp, bno, cyear, ahike;
exit when props%notfound;
p := p + 1;
dbms_output.put_line(' Property '||p);
dbms_output.put_line(' Property Id: '||id);
dbms_output.put_line(' Total Area: '||tarea);
dbms_output.put_line(' Plinth Area: '||parea);
dbms_output.put_line(' Available from: '||afrom);
dbms_output.put_line(' Address: '||addr);
dbms_output.put_line(' Locality: '||loc);
dbms_output.put_line(' Type: '||tp);
dbms_output.put_line(' Construction Year: '||cyear);
dbms_output.put_line(' Annual Hike: '||ahike);
if atill is NULL then
	dbms_output.put_line(' Property available indefinitely');
else
	dbms_output.put_line(' Property available till: '||atill);
end if;
if bno is not null then
	dbms_output.put_line(' Number of bedrooms: '||bno);
end if;
dbms_output.put_line('-');
end loop;
close props;
if p = 0 then
	dbms_output.put_line(' No properties registered yet');
end if;
dbms_output.put_line(' Above information is subject to change');
end;
/

create or replace procedure GetTenantDetails(propid in number) as
p number;
ph number;
id number;
nm varchar2(20);
sdate date;
rpm number;
yhike number;
comm number;
cursor tens is
select tid, name, phone, start_date, rentpm, yearly_hike, commission from (rent join users on tid = aid) join user_phone on userid = tid where pid = propid and end_date is NULL;
begin
p := 0;
open tens;
loop
fetch tens into id, nm, ph, sdate, rpm, yhike, comm;
exit when tens%notfound;
	p := p + 1;
	if p = 1 then
		dbms_output.put_line(' Occupying Tenant id: '||id);
		dbms_output.put_line(' Tenant Name: '||nm);
		dbms_output.put_line(' Started on: '||sdate);
		dbms_output.put_line(' Current Rent per Month: '||rpm);
		dbms_output.put_line(' Yearly Rate Hike: '||yhike);
		if comm is NULL then
			dbms_output.put_line(' No commission involved');
		else
			dbms_output.put_line(' Commission: '||comm);
		end if;
		dbms_output.put_line(' Phone number: '||ph);
	else
		dbms_output.put_line(' Phone number: '||ph);
	end if;
end loop;
close tens;
if p = 0 then
	dbms_output.put_line(' Either this property does not exists or it currently has no tenants');
end if;
end;
/

create or replace procedure GetRentHistory(propid in number) as
p number;
id number;
sdate date;
edate date;
trent number;
cursor tens is
select tid, start_date, end_date, total_rent from rent_history natural join rent where pid = propid;
begin
p := 0;
open tens;
dbms_output.put_line('::::Property with id: '||propid||' has had the following tenants::::');
loop 
fetch tens into id, sdate, edate, trent;
exit when tens%notfound;
p := p + 1;
dbms_output.put_line(' Tenant '||p);
dbms_output.put_line(' Tenant id: '||id);
dbms_output.put_line(' Occupied the Property from: '||sdate);
if edate is NULL then
	dbms_output.put_line(' till today, and onwards');
else
	dbms_output.put_line(' Till: '||edate);
	dbms_output.put_line(' Net Rent amount: '||trent);
end if;
dbms_output.put_line('-');
end loop;
if p = 0 then
	dbms_output.put_line(' Either this property does not exist or no tenants have finished their tenure on it yet');
end if;
close tens;
end;
/

create or replace procedure GetPropertyRecordwithPID(propid in number) as
id number;
tarea number;
parea number;
afrom date;
atill date;
addr varchar2(50);
loc varchar2(30);
tp varchar2(20);
bno number;
cyear number;
ahike number;
cursor props is
select oid, total_area, plinth_area, available_from, available_till, address, locality, type, bedroomsno, construction_year, annual_hike from property where pid = propid;
begin
open props;
loop
fetch props into id, tarea, parea, afrom, atill, addr, loc, tp, bno, cyear, ahike;
exit when props%notfound;
dbms_output.put_line(' Owner Id: '||id);
dbms_output.put_line(' Total Area: '||tarea);
dbms_output.put_line(' Plinth Area: '||parea);
dbms_output.put_line(' Available from: '||afrom);
dbms_output.put_line(' Address: '||addr);
--dbms_output.put_line(' Locality: '||loc);
dbms_output.put_line(' Type: '||tp);
dbms_output.put_line(' Construction Year: '||cyear);
dbms_output.put_line(' Annual Hike: '||ahike);
if atill is NULL then
	dbms_output.put_line(' Property available indefinitely');
else
	dbms_output.put_line(' Property available till: '||atill);
end if;
if bno is not null then
	dbms_output.put_line(' Number of bedrooms: '||bno);
end if;
end loop;
close props;
end;
/

create or replace procedure SearchPropertyForRent(loc in varchar2) as
p number;
id number;
cursor props is
select pid from property where locality = loc;
begin
p := 0;
dbms_output.put_line('::::Locality/Street: '||loc||' has the following properties::::');
open props;
loop
fetch props into id;
exit when props%notfound;
p := p + 1;
dbms_output.put_line(' Property '||p);
GetPropertyRecordwithPID(id);
dbms_output.put_line('-');
end loop;
close props;
if p = 0 then
	dbms_output.put_line('No properties found');
end if;
end;
/

create or replace procedure AddNewTenant(tenantid in number, propid in number, rpm in number, yhike in number default 0, sdate in date default null, comm in number default null) as
strt date;
yhk number;
begin
select annual_hike into yhk from property where pid = propid;
if yhike <> 0 then
	yhk := yhike;
end if;
select current_date into strt from dual;
if sdate is not NULL then
  strt := sdate;
end if;
insert into rent values(tenantid, propid, strt, NULL, rpm, yhk, comm);
dbms_output.put_line('New tenant added');
end;
/

create or replace procedure FinishTenantPeriod(tenantid in number, propid in number, edate in date default null) as
ed date;
begin
select current_date into ed from dual; 
if edate is not null then
	ed := edate;
end if;
update rent set end_date = ed where tid = tenantid and pid = propid and end_date is NULL;
dbms_output.put_line('Updated tenant info');
end;
/

create or replace trigger RentHistoryUpdate after update on Rent for each row
declare
sdate date;
cm number;
edate date;
trent number;
yrs number;
yhike number;
mb number;
rpm number;
begin
sdate := :new.start_date;
edate := :new.end_date;	
yhike := :new.yearly_hike;
rpm := :new.rentpm;
cm := :new.commission;
select months_between(edate, sdate) into mb from dual;
yrs := floor(mb /12);
if yhike = 0 then
	yhike := 1;
end if;
select 12*(rpm)*(power(1+yhike, yrs) / yhike) into trent from dual;
if yhike = 1 then
	trent := yrs*12*rpm;
end if;
trent := trent + mb*rpm;
if cm is not null then
	trent := trent + cm;
end if;
insert into rent_history values(:new.pid, sdate, :new.tid, trent);
dbms_output.put_line('Rent History updated');
end;
/

