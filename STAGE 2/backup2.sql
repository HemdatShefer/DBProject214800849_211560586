prompt PL/SQL Developer import file
prompt Created on Tuesday, 6 August 2024 by hemda
set feedback off
set define off
prompt Creating CATERING...
create table CATERING
(
  cateringid        INTEGER not null,
  name              VARCHAR2(100) not null,
  menudescription   VARCHAR2(500) not null,
  contractstartdate DATE not null,
  contractenddate   DATE not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table CATERING
  add primary key (CATERINGID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table CATERING
  add constraint CHK_CONTRACT_DATES
  check (ContractEndDate > ContractStartDate);

prompt Creating CUSTOMERS...
create table CUSTOMERS
(
  customerid       INTEGER not null,
  firstname        VARCHAR2(50) not null,
  lastname         VARCHAR2(50) not null,
  phonenumber      VARCHAR2(15) not null,
  birthdaydate     DATE not null,
  lastpurchasedate DATE
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table CUSTOMERS
  add primary key (CUSTOMERID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table CUSTOMERS
  add constraint CHK_PHONE_NUMBER_LENGTH
  check (LENGTH(PhoneNumber) = 10);
alter table CUSTOMERS
  add constraint PHONE_NUMBER_LENGTH
  check (LENGTH(PhoneNumber) = 10);

prompt Creating VENUES...
create table VENUES
(
  venueid        INTEGER not null,
  name           VARCHAR2(100) not null,
  location       VARCHAR2(255) not null,
  capacity       INTEGER not null,
  opendate       DATE not null,
  renovationdate DATE not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table VENUES
  add primary key (VENUEID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating EVENTS_...
create table EVENTS_
(
  eventid               INTEGER not null,
  eventdate             DATE not null,
  eventconfirmationdate DATE,
  customerid            INTEGER not null,
  venueid               INTEGER not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EVENTS_
  add primary key (EVENTID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EVENTS_
  add foreign key (VENUEID)
  references VENUES (VENUEID);

prompt Creating GUSTS...
create table GUSTS
(
  gustid            INTEGER not null,
  relationshiplevel VARCHAR2(50) not null,
  firstname         VARCHAR2(50) not null,
  lastname          VARCHAR2(50) not null,
  invitationdate    DATE not null,
  confirmationdate  DATE,
  rsvpstatus        VARCHAR2(50),
  eventid           INTEGER not null,
  customerid        INTEGER not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table GUSTS
  add primary key (GUSTID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table GUSTS
  add foreign key (EVENTID)
  references EVENTS_ (EVENTID);

prompt Creating HAS_CATERING...
create table HAS_CATERING
(
  cateringid INTEGER not null,
  eventid    INTEGER not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table HAS_CATERING
  add primary key (CATERINGID, EVENTID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table HAS_CATERING
  add foreign key (CATERINGID)
  references CATERING (CATERINGID);
alter table HAS_CATERING
  add foreign key (EVENTID)
  references EVENTS_ (EVENTID);

prompt Creating PAYMENTS...
create table PAYMENTS
(
  paymentid           INTEGER not null,
  amount              NUMBER(10,2) not null,
  paymentdate         DATE not null,
  paymentdeadlinedate DATE,
  customerid          INTEGER not null,
  eventid             INTEGER not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table PAYMENTS
  add primary key (PAYMENTID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table PAYMENTS
  add foreign key (EVENTID)
  references EVENTS_ (EVENTID);
alter table PAYMENTS
  add constraint CHK_AMOUNT_POSITIVE
  check (Amount > 0);

prompt Disabling triggers for CATERING...
alter table CATERING disable all triggers;
prompt Disabling triggers for CUSTOMERS...
alter table CUSTOMERS disable all triggers;
prompt Disabling triggers for VENUES...
alter table VENUES disable all triggers;
prompt Disabling triggers for EVENTS_...
alter table EVENTS_ disable all triggers;
prompt Disabling triggers for GUSTS...
alter table GUSTS disable all triggers;
prompt Disabling triggers for HAS_CATERING...
alter table HAS_CATERING disable all triggers;
prompt Disabling triggers for PAYMENTS...
alter table PAYMENTS disable all triggers;
prompt Disabling foreign key constraints for EVENTS_...
alter table EVENTS_ disable constraint SYS_C007771;
prompt Disabling foreign key constraints for GUSTS...
alter table GUSTS disable constraint SYS_C007780;
prompt Disabling foreign key constraints for HAS_CATERING...
alter table HAS_CATERING disable constraint SYS_C007793;
alter table HAS_CATERING disable constraint SYS_C007794;
prompt Disabling foreign key constraints for PAYMENTS...
alter table PAYMENTS disable constraint SYS_C007789;
prompt Deleting PAYMENTS...
delete from PAYMENTS;
commit;
prompt Deleting HAS_CATERING...
delete from HAS_CATERING;
commit;
prompt Deleting GUSTS...
delete from GUSTS;
commit;
prompt Deleting EVENTS_...
delete from EVENTS_;
commit;
prompt Deleting VENUES...
delete from VENUES;
commit;
prompt Deleting CUSTOMERS...
delete from CUSTOMERS;
commit;
prompt Deleting CATERING...
delete from CATERING;
commit;
prompt Loading CATERING...
insert into CATERING (cateringid, name, menudescription, contractstartdate, contractenddate)
values (1, 'Gourmet Delight', 'Fine dining experience with a touch of elegance', to_date('15-01-2020', 'dd-mm-yyyy'), to_date('15-01-2021', 'dd-mm-yyyy'));
insert into CATERING (cateringid, name, menudescription, contractstartdate, contractenddate)
values (2, 'Home Comforts', 'Homestyle meals with a cozy feel', to_date('20-02-2020', 'dd-mm-yyyy'), to_date('20-02-2021', 'dd-mm-yyyy'));
insert into CATERING (cateringid, name, menudescription, contractstartdate, contractenddate)
values (3, 'Healthy Choices', 'Nutrition-packed meals for health-conscious individuals', to_date('25-03-2020', 'dd-mm-yyyy'), to_date('25-03-2021', 'dd-mm-yyyy'));
insert into CATERING (cateringid, name, menudescription, contractstartdate, contractenddate)
values (4, 'Exotic Flavors', 'A journey through exotic and vibrant cuisines', to_date('30-04-2020', 'dd-mm-yyyy'), to_date('30-04-2021', 'dd-mm-yyyy'));
insert into CATERING (cateringid, name, menudescription, contractstartdate, contractenddate)
values (5, 'BBQ Heaven', 'Smoky and savory barbecue delights', to_date('05-05-2020', 'dd-mm-yyyy'), to_date('05-05-2021', 'dd-mm-yyyy'));
insert into CATERING (cateringid, name, menudescription, contractstartdate, contractenddate)
values (6, 'Seafood Paradise', 'Fresh and succulent seafood dishes', to_date('10-06-2020', 'dd-mm-yyyy'), to_date('10-06-2021', 'dd-mm-yyyy'));
insert into CATERING (cateringid, name, menudescription, contractstartdate, contractenddate)
values (7, 'Vegan Feast', 'Plant-based gourmet meals', to_date('15-07-2020', 'dd-mm-yyyy'), to_date('15-07-2021', 'dd-mm-yyyy'));
insert into CATERING (cateringid, name, menudescription, contractstartdate, contractenddate)
values (8, 'Sweet Endings', 'Decadent desserts and sweet treats', to_date('20-08-2020', 'dd-mm-yyyy'), to_date('20-08-2021', 'dd-mm-yyyy'));
insert into CATERING (cateringid, name, menudescription, contractstartdate, contractenddate)
values (9, 'Comfort Cravings', 'Soul-soothing comfort food', to_date('25-09-2020', 'dd-mm-yyyy'), to_date('25-09-2021', 'dd-mm-yyyy'));
insert into CATERING (cateringid, name, menudescription, contractstartdate, contractenddate)
values (10, 'Italian Classics', 'Traditional Italian cuisine with a modern twist', to_date('30-10-2020', 'dd-mm-yyyy'), to_date('30-10-2021', 'dd-mm-yyyy'));
insert into CATERING (cateringid, name, menudescription, contractstartdate, contractenddate)
values (11, 'Asian Fusion', 'Innovative fusion of Asian flavors', to_date('04-11-2020', 'dd-mm-yyyy'), to_date('04-11-2021', 'dd-mm-yyyy'));
insert into CATERING (cateringid, name, menudescription, contractstartdate, contractenddate)
values (12, 'Fiesta Mexicana', 'Vibrant and flavorful Mexican dishes', to_date('09-12-2020', 'dd-mm-yyyy'), to_date('09-12-2021', 'dd-mm-yyyy'));
insert into CATERING (cateringid, name, menudescription, contractstartdate, contractenddate)
values (13, 'French Elegance', 'Sophisticated and classic French cuisine', to_date('14-01-2021', 'dd-mm-yyyy'), to_date('14-01-2022', 'dd-mm-yyyy'));
insert into CATERING (cateringid, name, menudescription, contractstartdate, contractenddate)
values (14, 'Mediterranean Magic', 'Heart-healthy Mediterranean dishes', to_date('18-02-2021', 'dd-mm-yyyy'), to_date('18-02-2022', 'dd-mm-yyyy'));
insert into CATERING (cateringid, name, menudescription, contractstartdate, contractenddate)
values (15, 'Street Food Extravaganza', 'Authentic street food from around the world', to_date('25-03-2021', 'dd-mm-yyyy'), to_date('25-03-2022', 'dd-mm-yyyy'));
insert into CATERING (cateringid, name, menudescription, contractstartdate, contractenddate)
values (16, 'Rustic Retreat', 'Hearty and rustic farm-to-table meals', to_date('30-04-2021', 'dd-mm-yyyy'), to_date('30-04-2022', 'dd-mm-yyyy'));
insert into CATERING (cateringid, name, menudescription, contractstartdate, contractenddate)
values (17, 'Sushi Sensations', 'Exquisite sushi and Japanese delicacies', to_date('05-05-2021', 'dd-mm-yyyy'), to_date('05-05-2022', 'dd-mm-yyyy'));
insert into CATERING (cateringid, name, menudescription, contractstartdate, contractenddate)
values (18, 'Tropical Taste', 'Fresh and vibrant tropical flavors', to_date('10-06-2021', 'dd-mm-yyyy'), to_date('10-06-2022', 'dd-mm-yyyy'));
insert into CATERING (cateringid, name, menudescription, contractstartdate, contractenddate)
values (19, 'Burger Bonanza', 'Gourmet burgers with a variety of toppings', to_date('15-07-2021', 'dd-mm-yyyy'), to_date('15-07-2022', 'dd-mm-yyyy'));
insert into CATERING (cateringid, name, menudescription, contractstartdate, contractenddate)
values (20, 'Brunch Bliss', 'Delightful and indulgent brunch options', to_date('20-08-2021', 'dd-mm-yyyy'), to_date('20-08-2022', 'dd-mm-yyyy'));
insert into CATERING (cateringid, name, menudescription, contractstartdate, contractenddate)
values (21, 'Tapas Treats', 'Spanish tapas and small plates', to_date('25-09-2021', 'dd-mm-yyyy'), to_date('25-09-2022', 'dd-mm-yyyy'));
insert into CATERING (cateringid, name, menudescription, contractstartdate, contractenddate)
values (22, 'Middle Eastern Delights', 'Rich and aromatic Middle Eastern cuisine', to_date('30-10-2021', 'dd-mm-yyyy'), to_date('30-10-2022', 'dd-mm-yyyy'));
insert into CATERING (cateringid, name, menudescription, contractstartdate, contractenddate)
values (23, 'American Diner', 'Classic American diner fare', to_date('04-11-2021', 'dd-mm-yyyy'), to_date('04-11-2022', 'dd-mm-yyyy'));
insert into CATERING (cateringid, name, menudescription, contractstartdate, contractenddate)
values (24, 'Caribbean Flavors', 'Spicy and bold Caribbean dishes', to_date('09-12-2021', 'dd-mm-yyyy'), to_date('09-12-2022', 'dd-mm-yyyy'));
insert into CATERING (cateringid, name, menudescription, contractstartdate, contractenddate)
values (25, 'Indian Spice', 'Aromatic and flavorful Indian cuisine', to_date('14-01-2022', 'dd-mm-yyyy'), to_date('14-01-2023', 'dd-mm-yyyy'));
insert into CATERING (cateringid, name, menudescription, contractstartdate, contractenddate)
values (26, 'Greek Feast', 'Fresh and vibrant Greek dishes', to_date('18-02-2022', 'dd-mm-yyyy'), to_date('18-02-2023', 'dd-mm-yyyy'));
insert into CATERING (cateringid, name, menudescription, contractstartdate, contractenddate)
values (27, 'Modern Bistro', 'Contemporary and chic bistro fare', to_date('25-03-2022', 'dd-mm-yyyy'), to_date('25-03-2023', 'dd-mm-yyyy'));
insert into CATERING (cateringid, name, menudescription, contractstartdate, contractenddate)
values (28, 'Soul Food', 'Heartwarming and soulful Southern cuisine', to_date('30-04-2022', 'dd-mm-yyyy'), to_date('30-04-2023', 'dd-mm-yyyy'));
insert into CATERING (cateringid, name, menudescription, contractstartdate, contractenddate)
values (29, 'Fusion Frenzy', 'A creative mix of global flavors', to_date('05-05-2022', 'dd-mm-yyyy'), to_date('05-05-2023', 'dd-mm-yyyy'));
insert into CATERING (cateringid, name, menudescription, contractstartdate, contractenddate)
values (30, 'Dessert Dream', 'Heavenly and indulgent desserts', to_date('10-06-2022', 'dd-mm-yyyy'), to_date('10-06-2023', 'dd-mm-yyyy'));
insert into CATERING (cateringid, name, menudescription, contractstartdate, contractenddate)
values (1000, 'Gourmet Catering', 'Full service catering with a wide variety of menu options', to_date('01-01-2020', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'));
insert into CATERING (cateringid, name, menudescription, contractstartdate, contractenddate)
values (2000, 'Event Catering', 'Specializing in corporate and private events', to_date('01-06-2019', 'dd-mm-yyyy'), to_date('01-06-2024', 'dd-mm-yyyy'));
commit;
prompt 32 records loaded
prompt Loading CUSTOMERS...
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1000, 'Rene', 'Ali', '0565733703', to_date('01-06-1984', 'dd-mm-yyyy'), to_date('09-07-2014', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1001, 'Keith', 'Van Shelton', '0581872701', to_date('25-08-1978', 'dd-mm-yyyy'), to_date('03-07-2019', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1002, 'Tim', 'Statham', '0591857884', to_date('08-05-1997', 'dd-mm-yyyy'), to_date('05-07-2017', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1003, 'Cyndi', 'McGinley', '0576984268', to_date('04-03-1987', 'dd-mm-yyyy'), to_date('04-01-2017', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1004, 'Carla', 'Turner', '0519397861', to_date('02-06-1994', 'dd-mm-yyyy'), to_date('28-12-2022', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1005, 'Paul', 'Checker', '0532219973', to_date('27-02-2000', 'dd-mm-yyyy'), to_date('05-07-2017', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1006, 'Corey', 'Schiavelli', '0581051159', to_date('08-09-1990', 'dd-mm-yyyy'), to_date('28-12-2022', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1007, 'Clive', 'Lindley', '0544309957', to_date('28-06-1977', 'dd-mm-yyyy'), to_date('09-07-2014', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1008, 'Jean-Claude', 'Giannini', '0555180193', to_date('08-06-1997', 'dd-mm-yyyy'), to_date('01-01-2020', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1009, 'Emmylou', 'Zeta-Jones', '0521854909', to_date('10-10-2000', 'dd-mm-yyyy'), to_date('01-01-2020', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1010, 'Rolando', 'Nash', '0577973379', to_date('04-06-1983', 'dd-mm-yyyy'), to_date('28-06-2023', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1011, 'Miko', 'Mitra', '0592603228', to_date('24-04-2008', 'dd-mm-yyyy'), to_date('27-12-2023', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1012, 'Annette', 'Chinlund', '0543846450', to_date('20-01-1976', 'dd-mm-yyyy'), to_date('04-01-2017', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1013, 'Juan', 'Williams', '0510461723', to_date('21-05-1998', 'dd-mm-yyyy'), to_date('04-07-2018', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1014, 'Cevin', 'Rea', '0526355761', to_date('01-09-1973', 'dd-mm-yyyy'), to_date('01-01-2020', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1015, 'Andre', 'Gore', '0559737184', to_date('02-07-2008', 'dd-mm-yyyy'), to_date('28-06-2023', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1016, 'Bridget', 'Sample', '0566768419', to_date('29-01-1985', 'dd-mm-yyyy'), to_date('08-07-2015', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1017, 'Clarence', 'Gyllenhaal', '0542683512', to_date('09-07-1987', 'dd-mm-yyyy'), to_date('29-06-2022', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1018, 'Meg', 'Elwes', '0519344710', to_date('10-09-1970', 'dd-mm-yyyy'), to_date('30-12-2020', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1019, 'Loreena', 'Thornton', '0567120309', to_date('30-12-1990', 'dd-mm-yyyy'), to_date('30-06-2021', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1020, 'Barry', 'Foster', '0533732091', to_date('27-01-1988', 'dd-mm-yyyy'), to_date('03-01-2018', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1021, 'Ike', 'Zeta-Jones', '0567466427', to_date('30-11-1974', 'dd-mm-yyyy'), to_date('30-06-2021', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1022, 'Merrill', 'Reubens', '0559527583', to_date('19-09-1996', 'dd-mm-yyyy'), to_date('02-01-2019', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1023, 'Vin', 'Woods', '0530898582', to_date('18-10-1985', 'dd-mm-yyyy'), to_date('04-01-2017', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1024, 'Fairuza', 'Boone', '0590766698', to_date('08-07-2002', 'dd-mm-yyyy'), to_date('09-07-2014', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1025, 'Christine', 'Niven', '0544087746', to_date('16-04-1981', 'dd-mm-yyyy'), to_date('03-07-2019', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1026, 'Milla', 'Fonda', '0537982927', to_date('26-12-1991', 'dd-mm-yyyy'), to_date('29-06-2022', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1027, 'Melanie', 'Driver', '0546098838', to_date('24-01-1983', 'dd-mm-yyyy'), to_date('09-07-2014', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1028, 'Hikaru', 'Scott', '0547418462', to_date('18-09-1994', 'dd-mm-yyyy'), to_date('07-01-2015', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1029, 'Kiefer', 'Schock', '0592427329', to_date('29-05-2003', 'dd-mm-yyyy'), to_date('06-01-2016', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1030, 'Sonny', 'Ramirez', '0568625948', to_date('04-09-2007', 'dd-mm-yyyy'), to_date('07-01-2015', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1031, 'Gladys', 'Cattrall', '0568242997', to_date('27-04-1977', 'dd-mm-yyyy'), to_date('04-07-2018', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1032, 'Jon', 'Cube', '0522663851', to_date('28-08-1972', 'dd-mm-yyyy'), to_date('29-06-2022', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1033, 'Emily', 'Davies', '0534505021', to_date('03-02-1991', 'dd-mm-yyyy'), to_date('03-07-2019', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1034, 'Bridgette', 'Cockburn', '0539092227', to_date('03-12-1997', 'dd-mm-yyyy'), to_date('28-06-2023', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1035, 'Rik', 'McElhone', '0598963883', to_date('24-04-1975', 'dd-mm-yyyy'), to_date('04-01-2017', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1036, 'Geoffrey', 'Keen', '0556881247', to_date('10-07-1991', 'dd-mm-yyyy'), to_date('27-12-2023', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1037, 'Denise', 'Myles', '0579683905', to_date('17-01-1993', 'dd-mm-yyyy'), to_date('28-06-2023', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1038, 'Kurtwood', 'Bacon', '0553391659', to_date('13-06-1970', 'dd-mm-yyyy'), to_date('28-12-2022', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1039, 'Eileen', 'Merchant', '0529774570', to_date('16-04-1976', 'dd-mm-yyyy'), to_date('27-12-2023', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1040, 'Norm', 'Gere', '0568103955', to_date('22-10-1997', 'dd-mm-yyyy'), to_date('01-01-2020', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1041, 'Jake', 'Shearer', '0576557290', to_date('17-04-1982', 'dd-mm-yyyy'), to_date('28-12-2022', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1042, 'Deborah', 'Sutherland', '0521548664', to_date('27-07-1995', 'dd-mm-yyyy'), to_date('07-01-2015', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1043, 'Aimee', 'Darren', '0565171574', to_date('03-07-1979', 'dd-mm-yyyy'), to_date('07-01-2015', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1044, 'Cliff', 'Spears', '0587225976', to_date('09-03-1975', 'dd-mm-yyyy'), to_date('28-06-2023', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1045, 'Carrie', 'Kudrow', '0514729203', to_date('26-08-1987', 'dd-mm-yyyy'), to_date('29-06-2022', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1046, 'Kiefer', 'Wheel', '0593944474', to_date('22-11-1995', 'dd-mm-yyyy'), to_date('06-01-2016', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1047, 'Nicolas', 'Witherspoon', '0525527360', to_date('03-10-1971', 'dd-mm-yyyy'), to_date('06-01-2016', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1048, 'Tia', 'Gallagher', '0549027266', to_date('13-01-1970', 'dd-mm-yyyy'), to_date('01-01-2020', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1049, 'Meg', 'Lauper', '0512719201', to_date('19-06-1996', 'dd-mm-yyyy'), to_date('03-01-2018', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1050, 'Night', 'Green', '0591193332', to_date('14-04-1979', 'dd-mm-yyyy'), to_date('02-01-2019', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1051, 'Willie', 'Saxon', '0566996940', to_date('04-12-1982', 'dd-mm-yyyy'), to_date('28-06-2023', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1052, 'Todd', 'Faithfull', '0530861294', to_date('09-10-1992', 'dd-mm-yyyy'), to_date('04-01-2017', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1053, 'Crispin', 'Salonga', '0519632212', to_date('24-11-1997', 'dd-mm-yyyy'), to_date('01-01-2020', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1054, 'Rita', 'Ellis', '0510884515', to_date('12-02-1993', 'dd-mm-yyyy'), to_date('04-07-2018', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1055, 'Gordon', 'Downey', '0525329996', to_date('24-10-2009', 'dd-mm-yyyy'), to_date('06-07-2016', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1056, 'Lena', 'Vicious', '0564268536', to_date('23-07-1972', 'dd-mm-yyyy'), to_date('03-07-2019', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1057, 'Hank', 'Levert', '0599702178', to_date('12-01-2008', 'dd-mm-yyyy'), to_date('02-01-2019', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1058, 'Emerson', 'Secada', '0556885483', to_date('19-03-2003', 'dd-mm-yyyy'), to_date('29-06-2022', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1059, 'Boz', 'Irving', '0519646541', to_date('25-09-2002', 'dd-mm-yyyy'), to_date('29-12-2021', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1060, 'Mika', 'Craven', '0555645771', to_date('04-02-2001', 'dd-mm-yyyy'), to_date('03-01-2018', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1061, 'Cheech', 'Vannelli', '0535310258', to_date('23-12-1977', 'dd-mm-yyyy'), to_date('28-12-2022', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1062, 'Wesley', 'Snipes', '0599582038', to_date('19-02-1981', 'dd-mm-yyyy'), to_date('28-06-2023', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1063, 'Davis', 'Irving', '0545091503', to_date('15-02-1995', 'dd-mm-yyyy'), to_date('28-12-2022', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1064, 'Viggo', 'Womack', '0559831221', to_date('11-02-1990', 'dd-mm-yyyy'), to_date('01-07-2020', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1065, 'Maceo', 'Ammons', '0580623426', to_date('29-06-1988', 'dd-mm-yyyy'), to_date('28-06-2023', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1066, 'Austin', 'McGowan', '0587440483', to_date('11-06-1997', 'dd-mm-yyyy'), to_date('29-06-2022', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1067, 'Fionnula', 'Redford', '0574967558', to_date('24-12-1994', 'dd-mm-yyyy'), to_date('27-12-2023', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1068, 'Maceo', 'Statham', '0573745504', to_date('27-06-2005', 'dd-mm-yyyy'), to_date('05-07-2017', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1069, 'Temuera', 'Abraham', '0537733468', to_date('26-02-2009', 'dd-mm-yyyy'), to_date('28-06-2023', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1070, 'Rachid', 'Wahlberg', '0570380675', to_date('28-04-1991', 'dd-mm-yyyy'), to_date('30-06-2021', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1071, 'Larenz', 'Quinlan', '0584619024', to_date('18-05-2008', 'dd-mm-yyyy'), to_date('27-12-2023', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1072, 'Nick', 'MacIsaac', '0549831160', to_date('02-02-1984', 'dd-mm-yyyy'), to_date('30-12-2020', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1073, 'Denny', 'Shatner', '0510542021', to_date('13-06-1998', 'dd-mm-yyyy'), to_date('05-07-2017', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1074, 'Jean-Luc', 'Pryce', '0581528034', to_date('05-11-1987', 'dd-mm-yyyy'), to_date('03-07-2019', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1075, 'Rich', 'Wine', '0519464793', to_date('20-12-1987', 'dd-mm-yyyy'), to_date('28-12-2022', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1076, 'Josh', 'Downey', '0554305115', to_date('05-05-1978', 'dd-mm-yyyy'), to_date('28-06-2023', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1077, 'Nile', 'Shocked', '0541211079', to_date('26-05-1992', 'dd-mm-yyyy'), to_date('30-12-2020', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1078, 'Derek', 'Danes', '0588417123', to_date('07-06-1980', 'dd-mm-yyyy'), to_date('28-06-2023', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1079, 'Keanu', 'Freeman', '0541341087', to_date('12-03-1993', 'dd-mm-yyyy'), to_date('28-06-2023', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1080, 'Ernest', 'Schneider', '0536012569', to_date('13-01-1970', 'dd-mm-yyyy'), to_date('27-12-2023', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1081, 'Jaime', 'Frost', '0539051141', to_date('04-01-1971', 'dd-mm-yyyy'), to_date('02-01-2019', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1082, 'Judi', 'Hurley', '0544527080', to_date('04-09-1997', 'dd-mm-yyyy'), to_date('02-01-2019', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1083, 'Charles', 'Pryce', '0589302831', to_date('02-06-1993', 'dd-mm-yyyy'), to_date('04-01-2017', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1084, 'Cevin', 'McKennitt', '0527916539', to_date('01-05-2002', 'dd-mm-yyyy'), null);
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1085, 'Aida', 'Haggard', '0599109785', to_date('16-09-1992', 'dd-mm-yyyy'), to_date('06-07-2016', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1086, 'Vendetta', 'Emmerich', '0595013401', to_date('14-03-2006', 'dd-mm-yyyy'), to_date('03-01-2018', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1087, 'Nathan', 'Caldwell', '0551486214', to_date('30-04-1985', 'dd-mm-yyyy'), to_date('02-01-2019', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1088, 'Will', 'Monk', '0596640576', to_date('14-12-1986', 'dd-mm-yyyy'), to_date('05-07-2017', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1089, 'Praga', 'Sweeney', '0522451178', to_date('28-08-1976', 'dd-mm-yyyy'), to_date('29-06-2022', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1090, 'Ethan', 'Dreyfuss', '0523263148', to_date('04-02-1971', 'dd-mm-yyyy'), to_date('07-01-2015', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1091, 'Harold', 'Liu', '0514652566', to_date('11-02-1978', 'dd-mm-yyyy'), to_date('01-01-2020', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1092, 'Chazz', 'Barkin', '0552566689', to_date('02-08-1995', 'dd-mm-yyyy'), to_date('04-01-2017', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1093, 'Luis', 'Heron', '0567067280', to_date('09-06-1989', 'dd-mm-yyyy'), to_date('27-12-2023', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1094, 'Gailard', 'Rodriguez', '0511267454', to_date('03-11-1973', 'dd-mm-yyyy'), null);
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1095, 'Christmas', 'Chung', '0563440218', to_date('19-03-1973', 'dd-mm-yyyy'), to_date('30-12-2020', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1096, 'Celia', 'Humphrey', '0536019077', to_date('28-05-1986', 'dd-mm-yyyy'), to_date('02-01-2019', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1097, 'Nikki', 'Quinones', '0583078963', to_date('10-07-1997', 'dd-mm-yyyy'), to_date('01-07-2020', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1098, 'Sophie', 'Serbedzija', '0582475606', to_date('15-10-1978', 'dd-mm-yyyy'), to_date('01-01-2020', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1099, 'Mike', 'McGriff', '0512772042', to_date('21-02-2003', 'dd-mm-yyyy'), to_date('05-07-2017', 'dd-mm-yyyy'));
commit;
prompt 100 records committed...
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1100, 'First', 'Dupree', '0583187976', to_date('01-11-1993', 'dd-mm-yyyy'), to_date('30-06-2021', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1101, 'Trey', 'Venora', '0552833838', to_date('20-08-1973', 'dd-mm-yyyy'), to_date('01-07-2020', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1102, 'Night', 'Pepper', '0599990239', to_date('23-12-1989', 'dd-mm-yyyy'), to_date('29-12-2021', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1103, 'Reese', 'Benson', '0584638324', to_date('13-10-1990', 'dd-mm-yyyy'), to_date('30-12-2020', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1104, 'Suzanne', 'Red', '0568420504', to_date('15-01-1986', 'dd-mm-yyyy'), null);
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1105, 'Taye', 'Finney', '0578760700', to_date('18-08-1992', 'dd-mm-yyyy'), to_date('27-12-2023', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1106, 'Rhea', 'Rodgers', '0538782695', to_date('29-10-1981', 'dd-mm-yyyy'), to_date('08-07-2015', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1107, 'Boz', 'Uggams', '0568534945', to_date('01-12-1983', 'dd-mm-yyyy'), to_date('28-12-2022', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1108, 'Alicia', 'Keitel', '0528558961', to_date('25-08-2002', 'dd-mm-yyyy'), to_date('04-07-2018', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1109, 'Timothy', 'Choice', '0580471653', to_date('07-01-2005', 'dd-mm-yyyy'), to_date('01-07-2020', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1110, 'Marina', 'Whitaker', '0526363542', to_date('25-05-1986', 'dd-mm-yyyy'), to_date('06-07-2016', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1111, 'Selma', 'Kudrow', '0563212109', to_date('28-04-2005', 'dd-mm-yyyy'), to_date('01-07-2020', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1112, 'Sandra', 'Trejo', '0590135666', to_date('06-01-1974', 'dd-mm-yyyy'), to_date('29-06-2022', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1113, 'Woody', 'Hanley', '0512354695', to_date('06-03-1991', 'dd-mm-yyyy'), to_date('08-07-2015', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1114, 'Mekhi', 'Liotta', '0537481867', to_date('29-08-1985', 'dd-mm-yyyy'), to_date('06-07-2016', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1115, 'Teena', 'McDonald', '0518450331', to_date('02-05-2000', 'dd-mm-yyyy'), to_date('06-01-2016', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1116, 'Rickie', 'Hirsch', '0548068605', to_date('25-02-2008', 'dd-mm-yyyy'), to_date('07-01-2015', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1117, 'Cheech', 'McCoy', '0595423057', to_date('17-09-1999', 'dd-mm-yyyy'), to_date('01-07-2020', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1118, 'Harry', 'Chao', '0523929762', to_date('17-08-1992', 'dd-mm-yyyy'), null);
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1119, 'Allison', 'Raye', '0592833740', to_date('26-08-1987', 'dd-mm-yyyy'), to_date('30-12-2020', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1120, 'Minnie', 'Cobbs', '0532744880', to_date('10-01-1994', 'dd-mm-yyyy'), to_date('04-01-2017', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1121, 'Rupert', 'Durning', '0543391609', to_date('20-12-1979', 'dd-mm-yyyy'), to_date('30-06-2021', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1122, 'Frederic', 'Coward', '0532988545', to_date('26-03-1971', 'dd-mm-yyyy'), null);
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1123, 'Kevn', 'Jonze', '0530596299', to_date('26-01-1974', 'dd-mm-yyyy'), to_date('03-07-2019', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1124, 'Nils', 'Frakes', '0599284779', to_date('12-05-2001', 'dd-mm-yyyy'), to_date('02-01-2019', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1125, 'Jonathan', 'Blackwell', '0533813459', to_date('17-03-1974', 'dd-mm-yyyy'), to_date('30-12-2020', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1126, 'Mira', 'Rebhorn', '0541278448', to_date('10-09-2009', 'dd-mm-yyyy'), to_date('29-06-2022', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1127, 'Alex', 'Lopez', '0511761089', to_date('22-06-1987', 'dd-mm-yyyy'), to_date('27-12-2023', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1128, 'Cate', 'Cale', '0546458688', to_date('31-05-1989', 'dd-mm-yyyy'), to_date('29-06-2022', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1129, 'Lila', 'Applegate', '0547836470', to_date('15-10-1981', 'dd-mm-yyyy'), to_date('01-01-2020', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1130, 'Alessandro', 'Quatro', '0556254578', to_date('09-02-2007', 'dd-mm-yyyy'), to_date('06-07-2016', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1131, 'Terrence', 'Albright', '0543218683', to_date('13-07-1975', 'dd-mm-yyyy'), to_date('06-01-2016', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1132, 'Tom', 'Spiner', '0510672932', to_date('13-08-2007', 'dd-mm-yyyy'), to_date('29-06-2022', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1133, 'Lance', 'Hatfield', '0554871419', to_date('14-08-1979', 'dd-mm-yyyy'), to_date('29-06-2022', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1134, 'Thora', 'Gryner', '0543929634', to_date('23-04-2001', 'dd-mm-yyyy'), to_date('07-01-2015', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1135, 'Derek', 'Payne', '0510494420', to_date('04-07-1998', 'dd-mm-yyyy'), to_date('05-07-2017', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1136, 'Ving', 'Moriarty', '0567833502', to_date('31-03-1983', 'dd-mm-yyyy'), to_date('01-07-2020', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1137, 'Denny', 'Ojeda', '0543450391', to_date('17-05-1987', 'dd-mm-yyyy'), to_date('28-06-2023', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1138, 'Lou', 'Gilliam', '0582315135', to_date('29-03-1977', 'dd-mm-yyyy'), to_date('02-01-2019', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1139, 'Rachel', 'Mollard', '0568405045', to_date('03-11-1984', 'dd-mm-yyyy'), to_date('04-07-2018', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1140, 'Gil', 'Brooks', '0588929836', to_date('24-09-2008', 'dd-mm-yyyy'), to_date('08-07-2015', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1141, 'Grace', 'Perrineau', '0519245204', to_date('28-08-1987', 'dd-mm-yyyy'), to_date('08-07-2015', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1142, 'Rebeka', 'Birch', '0519786090', to_date('06-06-1986', 'dd-mm-yyyy'), to_date('08-07-2015', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1143, 'Marianne', 'Cervine', '0544028587', to_date('20-02-2004', 'dd-mm-yyyy'), to_date('29-06-2022', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1144, 'Nils', 'Whitaker', '0573755725', to_date('20-11-2002', 'dd-mm-yyyy'), to_date('28-06-2023', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1145, 'Benicio', 'Gibbons', '0560918726', to_date('22-04-1974', 'dd-mm-yyyy'), to_date('02-01-2019', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1146, 'Julio', 'Leigh', '0577624577', to_date('13-08-1992', 'dd-mm-yyyy'), to_date('27-12-2023', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1147, 'Kate', 'Hamilton', '0528998734', to_date('31-05-1979', 'dd-mm-yyyy'), to_date('30-06-2021', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1148, 'Loretta', 'Feuerstein', '0523993823', to_date('20-04-1997', 'dd-mm-yyyy'), to_date('03-07-2019', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1149, 'Wesley', 'Short', '0571759431', to_date('04-01-2001', 'dd-mm-yyyy'), to_date('06-07-2016', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1150, 'Natalie', 'Mollard', '0582697039', to_date('23-12-1989', 'dd-mm-yyyy'), to_date('07-01-2015', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1151, 'Gary', 'Berkley', '0526024223', to_date('22-08-1974', 'dd-mm-yyyy'), to_date('30-12-2020', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1152, 'Ashley', 'McKennitt', '0578069781', to_date('18-12-1992', 'dd-mm-yyyy'), to_date('05-07-2017', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1153, 'Hank', 'Derringer', '0513963171', to_date('28-06-1982', 'dd-mm-yyyy'), to_date('28-12-2022', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1154, 'Brian', 'Palminteri', '0563430447', to_date('26-09-2009', 'dd-mm-yyyy'), to_date('09-07-2014', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1155, 'Ali', 'Malkovich', '0515548838', to_date('01-03-1994', 'dd-mm-yyyy'), to_date('30-12-2020', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1156, 'Malcolm', 'James', '0518925823', to_date('26-10-1979', 'dd-mm-yyyy'), to_date('27-12-2023', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1157, 'Bernie', 'Watson', '0524865041', to_date('06-07-2001', 'dd-mm-yyyy'), to_date('06-01-2016', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1158, 'Domingo', 'Shaye', '0584210727', to_date('12-11-1998', 'dd-mm-yyyy'), to_date('08-07-2015', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1159, 'Naomi', 'Prowse', '0581748093', to_date('23-12-1999', 'dd-mm-yyyy'), to_date('04-01-2017', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1160, 'Thelma', 'Harry', '0565809973', to_date('30-11-1978', 'dd-mm-yyyy'), to_date('09-07-2014', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1161, 'Isaiah', 'Eat World', '0519288616', to_date('04-01-2005', 'dd-mm-yyyy'), to_date('03-01-2018', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1162, 'Lesley', 'Stevenson', '0533327264', to_date('15-05-1977', 'dd-mm-yyyy'), to_date('06-01-2016', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1163, 'Wang', 'Lange', '0599698772', to_date('14-12-1985', 'dd-mm-yyyy'), to_date('04-07-2018', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1164, 'Andrea', 'Peet', '0528955567', to_date('23-06-1992', 'dd-mm-yyyy'), to_date('05-07-2017', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1165, 'Elvis', 'Dysart', '0554147667', to_date('15-01-1985', 'dd-mm-yyyy'), to_date('28-12-2022', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1166, 'Suzi', 'Burns', '0576311379', to_date('23-06-2004', 'dd-mm-yyyy'), to_date('04-07-2018', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1167, 'Carl', 'Kweller', '0538505823', to_date('25-10-2007', 'dd-mm-yyyy'), to_date('04-01-2017', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1168, 'Kevin', 'Kenoly', '0535378090', to_date('12-07-1992', 'dd-mm-yyyy'), to_date('06-07-2016', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1169, 'Jessica', 'Forrest', '0557076786', to_date('05-09-1999', 'dd-mm-yyyy'), to_date('03-01-2018', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1170, 'Andre', 'Hingle', '0550688986', to_date('02-01-1984', 'dd-mm-yyyy'), to_date('04-01-2017', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1171, 'Delbert', 'Cohn', '0556411413', to_date('02-05-1998', 'dd-mm-yyyy'), to_date('30-12-2020', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1172, 'Gran', 'Boorem', '0583947700', to_date('26-11-1985', 'dd-mm-yyyy'), to_date('03-07-2019', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1173, 'Albertina', 'Savage', '0571398100', to_date('26-08-1992', 'dd-mm-yyyy'), to_date('06-07-2016', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1174, 'Kirk', 'Cozier', '0552047089', to_date('04-03-1970', 'dd-mm-yyyy'), to_date('28-06-2023', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1175, 'Chloe', 'Leachman', '0537163184', to_date('01-07-1988', 'dd-mm-yyyy'), to_date('04-01-2017', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1176, 'Vern', 'McKellen', '0585524932', to_date('15-11-1994', 'dd-mm-yyyy'), to_date('03-01-2018', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1177, 'Kitty', 'Leachman', '0583736328', to_date('27-01-2006', 'dd-mm-yyyy'), to_date('03-01-2018', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1178, 'Sinead', 'Quinn', '0568843885', to_date('21-02-1995', 'dd-mm-yyyy'), to_date('28-12-2022', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1179, 'Tommy', 'Penders', '0550465119', to_date('29-05-1973', 'dd-mm-yyyy'), to_date('04-07-2018', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1180, 'Harrison', 'Elizabeth', '0535263800', to_date('06-04-2003', 'dd-mm-yyyy'), to_date('04-07-2018', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1181, 'Larnelle', 'Mollard', '0529290063', to_date('13-01-1972', 'dd-mm-yyyy'), to_date('02-01-2019', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1182, 'Linda', 'Brolin', '0566242806', to_date('22-08-1982', 'dd-mm-yyyy'), to_date('05-07-2017', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1183, 'Sophie', 'Bright', '0525958220', to_date('28-01-1979', 'dd-mm-yyyy'), null);
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1184, 'Sheena', 'DiCaprio', '0537631076', to_date('26-06-1971', 'dd-mm-yyyy'), to_date('03-07-2019', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1185, 'Chuck', 'Wells', '0582964417', to_date('20-10-1980', 'dd-mm-yyyy'), to_date('29-12-2021', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1186, 'Jodie', 'Flanagan', '0551693373', to_date('26-06-1991', 'dd-mm-yyyy'), to_date('03-07-2019', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1187, 'Hazel', 'Whitford', '0559737614', to_date('06-06-1985', 'dd-mm-yyyy'), null);
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1188, 'Joely', 'Crow', '0555496559', to_date('07-05-2002', 'dd-mm-yyyy'), to_date('30-12-2020', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1189, 'Harvey', 'Jane', '0591037831', to_date('04-10-1991', 'dd-mm-yyyy'), null);
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1190, 'Rachael', 'Emmerich', '0575040709', to_date('28-06-1976', 'dd-mm-yyyy'), to_date('04-01-2017', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1191, 'Davey', 'Sampson', '0561306442', to_date('13-06-2007', 'dd-mm-yyyy'), to_date('02-01-2019', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1192, 'Dorry', 'Preston', '0589787271', to_date('20-02-2007', 'dd-mm-yyyy'), to_date('30-06-2021', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1193, 'Jay', 'Tippe', '0526393266', to_date('08-11-1997', 'dd-mm-yyyy'), to_date('06-07-2016', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1194, 'Etta', 'Cronin', '0539828934', to_date('07-11-2007', 'dd-mm-yyyy'), to_date('08-07-2015', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1195, 'Maria', 'Idol', '0536646612', to_date('16-09-1996', 'dd-mm-yyyy'), to_date('08-07-2015', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1196, 'Michelle', 'Black', '0529896683', to_date('26-08-1979', 'dd-mm-yyyy'), null);
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1197, 'Daryl', 'Sweet', '0540767315', to_date('18-07-1986', 'dd-mm-yyyy'), to_date('04-01-2017', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1198, 'Alex', 'Janney', '0567591373', to_date('14-03-1978', 'dd-mm-yyyy'), to_date('01-07-2020', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1199, 'Maury', 'Rippy', '0591904793', to_date('21-10-1980', 'dd-mm-yyyy'), null);
commit;
prompt 200 records committed...
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1200, 'Benjamin', 'Crystal', '0539961845', to_date('11-12-1981', 'dd-mm-yyyy'), to_date('30-06-2021', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1201, 'Shannyn', 'Diddley', '0534325903', to_date('18-12-1994', 'dd-mm-yyyy'), to_date('28-12-2022', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1202, 'Goran', 'Fogerty', '0539530945', to_date('15-02-2002', 'dd-mm-yyyy'), to_date('06-07-2016', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1203, 'Tamala', 'Portman', '0510229352', to_date('30-03-1981', 'dd-mm-yyyy'), to_date('29-12-2021', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1204, 'Sara', 'Leto', '0533444191', to_date('29-08-2003', 'dd-mm-yyyy'), to_date('09-07-2014', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1205, 'Edgar', 'Hannah', '0587714491', to_date('13-07-1986', 'dd-mm-yyyy'), to_date('07-01-2015', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1206, 'Pelvic', 'Hopper', '0572166868', to_date('31-10-1973', 'dd-mm-yyyy'), to_date('06-01-2016', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1207, 'Denny', 'Newton', '0583007521', to_date('26-10-2003', 'dd-mm-yyyy'), to_date('08-07-2015', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1208, 'Matt', 'Berkeley', '0557775664', to_date('16-06-1996', 'dd-mm-yyyy'), to_date('01-07-2020', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1209, 'Samuel', 'Vassar', '0572568917', to_date('07-08-2009', 'dd-mm-yyyy'), to_date('07-01-2015', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1210, 'Tori', 'Balaban', '0584963652', to_date('19-08-2008', 'dd-mm-yyyy'), to_date('06-07-2016', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1211, 'Lindsey', 'Marsden', '0535616885', to_date('05-09-1983', 'dd-mm-yyyy'), to_date('04-07-2018', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1212, 'Charles', 'Harrison', '0596739534', to_date('21-05-1998', 'dd-mm-yyyy'), to_date('07-01-2015', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1213, 'Rosie', 'Kane', '0530831068', to_date('23-02-1998', 'dd-mm-yyyy'), to_date('27-12-2023', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1214, 'Patti', 'Laurie', '0510273996', to_date('23-06-1999', 'dd-mm-yyyy'), to_date('03-07-2019', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1215, 'Sander', 'O''Hara', '0585206875', to_date('05-04-1990', 'dd-mm-yyyy'), to_date('28-06-2023', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1216, 'Dwight', 'Colman', '0568964652', to_date('14-08-1997', 'dd-mm-yyyy'), to_date('06-07-2016', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1217, 'Scarlett', 'Lemmon', '0599091284', to_date('12-04-1999', 'dd-mm-yyyy'), to_date('06-07-2016', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1218, 'Anthony', 'Speaks', '0510532663', to_date('09-12-2004', 'dd-mm-yyyy'), to_date('01-01-2020', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1219, 'Dianne', 'Beckham', '0541529430', to_date('09-05-1972', 'dd-mm-yyyy'), to_date('04-01-2017', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1220, 'Mandy', 'McIntosh', '0595266715', to_date('20-04-1990', 'dd-mm-yyyy'), to_date('28-12-2022', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1221, 'Delroy', 'Culkin', '0568651844', to_date('19-12-1971', 'dd-mm-yyyy'), to_date('30-06-2021', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1222, 'Miriam', 'Dorn', '0584325016', to_date('02-07-1978', 'dd-mm-yyyy'), to_date('06-01-2016', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1223, 'Marc', 'McGoohan', '0516737892', to_date('02-03-1992', 'dd-mm-yyyy'), to_date('06-07-2016', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1224, 'Chazz', 'Benet', '0556739205', to_date('23-12-1993', 'dd-mm-yyyy'), to_date('07-01-2015', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1225, 'Willie', 'Jay', '0511729133', to_date('30-04-1982', 'dd-mm-yyyy'), to_date('08-07-2015', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1226, 'Courtney', 'Bates', '0536268920', to_date('27-06-1979', 'dd-mm-yyyy'), to_date('06-07-2016', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1227, 'Patrick', 'Polley', '0526639201', to_date('24-08-1981', 'dd-mm-yyyy'), to_date('06-01-2016', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1228, 'Terence', 'Portman', '0526647100', to_date('25-06-2001', 'dd-mm-yyyy'), to_date('29-06-2022', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1229, 'Charles', 'DeGraw', '0553379265', to_date('10-07-2007', 'dd-mm-yyyy'), to_date('01-01-2020', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1230, 'Art', 'Bachman', '0599671055', to_date('26-08-1977', 'dd-mm-yyyy'), to_date('29-06-2022', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1231, 'Nik', 'Tyson', '0537119313', to_date('02-09-1981', 'dd-mm-yyyy'), to_date('07-01-2015', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1232, 'Sean', 'Matthau', '0578696555', to_date('09-03-1971', 'dd-mm-yyyy'), to_date('01-07-2020', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1233, 'Milla', 'Bryson', '0521933979', to_date('02-11-1987', 'dd-mm-yyyy'), to_date('05-07-2017', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1234, 'Andie', 'Hiatt', '0512984845', to_date('30-07-1974', 'dd-mm-yyyy'), to_date('01-01-2020', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1235, 'Isaiah', 'Mortensen', '0536434251', to_date('09-12-1991', 'dd-mm-yyyy'), null);
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1236, 'Nile', 'Robbins', '0592635463', to_date('28-03-1977', 'dd-mm-yyyy'), to_date('05-07-2017', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1237, 'Jonathan', 'Trevino', '0546791407', to_date('16-07-1993', 'dd-mm-yyyy'), to_date('28-06-2023', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1238, 'Merillee', 'Lonsdale', '0516254129', to_date('04-12-1987', 'dd-mm-yyyy'), to_date('29-12-2021', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1239, 'Rosco', 'Watson', '0554904178', to_date('15-05-1997', 'dd-mm-yyyy'), to_date('06-01-2016', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1240, 'Ming-Na', 'Herndon', '0544016533', to_date('19-12-1992', 'dd-mm-yyyy'), to_date('28-06-2023', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1241, 'Don', 'Mifune', '0571847731', to_date('07-03-1974', 'dd-mm-yyyy'), to_date('29-12-2021', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1242, 'Linda', 'Cassel', '0594140969', to_date('31-08-1984', 'dd-mm-yyyy'), to_date('03-01-2018', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1243, 'Steve', 'Osborne', '0549121029', to_date('29-08-1982', 'dd-mm-yyyy'), to_date('09-07-2014', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1244, 'Rhea', 'Yorn', '0524201425', to_date('02-04-1978', 'dd-mm-yyyy'), to_date('03-07-2019', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1245, 'Stevie', 'Morse', '0585874309', to_date('12-03-2000', 'dd-mm-yyyy'), to_date('04-07-2018', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1246, 'Leon', 'Nicholas', '0598626007', to_date('18-03-1970', 'dd-mm-yyyy'), to_date('09-07-2014', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1247, 'Seth', 'Peterson', '0557329252', to_date('30-05-1986', 'dd-mm-yyyy'), to_date('27-12-2023', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1248, 'Rutger', 'Numan', '0528119072', to_date('14-07-1978', 'dd-mm-yyyy'), to_date('05-07-2017', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1249, 'Balthazar', 'Moorer', '0552207678', to_date('20-01-1987', 'dd-mm-yyyy'), to_date('01-01-2020', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1250, 'Kitty', 'Underwood', '0592772548', to_date('31-07-1985', 'dd-mm-yyyy'), to_date('30-06-2021', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1251, 'Belinda', 'Favreau', '0552711391', to_date('06-11-2006', 'dd-mm-yyyy'), to_date('09-07-2014', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1252, 'Campbell', 'Gates', '0574858354', to_date('16-04-2004', 'dd-mm-yyyy'), to_date('30-06-2021', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1253, 'Victor', 'Affleck', '0557613615', to_date('23-08-1987', 'dd-mm-yyyy'), to_date('04-01-2017', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1254, 'Wayne', 'Torn', '0518275721', to_date('02-01-1971', 'dd-mm-yyyy'), to_date('04-01-2017', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1255, 'Jonny Lee', 'Arden', '0589310922', to_date('24-02-1990', 'dd-mm-yyyy'), to_date('01-01-2020', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1256, 'Dianne', 'Cantrell', '0584327105', to_date('16-01-1992', 'dd-mm-yyyy'), to_date('29-06-2022', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1257, 'Meg', 'Teng', '0575439293', to_date('20-07-2006', 'dd-mm-yyyy'), to_date('01-01-2020', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1258, 'Judy', 'Browne', '0532879593', to_date('08-02-1993', 'dd-mm-yyyy'), to_date('01-07-2020', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1259, 'Gwyneth', 'Avalon', '0581326426', to_date('23-05-1987', 'dd-mm-yyyy'), to_date('29-12-2021', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1260, 'Thelma', 'Burstyn', '0582654519', to_date('12-02-1988', 'dd-mm-yyyy'), to_date('30-12-2020', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1261, 'Sylvester', 'Warden', '0593069034', to_date('24-03-1988', 'dd-mm-yyyy'), to_date('29-12-2021', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1262, 'Oro', 'Webb', '0597422698', to_date('30-03-1992', 'dd-mm-yyyy'), to_date('29-12-2021', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1263, 'Rod', 'Borden', '0539658638', to_date('22-12-1992', 'dd-mm-yyyy'), to_date('06-01-2016', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1264, 'Debra', 'Randal', '0525224549', to_date('14-09-2009', 'dd-mm-yyyy'), to_date('27-12-2023', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1265, 'Thora', 'Lunch', '0529018856', to_date('09-04-1971', 'dd-mm-yyyy'), to_date('01-01-2020', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1266, 'Cherry', 'Moffat', '0526537628', to_date('29-03-1997', 'dd-mm-yyyy'), to_date('01-01-2020', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1267, 'Renee', 'O''Donnell', '0593193048', to_date('02-05-1978', 'dd-mm-yyyy'), to_date('01-01-2020', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1268, 'Crispin', 'Mitra', '0522175184', to_date('02-04-2001', 'dd-mm-yyyy'), null);
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1269, 'Harry', 'Swinton', '0525786754', to_date('15-05-1999', 'dd-mm-yyyy'), to_date('29-12-2021', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1270, 'Ricky', 'Marshall', '0583714853', to_date('27-11-1986', 'dd-mm-yyyy'), to_date('09-07-2014', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1271, 'Lena', 'Lloyd', '0587694066', to_date('31-03-1996', 'dd-mm-yyyy'), to_date('27-12-2023', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1272, 'Cameron', 'Durning', '0527882325', to_date('28-07-1974', 'dd-mm-yyyy'), null);
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1273, 'Cuba', 'Broza', '0531457744', to_date('11-03-1974', 'dd-mm-yyyy'), to_date('02-01-2019', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1274, 'Wally', 'Hart', '0599472495', to_date('08-12-1983', 'dd-mm-yyyy'), to_date('29-06-2022', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1275, 'Jean-Claude', 'Richards', '0520581249', to_date('13-05-1978', 'dd-mm-yyyy'), to_date('02-01-2019', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1276, 'Phoebe', 'Shannon', '0514139511', to_date('17-07-1995', 'dd-mm-yyyy'), to_date('09-07-2014', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1277, 'Jake', 'Heatherly', '0544063238', to_date('27-01-1992', 'dd-mm-yyyy'), null);
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1278, 'Edwin', 'Wiest', '0572519969', to_date('09-11-1997', 'dd-mm-yyyy'), to_date('01-07-2020', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1279, 'Aaron', 'DeGraw', '0516072698', to_date('02-04-1977', 'dd-mm-yyyy'), to_date('07-01-2015', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1280, 'Leelee', 'Ripley', '0515605021', to_date('18-05-2009', 'dd-mm-yyyy'), to_date('29-06-2022', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1281, 'Isaiah', 'Warwick', '0514068964', to_date('24-12-1981', 'dd-mm-yyyy'), null);
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1282, 'Paul', 'Duke', '0561386709', to_date('21-04-1974', 'dd-mm-yyyy'), to_date('28-06-2023', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1283, 'Buffy', 'Browne', '0593069598', to_date('31-05-1976', 'dd-mm-yyyy'), to_date('06-07-2016', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1284, 'Javon', 'Wakeling', '0531644909', to_date('08-12-2005', 'dd-mm-yyyy'), to_date('03-01-2018', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1285, 'Udo', 'McKellen', '0537578447', to_date('30-03-1975', 'dd-mm-yyyy'), to_date('04-07-2018', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1286, 'Alice', 'Faithfull', '0565680282', to_date('15-04-1999', 'dd-mm-yyyy'), to_date('06-07-2016', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1287, 'Jonny Lee', 'Taylor', '0530725470', to_date('30-09-1975', 'dd-mm-yyyy'), to_date('28-12-2022', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1288, 'Lari', 'McIntosh', '0541459453', to_date('13-12-1990', 'dd-mm-yyyy'), to_date('03-01-2018', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1289, 'Bonnie', 'Union', '0592297028', to_date('09-11-2006', 'dd-mm-yyyy'), to_date('03-07-2019', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1290, 'Dan', 'Nicks', '0533447345', to_date('03-02-1995', 'dd-mm-yyyy'), to_date('29-06-2022', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1291, 'Johnnie', 'Stanton', '0590852174', to_date('15-01-1983', 'dd-mm-yyyy'), to_date('09-07-2014', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1292, 'Kieran', 'Wiest', '0545739496', to_date('19-02-1986', 'dd-mm-yyyy'), to_date('02-01-2019', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1293, 'Julia', 'Coe', '0535393372', to_date('06-08-2000', 'dd-mm-yyyy'), to_date('02-01-2019', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1294, 'Murray', 'Close', '0570623682', to_date('12-07-2003', 'dd-mm-yyyy'), to_date('06-07-2016', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1295, 'Clive', 'Winslet', '0513243234', to_date('22-02-1982', 'dd-mm-yyyy'), to_date('28-12-2022', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1296, 'Ving', 'Cruise', '0549008817', to_date('17-03-1998', 'dd-mm-yyyy'), to_date('03-07-2019', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1297, 'Denny', 'Olin', '0513884260', to_date('23-04-1979', 'dd-mm-yyyy'), to_date('27-12-2023', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1298, 'Selma', 'Haggard', '0562059138', to_date('22-10-2009', 'dd-mm-yyyy'), to_date('02-01-2019', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1299, 'Ty', 'Guzman', '0547145151', to_date('22-07-1986', 'dd-mm-yyyy'), to_date('05-07-2017', 'dd-mm-yyyy'));
commit;
prompt 300 records committed...
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1300, 'Mos', 'Gugino', '0516351459', to_date('26-01-1994', 'dd-mm-yyyy'), to_date('05-07-2017', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1301, 'Mary-Louise', 'Cage', '0591149584', to_date('09-09-1979', 'dd-mm-yyyy'), to_date('29-12-2021', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1302, 'Larry', 'Costello', '0592477944', to_date('03-11-1986', 'dd-mm-yyyy'), to_date('01-01-2020', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1303, 'Annette', 'McCabe', '0558567409', to_date('22-11-1985', 'dd-mm-yyyy'), to_date('27-12-2023', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1304, 'Juliet', 'Lee', '0578652534', to_date('17-02-1993', 'dd-mm-yyyy'), to_date('09-07-2014', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1305, 'Alannah', 'Mollard', '0592376432', to_date('04-04-2004', 'dd-mm-yyyy'), to_date('27-12-2023', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1306, 'Edward', 'Nivola', '0577527631', to_date('07-01-1989', 'dd-mm-yyyy'), to_date('05-07-2017', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1307, 'Mia', 'Carradine', '0559896587', to_date('17-11-1996', 'dd-mm-yyyy'), to_date('28-06-2023', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1308, 'Tom', 'Cotton', '0517657796', to_date('14-07-1982', 'dd-mm-yyyy'), to_date('03-01-2018', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1309, 'Ted', 'Harry', '0559348072', to_date('14-08-1996', 'dd-mm-yyyy'), to_date('27-12-2023', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1310, 'Lee', 'Noseworthy', '0592718626', to_date('13-03-1981', 'dd-mm-yyyy'), to_date('03-01-2018', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1311, 'Humberto', 'Paul', '0541269413', to_date('08-10-2005', 'dd-mm-yyyy'), to_date('30-12-2020', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1312, 'Jeff', 'Harrelson', '0570267808', to_date('20-03-1999', 'dd-mm-yyyy'), to_date('04-07-2018', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1313, 'Lonnie', 'Magnuson', '0523822653', to_date('28-10-1976', 'dd-mm-yyyy'), to_date('01-01-2020', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1314, 'Micky', 'Moore', '0565309928', to_date('03-09-1977', 'dd-mm-yyyy'), to_date('30-12-2020', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1315, 'Donal', 'Pony', '0545582648', to_date('09-07-1996', 'dd-mm-yyyy'), to_date('02-01-2019', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1316, 'Rickie', 'Ribisi', '0573413463', to_date('26-02-2001', 'dd-mm-yyyy'), to_date('06-07-2016', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1317, 'Kenneth', 'Galecki', '0526216933', to_date('25-07-1988', 'dd-mm-yyyy'), to_date('06-01-2016', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1318, 'Lizzy', 'Brandt', '0541451446', to_date('05-01-1982', 'dd-mm-yyyy'), null);
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1319, 'Curtis', 'Quinones', '0519959868', to_date('18-12-2001', 'dd-mm-yyyy'), to_date('06-01-2016', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1320, 'Suzanne', 'Dean', '0572124495', to_date('01-10-1973', 'dd-mm-yyyy'), to_date('06-01-2016', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1321, 'Alana', 'Spall', '0554037548', to_date('22-01-2000', 'dd-mm-yyyy'), to_date('03-07-2019', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1322, 'Kevin', 'Curtis-Hall', '0553011652', to_date('14-11-2007', 'dd-mm-yyyy'), to_date('02-01-2019', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1323, 'Merle', 'Sawa', '0525114471', to_date('10-08-1974', 'dd-mm-yyyy'), to_date('07-01-2015', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1324, 'Pete', 'McAnally', '0523905570', to_date('12-03-1987', 'dd-mm-yyyy'), to_date('01-07-2020', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1325, 'Gin', 'Bruce', '0537257136', to_date('19-06-1986', 'dd-mm-yyyy'), to_date('29-06-2022', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1326, 'Pelvic', 'Solido', '0535309254', to_date('25-10-1976', 'dd-mm-yyyy'), to_date('29-06-2022', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1327, 'Lindsay', 'Hoskins', '0550943184', to_date('05-12-1989', 'dd-mm-yyyy'), to_date('02-01-2019', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1328, 'Meredith', 'Avital', '0543288725', to_date('20-09-1983', 'dd-mm-yyyy'), to_date('09-07-2014', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1329, 'Claude', 'Torres', '0592837944', to_date('11-12-2005', 'dd-mm-yyyy'), to_date('28-12-2022', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1330, 'Teena', 'Dawson', '0536156643', to_date('09-12-1971', 'dd-mm-yyyy'), to_date('08-07-2015', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1331, 'Angela', 'Iglesias', '0551897542', to_date('27-05-1971', 'dd-mm-yyyy'), to_date('28-12-2022', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1332, 'Wayman', 'Hamilton', '0582985125', to_date('30-10-1985', 'dd-mm-yyyy'), to_date('09-07-2014', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1333, 'Maxine', 'Merchant', '0599392109', to_date('14-04-2006', 'dd-mm-yyyy'), to_date('03-01-2018', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1334, 'Art', 'Janney', '0528471712', to_date('24-05-2007', 'dd-mm-yyyy'), to_date('01-01-2020', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1335, 'Janice', 'Satriani', '0517105032', to_date('02-03-2003', 'dd-mm-yyyy'), to_date('27-12-2023', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1336, 'Charles', 'Skerritt', '0543539059', to_date('28-08-1975', 'dd-mm-yyyy'), to_date('09-07-2014', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1337, 'Gordie', 'Humphrey', '0524516802', to_date('17-02-1981', 'dd-mm-yyyy'), to_date('07-01-2015', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1338, 'Kyle', 'Diaz', '0547288483', to_date('19-10-1995', 'dd-mm-yyyy'), to_date('28-06-2023', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1339, 'Katie', 'Perry', '0583632917', to_date('31-12-1984', 'dd-mm-yyyy'), to_date('01-01-2020', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1340, 'Boz', 'Estevez', '0558301436', to_date('29-07-1981', 'dd-mm-yyyy'), null);
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1341, 'Robby', 'Cornell', '0560209992', to_date('31-07-1996', 'dd-mm-yyyy'), to_date('08-07-2015', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1342, 'Desmond', 'Fraser', '0571885386', to_date('30-12-1980', 'dd-mm-yyyy'), to_date('04-07-2018', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1343, 'Halle', 'Bergen', '0515615950', to_date('08-11-1981', 'dd-mm-yyyy'), to_date('08-07-2015', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1344, 'Salma', 'Mann', '0537124040', to_date('09-08-1988', 'dd-mm-yyyy'), to_date('30-12-2020', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1345, 'Anita', 'Buffalo', '0573506799', to_date('03-01-1985', 'dd-mm-yyyy'), to_date('04-01-2017', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1346, 'Dylan', 'English', '0514470444', to_date('29-07-1993', 'dd-mm-yyyy'), to_date('28-06-2023', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1347, 'Vanessa', 'Wainwright', '0516046315', to_date('03-01-1970', 'dd-mm-yyyy'), to_date('09-07-2014', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1348, 'Jonny', 'Cozier', '0565682764', to_date('04-01-2009', 'dd-mm-yyyy'), to_date('28-12-2022', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1349, 'Alan', 'Sampson', '0528921228', to_date('03-08-2003', 'dd-mm-yyyy'), to_date('28-12-2022', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1350, 'Nikka', 'Seagal', '0584496965', to_date('26-05-2005', 'dd-mm-yyyy'), to_date('30-06-2021', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1351, 'Marley', 'Lithgow', '0557355636', to_date('01-09-2007', 'dd-mm-yyyy'), to_date('05-07-2017', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1352, 'Tzi', 'Hanks', '0594539448', to_date('15-12-2001', 'dd-mm-yyyy'), to_date('06-07-2016', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1353, 'Joely', 'Galecki', '0556168759', to_date('13-07-2002', 'dd-mm-yyyy'), to_date('03-07-2019', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1354, 'Raul', 'Thornton', '0518399520', to_date('15-06-1979', 'dd-mm-yyyy'), to_date('05-07-2017', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1355, 'Lara', 'Borgnine', '0568976925', to_date('26-11-2009', 'dd-mm-yyyy'), to_date('02-01-2019', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1356, 'Wade', 'Conlee', '0594228416', to_date('25-12-2001', 'dd-mm-yyyy'), to_date('29-12-2021', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1357, 'Nicole', 'Woodard', '0556086684', to_date('03-04-2001', 'dd-mm-yyyy'), to_date('29-06-2022', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1358, 'Stellan', 'Craven', '0591445604', to_date('19-06-1991', 'dd-mm-yyyy'), to_date('01-01-2020', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1359, 'Helen', 'Strathairn', '0530035715', to_date('18-09-2006', 'dd-mm-yyyy'), to_date('30-06-2021', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1360, 'Ming-Na', 'Caan', '0530958097', to_date('19-11-2000', 'dd-mm-yyyy'), to_date('07-01-2015', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1361, 'Bonnie', 'Morton', '0560742631', to_date('03-11-2007', 'dd-mm-yyyy'), to_date('09-07-2014', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1362, 'Paul', 'Wayans', '0524392397', to_date('10-06-2007', 'dd-mm-yyyy'), to_date('03-07-2019', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1363, 'Elizabeth', 'Evans', '0552477111', to_date('25-12-1988', 'dd-mm-yyyy'), to_date('28-12-2022', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1364, 'Teena', 'Schwimmer', '0551721972', to_date('24-11-1979', 'dd-mm-yyyy'), to_date('29-06-2022', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1365, 'Richie', 'Dorn', '0510976145', to_date('22-02-1988', 'dd-mm-yyyy'), to_date('04-07-2018', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1366, 'Chubby', 'Cassidy', '0579153042', to_date('12-06-1979', 'dd-mm-yyyy'), to_date('30-06-2021', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1367, 'Gilbert', 'Rispoli', '0524574528', to_date('04-10-2000', 'dd-mm-yyyy'), to_date('08-07-2015', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1368, 'Rosie', 'Clooney', '0574033424', to_date('19-03-1999', 'dd-mm-yyyy'), to_date('28-06-2023', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1369, 'Jay', 'Epps', '0530758210', to_date('29-01-1996', 'dd-mm-yyyy'), to_date('01-07-2020', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1370, 'Diane', 'Dushku', '0560295260', to_date('07-07-1982', 'dd-mm-yyyy'), to_date('03-01-2018', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1371, 'Samuel', 'Newman', '0561136729', to_date('23-08-2003', 'dd-mm-yyyy'), null);
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1372, 'Tobey', 'Austin', '0530422658', to_date('07-10-1980', 'dd-mm-yyyy'), to_date('06-01-2016', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1373, 'Raul', 'Westerberg', '0599774497', to_date('10-08-1988', 'dd-mm-yyyy'), to_date('02-01-2019', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1374, 'Boz', 'Elizondo', '0572003895', to_date('25-10-2009', 'dd-mm-yyyy'), to_date('29-06-2022', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1375, 'Charlton', 'Torino', '0547486450', to_date('19-08-2005', 'dd-mm-yyyy'), to_date('02-01-2019', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1376, 'Omar', 'Hornsby', '0519044002', to_date('23-12-1994', 'dd-mm-yyyy'), to_date('06-01-2016', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1377, 'Mika', 'Puckett', '0566111933', to_date('23-01-1987', 'dd-mm-yyyy'), to_date('27-12-2023', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1378, 'Geggy', 'Reid', '0513447054', to_date('13-06-1975', 'dd-mm-yyyy'), to_date('28-12-2022', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1379, 'Adam', 'Bening', '0571542624', to_date('21-10-1994', 'dd-mm-yyyy'), to_date('28-06-2023', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1380, 'Larnelle', 'Cage', '0519751440', to_date('21-11-1991', 'dd-mm-yyyy'), to_date('03-07-2019', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1381, 'Saul', 'Sharp', '0559787621', to_date('19-10-2007', 'dd-mm-yyyy'), to_date('30-12-2020', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1382, 'David', 'Osment', '0520985880', to_date('02-01-1982', 'dd-mm-yyyy'), to_date('04-07-2018', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1383, 'Tanya', 'Schiff', '0590744736', to_date('22-04-1992', 'dd-mm-yyyy'), to_date('08-07-2015', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1384, 'Debi', 'Furtado', '0597482978', to_date('03-08-1970', 'dd-mm-yyyy'), to_date('07-01-2015', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1385, 'Daryl', 'Underwood', '0537653163', to_date('27-01-1997', 'dd-mm-yyyy'), to_date('03-01-2018', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1386, 'Brittany', 'Thomson', '0525050320', to_date('11-10-2001', 'dd-mm-yyyy'), to_date('03-07-2019', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1387, 'Jaime', 'Spacey', '0539814873', to_date('24-05-1991', 'dd-mm-yyyy'), to_date('03-01-2018', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1388, 'Maceo', 'Connery', '0593409355', to_date('26-08-1970', 'dd-mm-yyyy'), to_date('04-01-2017', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1389, 'Juliana', 'Venora', '0581535204', to_date('22-10-1994', 'dd-mm-yyyy'), to_date('28-12-2022', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1390, 'Embeth', 'Blackmore', '0569247054', to_date('21-03-1988', 'dd-mm-yyyy'), to_date('05-07-2017', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1391, 'Benjamin', 'Hatosy', '0573392676', to_date('04-04-2000', 'dd-mm-yyyy'), to_date('01-01-2020', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1392, 'Woody', 'Midler', '0550553615', to_date('25-10-1993', 'dd-mm-yyyy'), to_date('09-07-2014', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1393, 'Paul', 'Pryce', '0547563999', to_date('19-08-1993', 'dd-mm-yyyy'), to_date('04-01-2017', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1394, 'Marianne', 'Marley', '0531434731', to_date('06-08-2005', 'dd-mm-yyyy'), to_date('09-07-2014', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1395, 'Cledus', 'Tanon', '0525161810', to_date('02-01-1999', 'dd-mm-yyyy'), to_date('07-01-2015', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1396, 'Charlie', 'Pleasence', '0572021853', to_date('04-07-1992', 'dd-mm-yyyy'), to_date('29-06-2022', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1397, 'Elle', 'Ward', '0544909112', to_date('26-08-1972', 'dd-mm-yyyy'), to_date('01-01-2020', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1398, 'Willem', 'Hutch', '0558485017', to_date('26-12-1994', 'dd-mm-yyyy'), to_date('04-01-2017', 'dd-mm-yyyy'));
insert into CUSTOMERS (customerid, firstname, lastname, phonenumber, birthdaydate, lastpurchasedate)
values (1399, 'Nigel', 'Dayne', '0541628535', to_date('16-08-1988', 'dd-mm-yyyy'), to_date('30-12-2020', 'dd-mm-yyyy'));
commit;
prompt 400 records loaded
prompt Loading VENUES...
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (1, 'Grand Hall', '123 Main St', 500, to_date('01-01-2000', 'dd-mm-yyyy'), to_date('01-01-2020', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (2, 'Conference Center', '456 Elm St', 200, to_date('05-05-2005', 'dd-mm-yyyy'), to_date('05-05-2015', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (3, 'Banquet Hall', '789 Oak St', 300, to_date('15-03-2010', 'dd-mm-yyyy'), to_date('15-03-2020', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (4, 'Wedding Venue', '101 Pine St', 400, to_date('20-07-2008', 'dd-mm-yyyy'), to_date('20-07-2018', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (5, 'Convention Center', '202 Cedar St', 800, to_date('10-11-2012', 'dd-mm-yyyy'), to_date('10-11-2022', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (6, 'Exhibition Hall', '303 Birch St', 250, to_date('25-02-2016', 'dd-mm-yyyy'), to_date('25-02-2026', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (7, 'Garden Venue', '404 Maple St', 350, to_date('18-06-2001', 'dd-mm-yyyy'), to_date('18-06-2021', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (8, 'Rooftop Venue', '505 Walnut St', 150, to_date('22-09-2003', 'dd-mm-yyyy'), to_date('22-09-2023', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (9, 'Beach Venue', '606 Palm St', 600, to_date('12-12-2014', 'dd-mm-yyyy'), to_date('12-12-2024', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (10, 'Country Club', '707 Spruce St', 450, to_date('08-04-2006', 'dd-mm-yyyy'), to_date('08-04-2016', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (11, 'City Hall', '808 Fir St', 700, to_date('14-08-2011', 'dd-mm-yyyy'), to_date('14-08-2021', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (12, 'Historic Mansion', '909 Cherry St', 320, to_date('28-10-2009', 'dd-mm-yyyy'), to_date('28-10-2019', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (13, 'Art Gallery', '1010 Ash St', 180, to_date('06-01-2017', 'dd-mm-yyyy'), to_date('06-01-2027', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (14, 'Hotel Ballroom', '1111 Willow St', 500, to_date('19-05-2002', 'dd-mm-yyyy'), to_date('19-05-2022', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (15, 'Museum Venue', '1212 Poplar St', 600, to_date('23-07-2015', 'dd-mm-yyyy'), to_date('23-07-2025', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (16, 'Resort Venue', '1313 Beech St', 350, to_date('30-03-2004', 'dd-mm-yyyy'), to_date('30-03-2024', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (17, 'Event Pavilion', '1414 Hemlock St', 250, to_date('11-09-2007', 'dd-mm-yyyy'), to_date('11-09-2027', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (18, 'Auditorium', '1515 Magnolia St', 450, to_date('05-11-2013', 'dd-mm-yyyy'), to_date('05-11-2023', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (19, 'Lakeside Venue', '1616 Olive St', 550, to_date('17-06-2018', 'dd-mm-yyyy'), to_date('17-06-2028', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (20, 'Park Venue', '1717 Cypress St', 220, to_date('01-10-2019', 'dd-mm-yyyy'), to_date('01-10-2029', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (21, 'Community Center', '1818 Pine St', 400, to_date('12-01-2020', 'dd-mm-yyyy'), to_date('12-01-2030', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (22, 'Mountain Lodge', '1919 Palm St', 300, to_date('14-02-2000', 'dd-mm-yyyy'), to_date('14-02-2020', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (23, 'Desert Venue', '2020 Maple St', 200, to_date('16-03-2005', 'dd-mm-yyyy'), to_date('16-03-2025', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (24, 'Vineyard Venue', '2121 Oak St', 350, to_date('18-04-2010', 'dd-mm-yyyy'), to_date('18-04-2030', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (25, 'Island Venue', '2323 Elm St', 500, to_date('20-05-2015', 'dd-mm-yyyy'), to_date('20-05-2035', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (26, 'River Venue', '2424 Spruce St', 250, to_date('22-06-2020', 'dd-mm-yyyy'), to_date('22-06-2040', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (27, 'Forest Venue', '2525 Fir St', 450, to_date('24-07-2003', 'dd-mm-yyyy'), to_date('24-07-2023', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (28, 'Castle Venue', '2626 Cedar St', 600, to_date('26-08-2008', 'dd-mm-yyyy'), to_date('26-08-2028', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (29, 'Heritage Hall', '2727 Birch St', 320, to_date('28-09-2013', 'dd-mm-yyyy'), to_date('28-09-2033', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (30, 'Library Venue', '2828 Cherry St', 180, to_date('30-10-2018', 'dd-mm-yyyy'), to_date('30-10-2038', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (31, 'Ranch Venue', '2929 Ash St', 500, to_date('01-11-2001', 'dd-mm-yyyy'), to_date('01-11-2021', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (32, 'Palace Venue', '3030 Willow St', 700, to_date('03-12-2006', 'dd-mm-yyyy'), to_date('03-12-2026', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (33, 'Studio Venue', '3131 Poplar St', 150, to_date('25-03-2008', 'dd-mm-yyyy'), to_date('25-03-2028', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (34, 'Sports Arena', '3232 Maple St', 1000, to_date('30-05-2010', 'dd-mm-yyyy'), to_date('30-05-2030', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (35, 'Theater Venue', '3333 Elm St', 750, to_date('15-07-2012', 'dd-mm-yyyy'), to_date('15-07-2032', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (36, 'Boat House', '3434 Pine St', 300, to_date('20-08-2014', 'dd-mm-yyyy'), to_date('20-08-2034', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (37, 'Aquarium Venue', '3535 Palm St', 400, to_date('10-09-2016', 'dd-mm-yyyy'), to_date('10-09-2036', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (38, 'Zoo Pavilion', '3636 Spruce St', 600, to_date('05-10-2018', 'dd-mm-yyyy'), to_date('05-10-2038', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (39, 'Amphitheater', '3737 Maple St', 1200, to_date('25-11-2020', 'dd-mm-yyyy'), to_date('25-11-2040', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (40, 'Convention Hall', '3838 Elm St', 900, to_date('15-12-2022', 'dd-mm-yyyy'), to_date('15-12-2042', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (1000, 'Grand Hall', '123 Main St', 500, to_date('01-01-2000', 'dd-mm-yyyy'), to_date('01-01-2020', 'dd-mm-yyyy'));
insert into VENUES (venueid, name, location, capacity, opendate, renovationdate)
values (2000, 'Conference Center', '456 Elm St', 200, to_date('05-05-2005', 'dd-mm-yyyy'), to_date('05-05-2015', 'dd-mm-yyyy'));
commit;
prompt 42 records loaded
prompt Loading EVENTS_...
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2000, to_date('23-04-2022', 'dd-mm-yyyy'), to_date('29-12-2021', 'dd-mm-yyyy'), 1172, 27);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2001, to_date('05-08-2022', 'dd-mm-yyyy'), to_date('13-08-2021', 'dd-mm-yyyy'), 1104, 2);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2002, to_date('30-10-2022', 'dd-mm-yyyy'), to_date('17-09-2021', 'dd-mm-yyyy'), 1358, 30);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2003, to_date('18-04-2022', 'dd-mm-yyyy'), to_date('25-11-2021', 'dd-mm-yyyy'), 1138, 17);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2004, to_date('06-08-2022', 'dd-mm-yyyy'), to_date('19-01-2021', 'dd-mm-yyyy'), 1351, 35);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2005, to_date('03-02-2022', 'dd-mm-yyyy'), to_date('02-04-2021', 'dd-mm-yyyy'), 1087, 37);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2006, to_date('25-10-2022', 'dd-mm-yyyy'), to_date('24-05-2021', 'dd-mm-yyyy'), 1079, 5);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2007, to_date('10-11-2022', 'dd-mm-yyyy'), to_date('05-01-2021', 'dd-mm-yyyy'), 1218, 14);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2008, to_date('06-09-2022', 'dd-mm-yyyy'), to_date('29-09-2021', 'dd-mm-yyyy'), 1378, 11);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2009, to_date('27-01-2022', 'dd-mm-yyyy'), to_date('17-02-2021', 'dd-mm-yyyy'), 1296, 20);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2010, to_date('17-10-2022', 'dd-mm-yyyy'), to_date('02-09-2021', 'dd-mm-yyyy'), 1338, 17);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2011, to_date('20-01-2022', 'dd-mm-yyyy'), to_date('15-04-2021', 'dd-mm-yyyy'), 1311, 37);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2012, to_date('01-06-2022', 'dd-mm-yyyy'), to_date('17-08-2021', 'dd-mm-yyyy'), 1349, 33);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2013, to_date('30-09-2022', 'dd-mm-yyyy'), to_date('22-11-2021', 'dd-mm-yyyy'), 1029, 14);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2014, to_date('20-04-2022', 'dd-mm-yyyy'), to_date('01-02-2021', 'dd-mm-yyyy'), 1356, 14);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2015, to_date('03-02-2022', 'dd-mm-yyyy'), to_date('17-11-2021', 'dd-mm-yyyy'), 1161, 24);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2016, to_date('01-02-2022', 'dd-mm-yyyy'), to_date('26-06-2021', 'dd-mm-yyyy'), 1151, 2000);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2017, to_date('08-12-2022', 'dd-mm-yyyy'), to_date('10-04-2021', 'dd-mm-yyyy'), 1367, 9);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2018, to_date('26-03-2022', 'dd-mm-yyyy'), to_date('18-12-2021', 'dd-mm-yyyy'), 1080, 32);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2019, to_date('09-07-2022', 'dd-mm-yyyy'), to_date('21-08-2021', 'dd-mm-yyyy'), 1079, 2);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2020, to_date('20-07-2022', 'dd-mm-yyyy'), to_date('16-12-2021', 'dd-mm-yyyy'), 1185, 36);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2021, to_date('09-07-2022', 'dd-mm-yyyy'), to_date('11-04-2021', 'dd-mm-yyyy'), 1148, 33);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2022, to_date('08-04-2022', 'dd-mm-yyyy'), to_date('24-07-2021', 'dd-mm-yyyy'), 1159, 10);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2023, to_date('29-08-2022', 'dd-mm-yyyy'), to_date('13-04-2021', 'dd-mm-yyyy'), 1122, 32);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2024, to_date('03-09-2022', 'dd-mm-yyyy'), to_date('24-09-2021', 'dd-mm-yyyy'), 1139, 19);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2025, to_date('15-11-2022', 'dd-mm-yyyy'), to_date('19-05-2021', 'dd-mm-yyyy'), 1341, 16);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2026, to_date('25-04-2022', 'dd-mm-yyyy'), to_date('13-04-2021', 'dd-mm-yyyy'), 1314, 33);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2027, to_date('17-01-2022', 'dd-mm-yyyy'), to_date('05-08-2021', 'dd-mm-yyyy'), 1065, 25);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2028, to_date('06-10-2022', 'dd-mm-yyyy'), to_date('20-09-2021', 'dd-mm-yyyy'), 1164, 29);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2029, to_date('20-04-2022', 'dd-mm-yyyy'), to_date('17-09-2021', 'dd-mm-yyyy'), 1021, 31);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2030, to_date('12-12-2022', 'dd-mm-yyyy'), to_date('08-11-2021', 'dd-mm-yyyy'), 1120, 25);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2031, to_date('10-11-2022', 'dd-mm-yyyy'), to_date('04-08-2021', 'dd-mm-yyyy'), 1178, 30);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2032, to_date('08-01-2022', 'dd-mm-yyyy'), to_date('05-04-2021', 'dd-mm-yyyy'), 1051, 39);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2033, to_date('21-06-2022', 'dd-mm-yyyy'), to_date('29-03-2021', 'dd-mm-yyyy'), 1346, 22);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2034, to_date('03-11-2022', 'dd-mm-yyyy'), to_date('08-07-2021', 'dd-mm-yyyy'), 1176, 25);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2035, to_date('17-05-2022', 'dd-mm-yyyy'), to_date('28-09-2021', 'dd-mm-yyyy'), 1000, 1);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2036, to_date('16-12-2022', 'dd-mm-yyyy'), to_date('17-04-2021', 'dd-mm-yyyy'), 1001, 27);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2037, to_date('11-11-2022', 'dd-mm-yyyy'), to_date('19-12-2021', 'dd-mm-yyyy'), 1130, 6);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2038, to_date('18-03-2022', 'dd-mm-yyyy'), to_date('19-03-2021', 'dd-mm-yyyy'), 1080, 11);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2039, to_date('19-05-2022', 'dd-mm-yyyy'), to_date('14-02-2021', 'dd-mm-yyyy'), 1314, 4);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2040, to_date('07-11-2022', 'dd-mm-yyyy'), to_date('22-07-2021', 'dd-mm-yyyy'), 1203, 8);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2041, to_date('14-03-2022', 'dd-mm-yyyy'), to_date('06-02-2021', 'dd-mm-yyyy'), 1218, 17);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2042, to_date('03-04-2022', 'dd-mm-yyyy'), to_date('07-10-2021', 'dd-mm-yyyy'), 1007, 12);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2043, to_date('21-08-2022', 'dd-mm-yyyy'), to_date('17-08-2021', 'dd-mm-yyyy'), 1321, 28);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2044, to_date('04-03-2022', 'dd-mm-yyyy'), to_date('07-10-2021', 'dd-mm-yyyy'), 1012, 21);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2045, to_date('17-11-2022', 'dd-mm-yyyy'), to_date('04-04-2021', 'dd-mm-yyyy'), 1263, 8);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2046, to_date('30-07-2022', 'dd-mm-yyyy'), to_date('31-01-2021', 'dd-mm-yyyy'), 1283, 9);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2047, to_date('20-04-2022', 'dd-mm-yyyy'), to_date('22-02-2021', 'dd-mm-yyyy'), 1018, 18);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2048, to_date('10-01-2022', 'dd-mm-yyyy'), to_date('22-10-2021', 'dd-mm-yyyy'), 1317, 29);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2049, to_date('03-06-2022', 'dd-mm-yyyy'), to_date('25-08-2021', 'dd-mm-yyyy'), 1298, 7);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2050, to_date('22-08-2022', 'dd-mm-yyyy'), to_date('30-04-2021', 'dd-mm-yyyy'), 1157, 5);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2051, to_date('13-05-2022', 'dd-mm-yyyy'), to_date('30-09-2021', 'dd-mm-yyyy'), 1171, 29);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2052, to_date('04-08-2022', 'dd-mm-yyyy'), to_date('03-12-2021', 'dd-mm-yyyy'), 1323, 32);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2053, to_date('27-11-2022', 'dd-mm-yyyy'), to_date('05-04-2021', 'dd-mm-yyyy'), 1314, 19);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2054, to_date('13-03-2022', 'dd-mm-yyyy'), to_date('13-02-2021', 'dd-mm-yyyy'), 1180, 18);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2055, to_date('03-02-2022', 'dd-mm-yyyy'), to_date('18-11-2021', 'dd-mm-yyyy'), 1288, 2);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2056, to_date('21-07-2022', 'dd-mm-yyyy'), to_date('25-11-2021', 'dd-mm-yyyy'), 1321, 15);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2057, to_date('25-05-2022', 'dd-mm-yyyy'), to_date('15-01-2021', 'dd-mm-yyyy'), 1233, 13);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2058, to_date('22-09-2022', 'dd-mm-yyyy'), to_date('15-09-2021', 'dd-mm-yyyy'), 1179, 17);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2059, to_date('19-06-2022', 'dd-mm-yyyy'), to_date('20-07-2021', 'dd-mm-yyyy'), 1198, 3);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2060, to_date('16-07-2022', 'dd-mm-yyyy'), to_date('04-04-2021', 'dd-mm-yyyy'), 1066, 17);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2061, to_date('25-05-2022', 'dd-mm-yyyy'), to_date('04-02-2021', 'dd-mm-yyyy'), 1284, 35);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2062, to_date('14-11-2022', 'dd-mm-yyyy'), to_date('04-03-2021', 'dd-mm-yyyy'), 1031, 2000);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2063, to_date('11-08-2022', 'dd-mm-yyyy'), to_date('05-07-2021', 'dd-mm-yyyy'), 1024, 2);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2064, to_date('26-07-2022', 'dd-mm-yyyy'), to_date('05-06-2021', 'dd-mm-yyyy'), 1349, 32);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2065, to_date('08-04-2022', 'dd-mm-yyyy'), to_date('15-11-2021', 'dd-mm-yyyy'), 1178, 26);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2066, to_date('16-11-2022', 'dd-mm-yyyy'), to_date('09-08-2021', 'dd-mm-yyyy'), 1036, 21);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2067, to_date('31-03-2022', 'dd-mm-yyyy'), to_date('10-06-2021', 'dd-mm-yyyy'), 1158, 26);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2068, to_date('23-06-2022', 'dd-mm-yyyy'), to_date('16-12-2021', 'dd-mm-yyyy'), 1177, 1);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2069, to_date('08-09-2022', 'dd-mm-yyyy'), to_date('06-05-2021', 'dd-mm-yyyy'), 1281, 21);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2070, to_date('12-01-2022', 'dd-mm-yyyy'), to_date('19-04-2021', 'dd-mm-yyyy'), 1097, 6);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2071, to_date('10-02-2022', 'dd-mm-yyyy'), to_date('26-02-2021', 'dd-mm-yyyy'), 1037, 20);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2072, to_date('11-05-2022', 'dd-mm-yyyy'), to_date('07-09-2021', 'dd-mm-yyyy'), 1342, 2);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2073, to_date('26-01-2022', 'dd-mm-yyyy'), to_date('16-03-2021', 'dd-mm-yyyy'), 1392, 9);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2074, to_date('06-02-2022', 'dd-mm-yyyy'), to_date('06-12-2021', 'dd-mm-yyyy'), 1093, 38);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2075, to_date('28-05-2022', 'dd-mm-yyyy'), to_date('09-10-2021', 'dd-mm-yyyy'), 1114, 1);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2076, to_date('03-01-2022', 'dd-mm-yyyy'), to_date('04-12-2021', 'dd-mm-yyyy'), 1201, 34);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2077, to_date('06-01-2022', 'dd-mm-yyyy'), to_date('15-01-2021', 'dd-mm-yyyy'), 1117, 2);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2078, to_date('04-10-2022', 'dd-mm-yyyy'), to_date('05-10-2021', 'dd-mm-yyyy'), 1251, 4);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2079, to_date('26-03-2022', 'dd-mm-yyyy'), to_date('26-11-2021', 'dd-mm-yyyy'), 1239, 4);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2080, to_date('07-05-2022', 'dd-mm-yyyy'), to_date('02-09-2021', 'dd-mm-yyyy'), 1047, 39);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2081, to_date('25-09-2022', 'dd-mm-yyyy'), to_date('17-07-2021', 'dd-mm-yyyy'), 1042, 24);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2082, to_date('15-01-2022', 'dd-mm-yyyy'), to_date('19-10-2021', 'dd-mm-yyyy'), 1324, 6);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2083, to_date('11-01-2022', 'dd-mm-yyyy'), to_date('07-11-2021', 'dd-mm-yyyy'), 1032, 30);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2084, to_date('17-11-2022', 'dd-mm-yyyy'), to_date('05-10-2021', 'dd-mm-yyyy'), 1287, 21);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2085, to_date('01-07-2022', 'dd-mm-yyyy'), to_date('01-09-2021', 'dd-mm-yyyy'), 1112, 13);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2086, to_date('07-10-2022', 'dd-mm-yyyy'), to_date('07-01-2021', 'dd-mm-yyyy'), 1367, 8);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2087, to_date('03-01-2022', 'dd-mm-yyyy'), to_date('15-10-2021', 'dd-mm-yyyy'), 1054, 25);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2088, to_date('08-02-2022', 'dd-mm-yyyy'), to_date('01-02-2021', 'dd-mm-yyyy'), 1216, 28);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2089, to_date('26-01-2022', 'dd-mm-yyyy'), to_date('05-11-2021', 'dd-mm-yyyy'), 1001, 18);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2090, to_date('27-12-2022', 'dd-mm-yyyy'), to_date('10-07-2021', 'dd-mm-yyyy'), 1310, 35);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2091, to_date('05-08-2022', 'dd-mm-yyyy'), to_date('12-12-2021', 'dd-mm-yyyy'), 1187, 2000);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2092, to_date('23-12-2022', 'dd-mm-yyyy'), to_date('06-10-2021', 'dd-mm-yyyy'), 1391, 17);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2093, to_date('24-02-2022', 'dd-mm-yyyy'), to_date('28-02-2021', 'dd-mm-yyyy'), 1291, 20);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2094, to_date('02-06-2022', 'dd-mm-yyyy'), to_date('28-09-2021', 'dd-mm-yyyy'), 1330, 34);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2095, to_date('10-11-2022', 'dd-mm-yyyy'), to_date('20-10-2021', 'dd-mm-yyyy'), 1007, 16);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2096, to_date('02-05-2022', 'dd-mm-yyyy'), to_date('03-05-2021', 'dd-mm-yyyy'), 1209, 6);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2097, to_date('17-10-2022', 'dd-mm-yyyy'), to_date('13-07-2021', 'dd-mm-yyyy'), 1046, 40);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2098, to_date('15-11-2022', 'dd-mm-yyyy'), to_date('15-08-2021', 'dd-mm-yyyy'), 1035, 28);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2099, to_date('19-12-2022', 'dd-mm-yyyy'), to_date('08-04-2021', 'dd-mm-yyyy'), 1360, 1);
commit;
prompt 100 records committed...
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2100, to_date('30-04-2022', 'dd-mm-yyyy'), to_date('11-12-2021', 'dd-mm-yyyy'), 1277, 20);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2101, to_date('15-11-2022', 'dd-mm-yyyy'), to_date('29-11-2021', 'dd-mm-yyyy'), 1387, 4);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2102, to_date('16-09-2022', 'dd-mm-yyyy'), to_date('19-10-2021', 'dd-mm-yyyy'), 1028, 20);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2103, to_date('08-08-2022', 'dd-mm-yyyy'), to_date('18-11-2021', 'dd-mm-yyyy'), 1133, 33);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2104, to_date('17-11-2022', 'dd-mm-yyyy'), to_date('12-07-2021', 'dd-mm-yyyy'), 1392, 34);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2105, to_date('01-07-2022', 'dd-mm-yyyy'), to_date('20-06-2021', 'dd-mm-yyyy'), 1065, 23);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2106, to_date('05-04-2022', 'dd-mm-yyyy'), to_date('24-10-2021', 'dd-mm-yyyy'), 1292, 19);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2107, to_date('29-05-2022', 'dd-mm-yyyy'), to_date('27-12-2021', 'dd-mm-yyyy'), 1236, 31);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2108, to_date('05-02-2022', 'dd-mm-yyyy'), to_date('03-01-2021', 'dd-mm-yyyy'), 1312, 6);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2109, to_date('18-06-2022', 'dd-mm-yyyy'), to_date('07-10-2021', 'dd-mm-yyyy'), 1238, 2000);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2110, to_date('12-04-2022', 'dd-mm-yyyy'), to_date('07-04-2021', 'dd-mm-yyyy'), 1156, 31);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2111, to_date('09-06-2022', 'dd-mm-yyyy'), to_date('04-12-2021', 'dd-mm-yyyy'), 1371, 39);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2112, to_date('24-09-2022', 'dd-mm-yyyy'), to_date('22-06-2021', 'dd-mm-yyyy'), 1136, 29);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2113, to_date('03-09-2022', 'dd-mm-yyyy'), to_date('21-12-2021', 'dd-mm-yyyy'), 1047, 1000);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2114, to_date('13-05-2022', 'dd-mm-yyyy'), to_date('09-01-2021', 'dd-mm-yyyy'), 1279, 1);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2115, to_date('27-07-2022', 'dd-mm-yyyy'), to_date('23-03-2021', 'dd-mm-yyyy'), 1210, 39);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2116, to_date('05-08-2022', 'dd-mm-yyyy'), to_date('15-05-2021', 'dd-mm-yyyy'), 1272, 22);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2117, to_date('08-08-2022', 'dd-mm-yyyy'), to_date('09-01-2021', 'dd-mm-yyyy'), 1188, 17);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2118, to_date('29-05-2022', 'dd-mm-yyyy'), to_date('30-05-2021', 'dd-mm-yyyy'), 1217, 10);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2119, to_date('17-12-2022', 'dd-mm-yyyy'), to_date('12-10-2021', 'dd-mm-yyyy'), 1167, 31);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2120, to_date('05-01-2022', 'dd-mm-yyyy'), to_date('07-09-2021', 'dd-mm-yyyy'), 1219, 15);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2121, to_date('14-09-2022', 'dd-mm-yyyy'), to_date('27-10-2021', 'dd-mm-yyyy'), 1090, 15);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2122, to_date('12-01-2022', 'dd-mm-yyyy'), to_date('19-05-2021', 'dd-mm-yyyy'), 1001, 12);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2123, to_date('26-06-2022', 'dd-mm-yyyy'), to_date('20-01-2021', 'dd-mm-yyyy'), 1179, 10);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2124, to_date('06-04-2022', 'dd-mm-yyyy'), to_date('22-02-2021', 'dd-mm-yyyy'), 1138, 8);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2125, to_date('12-11-2022', 'dd-mm-yyyy'), to_date('06-06-2021', 'dd-mm-yyyy'), 1288, 32);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2126, to_date('07-01-2022', 'dd-mm-yyyy'), to_date('19-09-2021', 'dd-mm-yyyy'), 1116, 30);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2127, to_date('27-02-2022', 'dd-mm-yyyy'), to_date('31-03-2021', 'dd-mm-yyyy'), 1074, 1);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2128, to_date('31-12-2022', 'dd-mm-yyyy'), to_date('20-05-2021', 'dd-mm-yyyy'), 1026, 1);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2129, to_date('07-11-2022', 'dd-mm-yyyy'), to_date('30-03-2021', 'dd-mm-yyyy'), 1399, 4);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2130, to_date('03-10-2022', 'dd-mm-yyyy'), to_date('19-03-2021', 'dd-mm-yyyy'), 1270, 13);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2131, to_date('03-08-2022', 'dd-mm-yyyy'), to_date('03-07-2021', 'dd-mm-yyyy'), 1350, 2);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2132, to_date('12-09-2022', 'dd-mm-yyyy'), to_date('24-02-2021', 'dd-mm-yyyy'), 1097, 18);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2133, to_date('21-09-2022', 'dd-mm-yyyy'), to_date('10-03-2021', 'dd-mm-yyyy'), 1295, 1000);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2134, to_date('02-09-2022', 'dd-mm-yyyy'), to_date('13-11-2021', 'dd-mm-yyyy'), 1170, 39);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2135, to_date('29-05-2022', 'dd-mm-yyyy'), to_date('29-01-2021', 'dd-mm-yyyy'), 1150, 15);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2136, to_date('04-02-2022', 'dd-mm-yyyy'), to_date('26-06-2021', 'dd-mm-yyyy'), 1348, 18);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2137, to_date('14-04-2022', 'dd-mm-yyyy'), to_date('30-11-2021', 'dd-mm-yyyy'), 1083, 40);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2138, to_date('01-09-2022', 'dd-mm-yyyy'), to_date('21-01-2021', 'dd-mm-yyyy'), 1301, 6);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2139, to_date('14-09-2022', 'dd-mm-yyyy'), to_date('21-07-2021', 'dd-mm-yyyy'), 1035, 29);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2140, to_date('16-08-2022', 'dd-mm-yyyy'), to_date('28-11-2021', 'dd-mm-yyyy'), 1143, 2000);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2141, to_date('11-07-2022', 'dd-mm-yyyy'), to_date('17-12-2021', 'dd-mm-yyyy'), 1073, 7);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2142, to_date('26-07-2022', 'dd-mm-yyyy'), to_date('29-09-2021', 'dd-mm-yyyy'), 1297, 34);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2143, to_date('21-06-2022', 'dd-mm-yyyy'), to_date('26-12-2021', 'dd-mm-yyyy'), 1360, 9);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2144, to_date('06-11-2022', 'dd-mm-yyyy'), to_date('12-08-2021', 'dd-mm-yyyy'), 1181, 38);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2145, to_date('19-01-2022', 'dd-mm-yyyy'), to_date('20-12-2021', 'dd-mm-yyyy'), 1358, 2000);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2146, to_date('16-07-2022', 'dd-mm-yyyy'), to_date('25-08-2021', 'dd-mm-yyyy'), 1118, 40);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2147, to_date('14-01-2022', 'dd-mm-yyyy'), to_date('19-02-2021', 'dd-mm-yyyy'), 1050, 10);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2148, to_date('29-11-2022', 'dd-mm-yyyy'), to_date('24-08-2021', 'dd-mm-yyyy'), 1076, 12);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2149, to_date('10-07-2022', 'dd-mm-yyyy'), to_date('07-11-2021', 'dd-mm-yyyy'), 1390, 35);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2150, to_date('19-07-2022', 'dd-mm-yyyy'), to_date('10-06-2021', 'dd-mm-yyyy'), 1025, 12);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2151, to_date('05-07-2022', 'dd-mm-yyyy'), to_date('17-08-2021', 'dd-mm-yyyy'), 1175, 35);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2152, to_date('15-12-2022', 'dd-mm-yyyy'), to_date('05-02-2021', 'dd-mm-yyyy'), 1328, 16);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2153, to_date('03-02-2022', 'dd-mm-yyyy'), to_date('29-12-2021', 'dd-mm-yyyy'), 1148, 27);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2154, to_date('13-10-2022', 'dd-mm-yyyy'), to_date('04-12-2021', 'dd-mm-yyyy'), 1152, 2000);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2155, to_date('13-03-2022', 'dd-mm-yyyy'), to_date('22-02-2021', 'dd-mm-yyyy'), 1321, 25);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2156, to_date('29-07-2022', 'dd-mm-yyyy'), to_date('16-04-2021', 'dd-mm-yyyy'), 1302, 10);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2157, to_date('07-11-2022', 'dd-mm-yyyy'), to_date('05-06-2021', 'dd-mm-yyyy'), 1122, 34);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2158, to_date('06-02-2022', 'dd-mm-yyyy'), to_date('30-03-2021', 'dd-mm-yyyy'), 1086, 17);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2159, to_date('24-01-2022', 'dd-mm-yyyy'), to_date('13-08-2021', 'dd-mm-yyyy'), 1172, 13);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2160, to_date('30-03-2022', 'dd-mm-yyyy'), to_date('19-12-2021', 'dd-mm-yyyy'), 1199, 14);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2161, to_date('31-03-2022', 'dd-mm-yyyy'), to_date('10-01-2021', 'dd-mm-yyyy'), 1082, 27);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2162, to_date('15-06-2022', 'dd-mm-yyyy'), to_date('12-01-2021', 'dd-mm-yyyy'), 1037, 26);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2163, to_date('03-03-2022', 'dd-mm-yyyy'), to_date('31-05-2021', 'dd-mm-yyyy'), 1278, 24);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2164, to_date('05-10-2022', 'dd-mm-yyyy'), to_date('22-06-2021', 'dd-mm-yyyy'), 1234, 16);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2165, to_date('16-07-2022', 'dd-mm-yyyy'), to_date('13-09-2021', 'dd-mm-yyyy'), 1252, 9);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2166, to_date('06-05-2022', 'dd-mm-yyyy'), to_date('24-08-2021', 'dd-mm-yyyy'), 1019, 11);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2167, to_date('31-01-2022', 'dd-mm-yyyy'), to_date('09-07-2021', 'dd-mm-yyyy'), 1035, 23);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2168, to_date('07-09-2022', 'dd-mm-yyyy'), to_date('13-12-2021', 'dd-mm-yyyy'), 1209, 36);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2169, to_date('26-03-2022', 'dd-mm-yyyy'), to_date('25-07-2021', 'dd-mm-yyyy'), 1093, 1);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2170, to_date('31-03-2022', 'dd-mm-yyyy'), to_date('26-04-2021', 'dd-mm-yyyy'), 1217, 8);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2171, to_date('06-05-2022', 'dd-mm-yyyy'), to_date('27-09-2021', 'dd-mm-yyyy'), 1057, 29);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2172, to_date('06-10-2022', 'dd-mm-yyyy'), to_date('11-07-2021', 'dd-mm-yyyy'), 1290, 34);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2173, to_date('04-07-2022', 'dd-mm-yyyy'), to_date('21-02-2021', 'dd-mm-yyyy'), 1268, 24);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2174, to_date('18-01-2022', 'dd-mm-yyyy'), to_date('08-05-2021', 'dd-mm-yyyy'), 1169, 3);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2175, to_date('21-11-2022', 'dd-mm-yyyy'), to_date('10-11-2021', 'dd-mm-yyyy'), 1153, 14);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2176, to_date('22-05-2022', 'dd-mm-yyyy'), to_date('28-06-2021', 'dd-mm-yyyy'), 1180, 24);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2177, to_date('31-08-2022', 'dd-mm-yyyy'), to_date('20-07-2021', 'dd-mm-yyyy'), 1224, 9);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2178, to_date('30-06-2022', 'dd-mm-yyyy'), to_date('28-04-2021', 'dd-mm-yyyy'), 1339, 8);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2179, to_date('29-06-2022', 'dd-mm-yyyy'), to_date('12-11-2021', 'dd-mm-yyyy'), 1101, 17);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2180, to_date('06-01-2022', 'dd-mm-yyyy'), to_date('28-06-2021', 'dd-mm-yyyy'), 1295, 11);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2181, to_date('25-07-2022', 'dd-mm-yyyy'), to_date('04-09-2021', 'dd-mm-yyyy'), 1164, 28);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2182, to_date('13-08-2022', 'dd-mm-yyyy'), to_date('04-04-2021', 'dd-mm-yyyy'), 1089, 3);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2183, to_date('15-03-2022', 'dd-mm-yyyy'), to_date('08-02-2021', 'dd-mm-yyyy'), 1023, 8);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2184, to_date('12-08-2022', 'dd-mm-yyyy'), to_date('20-09-2021', 'dd-mm-yyyy'), 1140, 29);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2185, to_date('18-01-2022', 'dd-mm-yyyy'), to_date('19-05-2021', 'dd-mm-yyyy'), 1222, 38);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2186, to_date('05-03-2022', 'dd-mm-yyyy'), to_date('22-10-2021', 'dd-mm-yyyy'), 1058, 8);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2187, to_date('12-10-2022', 'dd-mm-yyyy'), to_date('29-06-2021', 'dd-mm-yyyy'), 1360, 40);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2188, to_date('02-02-2022', 'dd-mm-yyyy'), to_date('07-02-2021', 'dd-mm-yyyy'), 1281, 40);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2189, to_date('29-05-2022', 'dd-mm-yyyy'), to_date('03-09-2021', 'dd-mm-yyyy'), 1041, 27);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2190, to_date('03-02-2022', 'dd-mm-yyyy'), to_date('19-06-2021', 'dd-mm-yyyy'), 1135, 26);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2191, to_date('18-02-2022', 'dd-mm-yyyy'), to_date('07-09-2021', 'dd-mm-yyyy'), 1247, 24);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2192, to_date('30-09-2022', 'dd-mm-yyyy'), to_date('26-06-2021', 'dd-mm-yyyy'), 1323, 3);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2193, to_date('13-10-2022', 'dd-mm-yyyy'), to_date('29-11-2021', 'dd-mm-yyyy'), 1342, 7);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2194, to_date('25-11-2022', 'dd-mm-yyyy'), to_date('22-09-2021', 'dd-mm-yyyy'), 1235, 34);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2195, to_date('06-10-2022', 'dd-mm-yyyy'), to_date('11-04-2021', 'dd-mm-yyyy'), 1289, 16);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2196, to_date('13-09-2022', 'dd-mm-yyyy'), to_date('23-10-2021', 'dd-mm-yyyy'), 1084, 32);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2197, to_date('18-08-2022', 'dd-mm-yyyy'), to_date('20-12-2021', 'dd-mm-yyyy'), 1105, 40);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2198, to_date('02-03-2022', 'dd-mm-yyyy'), to_date('15-04-2021', 'dd-mm-yyyy'), 1272, 7);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2199, to_date('09-03-2022', 'dd-mm-yyyy'), to_date('23-12-2021', 'dd-mm-yyyy'), 1134, 29);
commit;
prompt 200 records committed...
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2200, to_date('30-04-2022', 'dd-mm-yyyy'), to_date('30-04-2021', 'dd-mm-yyyy'), 1370, 2);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2201, to_date('23-02-2022', 'dd-mm-yyyy'), to_date('11-06-2021', 'dd-mm-yyyy'), 1142, 15);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2202, to_date('06-12-2022', 'dd-mm-yyyy'), to_date('27-03-2021', 'dd-mm-yyyy'), 1137, 33);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2203, to_date('21-05-2022', 'dd-mm-yyyy'), to_date('26-10-2021', 'dd-mm-yyyy'), 1049, 25);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2204, to_date('13-09-2022', 'dd-mm-yyyy'), to_date('05-10-2021', 'dd-mm-yyyy'), 1150, 3);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2205, to_date('18-09-2022', 'dd-mm-yyyy'), to_date('02-11-2021', 'dd-mm-yyyy'), 1271, 15);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2206, to_date('28-02-2022', 'dd-mm-yyyy'), to_date('25-03-2021', 'dd-mm-yyyy'), 1070, 8);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2207, to_date('31-03-2022', 'dd-mm-yyyy'), to_date('26-04-2021', 'dd-mm-yyyy'), 1097, 25);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2208, to_date('10-01-2022', 'dd-mm-yyyy'), to_date('02-07-2021', 'dd-mm-yyyy'), 1129, 26);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2209, to_date('28-04-2022', 'dd-mm-yyyy'), to_date('27-09-2021', 'dd-mm-yyyy'), 1091, 8);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2210, to_date('01-03-2022', 'dd-mm-yyyy'), to_date('12-09-2021', 'dd-mm-yyyy'), 1237, 38);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2211, to_date('26-12-2022', 'dd-mm-yyyy'), to_date('05-09-2021', 'dd-mm-yyyy'), 1109, 13);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2212, to_date('01-02-2022', 'dd-mm-yyyy'), to_date('19-10-2021', 'dd-mm-yyyy'), 1326, 38);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2213, to_date('11-01-2022', 'dd-mm-yyyy'), to_date('07-01-2021', 'dd-mm-yyyy'), 1157, 1);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2214, to_date('17-01-2022', 'dd-mm-yyyy'), to_date('03-01-2021', 'dd-mm-yyyy'), 1305, 11);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2215, to_date('07-08-2022', 'dd-mm-yyyy'), to_date('26-12-2021', 'dd-mm-yyyy'), 1060, 8);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2216, to_date('30-08-2022', 'dd-mm-yyyy'), to_date('13-12-2021', 'dd-mm-yyyy'), 1051, 12);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2217, to_date('17-05-2022', 'dd-mm-yyyy'), to_date('03-01-2021', 'dd-mm-yyyy'), 1359, 30);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2218, to_date('18-02-2022', 'dd-mm-yyyy'), to_date('04-09-2021', 'dd-mm-yyyy'), 1216, 1);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2219, to_date('17-04-2022', 'dd-mm-yyyy'), to_date('16-05-2021', 'dd-mm-yyyy'), 1043, 5);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2220, to_date('28-12-2022', 'dd-mm-yyyy'), to_date('25-06-2021', 'dd-mm-yyyy'), 1271, 35);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2221, to_date('03-11-2022', 'dd-mm-yyyy'), to_date('12-09-2021', 'dd-mm-yyyy'), 1290, 16);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2222, to_date('06-06-2022', 'dd-mm-yyyy'), to_date('16-07-2021', 'dd-mm-yyyy'), 1161, 3);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2223, to_date('02-12-2022', 'dd-mm-yyyy'), to_date('23-03-2021', 'dd-mm-yyyy'), 1247, 7);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2224, to_date('10-03-2022', 'dd-mm-yyyy'), to_date('03-05-2021', 'dd-mm-yyyy'), 1396, 7);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2225, to_date('07-04-2022', 'dd-mm-yyyy'), to_date('30-11-2021', 'dd-mm-yyyy'), 1026, 11);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2226, to_date('09-01-2022', 'dd-mm-yyyy'), to_date('10-12-2021', 'dd-mm-yyyy'), 1159, 4);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2227, to_date('03-06-2022', 'dd-mm-yyyy'), to_date('12-05-2021', 'dd-mm-yyyy'), 1130, 14);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2228, to_date('11-09-2022', 'dd-mm-yyyy'), to_date('24-01-2021', 'dd-mm-yyyy'), 1246, 1);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2229, to_date('19-04-2022', 'dd-mm-yyyy'), to_date('08-07-2021', 'dd-mm-yyyy'), 1101, 9);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2230, to_date('23-07-2022', 'dd-mm-yyyy'), to_date('09-12-2021', 'dd-mm-yyyy'), 1026, 14);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2231, to_date('08-04-2022', 'dd-mm-yyyy'), to_date('24-03-2021', 'dd-mm-yyyy'), 1394, 5);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2232, to_date('14-09-2022', 'dd-mm-yyyy'), to_date('05-01-2021', 'dd-mm-yyyy'), 1030, 2000);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2233, to_date('01-11-2022', 'dd-mm-yyyy'), to_date('30-07-2021', 'dd-mm-yyyy'), 1278, 22);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2234, to_date('25-08-2022', 'dd-mm-yyyy'), to_date('19-06-2021', 'dd-mm-yyyy'), 1158, 7);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2235, to_date('18-11-2022', 'dd-mm-yyyy'), to_date('24-01-2021', 'dd-mm-yyyy'), 1159, 9);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2236, to_date('11-08-2022', 'dd-mm-yyyy'), to_date('05-07-2021', 'dd-mm-yyyy'), 1320, 9);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2237, to_date('13-06-2022', 'dd-mm-yyyy'), to_date('27-07-2021', 'dd-mm-yyyy'), 1328, 25);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2238, to_date('29-04-2022', 'dd-mm-yyyy'), to_date('14-07-2021', 'dd-mm-yyyy'), 1296, 37);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2239, to_date('05-02-2022', 'dd-mm-yyyy'), to_date('17-02-2021', 'dd-mm-yyyy'), 1140, 15);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2240, to_date('11-06-2022', 'dd-mm-yyyy'), to_date('16-01-2021', 'dd-mm-yyyy'), 1024, 1);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2241, to_date('30-10-2022', 'dd-mm-yyyy'), to_date('25-07-2021', 'dd-mm-yyyy'), 1005, 23);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2242, to_date('22-06-2022', 'dd-mm-yyyy'), to_date('02-06-2021', 'dd-mm-yyyy'), 1311, 14);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2243, to_date('29-07-2022', 'dd-mm-yyyy'), to_date('09-11-2021', 'dd-mm-yyyy'), 1221, 33);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2244, to_date('20-04-2022', 'dd-mm-yyyy'), to_date('22-06-2021', 'dd-mm-yyyy'), 1367, 29);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2245, to_date('24-03-2022', 'dd-mm-yyyy'), to_date('28-05-2021', 'dd-mm-yyyy'), 1217, 1000);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2246, to_date('06-04-2022', 'dd-mm-yyyy'), to_date('05-11-2021', 'dd-mm-yyyy'), 1172, 25);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2247, to_date('03-04-2022', 'dd-mm-yyyy'), to_date('16-01-2021', 'dd-mm-yyyy'), 1230, 5);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2248, to_date('14-10-2022', 'dd-mm-yyyy'), to_date('11-03-2021', 'dd-mm-yyyy'), 1058, 3);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2249, to_date('16-11-2022', 'dd-mm-yyyy'), to_date('25-11-2021', 'dd-mm-yyyy'), 1205, 27);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2250, to_date('05-08-2022', 'dd-mm-yyyy'), to_date('07-03-2021', 'dd-mm-yyyy'), 1324, 32);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2251, to_date('15-10-2022', 'dd-mm-yyyy'), to_date('21-01-2021', 'dd-mm-yyyy'), 1316, 38);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2252, to_date('16-06-2022', 'dd-mm-yyyy'), to_date('29-04-2021', 'dd-mm-yyyy'), 1070, 15);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2253, to_date('15-06-2022', 'dd-mm-yyyy'), to_date('07-01-2021', 'dd-mm-yyyy'), 1317, 5);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2254, to_date('14-07-2022', 'dd-mm-yyyy'), to_date('10-08-2021', 'dd-mm-yyyy'), 1061, 19);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2255, to_date('22-12-2022', 'dd-mm-yyyy'), to_date('04-01-2021', 'dd-mm-yyyy'), 1118, 18);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2256, to_date('02-04-2022', 'dd-mm-yyyy'), to_date('02-12-2021', 'dd-mm-yyyy'), 1014, 26);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2257, to_date('01-07-2022', 'dd-mm-yyyy'), to_date('24-01-2021', 'dd-mm-yyyy'), 1382, 21);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2258, to_date('02-10-2022', 'dd-mm-yyyy'), to_date('01-05-2021', 'dd-mm-yyyy'), 1306, 30);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2259, to_date('15-03-2022', 'dd-mm-yyyy'), to_date('12-12-2021', 'dd-mm-yyyy'), 1349, 12);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2260, to_date('03-12-2022', 'dd-mm-yyyy'), to_date('18-02-2021', 'dd-mm-yyyy'), 1115, 28);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2261, to_date('06-11-2022', 'dd-mm-yyyy'), to_date('14-11-2021', 'dd-mm-yyyy'), 1086, 4);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2262, to_date('15-12-2022', 'dd-mm-yyyy'), to_date('30-09-2021', 'dd-mm-yyyy'), 1379, 21);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2263, to_date('19-11-2022', 'dd-mm-yyyy'), to_date('13-01-2021', 'dd-mm-yyyy'), 1362, 6);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2264, to_date('30-06-2022', 'dd-mm-yyyy'), to_date('28-05-2021', 'dd-mm-yyyy'), 1384, 27);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2265, to_date('06-02-2022', 'dd-mm-yyyy'), to_date('26-12-2021', 'dd-mm-yyyy'), 1146, 5);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2266, to_date('01-05-2022', 'dd-mm-yyyy'), to_date('26-08-2021', 'dd-mm-yyyy'), 1376, 23);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2267, to_date('21-11-2022', 'dd-mm-yyyy'), to_date('03-10-2021', 'dd-mm-yyyy'), 1132, 17);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2268, to_date('04-09-2022', 'dd-mm-yyyy'), to_date('01-09-2021', 'dd-mm-yyyy'), 1196, 29);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2269, to_date('07-01-2022', 'dd-mm-yyyy'), to_date('11-11-2021', 'dd-mm-yyyy'), 1287, 15);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2270, to_date('24-12-2022', 'dd-mm-yyyy'), to_date('28-05-2021', 'dd-mm-yyyy'), 1344, 37);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2271, to_date('30-12-2022', 'dd-mm-yyyy'), to_date('29-01-2021', 'dd-mm-yyyy'), 1227, 40);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2272, to_date('27-04-2022', 'dd-mm-yyyy'), to_date('08-07-2021', 'dd-mm-yyyy'), 1264, 31);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2273, to_date('28-12-2022', 'dd-mm-yyyy'), to_date('17-01-2021', 'dd-mm-yyyy'), 1014, 35);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2274, to_date('09-05-2022', 'dd-mm-yyyy'), to_date('18-02-2021', 'dd-mm-yyyy'), 1256, 28);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2275, to_date('24-04-2022', 'dd-mm-yyyy'), to_date('01-09-2021', 'dd-mm-yyyy'), 1183, 28);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2276, to_date('02-11-2022', 'dd-mm-yyyy'), to_date('29-05-2021', 'dd-mm-yyyy'), 1214, 2);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2277, to_date('16-06-2022', 'dd-mm-yyyy'), to_date('10-05-2021', 'dd-mm-yyyy'), 1189, 25);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2278, to_date('12-09-2022', 'dd-mm-yyyy'), to_date('30-11-2021', 'dd-mm-yyyy'), 1385, 33);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2279, to_date('20-09-2022', 'dd-mm-yyyy'), to_date('19-01-2021', 'dd-mm-yyyy'), 1083, 14);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2280, to_date('30-08-2022', 'dd-mm-yyyy'), to_date('01-11-2021', 'dd-mm-yyyy'), 1158, 2);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2281, to_date('11-05-2022', 'dd-mm-yyyy'), to_date('30-01-2021', 'dd-mm-yyyy'), 1208, 13);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2282, to_date('25-06-2022', 'dd-mm-yyyy'), to_date('18-12-2021', 'dd-mm-yyyy'), 1077, 24);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2283, to_date('27-04-2022', 'dd-mm-yyyy'), to_date('27-10-2021', 'dd-mm-yyyy'), 1126, 9);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2284, to_date('01-09-2022', 'dd-mm-yyyy'), to_date('12-07-2021', 'dd-mm-yyyy'), 1274, 39);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2285, to_date('22-07-2022', 'dd-mm-yyyy'), to_date('01-03-2021', 'dd-mm-yyyy'), 1369, 39);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2286, to_date('03-11-2022', 'dd-mm-yyyy'), to_date('27-10-2021', 'dd-mm-yyyy'), 1132, 21);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2287, to_date('09-11-2022', 'dd-mm-yyyy'), to_date('24-10-2021', 'dd-mm-yyyy'), 1208, 29);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2288, to_date('10-08-2022', 'dd-mm-yyyy'), to_date('20-08-2021', 'dd-mm-yyyy'), 1375, 15);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2289, to_date('14-04-2022', 'dd-mm-yyyy'), to_date('20-05-2021', 'dd-mm-yyyy'), 1256, 21);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2290, to_date('06-01-2022', 'dd-mm-yyyy'), to_date('15-07-2021', 'dd-mm-yyyy'), 1374, 35);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2291, to_date('27-02-2022', 'dd-mm-yyyy'), to_date('21-04-2021', 'dd-mm-yyyy'), 1292, 2);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2292, to_date('26-07-2022', 'dd-mm-yyyy'), to_date('29-11-2021', 'dd-mm-yyyy'), 1289, 6);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2293, to_date('03-08-2022', 'dd-mm-yyyy'), to_date('20-07-2021', 'dd-mm-yyyy'), 1308, 31);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2294, to_date('14-10-2022', 'dd-mm-yyyy'), to_date('12-11-2021', 'dd-mm-yyyy'), 1026, 16);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2295, to_date('03-08-2022', 'dd-mm-yyyy'), to_date('08-03-2021', 'dd-mm-yyyy'), 1386, 5);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2296, to_date('18-05-2022', 'dd-mm-yyyy'), to_date('26-11-2021', 'dd-mm-yyyy'), 1230, 40);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2297, to_date('30-09-2022', 'dd-mm-yyyy'), to_date('10-09-2021', 'dd-mm-yyyy'), 1195, 31);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2298, to_date('27-11-2022', 'dd-mm-yyyy'), to_date('12-06-2021', 'dd-mm-yyyy'), 1089, 4);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2299, to_date('18-06-2022', 'dd-mm-yyyy'), to_date('28-02-2021', 'dd-mm-yyyy'), 1116, 2000);
commit;
prompt 300 records committed...
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2300, to_date('28-01-2022', 'dd-mm-yyyy'), to_date('21-02-2021', 'dd-mm-yyyy'), 1377, 2000);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2301, to_date('23-09-2022', 'dd-mm-yyyy'), to_date('28-03-2021', 'dd-mm-yyyy'), 1394, 31);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2302, to_date('19-07-2022', 'dd-mm-yyyy'), to_date('30-12-2021', 'dd-mm-yyyy'), 1112, 37);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2303, to_date('01-07-2022', 'dd-mm-yyyy'), to_date('06-12-2021', 'dd-mm-yyyy'), 1306, 29);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2304, to_date('01-05-2022', 'dd-mm-yyyy'), to_date('28-04-2021', 'dd-mm-yyyy'), 1045, 30);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2305, to_date('10-08-2022', 'dd-mm-yyyy'), to_date('16-03-2021', 'dd-mm-yyyy'), 1164, 28);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2306, to_date('25-09-2022', 'dd-mm-yyyy'), to_date('29-06-2021', 'dd-mm-yyyy'), 1171, 5);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2307, to_date('02-04-2022', 'dd-mm-yyyy'), to_date('21-05-2021', 'dd-mm-yyyy'), 1143, 32);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2308, to_date('18-11-2022', 'dd-mm-yyyy'), to_date('03-07-2021', 'dd-mm-yyyy'), 1064, 20);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2309, to_date('11-01-2022', 'dd-mm-yyyy'), to_date('25-05-2021', 'dd-mm-yyyy'), 1322, 2000);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2310, to_date('12-10-2022', 'dd-mm-yyyy'), to_date('14-05-2021', 'dd-mm-yyyy'), 1041, 22);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2311, to_date('22-07-2022', 'dd-mm-yyyy'), to_date('13-10-2021', 'dd-mm-yyyy'), 1364, 8);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2312, to_date('21-12-2022', 'dd-mm-yyyy'), to_date('14-04-2021', 'dd-mm-yyyy'), 1349, 7);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2313, to_date('15-08-2022', 'dd-mm-yyyy'), to_date('28-07-2021', 'dd-mm-yyyy'), 1013, 11);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2314, to_date('22-09-2022', 'dd-mm-yyyy'), to_date('05-09-2021', 'dd-mm-yyyy'), 1374, 29);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2315, to_date('11-12-2022', 'dd-mm-yyyy'), to_date('07-12-2021', 'dd-mm-yyyy'), 1021, 34);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2316, to_date('20-10-2022', 'dd-mm-yyyy'), to_date('29-12-2021', 'dd-mm-yyyy'), 1280, 3);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2317, to_date('12-06-2022', 'dd-mm-yyyy'), to_date('26-08-2021', 'dd-mm-yyyy'), 1293, 38);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2318, to_date('11-10-2022', 'dd-mm-yyyy'), to_date('29-04-2021', 'dd-mm-yyyy'), 1271, 37);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2319, to_date('12-02-2022', 'dd-mm-yyyy'), to_date('29-05-2021', 'dd-mm-yyyy'), 1063, 11);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2320, to_date('11-12-2022', 'dd-mm-yyyy'), to_date('17-11-2021', 'dd-mm-yyyy'), 1275, 15);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2321, to_date('08-06-2022', 'dd-mm-yyyy'), to_date('22-11-2021', 'dd-mm-yyyy'), 1095, 34);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2322, to_date('30-09-2022', 'dd-mm-yyyy'), to_date('18-03-2021', 'dd-mm-yyyy'), 1059, 29);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2323, to_date('07-05-2022', 'dd-mm-yyyy'), to_date('14-09-2021', 'dd-mm-yyyy'), 1106, 19);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2324, to_date('20-10-2022', 'dd-mm-yyyy'), to_date('20-04-2021', 'dd-mm-yyyy'), 1164, 37);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2325, to_date('26-10-2022', 'dd-mm-yyyy'), to_date('30-01-2021', 'dd-mm-yyyy'), 1213, 7);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2326, to_date('25-06-2022', 'dd-mm-yyyy'), to_date('08-06-2021', 'dd-mm-yyyy'), 1066, 28);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2327, to_date('09-12-2022', 'dd-mm-yyyy'), to_date('10-06-2021', 'dd-mm-yyyy'), 1011, 17);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2328, to_date('12-01-2022', 'dd-mm-yyyy'), to_date('26-11-2021', 'dd-mm-yyyy'), 1364, 37);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2329, to_date('31-07-2022', 'dd-mm-yyyy'), to_date('21-09-2021', 'dd-mm-yyyy'), 1070, 40);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2330, to_date('21-04-2022', 'dd-mm-yyyy'), to_date('30-06-2021', 'dd-mm-yyyy'), 1193, 3);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2331, to_date('27-08-2022', 'dd-mm-yyyy'), to_date('21-07-2021', 'dd-mm-yyyy'), 1258, 35);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2332, to_date('28-12-2022', 'dd-mm-yyyy'), to_date('28-10-2021', 'dd-mm-yyyy'), 1258, 24);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2333, to_date('17-11-2022', 'dd-mm-yyyy'), to_date('21-03-2021', 'dd-mm-yyyy'), 1096, 34);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2334, to_date('18-06-2022', 'dd-mm-yyyy'), to_date('15-06-2021', 'dd-mm-yyyy'), 1296, 25);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2335, to_date('27-02-2022', 'dd-mm-yyyy'), to_date('18-06-2021', 'dd-mm-yyyy'), 1323, 39);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2336, to_date('28-02-2022', 'dd-mm-yyyy'), to_date('09-11-2021', 'dd-mm-yyyy'), 1164, 40);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2337, to_date('28-06-2022', 'dd-mm-yyyy'), to_date('26-01-2021', 'dd-mm-yyyy'), 1103, 26);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2338, to_date('19-07-2022', 'dd-mm-yyyy'), to_date('22-02-2021', 'dd-mm-yyyy'), 1151, 39);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2339, to_date('14-06-2022', 'dd-mm-yyyy'), to_date('15-04-2021', 'dd-mm-yyyy'), 1247, 40);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2340, to_date('10-08-2022', 'dd-mm-yyyy'), to_date('29-08-2021', 'dd-mm-yyyy'), 1113, 17);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2341, to_date('31-03-2022', 'dd-mm-yyyy'), to_date('18-01-2021', 'dd-mm-yyyy'), 1061, 10);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2342, to_date('10-12-2022', 'dd-mm-yyyy'), to_date('06-05-2021', 'dd-mm-yyyy'), 1237, 22);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2343, to_date('23-04-2022', 'dd-mm-yyyy'), to_date('04-01-2021', 'dd-mm-yyyy'), 1220, 1000);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2344, to_date('24-05-2022', 'dd-mm-yyyy'), to_date('08-12-2021', 'dd-mm-yyyy'), 1226, 17);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2345, to_date('23-06-2022', 'dd-mm-yyyy'), to_date('25-05-2021', 'dd-mm-yyyy'), 1069, 5);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2346, to_date('05-04-2022', 'dd-mm-yyyy'), to_date('22-12-2021', 'dd-mm-yyyy'), 1110, 13);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2347, to_date('19-09-2022', 'dd-mm-yyyy'), to_date('03-09-2021', 'dd-mm-yyyy'), 1147, 24);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2348, to_date('15-01-2022', 'dd-mm-yyyy'), to_date('13-08-2021', 'dd-mm-yyyy'), 1285, 8);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2349, to_date('08-06-2022', 'dd-mm-yyyy'), to_date('03-01-2021', 'dd-mm-yyyy'), 1334, 5);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2350, to_date('11-10-2022', 'dd-mm-yyyy'), to_date('10-04-2021', 'dd-mm-yyyy'), 1374, 15);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2351, to_date('25-04-2022', 'dd-mm-yyyy'), to_date('27-07-2021', 'dd-mm-yyyy'), 1029, 21);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2352, to_date('09-12-2022', 'dd-mm-yyyy'), to_date('19-01-2021', 'dd-mm-yyyy'), 1111, 23);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2353, to_date('30-09-2022', 'dd-mm-yyyy'), to_date('14-08-2021', 'dd-mm-yyyy'), 1346, 2);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2354, to_date('15-11-2022', 'dd-mm-yyyy'), to_date('01-01-2021', 'dd-mm-yyyy'), 1258, 20);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2355, to_date('27-10-2022', 'dd-mm-yyyy'), to_date('04-06-2021', 'dd-mm-yyyy'), 1337, 15);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2356, to_date('24-10-2022', 'dd-mm-yyyy'), to_date('13-03-2021', 'dd-mm-yyyy'), 1337, 15);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2357, to_date('05-11-2022', 'dd-mm-yyyy'), to_date('27-12-2021', 'dd-mm-yyyy'), 1048, 20);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2358, to_date('19-06-2022', 'dd-mm-yyyy'), to_date('11-08-2021', 'dd-mm-yyyy'), 1393, 3);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2359, to_date('27-06-2022', 'dd-mm-yyyy'), to_date('01-08-2021', 'dd-mm-yyyy'), 1385, 13);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2360, to_date('21-02-2022', 'dd-mm-yyyy'), to_date('22-10-2021', 'dd-mm-yyyy'), 1384, 16);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2361, to_date('28-05-2022', 'dd-mm-yyyy'), to_date('05-02-2021', 'dd-mm-yyyy'), 1218, 15);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2362, to_date('15-06-2022', 'dd-mm-yyyy'), to_date('13-06-2021', 'dd-mm-yyyy'), 1386, 28);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2363, to_date('09-07-2022', 'dd-mm-yyyy'), to_date('17-03-2021', 'dd-mm-yyyy'), 1305, 31);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2364, to_date('06-08-2022', 'dd-mm-yyyy'), to_date('12-08-2021', 'dd-mm-yyyy'), 1036, 37);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2365, to_date('11-10-2022', 'dd-mm-yyyy'), to_date('02-05-2021', 'dd-mm-yyyy'), 1039, 29);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2366, to_date('24-02-2022', 'dd-mm-yyyy'), to_date('05-12-2021', 'dd-mm-yyyy'), 1392, 31);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2367, to_date('12-07-2022', 'dd-mm-yyyy'), to_date('12-06-2021', 'dd-mm-yyyy'), 1226, 2000);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2368, to_date('28-06-2022', 'dd-mm-yyyy'), to_date('07-07-2021', 'dd-mm-yyyy'), 1217, 16);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2369, to_date('09-06-2022', 'dd-mm-yyyy'), to_date('30-08-2021', 'dd-mm-yyyy'), 1278, 12);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2370, to_date('19-09-2022', 'dd-mm-yyyy'), to_date('26-09-2021', 'dd-mm-yyyy'), 1293, 11);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2371, to_date('18-12-2022', 'dd-mm-yyyy'), to_date('23-08-2021', 'dd-mm-yyyy'), 1243, 1);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2372, to_date('13-03-2022', 'dd-mm-yyyy'), to_date('10-10-2021', 'dd-mm-yyyy'), 1159, 13);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2373, to_date('30-05-2022', 'dd-mm-yyyy'), to_date('02-11-2021', 'dd-mm-yyyy'), 1054, 17);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2374, to_date('11-08-2022', 'dd-mm-yyyy'), to_date('01-01-2021', 'dd-mm-yyyy'), 1071, 21);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2375, to_date('16-07-2022', 'dd-mm-yyyy'), to_date('05-07-2021', 'dd-mm-yyyy'), 1398, 3);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2376, to_date('10-08-2022', 'dd-mm-yyyy'), to_date('11-03-2021', 'dd-mm-yyyy'), 1187, 29);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2377, to_date('21-09-2022', 'dd-mm-yyyy'), to_date('31-07-2021', 'dd-mm-yyyy'), 1022, 19);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2378, to_date('04-01-2022', 'dd-mm-yyyy'), to_date('01-07-2021', 'dd-mm-yyyy'), 1183, 28);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2379, to_date('09-09-2022', 'dd-mm-yyyy'), to_date('24-04-2021', 'dd-mm-yyyy'), 1251, 14);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2380, to_date('24-07-2022', 'dd-mm-yyyy'), to_date('19-04-2021', 'dd-mm-yyyy'), 1086, 34);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2381, to_date('27-10-2022', 'dd-mm-yyyy'), to_date('04-10-2021', 'dd-mm-yyyy'), 1342, 28);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2382, to_date('07-04-2022', 'dd-mm-yyyy'), to_date('24-10-2021', 'dd-mm-yyyy'), 1338, 25);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2383, to_date('31-12-2022', 'dd-mm-yyyy'), to_date('25-01-2021', 'dd-mm-yyyy'), 1055, 31);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2384, to_date('09-04-2022', 'dd-mm-yyyy'), to_date('20-07-2021', 'dd-mm-yyyy'), 1280, 40);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2385, to_date('12-01-2022', 'dd-mm-yyyy'), to_date('31-07-2021', 'dd-mm-yyyy'), 1255, 33);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2386, to_date('28-04-2022', 'dd-mm-yyyy'), to_date('23-07-2021', 'dd-mm-yyyy'), 1268, 18);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2387, to_date('20-08-2022', 'dd-mm-yyyy'), to_date('25-09-2021', 'dd-mm-yyyy'), 1334, 25);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2388, to_date('11-10-2022', 'dd-mm-yyyy'), to_date('03-07-2021', 'dd-mm-yyyy'), 1205, 2);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2389, to_date('23-12-2022', 'dd-mm-yyyy'), to_date('16-10-2021', 'dd-mm-yyyy'), 1060, 33);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2390, to_date('05-03-2022', 'dd-mm-yyyy'), to_date('16-07-2021', 'dd-mm-yyyy'), 1107, 13);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2391, to_date('15-10-2022', 'dd-mm-yyyy'), to_date('20-05-2021', 'dd-mm-yyyy'), 1254, 7);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2392, to_date('19-05-2022', 'dd-mm-yyyy'), to_date('04-01-2021', 'dd-mm-yyyy'), 1286, 18);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2393, to_date('10-01-2022', 'dd-mm-yyyy'), to_date('05-11-2021', 'dd-mm-yyyy'), 1287, 22);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2394, to_date('15-04-2022', 'dd-mm-yyyy'), to_date('14-12-2021', 'dd-mm-yyyy'), 1364, 4);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2395, to_date('11-02-2022', 'dd-mm-yyyy'), to_date('25-05-2021', 'dd-mm-yyyy'), 1003, 24);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2396, to_date('28-01-2022', 'dd-mm-yyyy'), to_date('30-05-2021', 'dd-mm-yyyy'), 1309, 16);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2397, to_date('24-09-2022', 'dd-mm-yyyy'), to_date('05-02-2021', 'dd-mm-yyyy'), 1072, 18);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2398, to_date('16-01-2022', 'dd-mm-yyyy'), to_date('27-07-2021', 'dd-mm-yyyy'), 1298, 1);
insert into EVENTS_ (eventid, eventdate, eventconfirmationdate, customerid, venueid)
values (2399, to_date('03-03-2022', 'dd-mm-yyyy'), to_date('28-08-2021', 'dd-mm-yyyy'), 1361, 11);
commit;
prompt 400 records loaded
prompt Loading GUSTS...
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3012, 'Acquaintances', 'Fisher', 'Mann', to_date('17-02-2021', 'dd-mm-yyyy'), to_date('01-12-2021', 'dd-mm-yyyy'), 'Confirmed', 2314, 1056);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3020, 'Friends', 'Scarlett', 'Mirren', to_date('04-04-2021', 'dd-mm-yyyy'), to_date('24-03-2021', 'dd-mm-yyyy'), 'Confirmed', 2303, 1348);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3024, 'Close Friends', 'Billy', 'Bragg', to_date('26-11-2021', 'dd-mm-yyyy'), to_date('19-10-2021', 'dd-mm-yyyy'), 'Confirmed', 2169, 1217);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3031, 'Work Colleagues', 'Paula', 'Leguizamo', to_date('20-07-2021', 'dd-mm-yyyy'), to_date('29-07-2021', 'dd-mm-yyyy'), 'Confirmed', 2019, 1065);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3037, 'Close Friends', 'Scott', 'Venora', to_date('08-07-2021', 'dd-mm-yyyy'), to_date('20-03-2021', 'dd-mm-yyyy'), 'Confirmed', 2204, 1341);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3041, 'Extended Family', 'Claude', 'MacDowell', to_date('20-12-2021', 'dd-mm-yyyy'), to_date('25-09-2021', 'dd-mm-yyyy'), 'Confirmed', 2146, 1073);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3043, 'Neighbors', 'Colin', 'Romijn-Stamos', to_date('29-12-2021', 'dd-mm-yyyy'), to_date('01-10-2021', 'dd-mm-yyyy'), 'Confirmed', 2055, 1059);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3047, 'Close Friends', 'Thora', 'White', to_date('12-09-2021', 'dd-mm-yyyy'), to_date('26-08-2021', 'dd-mm-yyyy'), 'Confirmed', 2154, 1100);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3051, 'Immediate Family', 'Miguel', 'Kristofferson', to_date('05-09-2021', 'dd-mm-yyyy'), to_date('16-01-2021', 'dd-mm-yyyy'), 'Confirmed', 2083, 1219);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3079, 'Immediate Family', 'Diane', 'Ceasar', to_date('29-12-2021', 'dd-mm-yyyy'), to_date('06-07-2021', 'dd-mm-yyyy'), 'Confirmed', 2120, 1125);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3086, 'Neighbors', 'Linda', 'Shatner', to_date('12-09-2021', 'dd-mm-yyyy'), to_date('29-07-2021', 'dd-mm-yyyy'), 'Confirmed', 2007, 1283);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3099, 'Neighbors', 'Mykelti', 'Squier', to_date('22-06-2021', 'dd-mm-yyyy'), to_date('10-10-2021', 'dd-mm-yyyy'), 'Confirmed', 2070, 1348);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8930, 'Friend', 'Randy', 'Holiday', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8931, 'Friend', 'Randall', 'Vaughan', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8932, 'Friend', 'Molly', 'McDowell', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8933, 'Friend', 'Ronnie', 'Vincent', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8934, 'Friend', 'Casey', 'Mueller-Stahl', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8935, 'Friend', 'Neneh', 'De Almeida', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8936, 'Friend', 'King', 'Franklin', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8937, 'Friend', 'Ivan', 'Baranski', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8938, 'Friend', 'Thelma', 'Campbell', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8939, 'Friend', 'Rade', 'Williamson', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8940, 'Friend', 'Chanté', 'Morrison', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8941, 'Friend', 'Scott', 'Harrelson', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3113, 'Neighbors', 'Salma', 'Harmon', to_date('22-09-2021', 'dd-mm-yyyy'), to_date('14-11-2021', 'dd-mm-yyyy'), 'Confirmed', 2152, 1382);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8942, 'Friend', 'Clint', 'Leguizamo', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8943, 'Friend', 'Stellan', 'Howard', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8944, 'Friend', 'Sheryl', 'Bridges', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3117, 'Work Colleagues', 'Temuera', 'Moreno', to_date('21-04-2021', 'dd-mm-yyyy'), to_date('11-02-2021', 'dd-mm-yyyy'), 'Confirmed', 2161, 1246);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8945, 'Friend', 'Dorry', 'Nelligan', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8946, 'Friend', 'Tyrone', 'Irons', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8947, 'Friend', 'Alfie', 'Boone', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8948, 'Friend', 'Harry', 'Bale', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3122, 'Friends', 'Roy', 'Broadbent', to_date('27-10-2021', 'dd-mm-yyyy'), to_date('11-12-2021', 'dd-mm-yyyy'), 'Confirmed', 2201, 1359);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8949, 'Friend', 'Mae', 'Zellweger', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8950, 'Friend', 'Ving', 'Armstrong', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8951, 'Friend', 'Sonny', 'Carter', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3126, 'External Invitees', 'Brooke', 'Doucette', to_date('15-06-2021', 'dd-mm-yyyy'), to_date('24-06-2021', 'dd-mm-yyyy'), 'Confirmed', 2284, 1344);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8952, 'Friend', 'Hector', 'Whitmore', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8953, 'Friend', 'Juliet', 'Lofgren', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8954, 'Friend', 'Gordon', 'Dunaway', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8955, 'Friend', 'Lucinda', 'Tyson', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8956, 'Friend', 'Gates', 'Affleck', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3132, 'Immediate Family', 'Karon', 'Starr', to_date('07-11-2021', 'dd-mm-yyyy'), to_date('05-08-2021', 'dd-mm-yyyy'), 'Confirmed', 2284, 1218);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3133, 'Work Colleagues', 'Miko', 'Tyler', to_date('19-02-2021', 'dd-mm-yyyy'), to_date('04-11-2021', 'dd-mm-yyyy'), 'Confirmed', 2055, 1169);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3134, 'Immediate Family', 'Phoebe', 'Lane', to_date('27-10-2021', 'dd-mm-yyyy'), to_date('27-06-2021', 'dd-mm-yyyy'), 'Confirmed', 2136, 1394);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8957, 'Friend', 'Rascal', 'Parish', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8958, 'Friend', 'Faye', 'Laurie', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8959, 'Friend', 'Illeana', 'Gibson', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8960, 'Friend', 'Azucar', 'Fraser', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8961, 'Friend', 'Donal', 'Palin', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8962, 'Friend', 'Owen', 'Stevenson', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8963, 'Friend', 'Hank', 'Fox', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8964, 'Friend', 'Larenz', 'McDormand', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8965, 'Friend', 'Hex', 'Wilder', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8966, 'Friend', 'Andrea', 'Parsons', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8967, 'Friend', 'Alfred', 'Craig', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8968, 'Friend', 'Julie', 'Hiatt', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3147, 'Neighbors', 'Lizzy', 'Balaban', to_date('29-12-2021', 'dd-mm-yyyy'), to_date('16-05-2021', 'dd-mm-yyyy'), 'Confirmed', 2074, 1164);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8969, 'Friend', 'Vincent', 'Paxton', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8970, 'Friend', 'Oliver', 'Vanian', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8971, 'Friend', 'Benicio', 'David', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8972, 'Friend', 'Carrie-Anne', 'Reid', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3152, 'Friends', 'Bret', 'Rankin', to_date('28-05-2021', 'dd-mm-yyyy'), to_date('14-08-2021', 'dd-mm-yyyy'), 'Confirmed', 2245, 1183);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8973, 'Friend', 'Roberta', 'Basinger', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8974, 'Friend', 'Carole', 'Palmieri', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3155, 'Extended Family', 'Jeremy', 'Chaykin', to_date('24-10-2021', 'dd-mm-yyyy'), to_date('20-08-2021', 'dd-mm-yyyy'), 'Confirmed', 2127, 1209);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8975, 'Friend', 'Brian', 'Weaving', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8976, 'Friend', 'Rosario', 'Haslam', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8977, 'Friend', 'Jared', 'Secada', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8978, 'Friend', 'Bernard', 'Lerner', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8979, 'Friend', 'Devon', 'Prinze', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8980, 'Friend', 'Ricardo', 'Gayle', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8981, 'Friend', 'Ozzy', 'Pryce', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8982, 'Friend', 'Lynette', 'Zane', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8983, 'Friend', 'Sean', 'Bates', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8984, 'Friend', 'Rhys', 'Fichtner', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8985, 'Friend', 'Oliver', 'Waits', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8986, 'Friend', 'Machine', 'Blair', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3168, 'Neighbors', 'Brothers', 'Blige', to_date('16-12-2021', 'dd-mm-yyyy'), to_date('14-01-2021', 'dd-mm-yyyy'), 'Confirmed', 2149, 1099);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8987, 'Friend', 'Domingo', 'Blossoms', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8988, 'Friend', 'Rickie', 'Brandt', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8989, 'Friend', 'Christmas', 'Khan', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3172, 'Work Colleagues', 'Candice', 'O''Donnell', to_date('28-09-2021', 'dd-mm-yyyy'), to_date('13-04-2021', 'dd-mm-yyyy'), 'Confirmed', 2087, 1089);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8990, 'Friend', 'Leon', 'Lovitz', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3174, 'Acquaintances', 'Kiefer', 'LuPone', to_date('05-02-2021', 'dd-mm-yyyy'), to_date('08-11-2021', 'dd-mm-yyyy'), 'Confirmed', 2340, 1255);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8991, 'Friend', 'Garland', 'Aykroyd', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8992, 'Friend', 'Nicky', 'Boorem', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8993, 'Friend', 'Ernie', 'Mewes', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8994, 'Friend', 'Curt', 'Johansen', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8995, 'Friend', 'Fairuza', 'Newton', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8996, 'Friend', 'Zooey', 'Myles', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3181, 'Extended Family', 'Freddy', 'Speaks', to_date('07-11-2021', 'dd-mm-yyyy'), to_date('05-09-2021', 'dd-mm-yyyy'), 'Confirmed', 2255, 1269);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8997, 'Friend', 'Joey', 'Harnes', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8998, 'Friend', 'Connie', 'McGill', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8999, 'Friend', 'Guy', 'McKennitt', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (9000, 'Friend', 'Joanna', 'Magnuson', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3189, 'External Invitees', 'Gerald', 'Beals', to_date('01-07-2021', 'dd-mm-yyyy'), to_date('18-05-2021', 'dd-mm-yyyy'), 'Confirmed', 2118, 1227);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3191, 'External Invitees', 'Ike', 'McDonnell', to_date('14-09-2021', 'dd-mm-yyyy'), to_date('03-06-2021', 'dd-mm-yyyy'), 'Confirmed', 2320, 1029);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3192, 'External Invitees', 'Rawlins', 'McGinley', to_date('27-10-2021', 'dd-mm-yyyy'), to_date('15-07-2021', 'dd-mm-yyyy'), 'Confirmed', 2042, 1061);
commit;
prompt 100 records committed...
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3196, 'Close Friends', 'Pamela', 'MacNeil', to_date('25-07-2021', 'dd-mm-yyyy'), to_date('31-03-2021', 'dd-mm-yyyy'), 'Confirmed', 2149, 1104);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3200, 'Neighbors', 'Patrick', 'Schwarzenegger', to_date('26-04-2021', 'dd-mm-yyyy'), to_date('31-08-2021', 'dd-mm-yyyy'), 'Confirmed', 2058, 1116);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8836, 'Friend', 'Anjelica', 'Smurfit', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8837, 'Friend', 'Frank', 'Rossellini', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8838, 'Friend', 'Scarlett', 'Bloch', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8839, 'Friend', 'Katie', 'Close', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8840, 'Friend', 'Will', 'Giamatti', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8841, 'Friend', 'Azucar', 'Penders', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8842, 'Friend', 'Ethan', 'Assante', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8843, 'Friend', 'Mykelti', 'Hewitt', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3209, 'Immediate Family', 'Sydney', 'Pony', to_date('03-01-2021', 'dd-mm-yyyy'), to_date('07-05-2021', 'dd-mm-yyyy'), 'Confirmed', 2075, 1322);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8844, 'Friend', 'Saffron', 'Whitaker', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8845, 'Friend', 'Gailard', 'Willard', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8846, 'Friend', 'Geoff', 'Ingram', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3213, 'External Invitees', 'Ricardo', 'Sedgwick', to_date('29-06-2021', 'dd-mm-yyyy'), to_date('14-01-2021', 'dd-mm-yyyy'), 'Confirmed', 2040, 1105);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8847, 'Friend', 'Aidan', 'Perrineau', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8848, 'Friend', 'Roddy', 'Plimpton', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3216, 'Neighbors', 'Andrew', 'Martin', to_date('03-07-2021', 'dd-mm-yyyy'), to_date('10-11-2021', 'dd-mm-yyyy'), 'Confirmed', 2308, 1235);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8849, 'Friend', 'Treat', 'Bruce', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8850, 'Friend', 'Miles', 'Carnes', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8851, 'Friend', 'Tyrone', 'Blackwell', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8852, 'Friend', 'Vincent', 'Schwimmer', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8853, 'Friend', 'Collective', 'Lunch', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8854, 'Friend', 'Chanté', 'Steagall', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8855, 'Friend', 'Debi', 'Robards', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8856, 'Friend', 'Taryn', 'Costner', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3225, 'Acquaintances', 'Wayman', 'Piven', to_date('01-03-2021', 'dd-mm-yyyy'), to_date('09-01-2021', 'dd-mm-yyyy'), 'Confirmed', 2116, 1031);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8857, 'Friend', 'Holland', 'Cleese', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8858, 'Friend', 'Kurt', 'Serbedzija', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8859, 'Friend', 'Jon', 'Oates', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3229, 'Work Colleagues', 'Sylvester', 'Sweeney', to_date('25-08-2021', 'dd-mm-yyyy'), to_date('01-08-2021', 'dd-mm-yyyy'), 'Confirmed', 2094, 1163);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8860, 'Friend', 'Jim', 'Stigers', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8861, 'Friend', 'Minnie', 'Payne', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8862, 'Friend', 'Cesar', 'Zevon', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8863, 'Friend', 'Tracy', 'Parm', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3234, 'Close Friends', 'Benjamin', 'Hoffman', to_date('20-04-2021', 'dd-mm-yyyy'), to_date('01-02-2021', 'dd-mm-yyyy'), 'Confirmed', 2382, 1125);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8864, 'Friend', 'Geoff', 'Joli', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8865, 'Friend', 'Lou', 'Chao', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8866, 'Friend', 'Larnelle', 'Paymer', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8867, 'Friend', 'Crispin', 'Feliciano', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8868, 'Friend', 'Stevie', 'Lindo', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8869, 'Friend', 'Shawn', 'Easton', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8870, 'Friend', 'Dorry', 'Sutherland', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8871, 'Friend', 'Raymond', 'Taha', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8872, 'Friend', 'Pamela', 'Braugher', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8873, 'Friend', 'Anne', 'Wills', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8874, 'Friend', 'Jake', 'Price', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3246, 'Neighbors', 'Victoria', 'Burke', to_date('18-12-2021', 'dd-mm-yyyy'), to_date('08-08-2021', 'dd-mm-yyyy'), 'Confirmed', 2396, 1174);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8875, 'Friend', 'Taryn', 'Donelly', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8876, 'Friend', 'Joe', 'Bale', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8877, 'Friend', 'Curt', 'Rollins', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8878, 'Friend', 'Juliette', 'Walken', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8879, 'Friend', 'Claire', 'Wills', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3252, 'External Invitees', 'Jared', 'Levert', to_date('29-01-2021', 'dd-mm-yyyy'), to_date('16-05-2021', 'dd-mm-yyyy'), 'Confirmed', 2387, 1036);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8880, 'Friend', 'Garry', 'Malone', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3254, 'Close Friends', 'Jim', 'Roundtree', to_date('07-01-2021', 'dd-mm-yyyy'), to_date('09-11-2021', 'dd-mm-yyyy'), 'Confirmed', 2362, 1082);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8881, 'Friend', 'Lynn', 'Daniels', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8882, 'Friend', 'Vanessa', 'Finney', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8883, 'Friend', 'Darius', 'Vannelli', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8884, 'Friend', 'Thora', 'McCann', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8885, 'Friend', 'Jamie', 'Gary', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8886, 'Friend', 'Vanessa', 'Allison', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3261, 'Friends', 'Emm', 'Gore', to_date('17-03-2021', 'dd-mm-yyyy'), to_date('13-02-2021', 'dd-mm-yyyy'), 'Confirmed', 2032, 1104);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8887, 'Friend', 'Howard', 'Owen', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8888, 'Friend', 'Talvin', 'Darren', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8889, 'Friend', 'Jackson', 'Biggs', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8890, 'Friend', 'Andrew', 'Coward', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8891, 'Friend', 'Lance', 'Tarantino', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8892, 'Friend', 'Marie', 'Crouch', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8893, 'Friend', 'Malcolm', 'Posener', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8894, 'Friend', 'Rik', 'Farina', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3270, 'External Invitees', 'Penelope', 'Weiland', to_date('24-10-2021', 'dd-mm-yyyy'), to_date('18-07-2021', 'dd-mm-yyyy'), 'Confirmed', 2293, 1307);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8895, 'Friend', 'Lea', 'Sorvino', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8896, 'Friend', 'Sal', 'Fonda', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8897, 'Friend', 'Wesley', 'Haggard', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8898, 'Friend', 'Marc', 'Lucien', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3275, 'Close Friends', 'Whoopi', 'Pepper', to_date('05-04-2021', 'dd-mm-yyyy'), to_date('13-01-2021', 'dd-mm-yyyy'), 'Confirmed', 2342, 1248);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8899, 'Friend', 'Cheryl', 'Sevenfold', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8900, 'Friend', 'Jesus', 'Sinatra', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8901, 'Friend', 'Claude', 'Gilliam', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3279, 'Neighbors', 'Jude', 'Oszajca', to_date('16-01-2021', 'dd-mm-yyyy'), to_date('05-09-2021', 'dd-mm-yyyy'), 'Confirmed', 2053, 1393);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8902, 'Friend', 'Elle', 'Harris', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8903, 'Friend', 'Leslie', 'Levine', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8904, 'Friend', 'Brad', 'Winslet', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8905, 'Friend', 'Cate', 'Mitchell', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8906, 'Friend', 'Olympia', 'Tippe', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3285, 'Extended Family', 'Humberto', 'Loggia', to_date('28-02-2021', 'dd-mm-yyyy'), to_date('21-07-2021', 'dd-mm-yyyy'), 'Confirmed', 2199, 1312);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8907, 'Friend', 'Cherry', 'Lynskey', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8908, 'Friend', 'Tcheky', 'Gaines', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8909, 'Friend', 'Samuel', 'Dutton', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3289, 'Neighbors', 'Jude', 'Savage', to_date('22-09-2021', 'dd-mm-yyyy'), to_date('21-03-2021', 'dd-mm-yyyy'), 'Confirmed', 2211, 1073);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8910, 'Friend', 'Nicole', 'Estevez', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8911, 'Friend', 'Colin', 'Shawn', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8912, 'Friend', 'Colm', 'Dooley', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3293, 'Acquaintances', 'Johnette', 'Carnes', to_date('25-05-2021', 'dd-mm-yyyy'), to_date('12-11-2021', 'dd-mm-yyyy'), 'Confirmed', 2291, 1274);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8913, 'Friend', 'Aimee', 'Tyler', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3295, 'External Invitees', 'Lonnie', 'Belles', to_date('12-10-2021', 'dd-mm-yyyy'), to_date('07-10-2021', 'dd-mm-yyyy'), 'Confirmed', 2285, 1040);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8914, 'Friend', 'Joy', 'Davison', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8915, 'Friend', 'Joan', 'Ball', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8916, 'Friend', 'Bernard', 'Hatosy', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
commit;
prompt 200 records committed...
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8917, 'Friend', 'Neneh', 'Conlee', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8918, 'Friend', 'Julie', 'Hannah', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8919, 'Friend', 'Adrien', 'Biggs', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8920, 'Friend', 'Devon', 'Bandy', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8921, 'Friend', 'Bobbi', 'Bassett', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8922, 'Friend', 'Benjamin', 'Serbedzija', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8923, 'Friend', 'Rip', 'Holy', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8924, 'Friend', 'Lorraine', 'Nelligan', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8925, 'Friend', 'Busta', 'Hewitt', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8926, 'Friend', 'Cameron', 'Imperioli', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8927, 'Friend', 'Jason', 'Palmer', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8928, 'Friend', 'Timothy', 'Cocker', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8929, 'Friend', 'Cledus', 'Hiatt', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8744, 'Friend', 'Ronnie', 'Tippe', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3302, 'Extended Family', 'Kurtwood', 'Englund', to_date('17-07-2021', 'dd-mm-yyyy'), to_date('05-05-2021', 'dd-mm-yyyy'), 'Confirmed', 2175, 1135);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8745, 'Friend', 'Suzy', 'Paxton', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8746, 'Friend', 'Stevie', 'Edmunds', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3305, 'Neighbors', 'Lois', 'Ali', to_date('20-07-2021', 'dd-mm-yyyy'), to_date('08-05-2021', 'dd-mm-yyyy'), 'Confirmed', 2326, 1332);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8747, 'Friend', 'Robbie', 'Schwimmer', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8748, 'Friend', 'Gary', 'Whitmore', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3308, 'Acquaintances', 'Alan', 'Daniels', to_date('13-10-2021', 'dd-mm-yyyy'), to_date('12-05-2021', 'dd-mm-yyyy'), 'Confirmed', 2049, 1001);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3309, 'Immediate Family', 'Linda', 'Gandolfini', to_date('26-06-2021', 'dd-mm-yyyy'), to_date('01-09-2021', 'dd-mm-yyyy'), 'Confirmed', 2046, 1218);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8749, 'Friend', 'Jon', 'Hubbard', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3311, 'Neighbors', 'Olga', 'Karyo', to_date('03-05-2021', 'dd-mm-yyyy'), to_date('07-10-2021', 'dd-mm-yyyy'), 'Confirmed', 2082, 1264);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8750, 'Friend', 'Antonio', 'Guinness', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8751, 'Friend', 'Diane', 'Krabbe', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8752, 'Friend', 'Rene', 'Connery', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8753, 'Friend', 'Matt', 'Addy', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8754, 'Friend', 'Betty', 'Lopez', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8755, 'Friend', 'Nikki', 'Coward', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3318, 'Immediate Family', 'Neneh', 'Russo', to_date('27-03-2021', 'dd-mm-yyyy'), to_date('08-06-2021', 'dd-mm-yyyy'), 'Confirmed', 2371, 1155);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8756, 'Friend', 'Mel', 'Parm', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8757, 'Friend', 'Stockard', 'Clooney', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8758, 'Friend', 'Wang', 'Crystal', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8759, 'Friend', 'Tony', 'Cross', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8760, 'Friend', 'Harris', 'Secada', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3324, 'Work Colleagues', 'Howie', 'Nightingale', to_date('25-05-2021', 'dd-mm-yyyy'), to_date('09-03-2021', 'dd-mm-yyyy'), 'Confirmed', 2015, 1053);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8761, 'Friend', 'Goldie', 'Marx', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8762, 'Friend', 'Cate', 'Ponce', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8763, 'Friend', 'Avenged', 'Union', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8764, 'Friend', 'Connie', 'Lillard', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8765, 'Friend', 'Herbie', 'Dickinson', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8766, 'Friend', 'Willie', 'Rapaport', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3331, 'Acquaintances', 'Hank', 'Klugh', to_date('12-12-2021', 'dd-mm-yyyy'), to_date('03-07-2021', 'dd-mm-yyyy'), 'Confirmed', 2285, 1057);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3332, 'Acquaintances', 'Willem', 'Spiner', to_date('01-03-2021', 'dd-mm-yyyy'), to_date('06-10-2021', 'dd-mm-yyyy'), 'Confirmed', 2077, 1034);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8767, 'Friend', 'Glen', 'Gilliam', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8768, 'Friend', 'Nigel', 'Schwarzenegger', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8769, 'Friend', 'Franz', 'Witherspoon', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8770, 'Friend', 'Praga', 'Pressly', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3337, 'Acquaintances', 'Anne', 'Donelly', to_date('05-12-2021', 'dd-mm-yyyy'), to_date('06-07-2021', 'dd-mm-yyyy'), 'Confirmed', 2100, 1035);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8771, 'Friend', 'Shelby', 'Jordan', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8772, 'Friend', 'Melanie', 'Connery', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3340, 'Friends', 'Patricia', 'Colman', to_date('15-04-2021', 'dd-mm-yyyy'), to_date('13-08-2021', 'dd-mm-yyyy'), 'Confirmed', 2112, 1121);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8773, 'Friend', 'Brothers', 'Shepard', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8774, 'Friend', 'Bill', 'Galecki', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8775, 'Friend', 'Christian', 'Pearce', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8776, 'Friend', 'Julianna', 'Bedelia', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8777, 'Friend', 'Bernie', 'Kinski', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8778, 'Friend', 'Patrick', 'Speaks', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8779, 'Friend', 'Vincent', 'Guilfoyle', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8780, 'Friend', 'Denny', 'Deschanel', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8781, 'Friend', 'Larnelle', 'Purefoy', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8782, 'Friend', 'Garland', 'Place', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8783, 'Friend', 'Sonny', 'Carrere', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8784, 'Friend', 'Adrien', 'Gaines', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8785, 'Friend', 'Larry', 'Utada', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3354, 'Immediate Family', 'Armand', 'Gugino', to_date('24-10-2021', 'dd-mm-yyyy'), to_date('21-01-2021', 'dd-mm-yyyy'), 'Confirmed', 2119, 1394);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8786, 'Friend', 'Tony', 'Sarsgaard', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8787, 'Friend', 'Angela', 'Harmon', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3357, 'Immediate Family', 'Wade', 'Gates', to_date('22-09-2021', 'dd-mm-yyyy'), to_date('21-09-2021', 'dd-mm-yyyy'), 'Confirmed', 2072, 1003);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8788, 'Friend', 'Rhea', 'Cohn', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8789, 'Friend', 'Kay', 'Harry', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8790, 'Friend', 'Sheryl', 'Aniston', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8791, 'Friend', 'Rosie', 'Plimpton', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8792, 'Friend', 'Bridgette', 'Farina', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8793, 'Friend', 'Trini', 'Sizemore', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8794, 'Friend', 'Eugene', 'Nakai', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8795, 'Friend', 'Lila', 'Gooding', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8796, 'Friend', 'Neve', 'Gayle', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8797, 'Friend', 'Chad', 'Stuermer', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8798, 'Friend', 'Trini', 'Rossellini', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3369, 'Extended Family', 'Jeremy', 'Jovovich', to_date('29-12-2021', 'dd-mm-yyyy'), to_date('25-06-2021', 'dd-mm-yyyy'), 'Confirmed', 2210, 1044);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8799, 'Friend', 'Cledus', 'Midler', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8800, 'Friend', 'Demi', 'Leary', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3372, 'Friends', 'Marie', 'Crouch', to_date('15-06-2021', 'dd-mm-yyyy'), to_date('08-04-2021', 'dd-mm-yyyy'), 'Confirmed', 2391, 1343);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8801, 'Friend', 'Ryan', 'Harary', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3374, 'Close Friends', 'Gavin', 'Hudson', to_date('21-07-2021', 'dd-mm-yyyy'), to_date('11-03-2021', 'dd-mm-yyyy'), 'Confirmed', 2322, 1132);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8802, 'Friend', 'Rose', 'Silverman', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8803, 'Friend', 'Steve', 'Favreau', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8804, 'Friend', 'Trini', 'Zevon', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8805, 'Friend', 'Terrence', 'Wagner', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8806, 'Friend', 'Shelby', 'Tolkan', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8807, 'Friend', 'Teena', 'Chung', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8808, 'Friend', 'Hope', 'Hurt', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8809, 'Friend', 'Bridgette', 'Gayle', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8810, 'Friend', 'Max', 'Douglas', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3384, 'Close Friends', 'Vienna', 'Miles', to_date('18-11-2021', 'dd-mm-yyyy'), to_date('16-03-2021', 'dd-mm-yyyy'), 'Confirmed', 2140, 1360);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8811, 'Friend', 'Charlize', 'Gertner', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8812, 'Friend', 'Blair', 'Field', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8813, 'Friend', 'Maureen', 'Venora', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
commit;
prompt 300 records committed...
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3388, 'Extended Family', 'Roscoe', 'Berenger', to_date('04-09-2021', 'dd-mm-yyyy'), to_date('22-06-2021', 'dd-mm-yyyy'), 'Confirmed', 2016, 1116);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8814, 'Friend', 'Albertina', 'Plummer', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8815, 'Friend', 'Saul', 'Schock', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8816, 'Friend', 'Corey', 'Henriksen', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8817, 'Friend', 'Val', 'Checker', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8818, 'Friend', 'Suzanne', 'Chappelle', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8819, 'Friend', 'Geoffrey', 'Rourke', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8820, 'Friend', 'Diane', 'Elizabeth', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8821, 'Friend', 'Isaiah', 'Stevens', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8822, 'Friend', 'Saul', 'Swayze', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8823, 'Friend', 'Merillee', 'Coltrane', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3399, 'Friends', 'Ben', 'Foxx', to_date('23-08-2021', 'dd-mm-yyyy'), to_date('02-10-2021', 'dd-mm-yyyy'), 'Confirmed', 2214, 1118);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8824, 'Friend', 'Richie', 'Neville', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8825, 'Friend', 'Tobey', 'Tempest', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8826, 'Friend', 'Scarlett', 'Child', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8827, 'Friend', 'Dustin', 'Baldwin', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8828, 'Friend', 'Casey', 'Sossamon', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8829, 'Friend', 'Night', 'Hartnett', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8830, 'Friend', 'Tilda', 'Lennox', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8831, 'Friend', 'Rachael', 'Zappacosta', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8832, 'Friend', 'Tzi', 'Faithfull', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8833, 'Friend', 'Talvin', 'Farina', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8834, 'Friend', 'Sara', 'Fishburne', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8835, 'Friend', 'Lea', 'Palminteri', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8644, 'Friend', 'Bradley', 'Berkoff', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8645, 'Friend', 'Tony', 'Ball', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8646, 'Friend', 'Pablo', 'Raye', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3407, 'Work Colleagues', 'Miki', 'Pollack', to_date('21-12-2021', 'dd-mm-yyyy'), to_date('16-03-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8647, 'Friend', 'Sigourney', 'Nicholson', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8648, 'Friend', 'Lin', 'Rubinek', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3410, 'Close Friends', 'Tilda', 'Blaine', to_date('22-06-2021', 'dd-mm-yyyy'), to_date('02-01-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8649, 'Friend', 'Loren', 'Hudson', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8650, 'Friend', 'Kid', 'Taha', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8651, 'Friend', 'Austin', 'Silverman', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8652, 'Friend', 'Mike', 'Torino', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8653, 'Friend', 'Josh', 'Navarro', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8654, 'Friend', 'Matt', 'Shand', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8655, 'Friend', 'Alfred', 'Visnjic', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3418, 'Acquaintances', 'Emm', 'Baez', to_date('03-10-2021', 'dd-mm-yyyy'), to_date('10-04-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8656, 'Friend', 'Gil', 'Eastwood', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8657, 'Friend', 'Willie', 'Randal', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8658, 'Friend', 'Adrien', 'Paquin', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8659, 'Friend', 'Devon', 'Boorem', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8660, 'Friend', 'Jessica', 'Van Damme', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8661, 'Friend', 'Tal', 'Ricci', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8662, 'Friend', 'Raymond', 'Marley', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8663, 'Friend', 'Jet', 'Mathis', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8664, 'Friend', 'Geoffrey', 'Morrison', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3428, 'Work Colleagues', 'Anjelica', 'English', to_date('02-07-2021', 'dd-mm-yyyy'), to_date('04-06-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8665, 'Friend', 'Austin', 'Clarkson', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3430, 'Neighbors', 'Tilda', 'Shepard', to_date('19-05-2021', 'dd-mm-yyyy'), to_date('07-02-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8666, 'Friend', 'Vin', 'Wills', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3432, 'Close Friends', 'Winona', 'Coverdale', to_date('14-02-2021', 'dd-mm-yyyy'), to_date('18-11-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8667, 'Friend', 'Fiona', 'Guilfoyle', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8668, 'Friend', 'Mac', 'DeLuise', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8669, 'Friend', 'Brent', 'Devine', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8670, 'Friend', 'Cherry', 'Domino', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8671, 'Friend', 'Azucar', 'Koyana', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8672, 'Friend', 'Patti', 'Clooney', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8673, 'Friend', 'Brendan', 'McGoohan', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8674, 'Friend', 'Clive', 'Young', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8675, 'Friend', 'Freda', 'Jeter', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8676, 'Friend', 'Sara', 'Sheen', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8677, 'Friend', 'Ernie', 'MacIsaac', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8678, 'Friend', 'Rosanne', 'Loring', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8679, 'Friend', 'Mandy', 'Red', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8680, 'Friend', 'Gabriel', 'Blanchett', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8681, 'Friend', 'Pat', 'McFerrin', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8682, 'Friend', 'Julianna', 'Gill', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8683, 'Friend', 'Colleen', 'Day-Lewis', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8684, 'Friend', 'Karon', 'Midler', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8685, 'Friend', 'Alice', 'Schwimmer', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8686, 'Friend', 'Teena', 'Klugh', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8687, 'Friend', 'Meryl', 'Martin', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8688, 'Friend', 'Jackson', 'Jones', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8689, 'Friend', 'Toshiro', 'Gaynor', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8690, 'Friend', 'Rosario', 'Avalon', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3457, 'Extended Family', 'Holland', 'Wakeling', to_date('16-03-2021', 'dd-mm-yyyy'), to_date('02-05-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8691, 'Friend', 'Mia', 'Portman', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8692, 'Friend', 'Jay', 'Gugino', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8693, 'Friend', 'Claude', 'Rossellini', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8694, 'Friend', 'Meredith', 'Lopez', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8695, 'Friend', 'Lois', 'Fogerty', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3463, 'Friends', 'Casey', 'Channing', to_date('03-01-2021', 'dd-mm-yyyy'), to_date('09-09-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8696, 'Friend', 'Tzi', 'Evett', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8697, 'Friend', 'Yaphet', 'Oates', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8698, 'Friend', 'Cloris', 'Ingram', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8699, 'Friend', 'Edgar', 'Burton', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8700, 'Friend', 'Bridget', 'Rollins', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8701, 'Friend', 'Ty', 'Sorvino', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8702, 'Friend', 'France', 'Llewelyn', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8703, 'Friend', 'Matthew', 'Kattan', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3472, 'Acquaintances', 'Nils', 'Englund', to_date('29-01-2021', 'dd-mm-yyyy'), to_date('17-10-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8704, 'Friend', 'Jann', 'Irving', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8705, 'Friend', 'Kirsten', 'Arkin', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8706, 'Friend', 'Merle', 'Gough', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8707, 'Friend', 'Jaime', 'Ponty', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8708, 'Friend', 'Lena', 'Heatherly', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8709, 'Friend', 'Sonny', 'Bergen', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8710, 'Friend', 'Elias', 'Peniston', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
commit;
prompt 400 records committed...
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8711, 'Friend', 'Sammy', 'O''Neill', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8712, 'Friend', 'Temuera', 'Paquin', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8713, 'Friend', 'Joshua', 'Lorenz', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8714, 'Friend', 'Harvey', 'Weaver', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8715, 'Friend', 'Garland', 'Woodward', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8716, 'Friend', 'Ian', 'Perlman', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8717, 'Friend', 'Rosco', 'Brody', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8718, 'Friend', 'Wendy', 'Newton', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8719, 'Friend', 'Buffy', 'Peebles', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8720, 'Friend', 'Bernie', 'Oakenfold', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8721, 'Friend', 'Carlos', 'Ward', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8722, 'Friend', 'Marc', 'Sandler', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3492, 'Neighbors', 'Benicio', 'Beckinsale', to_date('16-04-2021', 'dd-mm-yyyy'), to_date('02-05-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8723, 'Friend', 'Andie', 'Llewelyn', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8724, 'Friend', 'Sally', 'Archer', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8725, 'Friend', 'Wallace', 'Easton', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8726, 'Friend', 'Wade', 'Haysbert', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8727, 'Friend', 'Cate', 'Judd', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8728, 'Friend', 'Chad', 'Tripplehorn', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8729, 'Friend', 'Balthazar', 'Nolte', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3500, 'External Invitees', 'Neve', 'Rebhorn', to_date('08-03-2021', 'dd-mm-yyyy'), to_date('10-02-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8730, 'Friend', 'Mindy', 'Silverman', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8731, 'Friend', 'Illeana', 'Black', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8732, 'Friend', 'Merillee', 'McNarland', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3504, 'Friends', 'Emerson', 'Kapanka', to_date('21-05-2021', 'dd-mm-yyyy'), to_date('30-06-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8733, 'Friend', 'Sander', 'Luongo', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8734, 'Friend', 'Samuel', 'Gertner', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8735, 'Friend', 'Jesus', 'Arthur', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8736, 'Friend', 'Tilda', 'Tambor', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8737, 'Friend', 'Dermot', 'Page', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8738, 'Friend', 'Toni', 'Holiday', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8739, 'Friend', 'Cherry', 'Kurtz', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8740, 'Friend', 'Christian', 'McCabe', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8741, 'Friend', 'Ernest', 'Leoni', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8742, 'Friend', 'Emmylou', 'Eckhart', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8743, 'Friend', 'Jamie', 'McDonald', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8547, 'Friend', 'Lea', 'Tomlin', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8548, 'Friend', 'Stevie', 'Mazzello', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8549, 'Friend', 'Jean', 'Dunaway', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8550, 'Friend', 'Julio', 'Alston', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8551, 'Friend', 'Eric', 'Kweller', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8552, 'Friend', 'Rik', 'Redgrave', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3512, 'Work Colleagues', 'Susan', 'Lofgren', to_date('28-05-2021', 'dd-mm-yyyy'), to_date('07-02-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8553, 'Friend', 'Roddy', 'Folds', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8554, 'Friend', 'Will', 'Tennison', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8555, 'Friend', 'Hazel', 'Cara', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3516, 'Close Friends', 'Ashton', 'Branch', to_date('05-04-2021', 'dd-mm-yyyy'), to_date('17-05-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8556, 'Friend', 'Suzanne', 'Bentley', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8557, 'Friend', 'Kirk', 'Lee', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8558, 'Friend', 'Harvey', 'Freeman', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3520, 'Close Friends', 'Thora', 'Puckett', to_date('10-12-2021', 'dd-mm-yyyy'), to_date('01-12-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8559, 'Friend', 'Randy', 'Culkin', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3522, 'Extended Family', 'Vince', 'Quinlan', to_date('10-11-2021', 'dd-mm-yyyy'), to_date('15-02-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8560, 'Friend', 'Angelina', 'Richards', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8561, 'Friend', 'Nikka', 'Platt', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8562, 'Friend', 'Desmond', 'McFadden', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8563, 'Friend', 'Joely', 'Hayek', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3527, 'Work Colleagues', 'Devon', 'Sledge', to_date('17-11-2021', 'dd-mm-yyyy'), to_date('08-10-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3528, 'Work Colleagues', 'Fisher', 'Rickles', to_date('25-07-2021', 'dd-mm-yyyy'), to_date('02-08-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8564, 'Friend', 'Jennifer', 'Sevenfold', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8565, 'Friend', 'Horace', 'DeLuise', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3531, 'Work Colleagues', 'Geoff', 'Turner', to_date('31-07-2021', 'dd-mm-yyyy'), to_date('18-02-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8566, 'Friend', 'Salma', 'Khan', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3533, 'Work Colleagues', 'Claude', 'Lithgow', to_date('05-07-2021', 'dd-mm-yyyy'), to_date('11-01-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8567, 'Friend', 'Collin', 'Ball', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8568, 'Friend', 'Gladys', 'Heatherly', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8569, 'Friend', 'Cornell', 'Furay', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8570, 'Friend', 'Rutger', 'Morales', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8571, 'Friend', 'Burt', 'Navarro', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8572, 'Friend', 'Patricia', 'Eldard', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3540, 'Work Colleagues', 'Kid', 'Jackson', to_date('05-09-2021', 'dd-mm-yyyy'), to_date('04-02-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8573, 'Friend', 'Willem', 'Matthau', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8574, 'Friend', 'Tori', 'Bean', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8575, 'Friend', 'Keith', 'DiFranco', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8576, 'Friend', 'Wes', 'English', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8577, 'Friend', 'Mary Beth', 'Hagar', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8578, 'Friend', 'Marianne', 'Lipnicki', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8579, 'Friend', 'Johnnie', 'Van Damme', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8580, 'Friend', 'Lindsey', 'Red', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8581, 'Friend', 'Luis', 'Gambon', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8582, 'Friend', 'Red', 'Baez', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3551, 'Close Friends', 'Stevie', 'Hersh', to_date('08-07-2021', 'dd-mm-yyyy'), to_date('11-01-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8583, 'Friend', 'Latin', 'Crowe', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8584, 'Friend', 'Randy', 'Unger', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8585, 'Friend', 'Night', 'Ponty', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8586, 'Friend', 'Joy', 'Davidson', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8587, 'Friend', 'Julianne', 'Keen', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8588, 'Friend', 'Frederic', 'Ingram', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8589, 'Friend', 'Rolando', 'Tucker', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8590, 'Friend', 'Linda', 'Sandler', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8591, 'Friend', 'Teri', 'Ifans', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8592, 'Friend', 'Burton', 'Pryce', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8593, 'Friend', 'Joey', 'Spacek', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8594, 'Friend', 'Jane', 'Aniston', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8595, 'Friend', 'Wayne', 'McGriff', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8596, 'Friend', 'Tea', 'Jovovich', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8597, 'Friend', 'Lynette', 'Holiday', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3567, 'Friends', 'Hector', 'Dzundza', to_date('23-08-2021', 'dd-mm-yyyy'), to_date('17-06-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8598, 'Friend', 'Loretta', 'Brandt', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8599, 'Friend', 'Bobbi', 'Molina', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
commit;
prompt 500 records committed...
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8600, 'Friend', 'Yaphet', 'Womack', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8601, 'Friend', 'Dick', 'Twilley', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8602, 'Friend', 'Kathy', 'Moorer', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8603, 'Friend', 'Leonardo', 'Scorsese', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8604, 'Friend', 'Sophie', 'Rundgren', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8605, 'Friend', 'Daniel', 'Lloyd', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8606, 'Friend', 'Cloris', 'Berkeley', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8607, 'Friend', 'Gil', 'Maguire', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8608, 'Friend', 'Wayman', 'Sweet', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8609, 'Friend', 'Pamela', 'Peterson', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8610, 'Friend', 'Solomon', 'Carrington', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8611, 'Friend', 'Mitchell', 'Randal', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8612, 'Friend', 'Gailard', 'Flanagan', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8613, 'Friend', 'Dennis', 'Midler', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8614, 'Friend', 'Rhett', 'Dunaway', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8615, 'Friend', 'Richard', 'Craven', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8616, 'Friend', 'Dar', 'Larter', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8617, 'Friend', 'Tori', 'Mifune', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8618, 'Friend', 'Philip', 'Aykroyd', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8619, 'Friend', 'Maggie', 'Cetera', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8620, 'Friend', 'Terri', 'Russo', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8621, 'Friend', 'Madeleine', 'Niven', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8622, 'Friend', 'Terri', 'Mifune', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8623, 'Friend', 'Hilary', 'Moody', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8624, 'Friend', 'Hope', 'Sanders', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3595, 'Neighbors', 'Breckin', 'Schwarzenegger', to_date('12-09-2021', 'dd-mm-yyyy'), to_date('11-12-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8625, 'Friend', 'Crispin', 'Porter', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8626, 'Friend', 'Jena', 'Crewson', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3598, 'Extended Family', 'Junior', 'Raye', to_date('22-02-2021', 'dd-mm-yyyy'), to_date('01-10-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3599, 'Acquaintances', 'Irene', 'Colman', to_date('04-04-2021', 'dd-mm-yyyy'), to_date('01-04-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8627, 'Friend', 'Joey', 'Vaughan', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8628, 'Friend', 'Tia', 'Tate', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8629, 'Friend', 'Lin', 'English', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8630, 'Friend', 'Chris', 'Idle', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3604, 'External Invitees', 'Lesley', 'Levy', to_date('13-02-2021', 'dd-mm-yyyy'), to_date('06-11-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8631, 'Friend', 'Suzi', 'Black', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8632, 'Friend', 'Ryan', 'Mortensen', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8633, 'Friend', 'Clarence', 'Potter', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8634, 'Friend', 'Franz', 'Tah', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8635, 'Friend', 'Cledus', 'Close', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8636, 'Friend', 'Clive', 'Collie', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8637, 'Friend', 'Nikki', 'Rodriguez', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8638, 'Friend', 'Coley', 'Jamal', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8639, 'Friend', 'Teena', 'Tolkan', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8640, 'Friend', 'Jack', 'Rebhorn', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8641, 'Friend', 'Shannon', 'Wen', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8642, 'Friend', 'Rose', 'Robinson', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8643, 'Friend', 'Kelli', 'Arden', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8449, 'Friend', 'Doug', 'Fogerty', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8450, 'Friend', 'Dabney', 'Seagal', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8451, 'Friend', 'Madeleine', 'Hatosy', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3611, 'Extended Family', 'Patricia', 'Ferrer', to_date('17-09-2021', 'dd-mm-yyyy'), to_date('14-11-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8452, 'Friend', 'Val', 'Black', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8453, 'Friend', 'Stephen', 'McPherson', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8454, 'Friend', 'Bret', 'Eastwood', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8455, 'Friend', 'Ashton', 'Mason', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3616, 'Work Colleagues', 'Swoosie', 'Keener', to_date('03-07-2021', 'dd-mm-yyyy'), to_date('02-05-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3617, 'Neighbors', 'Nikka', 'Margolyes', to_date('19-03-2021', 'dd-mm-yyyy'), to_date('18-06-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8456, 'Friend', 'Dustin', 'Raitt', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8457, 'Friend', 'Brent', 'Foxx', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8458, 'Friend', 'Natacha', 'Garofalo', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8459, 'Friend', 'Bo', 'Pesci', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8460, 'Friend', 'Rickie', 'Vicious', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8461, 'Friend', 'Lynette', 'Hauser', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8462, 'Friend', 'Thomas', 'Hynde', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8463, 'Friend', 'Jarvis', 'Hopkins', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8464, 'Friend', 'Johnnie', 'Fonda', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3627, 'Extended Family', 'Vickie', 'Waite', to_date('03-01-2021', 'dd-mm-yyyy'), to_date('04-05-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8465, 'Friend', 'Lucinda', 'Fariq', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8466, 'Friend', 'Franco', 'Root', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8467, 'Friend', 'Molly', 'Mould', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8468, 'Friend', 'Leelee', 'Kinney', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8469, 'Friend', 'Judd', 'Jackson', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8470, 'Friend', 'Loren', 'Reinhold', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8471, 'Friend', 'Vincent', 'Thornton', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8472, 'Friend', 'Jay', 'Katt', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8473, 'Friend', 'Laurence', 'Parm', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8474, 'Friend', 'Javon', 'Hart', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8475, 'Friend', 'Mickey', 'Uggams', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8476, 'Friend', 'Derrick', 'Child', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8477, 'Friend', 'Melba', 'Osborne', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8478, 'Friend', 'Carlos', 'Ronstadt', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8479, 'Friend', 'Yolanda', 'Wainwright', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8480, 'Friend', 'Liv', 'Porter', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8481, 'Friend', 'Sharon', 'Gertner', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8482, 'Friend', 'Doug', 'Loggins', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8483, 'Friend', 'Shawn', 'Cruz', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8484, 'Friend', 'Cuba', 'Bentley', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8485, 'Friend', 'Earl', 'Goldberg', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3649, 'Close Friends', 'Lydia', 'Mohr', to_date('10-06-2021', 'dd-mm-yyyy'), to_date('25-05-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8486, 'Friend', 'Hugo', 'Cummings', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8487, 'Friend', 'Ice', 'Hall', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3652, 'Neighbors', 'Mickey', 'Akins', to_date('22-02-2021', 'dd-mm-yyyy'), to_date('22-08-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8488, 'Friend', 'Miranda', 'Donelly', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8489, 'Friend', 'Kazem', 'LaPaglia', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8490, 'Friend', 'Rodney', 'Rankin', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8491, 'Friend', 'Patrick', 'Zane', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8492, 'Friend', 'Bridgette', 'Warburton', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8493, 'Friend', 'Mac', 'Colman', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8494, 'Friend', 'Buddy', 'Swayze', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
commit;
prompt 600 records committed...
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8495, 'Friend', 'Mickey', 'Torres', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8496, 'Friend', 'Ricky', 'Stevens', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3662, 'Acquaintances', 'Brendan', 'Irving', to_date('26-04-2021', 'dd-mm-yyyy'), to_date('04-05-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8497, 'Friend', 'Kyle', 'Rubinek', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8498, 'Friend', 'Vickie', 'Olin', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8499, 'Friend', 'Emm', 'Pleasure', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8501, 'Friend', 'Veruca', 'Craddock', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8502, 'Friend', 'Adam', 'Cruz', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8503, 'Friend', 'Raul', 'Russell', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8504, 'Friend', 'Rickie', 'Cleary', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8505, 'Friend', 'Harold', 'Arquette', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8506, 'Friend', 'Bebe', 'Curry', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8507, 'Friend', 'Helen', 'Buckingham', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3673, 'Acquaintances', 'Emmylou', 'Balin', to_date('15-10-2021', 'dd-mm-yyyy'), to_date('03-01-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8508, 'Friend', 'Bo', 'Newton', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8509, 'Friend', 'Boz', 'Sellers', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8510, 'Friend', 'Sonny', 'Todd', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3677, 'Acquaintances', 'Giancarlo', 'Janney', to_date('10-09-2021', 'dd-mm-yyyy'), to_date('19-01-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8511, 'Friend', 'Patti', 'Badalucco', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8512, 'Friend', 'Joan', 'Milsap', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8513, 'Friend', 'Cathy', 'Scorsese', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8514, 'Friend', 'Gabriel', 'Cornell', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8515, 'Friend', 'Lucy', 'Aglukark', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3683, 'Close Friends', 'Leonardo', 'McGinley', to_date('20-06-2021', 'dd-mm-yyyy'), to_date('16-05-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8516, 'Friend', 'France', 'Zeta-Jones', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8517, 'Friend', 'Chris', 'Knight', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8518, 'Friend', 'Ossie', 'Cassel', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3687, 'Close Friends', 'Bret', 'Tisdale', to_date('19-03-2021', 'dd-mm-yyyy'), to_date('08-11-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8519, 'Friend', 'Coley', 'Tah', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8520, 'Friend', 'Roy', 'O''Neill', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8521, 'Friend', 'Chrissie', 'Weston', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8522, 'Friend', 'Lili', 'Laws', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8523, 'Friend', 'Tobey', 'Isaak', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8524, 'Friend', 'Nastassja', 'Soda', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8525, 'Friend', 'Chazz', 'Lane', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3695, 'Immediate Family', 'Kristin', 'Tambor', to_date('15-07-2021', 'dd-mm-yyyy'), to_date('26-06-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3696, 'Neighbors', 'Kylie', 'Creek', to_date('26-04-2021', 'dd-mm-yyyy'), to_date('04-05-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8526, 'Friend', 'Carol', 'Carradine', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8527, 'Friend', 'Busta', 'Reeves', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8528, 'Friend', 'Nicolas', 'McDowell', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3700, 'Work Colleagues', 'Chalee', 'Calle', to_date('28-04-2021', 'dd-mm-yyyy'), to_date('10-03-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8529, 'Friend', 'Sara', 'Spears', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8530, 'Friend', 'Clive', 'Griffiths', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8531, 'Friend', 'Lila', 'Nelligan', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8532, 'Friend', 'Lea', 'Collins', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8533, 'Friend', 'Harvey', 'Sartain', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3706, 'Immediate Family', 'Cole', 'Duchovny', to_date('21-05-2021', 'dd-mm-yyyy'), to_date('22-04-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8534, 'Friend', 'Nora', 'Lizzy', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8535, 'Friend', 'Gran', 'Clarkson', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8536, 'Friend', 'Jeffery', 'Mahood', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8537, 'Friend', 'Tobey', 'Larter', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8448, 'Friend', 'Nicholas', 'Slater', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8538, 'Friend', 'Luke', 'Geldof', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8539, 'Friend', 'Karen', 'Westerberg', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8540, 'Friend', 'Rich', 'Shelton', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8541, 'Friend', 'Juan', 'Winger', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8542, 'Friend', 'Desmond', 'Gold', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8543, 'Friend', 'Louise', 'Santana', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8544, 'Friend', 'Victoria', 'Moriarty', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8545, 'Friend', 'Joaquim', 'Madonna', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8546, 'Friend', 'Gena', 'Hayes', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2004, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8349, 'Friend', 'Oro', 'Noseworthy', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3712, 'Neighbors', 'Victoria', 'McLean', to_date('05-04-2021', 'dd-mm-yyyy'), to_date('22-10-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8350, 'Friend', 'Eugene', 'Costner', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8351, 'Friend', 'Josh', 'Mann', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8352, 'Friend', 'Eliza', 'DeLuise', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8353, 'Friend', 'Hugo', 'Lucas', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8354, 'Friend', 'Hope', 'Hampton', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8355, 'Friend', 'Ethan', 'Robinson', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3719, 'Extended Family', 'Diamond', 'Heslov', to_date('24-08-2021', 'dd-mm-yyyy'), to_date('10-04-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3720, 'Acquaintances', 'Machine', 'Stewart', to_date('08-03-2021', 'dd-mm-yyyy'), to_date('04-09-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8356, 'Friend', 'Mykelti', 'Guest', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8357, 'Friend', 'Dan', 'Balin', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8358, 'Friend', 'Patrick', 'Carrack', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3724, 'External Invitees', 'Rascal', 'De Almeida', to_date('24-08-2021', 'dd-mm-yyyy'), to_date('24-03-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8359, 'Friend', 'Tara', 'Atlas', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8360, 'Friend', 'Mac', 'Brosnan', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8361, 'Friend', 'Miguel', 'Conlee', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8362, 'Friend', 'Thin', 'Bryson', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3729, 'Friends', 'Campbell', 'Williamson', to_date('03-01-2021', 'dd-mm-yyyy'), to_date('21-09-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3730, 'Close Friends', 'Oro', 'Walker', to_date('16-03-2021', 'dd-mm-yyyy'), to_date('23-01-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3731, 'External Invitees', 'Nicole', 'Margolyes', to_date('29-12-2021', 'dd-mm-yyyy'), to_date('05-11-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8363, 'Friend', 'Eric', 'Bridges', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8364, 'Friend', 'Johnny', 'Serbedzija', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8365, 'Friend', 'Lydia', 'MacPherson', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8366, 'Friend', 'Taye', 'Ronstadt', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8367, 'Friend', 'Azucar', 'Askew', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8368, 'Friend', 'Tori', 'Warburton', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8369, 'Friend', 'Sheena', 'Sarandon', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8370, 'Friend', 'Nicole', 'Stuermer', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8371, 'Friend', 'Dave', 'Murray', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8372, 'Friend', 'Lennie', 'Hayes', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8373, 'Friend', 'Yolanda', 'Allan', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8374, 'Friend', 'Ben', 'Sossamon', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8375, 'Friend', 'Pete', 'Tobolowsky', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3745, 'Immediate Family', 'Ted', 'Pullman', to_date('18-11-2021', 'dd-mm-yyyy'), to_date('19-03-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8376, 'Friend', 'Jim', 'Wills', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8377, 'Friend', 'Taryn', 'Conlee', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8378, 'Friend', 'Clive', 'Doucette', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8379, 'Friend', 'Illeana', 'Jay', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
commit;
prompt 700 records committed...
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8380, 'Friend', 'Alicia', 'Stevenson', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8381, 'Friend', 'Lindsay', 'Moriarty', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8382, 'Friend', 'Gates', 'de Lancie', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8383, 'Friend', 'Gene', 'Tyler', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3754, 'Acquaintances', 'Vin', 'Cleese', to_date('20-08-2021', 'dd-mm-yyyy'), to_date('06-02-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8384, 'Friend', 'Maury', 'Austin', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8385, 'Friend', 'Pamela', 'Kattan', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8386, 'Friend', 'Maggie', 'Trevino', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8387, 'Friend', 'Rebecca', 'Kinnear', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8388, 'Friend', 'Emilio', 'Nolte', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8389, 'Friend', 'Lili', 'Adkins', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8390, 'Friend', 'Madeline', 'Travers', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8391, 'Friend', 'Randy', 'Crudup', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8392, 'Friend', 'Frances', 'McDowell', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8393, 'Friend', 'Henry', 'Curtis', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3765, 'Immediate Family', 'Kris', 'Broza', to_date('29-06-2021', 'dd-mm-yyyy'), to_date('19-12-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8394, 'Friend', 'Beverley', 'Pepper', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8395, 'Friend', 'Rory', 'MacPherson', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8396, 'Friend', 'Balthazar', 'Sartain', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8397, 'Friend', 'Frances', 'Carter', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8398, 'Friend', 'Mika', 'Benoit', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3771, 'Friends', 'Shannon', 'Melvin', to_date('11-03-2021', 'dd-mm-yyyy'), to_date('08-07-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8399, 'Friend', 'Lucy', 'Rubinek', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8400, 'Friend', 'Martha', 'Rowlands', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8401, 'Friend', 'Vincent', 'Goldwyn', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8402, 'Friend', 'Kenny', 'Marley', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8403, 'Friend', 'Madeleine', 'Heald', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8404, 'Friend', 'Jeffery', 'Alda', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8405, 'Friend', 'Connie', 'Heron', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8406, 'Friend', 'Belinda', 'Wen', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8407, 'Friend', 'Tara', 'McAnally', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8408, 'Friend', 'Arnold', 'Guilfoyle', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8409, 'Friend', 'Molly', 'Davis', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8410, 'Friend', 'Mili', 'Navarro', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8411, 'Friend', 'Ray', 'Morse', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8412, 'Friend', 'Rhys', 'Metcalf', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8413, 'Friend', 'Neve', 'McConaughey', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8414, 'Friend', 'Dorry', 'Bean', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8415, 'Friend', 'Howie', 'Henriksen', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8416, 'Friend', 'Jackie', 'Rhymes', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8417, 'Friend', 'Regina', 'Lorenz', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8418, 'Friend', 'Brent', 'Cohn', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8419, 'Friend', 'Lesley', 'Reed', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8420, 'Friend', 'Salma', 'May', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3794, 'Friends', 'Tamala', 'Kinski', to_date('26-06-2021', 'dd-mm-yyyy'), to_date('14-10-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3795, 'Friends', 'Jesus', 'Williams', to_date('17-02-2021', 'dd-mm-yyyy'), to_date('13-03-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8421, 'Friend', 'Holly', 'Sisto', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8422, 'Friend', 'Jesus', 'Thomson', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8423, 'Friend', 'Geoffrey', 'Warburton', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8424, 'Friend', 'Roy', 'Wright', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3800, 'External Invitees', 'Charlize', 'Field', to_date('02-04-2021', 'dd-mm-yyyy'), to_date('16-10-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8425, 'Friend', 'Mary-Louise', 'Hershey', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8426, 'Friend', 'Deborah', 'Lynne', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8427, 'Friend', 'Radney', 'Child', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8428, 'Friend', 'Merle', 'Loeb', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8429, 'Friend', 'Tamala', 'Puckett', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8430, 'Friend', 'Nora', 'Davies', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8431, 'Friend', 'Leon', 'Scott', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8432, 'Friend', 'Randall', 'Ricci', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8433, 'Friend', 'Mel', 'Garfunkel', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8434, 'Friend', 'Elijah', 'Fishburne', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8435, 'Friend', 'Randy', 'Carlyle', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8436, 'Friend', 'Lionel', 'Pride', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8437, 'Friend', 'Ty', 'Crimson', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8438, 'Friend', 'Vienna', 'Stiers', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8439, 'Friend', 'Julianne', 'King', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8440, 'Friend', 'Alfie', 'Hatfield', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8441, 'Friend', 'Gailard', 'Cube', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8442, 'Friend', 'Fionnula', 'Campbell', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8443, 'Friend', 'Kyra', 'Sorvino', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8444, 'Friend', 'Gene', 'Benet', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8445, 'Friend', 'Gabriel', 'McAnally', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8446, 'Friend', 'Taryn', 'Skaggs', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8447, 'Friend', 'Cate', 'Flanagan', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8251, 'Friend', 'Melba', 'Bogguss', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3815, 'External Invitees', 'Guy', 'Page', to_date('26-04-2021', 'dd-mm-yyyy'), to_date('03-07-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8252, 'Friend', 'Aimee', 'Hunt', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8253, 'Friend', 'Randall', 'Brothers', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8254, 'Friend', 'Clint', 'Winter', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8255, 'Friend', 'Laurie', 'Clooney', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8256, 'Friend', 'Scarlett', 'Cage', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8257, 'Friend', 'Linda', 'Burke', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3822, 'Neighbors', 'Trini', 'Linney', to_date('30-04-2021', 'dd-mm-yyyy'), to_date('01-06-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8258, 'Friend', 'Arturo', 'Domino', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8259, 'Friend', 'Aimee', 'Aaron', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3825, 'External Invitees', 'Mint', 'Weaving', to_date('29-06-2021', 'dd-mm-yyyy'), to_date('03-08-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3826, 'Friends', 'Talvin', 'Reubens', to_date('04-01-2021', 'dd-mm-yyyy'), to_date('17-05-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8260, 'Friend', 'Ricky', 'Beals', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8261, 'Friend', 'Philip', 'Smurfit', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3829, 'Close Friends', 'Davy', 'Rooker', to_date('04-04-2021', 'dd-mm-yyyy'), to_date('18-10-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8262, 'Friend', 'Maureen', 'Davidtz', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8263, 'Friend', 'Susan', 'Tempest', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8264, 'Friend', 'Kid', 'Saxon', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8265, 'Friend', 'Johnette', 'Lane', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8266, 'Friend', 'Aimee', 'Brandt', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8267, 'Friend', 'Lena', 'Levy', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8268, 'Friend', 'Norm', 'Beckham', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8269, 'Friend', 'Morgan', 'Garcia', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8270, 'Friend', 'Cheech', 'Haggard', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8271, 'Friend', 'Kathy', 'Gleeson', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
commit;
prompt 800 records committed...
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8272, 'Friend', 'Rob', 'Amos', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8273, 'Friend', 'Sheena', 'Chan', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8274, 'Friend', 'Lorraine', 'Gold', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8275, 'Friend', 'Bridget', 'Bugnon', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3844, 'Close Friends', 'Ewan', 'Keaton', to_date('25-07-2021', 'dd-mm-yyyy'), to_date('22-10-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8276, 'Friend', 'Lloyd', 'Summer', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8277, 'Friend', 'Neil', 'Payne', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8278, 'Friend', 'Benicio', 'Krieger', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8279, 'Friend', 'Dianne', 'Craig', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8280, 'Friend', 'Toni', 'Dunn', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8281, 'Friend', 'Nina', 'Carlisle', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3851, 'Close Friends', 'Christina', 'Patton', to_date('07-09-2021', 'dd-mm-yyyy'), to_date('19-09-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8282, 'Friend', 'Ewan', 'Tempest', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8283, 'Friend', 'Annie', 'Carlyle', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8284, 'Friend', 'Kirk', 'Mollard', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3855, 'Acquaintances', 'Gilbert', 'Peet', to_date('02-06-2021', 'dd-mm-yyyy'), to_date('05-12-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8285, 'Friend', 'Angela', 'James', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8286, 'Friend', 'Lena', 'Rea', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8287, 'Friend', 'Laura', 'Womack', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8288, 'Friend', 'Jonatha', 'Pitt', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8289, 'Friend', 'Andie', 'Tsettos', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8290, 'Friend', 'Joanna', 'Pressly', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8291, 'Friend', 'Gwyneth', 'Singletary', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3863, 'Close Friends', 'Rene', 'Raye', to_date('13-03-2021', 'dd-mm-yyyy'), to_date('25-08-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8292, 'Friend', 'Amanda', 'Zahn', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8293, 'Friend', 'Aidan', 'Levert', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8294, 'Friend', 'Lorraine', 'Kattan', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8295, 'Friend', 'Jason', 'Connick', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3868, 'Friends', 'Matthew', 'Patton', to_date('13-11-2021', 'dd-mm-yyyy'), to_date('10-11-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8296, 'Friend', 'Etta', 'Cassidy', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3870, 'Extended Family', 'Russell', 'Cromwell', to_date('04-10-2021', 'dd-mm-yyyy'), to_date('05-06-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8297, 'Friend', 'Taylor', 'Hagerty', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8298, 'Friend', 'Debby', 'Winstone', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8299, 'Friend', 'Marie', 'Harnes', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8300, 'Friend', 'Spencer', 'Hagerty', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8301, 'Friend', 'Woody', 'Cruz', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8302, 'Friend', 'William', 'Buscemi', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8303, 'Friend', 'Juan', 'Bush', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3878, 'Friends', 'Ryan', 'Carlton', to_date('06-02-2021', 'dd-mm-yyyy'), to_date('18-04-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8304, 'Friend', 'Marianne', 'Yorn', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8305, 'Friend', 'King', 'Reeves', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8306, 'Friend', 'Lisa', 'Washington', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8307, 'Friend', 'Thomas', 'Sample', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8308, 'Friend', 'Daryle', 'Richardson', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8309, 'Friend', 'Joe', 'Cummings', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8310, 'Friend', 'Isaac', 'Fehr', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8311, 'Friend', 'Sonny', 'Arden', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8312, 'Friend', 'Wally', 'Gooding', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8313, 'Friend', 'Cathy', 'Parm', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8314, 'Friend', 'Geggy', 'Benoit', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8315, 'Friend', 'Adrien', 'Adler', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8316, 'Friend', 'Joshua', 'Saxon', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8317, 'Friend', 'Uma', 'Miles', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3893, 'Neighbors', 'Nils', 'Ribisi', to_date('19-01-2021', 'dd-mm-yyyy'), to_date('06-08-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3894, 'Work Colleagues', 'Emilio', 'Lewis', to_date('16-05-2021', 'dd-mm-yyyy'), to_date('26-11-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8318, 'Friend', 'Freda', 'Remar', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8319, 'Friend', 'Hal', 'Applegate', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8320, 'Friend', 'Dom', 'Vaughan', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8321, 'Friend', 'Bebe', 'Curfman', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8322, 'Friend', 'Carlene', 'Stoltz', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8323, 'Friend', 'Cevin', 'Shawn', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8324, 'Friend', 'Jody', 'Sainte-Marie', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8325, 'Friend', 'Bob', 'Theron', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8326, 'Friend', 'Alana', 'Haggard', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3904, 'External Invitees', 'Hope', 'Curtis-Hall', to_date('19-03-2021', 'dd-mm-yyyy'), to_date('07-05-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8327, 'Friend', 'Elvis', 'Candy', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3906, 'Neighbors', 'Vincent', 'Michaels', to_date('04-01-2021', 'dd-mm-yyyy'), to_date('04-05-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8328, 'Friend', 'Martin', 'Brickell', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8329, 'Friend', 'Parker', 'Reeves', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8330, 'Friend', 'Jackson', 'Bridges', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8331, 'Friend', 'Danni', 'Wiedlin', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8332, 'Friend', 'Edwin', 'Nolte', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8333, 'Friend', 'Leslie', 'Valentin', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8334, 'Friend', 'Matthew', 'Costello', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8335, 'Friend', 'Kelly', 'Devine', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8336, 'Friend', 'Matthew', 'Sheen', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8337, 'Friend', 'Martha', 'Byrne', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8338, 'Friend', 'Kathy', 'Martin', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8339, 'Friend', 'Melanie', 'Badalucco', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8340, 'Friend', 'Gilbert', 'Weaver', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8341, 'Friend', 'Chi', 'Wen', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8342, 'Friend', 'Carrie', 'Goodman', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8343, 'Friend', 'Leonardo', 'Christie', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8344, 'Friend', 'Carl', 'Rowlands', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8345, 'Friend', 'Fairuza', 'Lerner', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8346, 'Friend', 'Kenneth', 'Evett', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8347, 'Friend', 'Jon', 'Leary', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8348, 'Friend', 'Jet', 'Tomlin', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8150, 'Friend', 'Shirley', 'Derringer', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8151, 'Friend', 'Tyrone', 'Thompson', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8152, 'Friend', 'Belinda', 'Parm', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8153, 'Friend', 'Danny', 'Madonna', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3921, 'Immediate Family', 'Domingo', 'Badalucco', to_date('21-01-2021', 'dd-mm-yyyy'), to_date('24-07-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8154, 'Friend', 'Stockard', 'DeGraw', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8155, 'Friend', 'Buddy', 'Shelton', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3924, 'Friends', 'Julianne', 'Michael', to_date('30-03-2021', 'dd-mm-yyyy'), to_date('07-02-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3925, 'Friends', 'Edward', 'Guest', to_date('10-04-2021', 'dd-mm-yyyy'), to_date('01-12-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8156, 'Friend', 'Colm', 'Levy', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8157, 'Friend', 'Pete', 'Irons', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8158, 'Friend', 'Woody', 'Hampton', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
commit;
prompt 900 records committed...
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8159, 'Friend', 'Tara', 'Sutherland', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8160, 'Friend', 'Carole', 'Thomas', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8161, 'Friend', 'Liquid', 'Balaban', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8162, 'Friend', 'Carlene', 'Bonneville', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8163, 'Friend', 'Robert', 'Giraldo', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8164, 'Friend', 'Juan', 'Arden', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8165, 'Friend', 'Sally', 'LuPone', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8166, 'Friend', 'Daryl', 'Paul', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8167, 'Friend', 'Lionel', 'Voight', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8168, 'Friend', 'Neil', 'Diffie', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8169, 'Friend', 'Geggy', 'Fierstein', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8170, 'Friend', 'Sissy', 'Vicious', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8171, 'Friend', 'Tramaine', 'Dolenz', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8172, 'Friend', 'Ossie', 'Lucas', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3943, 'External Invitees', 'Debi', 'Jones', to_date('30-09-2021', 'dd-mm-yyyy'), to_date('31-07-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8173, 'Friend', 'Charlie', 'Domino', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8174, 'Friend', 'Bobby', 'Harper', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8175, 'Friend', 'First', 'Close', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8176, 'Friend', 'Pelvic', 'Tomlin', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8177, 'Friend', 'Howie', 'Gibbons', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8178, 'Friend', 'Spike', 'Singh', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8179, 'Friend', 'Howie', 'Frampton', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8180, 'Friend', 'Roberta', 'Singh', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8181, 'Friend', 'Stanley', 'Albright', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3953, 'Work Colleagues', 'Billy', 'Chesnutt', to_date('29-11-2021', 'dd-mm-yyyy'), to_date('01-12-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3954, 'Extended Family', 'Tanya', 'Molina', to_date('19-12-2021', 'dd-mm-yyyy'), to_date('03-01-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8182, 'Friend', 'Ali', 'Seagal', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8183, 'Friend', 'Aimee', 'Lloyd', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8184, 'Friend', 'LeVar', 'Posener', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8185, 'Friend', 'Rebeka', 'Makeba', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3959, 'Neighbors', 'Loreena', 'Hannah', to_date('15-07-2021', 'dd-mm-yyyy'), to_date('14-07-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3960, 'Extended Family', 'Taye', 'Bassett', to_date('08-06-2021', 'dd-mm-yyyy'), to_date('05-06-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8186, 'Friend', 'Nickel', 'Weaver', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8187, 'Friend', 'Maury', 'Dempsey', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8188, 'Friend', 'Thora', 'Flatts', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8189, 'Friend', 'George', 'Nolte', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8190, 'Friend', 'Denzel', 'Kinski', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8191, 'Friend', 'Connie', 'Trevino', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8192, 'Friend', 'Ramsey', 'Chandler', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8193, 'Friend', 'Lenny', 'Pressly', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8194, 'Friend', 'Oro', 'Meniketti', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8195, 'Friend', 'Natacha', 'Malone', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8196, 'Friend', 'Marc', 'Wright', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8197, 'Friend', 'Stanley', 'Holbrook', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3973, 'Acquaintances', 'Sydney', 'Ramis', to_date('02-12-2021', 'dd-mm-yyyy'), to_date('01-09-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8198, 'Friend', 'Red', 'Allison', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8199, 'Friend', 'Tim', 'Boone', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8200, 'Friend', 'Franco', 'Everett', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8201, 'Friend', 'Steven', 'Anderson', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8202, 'Friend', 'Chuck', 'Dillane', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8203, 'Friend', 'Clint', 'Rhodes', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8204, 'Friend', 'Ossie', 'Marley', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8205, 'Friend', 'Vin', 'Tobolowsky', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8206, 'Friend', 'Kyra', 'Coverdale', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8207, 'Friend', 'Sona', 'Palmieri', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3984, 'Neighbors', 'Keanu', 'Belles', to_date('05-09-2021', 'dd-mm-yyyy'), to_date('25-09-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8208, 'Friend', 'Joanna', 'Ticotin', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8209, 'Friend', 'Albert', 'Yulin', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8210, 'Friend', 'Bernie', 'Kidman', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8211, 'Friend', 'Fiona', 'Colon', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8212, 'Friend', 'John', 'Glover', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8213, 'Friend', 'Candice', 'Chandler', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8214, 'Friend', 'David', 'Van Der Beek', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8215, 'Friend', 'Eileen', 'Dorn', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3993, 'External Invitees', 'Nikki', 'Smith', to_date('13-08-2021', 'dd-mm-yyyy'), to_date('11-08-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8216, 'Friend', 'Roger', 'Hamilton', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3995, 'External Invitees', 'Arnold', 'Ferrer', to_date('13-08-2021', 'dd-mm-yyyy'), to_date('14-07-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8217, 'Friend', 'Domingo', 'Mitra', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8218, 'Friend', 'Freddy', 'Arkenstone', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8219, 'Friend', 'Rosario', 'Barry', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8220, 'Friend', 'Geoffrey', 'Finney', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8221, 'Friend', 'Trace', 'Li', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8222, 'Friend', 'Glen', 'Evanswood', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8223, 'Friend', 'Terrence', 'Diaz', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (4003, 'Extended Family', 'Graham', 'Day', to_date('17-11-2021', 'dd-mm-yyyy'), to_date('26-05-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8224, 'Friend', 'Freddy', 'Rapaport', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8225, 'Friend', 'Wes', 'Deejay', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8226, 'Friend', 'Luis', 'Roberts', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8227, 'Friend', 'Bridget', 'Leary', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8228, 'Friend', 'Colm', 'Askew', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8229, 'Friend', 'Cameron', 'Shelton', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8230, 'Friend', 'Franco', 'Kapanka', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8231, 'Friend', 'Dave', 'Wells', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8232, 'Friend', 'Debbie', 'Olyphant', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8233, 'Friend', 'Neil', 'Manning', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8234, 'Friend', 'Jeff', 'Randal', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8235, 'Friend', 'Avril', 'McAnally', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8236, 'Friend', 'Crystal', 'Richards', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8237, 'Friend', 'Irene', 'Donelly', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8238, 'Friend', 'Emerson', 'Sample', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8239, 'Friend', 'Carlos', 'Nash', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8240, 'Friend', 'Burt', 'Kahn', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8241, 'Friend', 'Tom', 'Raye', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8242, 'Friend', 'Curt', 'Botti', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8243, 'Friend', 'Davey', 'Cohn', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8244, 'Friend', 'Selma', 'Hatchet', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8245, 'Friend', 'Michael', 'Goldwyn', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8246, 'Friend', 'Eric', 'Richards', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8247, 'Friend', 'Courtney', 'Hackman', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8248, 'Friend', 'Tcheky', 'Boorem', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
commit;
prompt 1000 records committed...
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8249, 'Friend', 'Garland', 'Farina', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8250, 'Friend', 'Bebe', 'Bullock', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8049, 'Friend', 'Pierce', 'Mitra', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8050, 'Friend', 'Murray', 'Jordan', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8051, 'Friend', 'Nathan', 'Crouch', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (4021, 'External Invitees', 'Lara', 'Paige', to_date('10-04-2021', 'dd-mm-yyyy'), to_date('16-11-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8052, 'Friend', 'Shannyn', 'Joli', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8053, 'Friend', 'Nik', 'Bright', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8054, 'Friend', 'Forest', 'Van Helden', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8055, 'Friend', 'Heather', 'Leachman', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8056, 'Friend', 'Emerson', 'Wong', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8057, 'Friend', 'Phil', 'Gandolfini', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8058, 'Friend', 'Terence', 'Firth', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8059, 'Friend', 'Timothy', 'Baker', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8060, 'Friend', 'Clay', 'Blaine', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8061, 'Friend', 'Vonda', 'Cross', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8062, 'Friend', 'Christopher', 'Levy', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8063, 'Friend', 'Bret', 'Lang', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (4034, 'Friends', 'Chet', 'Myers', to_date('25-05-2021', 'dd-mm-yyyy'), to_date('12-04-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (4035, 'Friends', 'Ramsey', 'Applegate', to_date('27-12-2021', 'dd-mm-yyyy'), to_date('09-02-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8064, 'Friend', 'Rachid', 'Wilder', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8065, 'Friend', 'David', 'Goodall', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8066, 'Friend', 'Kenny', 'Leoni', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8067, 'Friend', 'Pelvic', 'Branch', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8068, 'Friend', 'Tcheky', 'Collie', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8069, 'Friend', 'Raul', 'Nugent', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8070, 'Friend', 'Tanya', 'Paquin', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8071, 'Friend', 'Kay', 'Voight', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8072, 'Friend', 'Roberta', 'Sewell', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8073, 'Friend', 'Ashley', 'Milsap', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8074, 'Friend', 'Jimmy', 'Favreau', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8075, 'Friend', 'Katie', 'Mahood', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8076, 'Friend', 'Morgan', 'Conley', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (4049, 'Immediate Family', 'Junior', 'Ponty', to_date('01-02-2021', 'dd-mm-yyyy'), to_date('12-11-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8077, 'Friend', 'Frank', 'Shocked', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8078, 'Friend', 'Chalee', 'Waite', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8079, 'Friend', 'Alannah', 'DiCaprio', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8080, 'Friend', 'Jeremy', 'Azaria', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8081, 'Friend', 'Edie', 'Hubbard', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (4055, 'Extended Family', 'Suzi', 'Williams', to_date('13-09-2021', 'dd-mm-yyyy'), to_date('08-12-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (4056, 'Extended Family', 'Busta', 'Rubinek', to_date('03-07-2021', 'dd-mm-yyyy'), to_date('08-01-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8082, 'Friend', 'Kevin', 'Wong', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8083, 'Friend', 'Cheryl', 'Lynch', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8084, 'Friend', 'Jamie', 'Cleary', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8085, 'Friend', 'Selma', 'Kramer', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8086, 'Friend', 'Gina', 'Wilkinson', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8087, 'Friend', 'Lydia', 'Peet', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8088, 'Friend', 'Albertina', 'Redford', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8089, 'Friend', 'Tanya', 'Kweller', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8090, 'Friend', 'Geoff', 'Boyle', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8091, 'Friend', 'Dean', 'Baez', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8092, 'Friend', 'Hugo', 'Shepherd', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (4068, 'Immediate Family', 'Bradley', 'Biggs', to_date('09-08-2021', 'dd-mm-yyyy'), to_date('24-06-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8093, 'Friend', 'Rebecca', 'Robards', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8094, 'Friend', 'Rickie', 'May', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8095, 'Friend', 'Rosanna', 'Kirkwood', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8096, 'Friend', 'Dar', 'Rawls', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8097, 'Friend', 'Campbell', 'Todd', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8098, 'Friend', 'Gloria', 'Dafoe', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8099, 'Friend', 'Rickie', 'Tsettos', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8100, 'Friend', 'David', 'Lovitz', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (4077, 'Acquaintances', 'Patty', 'Tilly', to_date('17-09-2021', 'dd-mm-yyyy'), to_date('22-11-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8101, 'Friend', 'Junior', 'David', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (4079, 'Extended Family', 'Gailard', 'Sobieski', to_date('03-09-2021', 'dd-mm-yyyy'), to_date('10-09-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8102, 'Friend', 'Mandy', 'Phillips', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8103, 'Friend', 'Rose', 'Paige', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (4082, 'Extended Family', 'Nicholas', 'Arkenstone', to_date('22-02-2021', 'dd-mm-yyyy'), to_date('21-02-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8104, 'Friend', 'Andrea', 'Irons', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8105, 'Friend', 'Carolyn', 'Church', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8106, 'Friend', 'Sara', 'Cazale', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8107, 'Friend', 'Lila', 'Watley', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8108, 'Friend', 'Rhona', 'Elizabeth', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8109, 'Friend', 'Kris', 'Rippy', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8110, 'Friend', 'Ossie', 'Iglesias', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8111, 'Friend', 'Gena', 'Domino', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8112, 'Friend', 'Rosco', 'Tilly', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8113, 'Friend', 'Derek', 'Byrd', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8114, 'Friend', 'Toshiro', 'Rodriguez', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8115, 'Friend', 'Rhea', 'Schiff', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8116, 'Friend', 'Harriet', 'Oszajca', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8117, 'Friend', 'John', 'Quinones', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8118, 'Friend', 'Thin', 'Anderson', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8119, 'Friend', 'Maureen', 'Bedelia', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8120, 'Friend', 'Don', 'Silverman', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (4100, 'Close Friends', 'Rene', 'Tate', to_date('17-04-2021', 'dd-mm-yyyy'), to_date('25-11-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8121, 'Friend', 'Ronnie', 'Bates', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8122, 'Friend', 'Lauren', 'Coe', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (4103, 'External Invitees', 'Christine', 'Biehn', to_date('30-01-2021', 'dd-mm-yyyy'), to_date('31-10-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8123, 'Friend', 'Etta', 'Aykroyd', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8124, 'Friend', 'Larry', 'Addy', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8125, 'Friend', 'Vin', 'Sherman', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8126, 'Friend', 'Richard', 'Saucedo', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (4108, 'Acquaintances', 'Kyle', 'Hector', to_date('27-03-2021', 'dd-mm-yyyy'), to_date('21-12-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8127, 'Friend', 'Machine', 'Sirtis', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8128, 'Friend', 'Fiona', 'Mathis', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8129, 'Friend', 'Gene', 'Mitra', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8130, 'Friend', 'Jeroen', 'Laws', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8131, 'Friend', 'Julio', 'Biel', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8132, 'Friend', 'Daryl', 'Conners', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8133, 'Friend', 'Rene', 'Close', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
commit;
prompt 1100 records committed...
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8134, 'Friend', 'Radney', 'Folds', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8135, 'Friend', 'Neil', 'DiCaprio', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8136, 'Friend', 'Fiona', 'Buffalo', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8137, 'Friend', 'Freddie', 'Steiger', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8138, 'Friend', 'Dave', 'Carlton', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8139, 'Friend', 'Holly', 'Domino', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8140, 'Friend', 'Manu', 'Remar', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8141, 'Friend', 'Patti', 'Davies', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8142, 'Friend', 'Brendan', 'Coyote', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8143, 'Friend', 'Tracy', 'Russell', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8144, 'Friend', 'Swoosie', 'Beckinsale', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8145, 'Friend', 'Harry', 'Derringer', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8146, 'Friend', 'Emilio', 'Lang', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8147, 'Friend', 'Lauren', 'Santa Rosa', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8148, 'Friend', 'Frances', 'Tyson', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8149, 'Friend', 'Parker', 'Tah', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (4126, 'External Invitees', 'Curtis', 'Scheider', to_date('30-11-2021', 'dd-mm-yyyy'), to_date('23-05-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (4127, 'Extended Family', 'Lucy', 'Pepper', to_date('05-12-2021', 'dd-mm-yyyy'), to_date('26-08-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (4129, 'Close Friends', 'Cherry', 'Sanders', to_date('28-07-2021', 'dd-mm-yyyy'), to_date('22-06-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (4132, 'Acquaintances', 'Cyndi', 'Mould', to_date('19-01-2021', 'dd-mm-yyyy'), to_date('05-06-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (4142, 'Immediate Family', 'Robby', 'Margulies', to_date('04-08-2021', 'dd-mm-yyyy'), to_date('14-02-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (4144, 'Friends', 'Wang', 'Mahoney', to_date('03-07-2021', 'dd-mm-yyyy'), to_date('10-01-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (4152, 'Extended Family', 'Cuba', 'McCready', to_date('01-05-2021', 'dd-mm-yyyy'), to_date('30-11-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (4153, 'Acquaintances', 'Giancarlo', 'Reiner', to_date('15-09-2021', 'dd-mm-yyyy'), to_date('26-05-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (4165, 'Neighbors', 'Katrin', 'Milsap', to_date('11-11-2021', 'dd-mm-yyyy'), to_date('17-05-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8000, 'Friend', 'Jonatha', 'Thornton', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8001, 'Friend', 'Kevin', 'Kweller', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8002, 'Friend', 'Ed', 'Coward', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8003, 'Friend', 'Pelvic', 'Cook', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8004, 'Friend', 'Alfie', 'Logue', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8005, 'Friend', 'Chloe', 'Joli', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8006, 'Friend', 'Katrin', 'Patillo', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8007, 'Friend', 'Morris', 'Rawls', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (4183, 'Immediate Family', 'Marisa', 'Watson', to_date('28-04-2021', 'dd-mm-yyyy'), to_date('05-05-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8008, 'Friend', 'Charlie', 'Zahn', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (4185, 'Immediate Family', 'Gailard', 'Brando', to_date('21-08-2021', 'dd-mm-yyyy'), to_date('14-05-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (4186, 'Friends', 'Jesse', 'Lonsdale', to_date('20-12-2021', 'dd-mm-yyyy'), to_date('16-06-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8009, 'Friend', 'Jean', 'Shand', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (4188, 'Extended Family', 'Stockard', 'Eastwood', to_date('07-09-2021', 'dd-mm-yyyy'), to_date('04-05-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8010, 'Friend', 'Curt', 'Flanagan', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8011, 'Friend', 'Rueben', 'Diehl', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8012, 'Friend', 'Diane', 'Hedaya', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (4192, 'Acquaintances', 'Victor', 'Rush', to_date('08-03-2021', 'dd-mm-yyyy'), to_date('05-10-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8013, 'Friend', 'Willem', 'Fiorentino', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (4194, 'External Invitees', 'Ron', 'Hornsby', to_date('01-01-2021', 'dd-mm-yyyy'), to_date('20-02-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8014, 'Friend', 'Winona', 'Ali', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (4196, 'Neighbors', 'Goran', 'Marx', to_date('28-06-2021', 'dd-mm-yyyy'), to_date('10-11-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8015, 'Friend', 'Ice', 'McKellen', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8016, 'Friend', 'Humberto', 'Hedaya', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8017, 'Friend', 'Xander', 'Carrere', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8018, 'Friend', 'Brendan', 'Lavigne', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (4201, 'Close Friends', 'Carl', 'Michaels', to_date('10-04-2021', 'dd-mm-yyyy'), to_date('15-04-2021', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8019, 'Friend', 'Jena', 'Wiest', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8020, 'Friend', 'Cameron', 'Morse', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8021, 'Friend', 'Robbie', 'Lapointe', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8022, 'Friend', 'Veruca', 'Phoenix', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8023, 'Friend', 'Kim', 'Cromwell', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8024, 'Friend', 'Vickie', 'Carmen', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8025, 'Friend', 'Michael', 'Adams', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8026, 'Friend', 'Vanessa', 'Chapman', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8027, 'Friend', 'Joey', 'DeLuise', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8028, 'Friend', 'Emerson', 'Sartain', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8029, 'Friend', 'Gerald', 'Berry', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8030, 'Friend', 'Ben', 'Janssen', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8031, 'Friend', 'Walter', 'McDowell', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8032, 'Friend', 'Sophie', 'Silverman', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8033, 'Friend', 'Terry', 'Hedaya', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8034, 'Friend', 'Lynette', 'Quinn', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8035, 'Friend', 'Hector', 'Root', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8036, 'Friend', 'Nicole', 'Chapman', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8037, 'Friend', 'Howard', 'Holmes', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8038, 'Friend', 'Rolando', 'Biggs', to_date('04-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8039, 'Friend', 'Embeth', 'Quatro', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8040, 'Friend', 'Larnelle', 'Sedgwick', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8041, 'Friend', 'Howard', 'Paymer', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8042, 'Friend', 'Morris', 'Tolkan', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8043, 'Friend', 'Domingo', 'Douglas', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8044, 'Friend', 'Natascha', 'Lizzy', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8045, 'Friend', 'Sheena', 'Greenwood', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8046, 'Friend', 'Keith', 'Lithgow', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8047, 'Friend', 'Kim', 'Kadison', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (8048, 'Friend', 'Miles', 'Alda', to_date('01-04-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 'Confirmed', 2000, 1172);
commit;
prompt 1182 records loaded
prompt Loading HAS_CATERING...
insert into HAS_CATERING (cateringid, eventid)
values (1, 2158);
insert into HAS_CATERING (cateringid, eventid)
values (1, 2186);
insert into HAS_CATERING (cateringid, eventid)
values (1, 2228);
insert into HAS_CATERING (cateringid, eventid)
values (1, 2249);
insert into HAS_CATERING (cateringid, eventid)
values (1, 2296);
insert into HAS_CATERING (cateringid, eventid)
values (1, 2310);
insert into HAS_CATERING (cateringid, eventid)
values (1, 2355);
insert into HAS_CATERING (cateringid, eventid)
values (1, 2386);
insert into HAS_CATERING (cateringid, eventid)
values (2, 2013);
insert into HAS_CATERING (cateringid, eventid)
values (2, 2333);
insert into HAS_CATERING (cateringid, eventid)
values (2, 2397);
insert into HAS_CATERING (cateringid, eventid)
values (3, 2062);
insert into HAS_CATERING (cateringid, eventid)
values (3, 2158);
insert into HAS_CATERING (cateringid, eventid)
values (3, 2177);
insert into HAS_CATERING (cateringid, eventid)
values (3, 2195);
insert into HAS_CATERING (cateringid, eventid)
values (3, 2305);
insert into HAS_CATERING (cateringid, eventid)
values (3, 2342);
insert into HAS_CATERING (cateringid, eventid)
values (4, 2073);
insert into HAS_CATERING (cateringid, eventid)
values (4, 2115);
insert into HAS_CATERING (cateringid, eventid)
values (4, 2256);
insert into HAS_CATERING (cateringid, eventid)
values (4, 2330);
insert into HAS_CATERING (cateringid, eventid)
values (5, 2214);
insert into HAS_CATERING (cateringid, eventid)
values (5, 2336);
insert into HAS_CATERING (cateringid, eventid)
values (5, 2347);
insert into HAS_CATERING (cateringid, eventid)
values (6, 2129);
insert into HAS_CATERING (cateringid, eventid)
values (6, 2152);
insert into HAS_CATERING (cateringid, eventid)
values (6, 2214);
insert into HAS_CATERING (cateringid, eventid)
values (7, 2021);
insert into HAS_CATERING (cateringid, eventid)
values (7, 2298);
insert into HAS_CATERING (cateringid, eventid)
values (7, 2302);
insert into HAS_CATERING (cateringid, eventid)
values (7, 2321);
insert into HAS_CATERING (cateringid, eventid)
values (8, 2195);
insert into HAS_CATERING (cateringid, eventid)
values (8, 2218);
insert into HAS_CATERING (cateringid, eventid)
values (8, 2317);
insert into HAS_CATERING (cateringid, eventid)
values (9, 2087);
insert into HAS_CATERING (cateringid, eventid)
values (9, 2140);
insert into HAS_CATERING (cateringid, eventid)
values (9, 2240);
insert into HAS_CATERING (cateringid, eventid)
values (10, 2216);
insert into HAS_CATERING (cateringid, eventid)
values (11, 2159);
insert into HAS_CATERING (cateringid, eventid)
values (11, 2234);
insert into HAS_CATERING (cateringid, eventid)
values (11, 2331);
insert into HAS_CATERING (cateringid, eventid)
values (11, 2382);
insert into HAS_CATERING (cateringid, eventid)
values (12, 2095);
insert into HAS_CATERING (cateringid, eventid)
values (12, 2135);
insert into HAS_CATERING (cateringid, eventid)
values (12, 2396);
insert into HAS_CATERING (cateringid, eventid)
values (13, 2113);
insert into HAS_CATERING (cateringid, eventid)
values (13, 2257);
insert into HAS_CATERING (cateringid, eventid)
values (13, 2389);
insert into HAS_CATERING (cateringid, eventid)
values (14, 2065);
insert into HAS_CATERING (cateringid, eventid)
values (14, 2280);
insert into HAS_CATERING (cateringid, eventid)
values (15, 2021);
insert into HAS_CATERING (cateringid, eventid)
values (16, 2003);
insert into HAS_CATERING (cateringid, eventid)
values (16, 2008);
insert into HAS_CATERING (cateringid, eventid)
values (16, 2344);
insert into HAS_CATERING (cateringid, eventid)
values (17, 2071);
insert into HAS_CATERING (cateringid, eventid)
values (17, 2148);
insert into HAS_CATERING (cateringid, eventid)
values (18, 2185);
insert into HAS_CATERING (cateringid, eventid)
values (18, 2208);
insert into HAS_CATERING (cateringid, eventid)
values (18, 2365);
insert into HAS_CATERING (cateringid, eventid)
values (19, 2058);
insert into HAS_CATERING (cateringid, eventid)
values (20, 2024);
insert into HAS_CATERING (cateringid, eventid)
values (20, 2060);
insert into HAS_CATERING (cateringid, eventid)
values (20, 2104);
insert into HAS_CATERING (cateringid, eventid)
values (20, 2179);
insert into HAS_CATERING (cateringid, eventid)
values (21, 2215);
insert into HAS_CATERING (cateringid, eventid)
values (21, 2291);
insert into HAS_CATERING (cateringid, eventid)
values (21, 2333);
insert into HAS_CATERING (cateringid, eventid)
values (21, 2357);
insert into HAS_CATERING (cateringid, eventid)
values (21, 2358);
insert into HAS_CATERING (cateringid, eventid)
values (22, 2057);
insert into HAS_CATERING (cateringid, eventid)
values (22, 2137);
insert into HAS_CATERING (cateringid, eventid)
values (22, 2265);
insert into HAS_CATERING (cateringid, eventid)
values (23, 2208);
insert into HAS_CATERING (cateringid, eventid)
values (23, 2307);
insert into HAS_CATERING (cateringid, eventid)
values (24, 2049);
insert into HAS_CATERING (cateringid, eventid)
values (24, 2054);
insert into HAS_CATERING (cateringid, eventid)
values (24, 2064);
insert into HAS_CATERING (cateringid, eventid)
values (24, 2087);
insert into HAS_CATERING (cateringid, eventid)
values (24, 2169);
insert into HAS_CATERING (cateringid, eventid)
values (24, 2189);
insert into HAS_CATERING (cateringid, eventid)
values (24, 2274);
insert into HAS_CATERING (cateringid, eventid)
values (25, 2107);
insert into HAS_CATERING (cateringid, eventid)
values (25, 2122);
insert into HAS_CATERING (cateringid, eventid)
values (25, 2299);
insert into HAS_CATERING (cateringid, eventid)
values (26, 2168);
insert into HAS_CATERING (cateringid, eventid)
values (26, 2208);
insert into HAS_CATERING (cateringid, eventid)
values (26, 2313);
insert into HAS_CATERING (cateringid, eventid)
values (27, 2139);
insert into HAS_CATERING (cateringid, eventid)
values (27, 2234);
insert into HAS_CATERING (cateringid, eventid)
values (28, 2112);
insert into HAS_CATERING (cateringid, eventid)
values (28, 2125);
insert into HAS_CATERING (cateringid, eventid)
values (28, 2295);
insert into HAS_CATERING (cateringid, eventid)
values (29, 2358);
insert into HAS_CATERING (cateringid, eventid)
values (30, 2251);
insert into HAS_CATERING (cateringid, eventid)
values (30, 2294);
insert into HAS_CATERING (cateringid, eventid)
values (1000, 2022);
insert into HAS_CATERING (cateringid, eventid)
values (1000, 2070);
insert into HAS_CATERING (cateringid, eventid)
values (2000, 2108);
insert into HAS_CATERING (cateringid, eventid)
values (2000, 2286);
insert into HAS_CATERING (cateringid, eventid)
values (2000, 2319);
commit;
prompt 100 records loaded
prompt Loading PAYMENTS...
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4000, 9123.24, to_date('07-12-1914', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1373, 2087);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4001, 32552.32, to_date('12-06-2002', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1061, 2005);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4002, 5585.25, to_date('16-01-1964', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1332, 2127);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4003, 19456.69, to_date('30-01-1905', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1302, 2032);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4004, 28126.09, to_date('20-04-1932', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1316, 2147);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4005, 22085.99, to_date('16-06-1904', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1269, 2206);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4006, 33248.29, to_date('01-09-2023', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1235, 2296);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4007, 27550.07, to_date('14-03-1992', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1158, 2362);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4008, 47388.65, to_date('31-03-2014', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1250, 2090);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4009, 32245, to_date('16-12-1952', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1280, 2027);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4010, 17105.12, to_date('14-10-1984', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1020, 2071);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4011, 24538.56, to_date('18-12-1998', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1011, 2385);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4012, 12543.6, to_date('08-08-2021', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1321, 2272);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4013, 26518.35, to_date('27-10-1974', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1270, 2258);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4014, 39967.24, to_date('19-10-1987', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1179, 2322);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4015, 14802.27, to_date('11-09-2007', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1321, 2124);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4016, 48348.25, to_date('05-11-1989', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1340, 2368);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4017, 35411.63, to_date('22-09-1977', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1103, 2150);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4018, 40022.15, to_date('06-06-1914', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1261, 2025);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4019, 17706.66, to_date('02-11-1933', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1080, 2253);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4020, 15404.62, to_date('19-08-1910', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1218, 2148);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4021, 7384.55, to_date('24-10-1954', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1216, 2191);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4022, 21770.79, to_date('06-06-1942', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1155, 2236);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4023, 8540.04, to_date('02-09-1955', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1082, 2070);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4024, 36097, to_date('25-06-1911', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1039, 2251);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4025, 19788.42, to_date('25-05-1939', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1083, 2085);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4026, 41965.12, to_date('04-04-1975', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1160, 2071);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4027, 39451.09, to_date('15-12-1943', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1206, 2275);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4028, 30529.35, to_date('15-06-1935', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1136, 2160);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4029, 39803.63, to_date('18-08-1934', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1300, 2320);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4030, 15545.53, to_date('02-10-1946', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1261, 2273);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4031, 45386.32, to_date('29-08-2016', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1280, 2143);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4032, 17462.91, to_date('09-11-1920', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1365, 2177);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4033, 45377.2, to_date('16-03-1968', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1253, 2151);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4034, 16578.43, to_date('11-11-2000', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1205, 2397);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4035, 10027.61, to_date('16-08-1968', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1168, 2297);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4036, 10253.6, to_date('05-12-1980', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1181, 2197);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4037, 11160.23, to_date('17-01-2022', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1197, 2367);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4038, 39193.69, to_date('13-04-1921', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1375, 2375);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4039, 41729.66, to_date('07-04-1951', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1235, 2290);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4040, 47789.6, to_date('07-07-1958', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1315, 2087);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4041, 29445.43, to_date('20-12-1961', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1128, 2074);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4042, 28522.14, to_date('07-03-1936', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1266, 2098);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4043, 44457.56, to_date('29-03-1902', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1227, 2170);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4044, 45428.81, to_date('05-10-1980', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1044, 2055);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4045, 26104.61, to_date('30-05-1967', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1262, 2261);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4046, 46633.1, to_date('13-11-2022', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1157, 2188);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4047, 18724.23, to_date('04-03-1975', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1146, 2066);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4048, 5936.33, to_date('23-10-2013', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1069, 2231);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4049, 16526.19, to_date('27-01-1961', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1305, 2184);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4050, 33471.89, to_date('22-06-1962', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1391, 2374);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4051, 47527.94, to_date('13-04-1969', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1324, 2152);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4052, 5422.04, to_date('22-06-1917', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1193, 2236);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4053, 46552.67, to_date('25-08-1913', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1332, 2135);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4054, 17797.25, to_date('03-09-2019', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1247, 2266);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4055, 12289.83, to_date('19-02-2009', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1297, 2232);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4056, 44277.99, to_date('11-12-1999', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1190, 2364);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4057, 43418.18, to_date('28-06-2023', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1060, 2219);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4058, 13118.96, to_date('29-04-1997', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1014, 2132);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4059, 28791.37, to_date('16-04-1974', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1083, 2107);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4060, 33115.98, to_date('08-06-1947', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1282, 2350);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4061, 26685.93, to_date('13-04-2021', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1125, 2329);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4062, 48635.23, to_date('14-03-1916', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1268, 2071);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4063, 28111.88, to_date('30-12-1928', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1251, 2355);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4064, 48705.06, to_date('06-12-2003', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1018, 2149);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4065, 49185.74, to_date('04-10-1974', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1154, 2122);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4066, 20170.27, to_date('25-08-1944', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1346, 2387);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4067, 12566.06, to_date('23-11-1926', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1006, 2304);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4068, 49908.96, to_date('25-10-1900', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1343, 2310);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4069, 47951.53, to_date('18-05-1968', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1041, 2192);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4070, 36111.76, to_date('15-04-1953', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1022, 2367);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4071, 41641.44, to_date('05-09-1940', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1053, 2008);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4072, 43623.67, to_date('14-08-1911', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1078, 2352);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4073, 10158.82, to_date('03-01-1908', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1025, 2045);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4074, 43348.35, to_date('10-09-1944', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1381, 2256);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4075, 37935.9, to_date('22-10-1916', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1280, 2221);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4076, 25714.91, to_date('23-08-1906', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1390, 2338);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4077, 49062.23, to_date('12-08-1950', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1360, 2075);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4078, 38207.19, to_date('02-02-1983', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1294, 2028);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4079, 43095.18, to_date('06-03-1955', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1228, 2372);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4080, 11955.59, to_date('10-09-1907', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1074, 2049);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4081, 29933, to_date('10-12-1933', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1195, 2342);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4082, 7391.37, to_date('11-01-1999', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1094, 2166);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4083, 23750.37, to_date('23-10-1988', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1371, 2141);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4084, 23963.39, to_date('02-10-2017', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1019, 2162);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4085, 5996.44, to_date('22-03-1931', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1044, 2139);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4086, 48917.48, to_date('01-02-1969', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1050, 2033);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4087, 37455.4, to_date('23-07-1963', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1184, 2232);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4088, 30138.19, to_date('28-08-1975', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1092, 2220);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4089, 24369.49, to_date('02-11-1930', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1266, 2376);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4090, 43053.09, to_date('21-07-1970', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1043, 2249);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4091, 38624.57, to_date('07-10-2017', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1226, 2351);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4092, 21599.6, to_date('21-10-1960', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1007, 2213);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4093, 21998.17, to_date('12-01-2016', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1336, 2349);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4094, 43254.24, to_date('06-02-1986', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1038, 2267);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4095, 44470.03, to_date('22-12-1911', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1209, 2380);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4096, 43124.47, to_date('03-11-2022', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1201, 2151);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4097, 36595.12, to_date('23-07-1919', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1123, 2116);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4098, 37102.94, to_date('30-06-1958', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1163, 2343);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4099, 30939.25, to_date('11-08-1958', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1275, 2349);
commit;
prompt 100 records committed...
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4100, 44084.35, to_date('24-04-2011', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1311, 2034);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4101, 12577.07, to_date('05-06-1953', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1361, 2076);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4102, 22244.69, to_date('08-04-1970', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1384, 2320);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4103, 8652.6, to_date('30-08-1951', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1273, 2015);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4104, 44383.05, to_date('27-05-2005', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1047, 2235);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4105, 12002.35, to_date('15-07-1938', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1330, 2137);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4106, 37325.95, to_date('29-05-1923', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1175, 2393);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4107, 8840.77, to_date('16-05-1971', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1229, 2034);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4108, 30394.09, to_date('03-08-1993', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1070, 2269);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4109, 20508.4, to_date('25-05-2009', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1324, 2099);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4110, 12931.67, to_date('21-01-1969', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1199, 2291);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4111, 24282.31, to_date('03-12-1938', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1026, 2340);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4112, 30898.2, to_date('02-05-1928', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1062, 2371);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4113, 23249.25, to_date('16-10-1918', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1133, 2021);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4114, 27522.78, to_date('07-03-1937', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1379, 2049);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4115, 40241.12, to_date('19-02-1921', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1278, 2116);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4116, 13020.87, to_date('15-10-1905', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1006, 2270);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4117, 35833.05, to_date('28-06-1967', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1312, 2202);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4118, 23373.66, to_date('10-04-2016', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1374, 2384);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4119, 20403.95, to_date('23-02-1935', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1002, 2168);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4120, 48169.79, to_date('17-06-1970', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1256, 2365);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4121, 45259.54, to_date('29-11-1933', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1260, 2354);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4122, 17509.7, to_date('09-01-1933', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1055, 2268);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4123, 27817.9, to_date('03-02-2003', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1295, 2107);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4124, 27972.39, to_date('26-11-1919', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1019, 2098);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4125, 40857.55, to_date('02-11-2003', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1293, 2375);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4126, 42644.75, to_date('14-01-2007', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1380, 2108);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4127, 30827.94, to_date('18-10-1956', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1012, 2315);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4128, 10213.33, to_date('02-06-1984', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1222, 2329);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4129, 45222.54, to_date('26-01-1950', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1119, 2330);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4130, 43118.64, to_date('24-06-1955', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1267, 2114);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4131, 24014.36, to_date('24-06-1992', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1236, 2328);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4132, 24771.97, to_date('26-09-2006', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1393, 2115);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4133, 10154.04, to_date('23-02-1937', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1116, 2016);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4134, 40834.67, to_date('20-10-1947', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1272, 2280);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4135, 14130.33, to_date('01-06-1975', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1353, 2005);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4136, 14559.93, to_date('09-09-1996', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1333, 2280);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4137, 27593.21, to_date('07-01-1951', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1202, 2149);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4138, 31197.12, to_date('30-05-1910', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1259, 2356);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4139, 6039.36, to_date('21-08-1994', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1133, 2306);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4140, 46458.54, to_date('03-12-1935', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1192, 2193);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4141, 45560.29, to_date('20-09-1978', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1313, 2328);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4142, 14048.75, to_date('09-05-1956', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1282, 2223);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4143, 33652.81, to_date('15-08-1917', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1200, 2067);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4144, 27256.36, to_date('27-07-1957', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1144, 2143);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4145, 34092.13, to_date('29-01-1938', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1078, 2218);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4146, 24608.3, to_date('07-01-1940', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1255, 2269);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4147, 10867.38, to_date('21-12-1944', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1106, 2374);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4148, 49586.67, to_date('06-12-1900', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1062, 2110);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4149, 16179.68, to_date('30-05-1982', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1094, 2319);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4150, 29407.98, to_date('22-10-2011', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1028, 2165);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4151, 32502.66, to_date('11-02-1915', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1010, 2137);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4152, 17864.99, to_date('12-03-1991', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1392, 2147);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4153, 8705.51, to_date('01-03-1930', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1000, 2348);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4154, 47230.97, to_date('29-10-1922', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1262, 2036);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4155, 45238.54, to_date('24-12-1983', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1350, 2070);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4156, 39226.55, to_date('24-01-2019', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1229, 2349);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4157, 8381.25, to_date('30-08-1944', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1154, 2006);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4158, 45048.95, to_date('04-08-1954', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1105, 2041);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4159, 13552.81, to_date('03-09-1929', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1321, 2258);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4160, 49463.82, to_date('07-07-2020', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1192, 2031);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4161, 22685.17, to_date('03-10-1963', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1103, 2159);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4162, 13959.54, to_date('09-09-1973', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1068, 2345);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4163, 40658.58, to_date('18-03-1957', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1346, 2139);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4164, 23963.99, to_date('06-06-1956', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1101, 2100);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4165, 10799.63, to_date('05-07-2004', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1266, 2010);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4166, 45123.88, to_date('25-06-1986', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1094, 2294);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4167, 39441.82, to_date('26-02-2003', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1153, 2077);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4168, 8646.49, to_date('28-04-2017', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1245, 2235);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4169, 49548.58, to_date('29-11-1967', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1001, 2276);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4170, 45704.04, to_date('14-10-1943', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1041, 2391);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4171, 33398.85, to_date('27-04-1915', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1053, 2134);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4172, 15900.45, to_date('27-12-1927', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1267, 2059);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4173, 49335.09, to_date('17-07-1943', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1086, 2360);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4174, 39800.61, to_date('26-07-1920', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1152, 2270);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4175, 7573.85, to_date('26-06-2007', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1208, 2049);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4176, 10522.24, to_date('26-03-2002', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1030, 2311);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4177, 10078.82, to_date('11-04-2014', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1390, 2329);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4178, 19390.13, to_date('16-08-1920', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1331, 2273);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4179, 29496.35, to_date('11-01-1989', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1313, 2012);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4180, 30652.97, to_date('08-07-1947', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1098, 2028);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4181, 7153.53, to_date('11-12-1935', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1351, 2089);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4182, 20262.63, to_date('11-04-1931', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1221, 2223);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4183, 10118.72, to_date('05-09-2019', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1067, 2236);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4184, 38715.96, to_date('07-09-1919', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1207, 2113);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4185, 42324.59, to_date('22-01-1942', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1248, 2156);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4186, 17959.1, to_date('17-01-1978', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1071, 2200);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4187, 49753.68, to_date('20-02-2014', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1049, 2137);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4188, 42354.26, to_date('14-08-1952', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1145, 2115);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4189, 29686.46, to_date('22-06-1923', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1079, 2038);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4190, 48709.02, to_date('10-05-1929', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1022, 2114);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4191, 19011.83, to_date('27-10-1946', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1194, 2304);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4192, 35368.14, to_date('14-12-2012', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1220, 2202);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4193, 6600.22, to_date('26-01-1983', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1033, 2202);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4194, 15367.85, to_date('19-03-1926', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1173, 2084);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4195, 39739.09, to_date('08-07-1906', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1265, 2079);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4196, 28652.62, to_date('25-09-1929', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1142, 2336);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4197, 29631.03, to_date('19-06-1990', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1169, 2054);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4198, 33354.51, to_date('21-11-1936', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1260, 2009);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4199, 20954.25, to_date('31-01-1901', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1333, 2327);
commit;
prompt 200 records committed...
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4200, 36134.92, to_date('18-02-1949', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1292, 2248);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4201, 25485.66, to_date('04-09-2011', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1086, 2315);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4202, 11588.91, to_date('14-08-1936', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1130, 2345);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4203, 49786.43, to_date('18-02-1912', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1047, 2215);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4204, 15712, to_date('13-02-1914', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1202, 2212);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4205, 46950, to_date('29-10-1988', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1202, 2191);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4206, 43429.44, to_date('13-04-1962', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1218, 2080);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4207, 17412.64, to_date('18-09-1949', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1311, 2384);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4208, 35188.04, to_date('27-02-1944', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1228, 2223);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4209, 33826.51, to_date('29-10-1919', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1228, 2152);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4210, 32610.45, to_date('01-02-1917', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1018, 2308);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4211, 9995.2, to_date('07-01-1982', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1160, 2127);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4212, 33211.96, to_date('16-11-1989', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1022, 2369);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4213, 23871.77, to_date('20-01-1913', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1041, 2307);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4214, 39179.79, to_date('09-04-2000', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1162, 2206);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4215, 24619.31, to_date('14-01-1990', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1034, 2162);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4216, 30214.89, to_date('11-10-2012', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1213, 2009);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4217, 48733.96, to_date('23-01-1992', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1161, 2375);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4218, 40436.26, to_date('09-10-2011', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1093, 2206);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4219, 45230.51, to_date('13-04-2022', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1253, 2205);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4220, 24347.7, to_date('29-11-1914', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1077, 2142);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4221, 29890.36, to_date('22-03-1900', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1227, 2067);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4222, 6867.15, to_date('30-11-1906', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1140, 2373);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4223, 28572.18, to_date('13-06-1999', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1291, 2151);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4224, 22418.47, to_date('29-07-1968', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1016, 2191);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4225, 34584.85, to_date('23-06-1905', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1269, 2254);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4226, 23085.73, to_date('20-02-1976', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1393, 2377);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4227, 25123.08, to_date('11-02-2019', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1054, 2044);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4228, 25830.03, to_date('26-12-1995', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1027, 2370);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4229, 36765.42, to_date('22-12-1979', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1385, 2145);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4230, 48768.75, to_date('13-08-2024', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1379, 2271);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4231, 30034.8, to_date('04-06-1910', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1352, 2052);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4232, 16517.41, to_date('18-12-1923', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1184, 2064);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4233, 38021.64, to_date('10-10-1979', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1017, 2063);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4234, 39593.91, to_date('31-12-1926', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1336, 2065);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4235, 14069.3, to_date('13-10-1913', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1174, 2045);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4236, 32885.38, to_date('29-08-1963', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1309, 2200);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4237, 8522.2, to_date('14-07-1949', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1022, 2218);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4238, 23177.43, to_date('31-01-1932', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1089, 2099);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4239, 44536.35, to_date('14-07-1985', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1367, 2368);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4240, 20745.95, to_date('08-03-1915', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1047, 2026);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4241, 7952.39, to_date('16-03-1927', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1351, 2283);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4242, 40011.46, to_date('30-06-1967', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1324, 2221);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4243, 46231.13, to_date('24-08-1977', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1105, 2216);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4244, 44255.83, to_date('06-05-1972', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1144, 2283);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4245, 36451.61, to_date('16-09-1998', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1123, 2170);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4246, 39401.66, to_date('16-05-1944', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1262, 2160);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4247, 12371.63, to_date('29-05-1942', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1169, 2010);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4248, 46853.98, to_date('20-04-1902', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1118, 2382);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4249, 20550.83, to_date('15-08-1977', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1099, 2002);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4250, 45404.65, to_date('28-01-1937', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1136, 2302);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4251, 35536.2, to_date('11-02-1937', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1219, 2171);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4252, 17199.07, to_date('11-04-1975', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1335, 2378);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4253, 24110.15, to_date('17-11-1959', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1358, 2092);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4254, 7765.54, to_date('10-11-1987', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1068, 2065);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4255, 23601.05, to_date('04-10-1953', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1071, 2296);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4256, 20107, to_date('21-03-2019', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1087, 2144);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4257, 9256.28, to_date('11-06-2003', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1370, 2114);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4258, 12855.4, to_date('17-07-1911', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1137, 2271);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4259, 45677.74, to_date('14-09-1973', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1171, 2331);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4260, 47488.41, to_date('05-07-1974', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1064, 2149);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4261, 47319.99, to_date('01-01-1933', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1274, 2280);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4262, 44608.79, to_date('30-03-1975', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1061, 2329);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4263, 48050.68, to_date('21-05-2022', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1068, 2149);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4264, 49286.14, to_date('24-08-1948', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1029, 2231);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4265, 34773.69, to_date('01-09-2019', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1153, 2117);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4266, 15461.24, to_date('04-01-1953', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1069, 2198);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4267, 20114.62, to_date('26-12-1973', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1095, 2322);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4268, 9412.79, to_date('07-12-2020', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1095, 2369);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4269, 39168.88, to_date('16-08-1910', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1104, 2039);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4270, 22286.75, to_date('23-07-1930', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1176, 2375);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4271, 25312.18, to_date('23-02-1981', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1236, 2098);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4272, 21688.15, to_date('23-02-1922', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1398, 2266);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4273, 15073.65, to_date('13-11-1933', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1320, 2120);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4274, 17335.33, to_date('04-12-1984', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1258, 2259);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4275, 7071.32, to_date('16-08-1904', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1208, 2176);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4276, 5776.77, to_date('05-04-1964', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1374, 2114);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4277, 15010.21, to_date('08-11-1902', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1358, 2076);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4278, 19170.41, to_date('03-03-1989', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1128, 2132);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4279, 44742.86, to_date('01-01-1993', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1332, 2279);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4280, 8125.41, to_date('06-02-1970', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1031, 2179);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4281, 40392.37, to_date('17-03-1921', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1022, 2033);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4282, 8606.45, to_date('22-01-1917', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1011, 2335);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4283, 24537.96, to_date('11-05-1937', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1008, 2333);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4284, 7900.55, to_date('16-01-1953', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1028, 2368);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4285, 27463.02, to_date('24-05-1937', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1231, 2108);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4286, 49646.36, to_date('07-10-2022', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1215, 2036);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4287, 30465.64, to_date('21-12-1925', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1194, 2035);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4288, 37925.92, to_date('16-09-1921', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1145, 2208);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4289, 13231.67, to_date('02-06-1924', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1295, 2377);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4290, 5419.02, to_date('10-07-2020', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1014, 2014);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4291, 15270.26, to_date('01-01-1949', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1275, 2038);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4292, 35619.95, to_date('25-08-1934', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1163, 2020);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4293, 31411.93, to_date('06-07-1934', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1395, 2056);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4294, 19116.81, to_date('11-05-2014', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1115, 2227);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4295, 11369.06, to_date('03-03-1978', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1142, 2314);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4296, 8933.31, to_date('06-01-1905', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1338, 2095);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4297, 8359.01, to_date('24-10-1903', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1053, 2275);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4298, 49933.06, to_date('27-09-1927', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1337, 2192);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4299, 26789.6, to_date('14-06-2021', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1268, 2142);
commit;
prompt 300 records committed...
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4300, 22286.39, to_date('11-04-1905', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1271, 2267);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4301, 19007.22, to_date('22-01-1957', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1208, 2049);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4302, 38999.61, to_date('17-04-1933', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1087, 2154);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4303, 31107.31, to_date('07-10-1927', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1178, 2071);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4304, 47506.83, to_date('20-11-1971', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1190, 2290);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4305, 47807.47, to_date('12-04-1962', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1092, 2259);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4306, 30324.25, to_date('22-06-2007', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1031, 2268);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4307, 31382.97, to_date('02-09-1941', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1128, 2303);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4308, 39766.96, to_date('17-12-1909', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1221, 2211);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4309, 19664.78, to_date('19-06-1960', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1105, 2021);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4310, 21728.25, to_date('01-04-1985', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1172, 2169);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4311, 13100.19, to_date('12-01-2008', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1382, 2266);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4312, 13521.36, to_date('01-01-1973', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1062, 2347);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4313, 10875.77, to_date('14-04-1970', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1289, 2266);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4314, 40783.85, to_date('21-10-1989', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1325, 2150);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4315, 16102.96, to_date('20-09-1951', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1080, 2186);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4316, 28444.34, to_date('21-07-1917', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1264, 2060);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4317, 10066.14, to_date('26-09-1917', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1005, 2112);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4318, 40751.8, to_date('23-03-1987', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1192, 2334);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4319, 30533.11, to_date('19-04-1907', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1119, 2266);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4320, 40367.41, to_date('23-11-1932', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1298, 2129);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4321, 39128.22, to_date('15-11-1940', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1004, 2040);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4322, 21518.79, to_date('27-02-1966', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1234, 2252);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4323, 27767.83, to_date('21-09-1998', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1026, 2260);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4324, 22216.83, to_date('28-09-1945', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1234, 2330);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4325, 49158.43, to_date('17-06-1944', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1108, 2270);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4326, 15535, to_date('18-07-1992', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1150, 2014);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4327, 36357.14, to_date('29-12-2018', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1033, 2246);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4328, 39951.1, to_date('29-11-1924', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1019, 2204);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4329, 41394.78, to_date('03-09-1904', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1077, 2332);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4330, 28751.59, to_date('10-04-2014', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1151, 2291);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4331, 37961.43, to_date('18-11-1984', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1352, 2202);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4332, 13498.4, to_date('14-01-1936', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1346, 2240);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4333, 8154.42, to_date('19-10-1923', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1093, 2247);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4334, 26558.19, to_date('14-11-1915', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1232, 2283);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4335, 43288.93, to_date('07-08-1941', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1051, 2384);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4336, 17694.18, to_date('24-03-1946', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1331, 2245);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4337, 8771.05, to_date('22-11-1909', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1028, 2097);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4338, 9720.41, to_date('19-03-1948', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1251, 2096);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4339, 33033.25, to_date('28-06-2017', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1325, 2095);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4340, 43218.59, to_date('13-10-2003', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1393, 2120);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4341, 20532.5, to_date('01-07-2006', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1323, 2002);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4342, 45317.34, to_date('10-03-1908', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1002, 2318);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4343, 33810.81, to_date('14-09-1978', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1179, 2066);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4344, 27534.03, to_date('06-11-1917', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1321, 2233);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4345, 14618.21, to_date('22-04-2022', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1060, 2097);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4346, 27679.05, to_date('24-05-1943', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1090, 2396);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4347, 14098.4, to_date('25-11-1908', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1093, 2028);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4348, 20822.61, to_date('21-02-1938', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1154, 2201);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4349, 32036.71, to_date('13-11-1985', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1240, 2102);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4350, 24324.06, to_date('26-10-1981', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1007, 2206);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4351, 5170.68, to_date('13-12-2013', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1105, 2285);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4352, 36923.66, to_date('10-08-1934', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1255, 2055);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4353, 34563.11, to_date('07-04-1950', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1257, 2102);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4354, 36896.9, to_date('14-07-1911', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1206, 2031);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4355, 42037.62, to_date('26-07-1926', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1284, 2095);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4356, 39271.26, to_date('14-02-1952', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1186, 2224);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4357, 25676.67, to_date('23-10-1922', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1370, 2118);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4358, 32105.55, to_date('24-05-2010', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1177, 2137);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4359, 14382.09, to_date('25-01-2011', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1001, 2039);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4360, 16831.69, to_date('03-03-2015', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1382, 2304);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4361, 36498.2, to_date('19-09-1919', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1184, 2086);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4362, 17659, to_date('09-09-2000', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1119, 2345);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4363, 12497.28, to_date('30-12-1917', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1008, 2000);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4364, 15040.98, to_date('15-07-1932', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1228, 2236);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4365, 21727.65, to_date('22-10-2020', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1318, 2228);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4366, 28204.67, to_date('18-11-1978', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1220, 2009);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4367, 43224.23, to_date('13-11-2013', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1115, 2333);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4368, 31742.38, to_date('06-01-1977', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1132, 2279);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4369, 25581.56, to_date('05-03-1924', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1087, 2230);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4370, 21266.01, to_date('01-04-1970', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1327, 2389);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4371, 15889.35, to_date('17-10-1935', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1058, 2248);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4372, 48123.85, to_date('20-01-1940', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1001, 2187);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4373, 32730.56, to_date('27-11-2000', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1371, 2016);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4374, 43179.9, to_date('04-08-1983', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1027, 2226);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4375, 43241.9, to_date('26-03-2021', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1381, 2177);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4376, 14655.6, to_date('21-06-1936', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1116, 2384);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4377, 44236.9, to_date('25-09-1974', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1093, 2123);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4378, 35034.21, to_date('30-11-1940', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1314, 2119);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4379, 22391.46, to_date('18-08-1987', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1107, 2155);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4380, 17027.55, to_date('22-02-1959', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1007, 2338);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4381, 18491.91, to_date('28-09-1976', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1296, 2074);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4382, 43605.31, to_date('20-02-1982', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1070, 2098);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4383, 25745.51, to_date('17-02-1987', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1012, 2189);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4384, 37086.86, to_date('06-09-1933', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1127, 2133);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4385, 37153.54, to_date('21-01-1975', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1212, 2357);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4386, 27295.52, to_date('29-09-2019', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1140, 2399);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4387, 16946.84, to_date('03-04-1911', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1307, 2240);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4388, 28775.4, to_date('15-02-2023', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1328, 2051);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4389, 21083.84, to_date('10-07-1954', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1143, 2397);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4390, 22070.65, to_date('25-06-1918', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1203, 2241);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4391, 16811.12, to_date('07-08-1945', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1303, 2193);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4392, 39067.28, to_date('13-08-1932', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1337, 2142);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4393, 31286.45, to_date('26-05-1971', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1333, 2133);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4394, 37397.47, to_date('31-01-1925', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1051, 2199);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4395, 44264.35, to_date('06-07-1999', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1095, 2231);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4396, 13906.34, to_date('15-02-1964', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1229, 2200);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4397, 29844.12, to_date('15-01-1958', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1243, 2390);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4398, 42181.25, to_date('28-11-1972', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1060, 2179);
insert into PAYMENTS (paymentid, amount, paymentdate, paymentdeadlinedate, customerid, eventid)
values (4399, 12280.4, to_date('08-10-2010', 'dd-mm-yyyy'), to_date('01-01-2025', 'dd-mm-yyyy'), 1230, 2016);
commit;
prompt 400 records loaded
prompt Enabling foreign key constraints for EVENTS_...
alter table EVENTS_ enable constraint SYS_C007771;
prompt Enabling foreign key constraints for GUSTS...
alter table GUSTS enable constraint SYS_C007780;
prompt Enabling foreign key constraints for HAS_CATERING...
alter table HAS_CATERING enable constraint SYS_C007793;
alter table HAS_CATERING enable constraint SYS_C007794;
prompt Enabling foreign key constraints for PAYMENTS...
alter table PAYMENTS enable constraint SYS_C007789;
prompt Enabling triggers for CATERING...
alter table CATERING enable all triggers;
prompt Enabling triggers for CUSTOMERS...
alter table CUSTOMERS enable all triggers;
prompt Enabling triggers for VENUES...
alter table VENUES enable all triggers;
prompt Enabling triggers for EVENTS_...
alter table EVENTS_ enable all triggers;
prompt Enabling triggers for GUSTS...
alter table GUSTS enable all triggers;
prompt Enabling triggers for HAS_CATERING...
alter table HAS_CATERING enable all triggers;
prompt Enabling triggers for PAYMENTS...
alter table PAYMENTS enable all triggers;
set feedback on
set define on
prompt Done.
