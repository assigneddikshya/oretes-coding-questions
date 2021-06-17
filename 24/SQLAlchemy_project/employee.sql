create database company;
use company;
create table employee(
   FNAME varchar(15) not null,
   MNAME char null,
   LNAME varchar(15) not null,
   SSN int(9) not null,
   BDATE date,
   ADDRESS varchar(35) not null,
   SEX char null,
   SALARY decimal(10,2) null,
   SUPER_SSN int(9) null,
   DNO int not null,
   primary key(SSN)
);
desc employee;
