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
### Connect
```
redis-cli -c -h <endpoint> -p 6379
```
### Test Redis commands
```
set a "hello"          // Set key "a" with a string value and no expiration
OK
get a                  // Get value for key "a"
"hello"
get b                  // Get value for key "b" results in miss
(nil)				
set b "Good-bye" EX 5  // Set key "b" with a string value and a 5 second expiration
get b
"Good-bye"
                   // wait 5 seconds
get b
(nil)                  // key has expired, nothing returned
quit                   // Exit from redis-cli
``