# terraform-demo

## MySQL - Test connection
### Connect
```
mysql -h <endpoint> -P 3306 -u <mymasteruser> -p
```
### Show databases & tables
```
SHOW DATABASES;
SHOW TABLES;
```
### Use Database
```
USE DatabaseName;
```
### Create Table
```
CREATE TABLE Persons (
    PersonID int,
    LastName varchar(255),
    FirstName varchar(255),
    Address varchar(255),
    City varchar(255)
);
```
### Describe table
```
Describe Persons;
```
### Drop table
```
DROP TABLE Persons;
```

## Redis - Test connection
