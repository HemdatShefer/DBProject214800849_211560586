-- PL/SQL Developer Export Tables for user SYSTEM@XE
-- Created by Haim on Tuesday, 6 August 2024
set feedback off
set define off

-- Dropping existing tables if they exist
begin
    execute immediate 'drop table CATERING cascade constraints';
    exception when others then if sqlcode <> -942 then raise; end if;
end;
/
begin
    execute immediate 'drop table CUSTOMERS cascade constraints';
    exception when others then if sqlcode <> -942 then raise; end if;
end;
/
begin
    execute immediate 'drop table EVENTS_ cascade constraints';
    exception when others then if sqlcode <> -942 then raise; end if;
end;
/
begin
    execute immediate 'drop table GUESTS cascade constraints';
    exception when others then if sqlcode <> -942 then raise; end if;
end;
/
begin
    execute immediate 'drop table HAS_CATERING cascade constraints';
    exception when others then if sqlcode <> -942 then raise; end if;
end;
/
begin
    execute immediate 'drop table PAYMENTS cascade constraints';
    exception when others then if sqlcode <> -942 then raise; end if;
end;
/
begin
    execute immediate 'drop table VENUES cascade constraints';
    exception when others then if sqlcode <> -942 then raise; end if;
end;
/

-- Creating CATERING...
create table CATERING
(
  cateringid        NUMBER not null,
  name              VARCHAR2(100),
  menudescription   VARCHAR2(255),
  contractstartdate DATE,
  contractenddate   DATE
)
;
alter table CATERING
  add primary key (CATERINGID)
  ;

-- Creating CUSTOMERS...
create table CUSTOMERS
(
  customerid       NUMBER not null,
  firstname        VARCHAR2(50),
  lastname         VARCHAR2(50),
  phonenumber      VARCHAR2(20),
  birthdaydate     DATE,
  lastpurchasedate DATE
)
;
alter table CUSTOMERS
  add primary key (CUSTOMERID)
  ;

-- Creating EVENTS_...
create table EVENTS_
(
  eventid    NUMBER not null,
  eventdate  DATE,
  endtime    TIMESTAMP(6),
  customerid NUMBER,
  venueid    NUMBER
)
;
alter table EVENTS_
  add primary key (EVENTID)
  ;
alter table EVENTS_
  add foreign key (CUSTOMERID)
  references CUSTOMERS (CUSTOMERID);

-- Creating GUESTS...
create table GUESTS
(
  guestid           NUMBER not null,
  relationshiplevel VARCHAR2(50),
  firstname         VARCHAR2(50),
  lastname          VARCHAR2(50),
  invitationdate    DATE,
  birthdaydate      DATE,
  eventid           NUMBER,
  customerid        NUMBER
)
;
alter table GUESTS
  add primary key (GUESTID)
 ;
alter table GUESTS
  add foreign key (EVENTID)
  references EVENTS_ (EVENTID);
alter table GUESTS
  add foreign key (CUSTOMERID)
  references CUSTOMERS (CUSTOMERID);

-- Creating HAS_CATERING...
create table HAS_CATERING
(
  cateringid NUMBER not null,
  eventid    NUMBER not null
)
;
alter table HAS_CATERING
  add primary key (CATERINGID, EVENTID)
 ;
alter table HAS_CATERING
  add foreign key (CATERINGID)
  references CATERING (CATERINGID);
alter table HAS_CATERING
  add foreign key (EVENTID)
  references EVENTS_ (EVENTID);

-- Creating PAYMENTS...
create table PAYMENTS
(
  paymentid     NUMBER not null,
  amount        NUMBER,
  paymentdate   DATE,
  processeddate DATE,
  customerid    NUMBER,
  eventid       NUMBER
)
;
alter table PAYMENTS
  add primary key (PAYMENTID)
 ;
alter table PAYMENTS
  add foreign key (CUSTOMERID)
  references CUSTOMERS (CUSTOMERID);
alter table PAYMENTS
  add foreign key (EVENTID)
  references EVENTS_ (EVENTID);

-- Creating VENUES...
create table VENUES
(
  venueid        NUMBER not null,
  name           VARCHAR2(100),
  location       VARCHAR2(100),
  capacity       NUMBER,
  opendate       DATE,
  renovationdate DATE
)
;
alter table VENUES
  add primary key (VENUEID)
 ;

-- Loading CATERING...
insert into CATERING (cateringid, name, menudescription, contractstartdate, contractenddate)
values (1000, 'Gourmet Catering', 'Full service catering with a wide variety of menu options', to_date('01-01-2020', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'));
insert into CATERING (cateringid, name, menudescription, contractstartdate, contractenddate)
values (2000, 'Event Catering', 'Specializing in corporate and private events', to_date('01-06-2019', 'dd-mm-yyyy'), to_date('01-06-2024', 'dd-mm-yyyy'));
commit;
-- 2 records loaded

-- Loading CUSTOMERS...
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1000, 'John', 'Doe', '1234567890', to_date('01-01-1980', 'dd-mm-yyyy'), to_date('01-06-2023', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (2000, 'Jane', 'Smith', '0987654321', to_date('02-02-1990', 'dd-mm-yyyy'), to_date('02-06-2023', 'dd-mm-yyyy'));
commit;
-- 2 records loaded

-- Loading EVENTS_...
insert into EVENTS_ (eventid, eventdate, endtime, customerid, venueid)
values (1000, to_date('25-12-2023', 'dd-mm-yyyy'), to_timestamp('25-12-2023 18:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1000, 1000);
insert into EVENTS_ (eventid, eventdate, endtime, customerid, venueid)
values (2000, to_date('31-12-2023', 'dd-mm-yyyy'), to_timestamp('31-12-2023 23:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 2000, 2000);
commit;
-- 2 records loaded

-- Loading GUESTS...
insert into GUESTS (guestid, relationshiplevel, firstname, lastname, invitationdate, birthdaydate, eventid, customerid)
values (1000, 'Friend', 'Alice', 'Brown', to_date('01-11-2023', 'dd-mm-yyyy'), to_date('15-03-1985', 'dd-mm-yyyy'), 1000, 1000);
insert into GUESTS (guestid, relationshiplevel, firstname, lastname, invitationdate, birthdaydate, eventid, customerid)
values (2000, 'Colleague', 'Bob', 'Green', to_date('15-11-2023', 'dd-mm-yyyy'), to_date('30-07-1992', 'dd-mm-yyyy'), 2000, 2000);
commit;
-- 2 records loaded

-- Loading HAS_CATERING...
insert into HAS_CATERING (cateringid, eventid)
values (1000, 1000);
insert into HAS_CATERING (cateringid, eventid)
values (2000, 2000);
commit;
-- 2 records loaded

-- Loading PAYMENTS...
insert into PAYMENTS (paymentid, amount, paymentdate, processeddate, customerid, eventid)
values (1000, 500, to_date('10-06-2023', 'dd-mm-yyyy'), to_date('11-06-2023', 'dd-mm-yyyy'), 1000, 1000);
insert into PAYMENTS (paymentid, amount, paymentdate, processeddate, customerid, eventid)
values (2000, 750, to_date('15-06-2023', 'dd-mm-yyyy'), to_date('16-06-2023', 'dd-mm-yyyy'), 2000, 2000);
commit;
-- 2 records loaded

-- Loading VENUES...
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (1000, 'Grand Hall', '123 Main St', 500, to_date('01-01-2000', 'dd-mm-yyyy'), to_date('01-01-2020', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (2000, 'Conference Center', '456 Elm St', 200, to_date('05-05-2005', 'dd-mm-yyyy'), to_date('05-05-2015', 'dd-mm-yyyy'));
commit;
-- 2 records loaded

set feedback on
set define on
-- Done
