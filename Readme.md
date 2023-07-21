# DBMS-Project
A CLI based project to create and manage data in a oracle database. This repository involves the following pl/sql files:

- createuser: Creates a user for this project
- initial: Connects to the created user and modifies the settings to the required values.
- createtable: Creates the tables necessary for the project
- data: Adds some dummy data to the tables for testing and showcase
- proc: Creates the required procedures and triggers for the project
- cleardata: clears all data from all project tables
- cleardatabase: deletes all tables, procedures and triggers from the database
- exit: commits all changes and exits the CLI
  
## Running the project
SQL Plus CLI with Oracle is recommended for this project. Minimum steps to run the project on a new system: 

1. Open an instance of the CLI
2. Run createuser > initial > createtable > proc in that order
3. Check proc specifications in the next section

## Procedures and Triggers

1. InsertPropertyRecord(Attributes of the record [check proc]): Enter a record for a property
2. GetPropertyRecords(OwnerId): Display the properties (with all details) for a given ownerID
3. GetTenantDetails(PropertyId): Print the current tenant details for a property
4. CreateNewUser(Attributes of the record [check proc]): Enter a record for a user
5. SearchPropertyForRent(locality): Prints details of properties in a city/locality
6. GetRentHistory(PropertyId): Print the rent history for a given property id
7. Other helper triggers and procedures in proc
