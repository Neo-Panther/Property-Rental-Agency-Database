--Add user data
exec CreateNewUser(184985639051, 'Yksi', '11111111', 1234567890, 'Eins', 11, 1, '1', 'Unus', 111111);
exec CreateNewUser(208746935501, 'Kaksi', '22222222', 2345678901, 'Zwei', 22, 2, '2', 'Duo', 222222);
exec CreateNewUser(366757653109, 'Kolme', '33333333', 3456789012, 'Drei', 33, 3, '3', 'Tres', 333333);
exec CreateNewUser(432896573001, 'Nelja', '44444444', 4567890123, 'Vier', 44, 4, '4', 'Quattor', 444444);
exec CreateNewUser(565397245678, 'Viisi', '55555555', 5678901234, 'Funf', 55, 5, '2', 'Quinque', 555555);
exec CreateNewUser(639846289203, 'Kuusi', '66666666', 6789012345, 'Sechs', 66, 6, '6', 'Six', 666666);
exec CreateNewUser(729327349201, 'Seisteman', '77777777', 7890123456, 'Sieben', 77, 7, '7', 'Septem', 777777);
exec CreateNewUser(821325132092, 'Kahdeksan', '88888888', 8901234567, 'Acht', 88, 8, '8', 'Octo', 888888);
exec CreateNewUser(970686970485, 'Yhdeksan', '99999999', 9012345678, 'Neun', 99, 9, '9', 'Novem', 999999);

--Add some extra phone numbers(not needed for all users)
exec InsertUserPhone(184985639051, 1123456789);
exec InsertUserPhone(184985639051, 1112345678);
exec InsertUserPhone(366757653109, 3345678901);
exec InsertUserPhone(565397245678, 5567890123);
exec InsertUserPhone(729327349201, 7789012345);

--Add property data (owner id depends on user id)
--area in sq feet
exec InsertPropertyRecord(1,  184985639051, 1220, 1100, '111', '1', 'flat', 2009, '20-aug-2022', bno => 3);
exec InsertPropertyRecord(24, 208746935501, 1900, 1800, '222', '2', 'independent-house', 2015, '30-dec-2021', bno => 4, ahike => 10);
exec InsertPropertyRecord(53, 565397245678, 750, 740, '333', '2', 'shop', 2016, '9-may-2022', '25-jul-2027');
exec InsertPropertyRecord(13, 184985639051, 3040, 3000, '112', '1', 'warehouse', 2000, '23-jun-2022', ahike => 5);
exec InsertPropertyRecord(28, 208746935501, 810, 800, '223', '3', 'shop', 2007, '30-mar-2019', '30-mar-2025', ahike => 10);
exec InsertPropertyRecord(69, 639846289203, 2000, 1950, '666', '6', 'independent-house', 2005, '7-jun-2007', bno => 4);
exec InsertPropertyRecord(7,  729327349201, 3519, 3500, '777', '7', 'warehouse' , 2010, '8-oct-2021', ahike => 11);

--Add some tenants (info of rent table) (tenant id depends on user id, property id depends on the property table)
exec AddNewTenant(432896573001, 24, 19000, 5, '17-sep-2022', 1100);
exec AddNewTenant(565397245678, 24, 19999, 10, '17-jan-2023', 1000);
exec AddNewTenant(366757653109, 13, 200000, 5, '25-dec-2022');
exec AddNewTenant(366757653109, 53, 30300, 15, '25-dec-2022');
exec AddNewTenant(970686970485, 69, 25000, comm => 4200);
exec AddNewTenant(821325132092, 28, 35000, 10, '20-may-2022');

--Add random finish date for a few tenants(depends on above info)
exec FinishTenantPeriod(432896573001, 24, '30-apr-2023');
exec FinishTenantPeriod(821325132092, 28);