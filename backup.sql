prompt PL/SQL Developer import file
prompt Created on Saturday, 6 July 2024 by hemda
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
values (3000, 'Acquaintances', 'Goran', 'Giraldo', to_date('03-07-2021', 'dd-mm-yyyy'), to_date('30-07-2021', 'dd-mm-yyyy'), 'Cancelled', 2265, 1156);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3001, 'Friends', 'Chet', 'Tah', to_date('20-05-2021', 'dd-mm-yyyy'), to_date('25-06-2021', 'dd-mm-yyyy'), 'Declined', 2104, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3002, 'Close Friends', 'Gene', 'Ramirez', to_date('24-09-2021', 'dd-mm-yyyy'), to_date('31-01-2021', 'dd-mm-yyyy'), 'Waitlisted', 2160, 1063);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3003, 'Acquaintances', 'Murray', 'Shawn', to_date('15-08-2021', 'dd-mm-yyyy'), to_date('21-08-2021', 'dd-mm-yyyy'), 'Declined', 2322, 1025);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3004, 'Work Colleagues', 'Oro', 'Polley', to_date('09-01-2021', 'dd-mm-yyyy'), to_date('03-06-2021', 'dd-mm-yyyy'), 'Waitlisted', 2089, 1023);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3005, 'Acquaintances', 'Roberta', 'Geldof', to_date('17-04-2021', 'dd-mm-yyyy'), to_date('17-11-2021', 'dd-mm-yyyy'), 'Waitlisted', 2012, 1308);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3006, 'Work Colleagues', 'Dwight', 'Tilly', to_date('10-11-2021', 'dd-mm-yyyy'), to_date('31-10-2021', 'dd-mm-yyyy'), 'Waitlisted', 2264, 1258);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3007, 'External Invitees', 'Stevie', 'Getty', to_date('27-10-2021', 'dd-mm-yyyy'), to_date('04-10-2021', 'dd-mm-yyyy'), 'Declined', 2230, 1340);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3008, 'Neighbors', 'Rick', 'Forster', to_date('11-08-2021', 'dd-mm-yyyy'), to_date('17-02-2021', 'dd-mm-yyyy'), '''Plus One''.', 2325, 1002);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3009, 'Work Colleagues', 'Joshua', 'Sandler', to_date('26-12-2021', 'dd-mm-yyyy'), to_date('30-10-2021', 'dd-mm-yyyy'), 'Waitlisted', 2039, 1287);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3010, 'Close Friends', 'Dwight', 'Dafoe', to_date('25-08-2021', 'dd-mm-yyyy'), to_date('06-08-2021', 'dd-mm-yyyy'), '''Plus One''.', 2205, 1374);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3011, 'Neighbors', 'Andie', 'Cassidy', to_date('28-10-2021', 'dd-mm-yyyy'), to_date('31-07-2021', 'dd-mm-yyyy'), 'Cancelled', 2290, 1041);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3012, 'Acquaintances', 'Fisher', 'Mann', to_date('17-02-2021', 'dd-mm-yyyy'), to_date('01-12-2021', 'dd-mm-yyyy'), 'Confirmed', 2314, 1056);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3013, 'Close Friends', 'Liv', 'Ponce', to_date('29-05-2021', 'dd-mm-yyyy'), to_date('20-05-2021', 'dd-mm-yyyy'), 'Declined', 2192, 1092);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3014, 'Acquaintances', 'Alessandro', 'Kadison', to_date('24-10-2021', 'dd-mm-yyyy'), to_date('14-02-2021', 'dd-mm-yyyy'), 'Declined', 2104, 1165);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3015, 'Acquaintances', 'Jean-Claude', 'Depp', to_date('30-01-2021', 'dd-mm-yyyy'), to_date('01-06-2021', 'dd-mm-yyyy'), 'Declined', 2288, 1003);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3016, 'Neighbors', 'Lydia', 'Matthau', to_date('04-04-2021', 'dd-mm-yyyy'), to_date('12-07-2021', 'dd-mm-yyyy'), 'Declined', 2255, 1330);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3017, 'External Invitees', 'Scarlett', 'Cotton', to_date('07-11-2021', 'dd-mm-yyyy'), to_date('10-08-2021', 'dd-mm-yyyy'), '''Plus One''.', 2233, 1087);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3018, 'Close Friends', 'Annette', 'McDiarmid', to_date('20-09-2021', 'dd-mm-yyyy'), to_date('31-08-2021', 'dd-mm-yyyy'), 'No Response', 2039, 1366);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3019, 'Close Friends', 'Pierce', 'Ferrell', to_date('20-07-2021', 'dd-mm-yyyy'), to_date('01-08-2021', 'dd-mm-yyyy'), 'Cancelled', 2165, 1279);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3020, 'Friends', 'Scarlett', 'Mirren', to_date('04-04-2021', 'dd-mm-yyyy'), to_date('24-03-2021', 'dd-mm-yyyy'), 'Confirmed', 2303, 1348);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3021, 'Acquaintances', 'Harvey', 'Walken', to_date('22-02-2021', 'dd-mm-yyyy'), to_date('03-08-2021', 'dd-mm-yyyy'), 'No Response', 2082, 1216);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3022, 'Immediate Family', 'Natalie', 'Owen', to_date('18-12-2021', 'dd-mm-yyyy'), to_date('31-12-2021', 'dd-mm-yyyy'), 'Declined', 2041, 1291);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3023, 'External Invitees', 'Wes', 'Morrison', to_date('07-10-2021', 'dd-mm-yyyy'), to_date('05-06-2021', 'dd-mm-yyyy'), 'Cancelled', 2017, 1107);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3024, 'Close Friends', 'Billy', 'Bragg', to_date('26-11-2021', 'dd-mm-yyyy'), to_date('19-10-2021', 'dd-mm-yyyy'), 'Confirmed', 2169, 1217);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3025, 'Friends', 'Lauren', 'Griggs', to_date('15-04-2021', 'dd-mm-yyyy'), to_date('01-06-2021', 'dd-mm-yyyy'), 'Declined', 2214, 1008);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3026, 'External Invitees', 'Busta', 'Wainwright', to_date('25-07-2021', 'dd-mm-yyyy'), to_date('01-06-2021', 'dd-mm-yyyy'), 'No Response', 2100, 1238);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3027, 'Acquaintances', 'Jean-Claude', 'Colin Young', to_date('13-09-2021', 'dd-mm-yyyy'), to_date('20-04-2021', 'dd-mm-yyyy'), 'Waitlisted', 2099, 1302);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3028, 'Neighbors', 'Buffy', 'Liu', to_date('28-10-2021', 'dd-mm-yyyy'), to_date('16-07-2021', 'dd-mm-yyyy'), 'No Response', 2321, 1225);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3029, 'Close Friends', 'Boz', 'Kahn', to_date('03-07-2021', 'dd-mm-yyyy'), to_date('17-03-2021', 'dd-mm-yyyy'), 'No Response', 2060, 1170);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3030, 'Close Friends', 'Gaby', 'Rhymes', to_date('28-06-2021', 'dd-mm-yyyy'), to_date('18-09-2021', 'dd-mm-yyyy'), 'Cancelled', 2163, 1285);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3031, 'Work Colleagues', 'Paula', 'Leguizamo', to_date('20-07-2021', 'dd-mm-yyyy'), to_date('29-07-2021', 'dd-mm-yyyy'), 'Confirmed', 2019, 1065);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3032, 'Extended Family', 'Madeline', 'Moody', to_date('03-07-2021', 'dd-mm-yyyy'), to_date('05-04-2021', 'dd-mm-yyyy'), 'No Response', 2382, 1040);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3033, 'External Invitees', 'Barbara', 'Swank', to_date('12-12-2021', 'dd-mm-yyyy'), to_date('03-02-2021', 'dd-mm-yyyy'), 'No Response', 2009, 1191);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3034, 'Extended Family', 'Cary', 'Mohr', to_date('10-08-2021', 'dd-mm-yyyy'), to_date('21-03-2021', 'dd-mm-yyyy'), 'No Response', 2130, 1293);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3035, 'Immediate Family', 'Stephanie', 'Stone', to_date('20-05-2021', 'dd-mm-yyyy'), to_date('21-08-2021', 'dd-mm-yyyy'), 'Waitlisted', 2345, 1174);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3036, 'Extended Family', 'Armand', 'Craddock', to_date('29-04-2021', 'dd-mm-yyyy'), to_date('16-04-2021', 'dd-mm-yyyy'), '''Plus One''.', 2333, 1312);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3037, 'Close Friends', 'Scott', 'Venora', to_date('08-07-2021', 'dd-mm-yyyy'), to_date('20-03-2021', 'dd-mm-yyyy'), 'Confirmed', 2204, 1341);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3038, 'Friends', 'Curtis', 'Collie', to_date('29-11-2021', 'dd-mm-yyyy'), to_date('07-10-2021', 'dd-mm-yyyy'), 'No Response', 2261, 1300);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3039, 'Close Friends', 'Chet', 'Carlton', to_date('13-02-2021', 'dd-mm-yyyy'), to_date('21-11-2021', 'dd-mm-yyyy'), '''Plus One''.', 2197, 1192);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3040, 'Close Friends', 'Randy', 'Crudup', to_date('17-08-2021', 'dd-mm-yyyy'), to_date('22-06-2021', 'dd-mm-yyyy'), 'Declined', 2110, 1273);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3041, 'Extended Family', 'Claude', 'MacDowell', to_date('20-12-2021', 'dd-mm-yyyy'), to_date('25-09-2021', 'dd-mm-yyyy'), 'Confirmed', 2146, 1073);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3042, 'External Invitees', 'Alana', 'Cronin', to_date('19-03-2021', 'dd-mm-yyyy'), to_date('14-09-2021', 'dd-mm-yyyy'), '''Plus One''.', 2370, 1131);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3043, 'Neighbors', 'Colin', 'Romijn-Stamos', to_date('29-12-2021', 'dd-mm-yyyy'), to_date('01-10-2021', 'dd-mm-yyyy'), 'Confirmed', 2055, 1059);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3044, 'Work Colleagues', 'Taryn', 'Rhys-Davies', to_date('14-07-2021', 'dd-mm-yyyy'), to_date('01-03-2021', 'dd-mm-yyyy'), 'Cancelled', 2005, 1136);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3045, 'Immediate Family', 'Arturo', 'Field', to_date('12-08-2021', 'dd-mm-yyyy'), to_date('28-10-2021', 'dd-mm-yyyy'), 'No Response', 2291, 1019);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3046, 'Close Friends', 'Simon', 'Moorer', to_date('28-05-2021', 'dd-mm-yyyy'), to_date('25-11-2021', 'dd-mm-yyyy'), 'No Response', 2226, 1187);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3047, 'Close Friends', 'Thora', 'White', to_date('12-09-2021', 'dd-mm-yyyy'), to_date('26-08-2021', 'dd-mm-yyyy'), 'Confirmed', 2154, 1100);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3048, 'Acquaintances', 'Jean-Luc', 'Broza', to_date('26-11-2021', 'dd-mm-yyyy'), to_date('30-03-2021', 'dd-mm-yyyy'), 'Waitlisted', 2267, 1294);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3049, 'Work Colleagues', 'Sonny', 'Hidalgo', to_date('12-09-2021', 'dd-mm-yyyy'), to_date('05-09-2021', 'dd-mm-yyyy'), 'No Response', 2053, 1394);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3050, 'External Invitees', 'Thelma', 'Leoni', to_date('04-02-2021', 'dd-mm-yyyy'), to_date('28-09-2021', 'dd-mm-yyyy'), 'Waitlisted', 2358, 1253);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3051, 'Immediate Family', 'Miguel', 'Kristofferson', to_date('05-09-2021', 'dd-mm-yyyy'), to_date('16-01-2021', 'dd-mm-yyyy'), 'Confirmed', 2083, 1219);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3052, 'Friends', 'Chely', 'Moody', to_date('01-03-2021', 'dd-mm-yyyy'), to_date('06-02-2021', 'dd-mm-yyyy'), 'Waitlisted', 2302, 1123);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3053, 'Friends', 'Geggy', 'Rain', to_date('02-09-2021', 'dd-mm-yyyy'), to_date('03-07-2021', 'dd-mm-yyyy'), 'Declined', 2200, 1193);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3054, 'Neighbors', 'Carolyn', 'Blige', to_date('07-09-2021', 'dd-mm-yyyy'), to_date('14-02-2021', 'dd-mm-yyyy'), 'Declined', 2048, 1296);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3055, 'Friends', 'Winona', 'Rockwell', to_date('02-09-2021', 'dd-mm-yyyy'), to_date('22-05-2021', 'dd-mm-yyyy'), 'Declined', 2391, 1304);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3056, 'Extended Family', 'Neneh', 'Skerritt', to_date('14-11-2021', 'dd-mm-yyyy'), to_date('22-08-2021', 'dd-mm-yyyy'), '''Plus One''.', 2269, 1379);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3057, 'Immediate Family', 'Jeremy', 'Rodgers', to_date('28-02-2021', 'dd-mm-yyyy'), to_date('10-07-2021', 'dd-mm-yyyy'), '''Plus One''.', 2057, 1392);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3058, 'Work Colleagues', 'Emilio', 'Northam', to_date('20-10-2021', 'dd-mm-yyyy'), to_date('16-06-2021', 'dd-mm-yyyy'), 'Cancelled', 2136, 1062);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3059, 'External Invitees', 'Sinead', 'Sutherland', to_date('03-05-2021', 'dd-mm-yyyy'), to_date('03-03-2021', 'dd-mm-yyyy'), '''Plus One''.', 2181, 1220);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3060, 'Friends', 'Kimberly', 'Hurt', to_date('01-02-2021', 'dd-mm-yyyy'), to_date('14-04-2021', 'dd-mm-yyyy'), 'Waitlisted', 2288, 1399);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3061, 'Extended Family', 'LeVar', 'O''Neill', to_date('27-10-2021', 'dd-mm-yyyy'), to_date('21-12-2021', 'dd-mm-yyyy'), '''Plus One''.', 2307, 1350);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3062, 'Friends', 'Aimee', 'Ramirez', to_date('21-02-2021', 'dd-mm-yyyy'), to_date('04-09-2021', 'dd-mm-yyyy'), 'No Response', 2217, 1279);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3063, 'Work Colleagues', 'Leslie', 'Logue', to_date('27-07-2021', 'dd-mm-yyyy'), to_date('18-11-2021', 'dd-mm-yyyy'), 'Declined', 2313, 1217);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3064, 'Immediate Family', 'Terry', 'Cromwell', to_date('10-03-2021', 'dd-mm-yyyy'), to_date('20-12-2021', 'dd-mm-yyyy'), '''Plus One''.', 2032, 1103);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3065, 'Neighbors', 'Harry', 'Cozier', to_date('29-11-2021', 'dd-mm-yyyy'), to_date('08-02-2021', 'dd-mm-yyyy'), 'Waitlisted', 2187, 1205);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3066, 'Friends', 'Pierce', 'Warren', to_date('17-02-2021', 'dd-mm-yyyy'), to_date('23-03-2021', 'dd-mm-yyyy'), 'Cancelled', 2243, 1257);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3067, 'Neighbors', 'Miguel', 'Blades', to_date('01-03-2021', 'dd-mm-yyyy'), to_date('14-01-2021', 'dd-mm-yyyy'), '''Plus One''.', 2203, 1124);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3068, 'Extended Family', 'Yolanda', 'Bracco', to_date('02-06-2021', 'dd-mm-yyyy'), to_date('24-02-2021', 'dd-mm-yyyy'), 'Cancelled', 2330, 1391);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3069, 'Acquaintances', 'Stevie', 'Rodgers', to_date('26-11-2021', 'dd-mm-yyyy'), to_date('13-03-2021', 'dd-mm-yyyy'), '''Plus One''.', 2292, 1079);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3070, 'Extended Family', 'Robbie', 'Berry', to_date('13-10-2021', 'dd-mm-yyyy'), to_date('23-01-2021', 'dd-mm-yyyy'), 'No Response', 2122, 1287);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3071, 'Immediate Family', 'Betty', 'Kutcher', to_date('21-02-2021', 'dd-mm-yyyy'), to_date('01-03-2021', 'dd-mm-yyyy'), 'Cancelled', 2222, 1153);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3072, 'Close Friends', 'Nick', 'Costello', to_date('17-12-2021', 'dd-mm-yyyy'), to_date('18-10-2021', 'dd-mm-yyyy'), 'Waitlisted', 2370, 1343);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3073, 'Immediate Family', 'Jena', 'Kenoly', to_date('25-07-2021', 'dd-mm-yyyy'), to_date('11-07-2021', 'dd-mm-yyyy'), 'Declined', 2170, 1073);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3074, 'External Invitees', 'Ed', 'Worrell', to_date('21-02-2021', 'dd-mm-yyyy'), to_date('31-08-2021', 'dd-mm-yyyy'), 'Declined', 2120, 1041);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3075, 'Work Colleagues', 'Bill', 'Hornsby', to_date('28-07-2021', 'dd-mm-yyyy'), to_date('20-10-2021', 'dd-mm-yyyy'), 'Declined', 2099, 1095);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3076, 'Immediate Family', 'Rita', 'Pullman', to_date('16-01-2021', 'dd-mm-yyyy'), to_date('22-05-2021', 'dd-mm-yyyy'), 'Waitlisted', 2093, 1024);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3077, 'Extended Family', 'Nathan', 'Witt', to_date('14-12-2021', 'dd-mm-yyyy'), to_date('24-05-2021', 'dd-mm-yyyy'), '''Plus One''.', 2330, 1270);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3078, 'External Invitees', 'Avril', 'Ronstadt', to_date('04-04-2021', 'dd-mm-yyyy'), to_date('10-01-2021', 'dd-mm-yyyy'), '''Plus One''.', 2056, 1172);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3079, 'Immediate Family', 'Diane', 'Ceasar', to_date('29-12-2021', 'dd-mm-yyyy'), to_date('06-07-2021', 'dd-mm-yyyy'), 'Confirmed', 2120, 1125);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3080, 'Immediate Family', 'Sydney', 'Botti', to_date('08-11-2021', 'dd-mm-yyyy'), to_date('05-12-2021', 'dd-mm-yyyy'), 'Waitlisted', 2198, 1076);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3081, 'External Invitees', 'Merillee', 'Ojeda', to_date('16-07-2021', 'dd-mm-yyyy'), to_date('13-02-2021', 'dd-mm-yyyy'), 'Waitlisted', 2234, 1334);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3082, 'Close Friends', 'Vincent', 'Michael', to_date('24-01-2021', 'dd-mm-yyyy'), to_date('28-08-2021', 'dd-mm-yyyy'), 'No Response', 2107, 1314);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3083, 'External Invitees', 'Jon', 'Macy', to_date('12-09-2021', 'dd-mm-yyyy'), to_date('13-11-2021', 'dd-mm-yyyy'), 'Waitlisted', 2324, 1397);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3084, 'External Invitees', 'James', 'Richardson', to_date('02-09-2021', 'dd-mm-yyyy'), to_date('07-12-2021', 'dd-mm-yyyy'), '''Plus One''.', 2141, 1125);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3085, 'Close Friends', 'Marianne', 'Kline', to_date('06-02-2021', 'dd-mm-yyyy'), to_date('13-01-2021', 'dd-mm-yyyy'), 'No Response', 2301, 1311);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3086, 'Neighbors', 'Linda', 'Shatner', to_date('12-09-2021', 'dd-mm-yyyy'), to_date('29-07-2021', 'dd-mm-yyyy'), 'Confirmed', 2007, 1283);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3087, 'Work Colleagues', 'Aaron', 'Daniels', to_date('29-12-2021', 'dd-mm-yyyy'), to_date('17-06-2021', 'dd-mm-yyyy'), 'No Response', 2110, 1247);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3088, 'Friends', 'Marie', 'Hobson', to_date('07-10-2021', 'dd-mm-yyyy'), to_date('07-06-2021', 'dd-mm-yyyy'), 'Waitlisted', 2132, 1377);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3089, 'Acquaintances', 'Donna', 'Birch', to_date('07-03-2021', 'dd-mm-yyyy'), to_date('26-06-2021', 'dd-mm-yyyy'), '''Plus One''.', 2306, 1227);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3090, 'Extended Family', 'Ethan', 'Tanon', to_date('08-11-2021', 'dd-mm-yyyy'), to_date('28-04-2021', 'dd-mm-yyyy'), 'Cancelled', 2244, 1077);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3091, 'Friends', 'Horace', 'Gallagher', to_date('07-04-2021', 'dd-mm-yyyy'), to_date('21-11-2021', 'dd-mm-yyyy'), 'Cancelled', 2230, 1194);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3092, 'Neighbors', 'Lionel', 'Sheen', to_date('04-01-2021', 'dd-mm-yyyy'), to_date('21-12-2021', 'dd-mm-yyyy'), 'Declined', 2340, 1019);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3093, 'Friends', 'Kylie', 'Payne', to_date('31-03-2021', 'dd-mm-yyyy'), to_date('31-10-2021', 'dd-mm-yyyy'), 'Waitlisted', 2182, 1090);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3094, 'External Invitees', 'Harris', 'Horizon', to_date('20-07-2021', 'dd-mm-yyyy'), to_date('13-12-2021', 'dd-mm-yyyy'), 'No Response', 2065, 1274);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3095, 'Extended Family', 'Laurie', 'Polley', to_date('05-06-2021', 'dd-mm-yyyy'), to_date('13-10-2021', 'dd-mm-yyyy'), 'Cancelled', 2395, 1334);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3096, 'Close Friends', 'Danny', 'Wainwright', to_date('20-05-2021', 'dd-mm-yyyy'), to_date('12-08-2021', 'dd-mm-yyyy'), '''Plus One''.', 2088, 1022);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3097, 'Work Colleagues', 'Rascal', 'Dillon', to_date('30-07-2021', 'dd-mm-yyyy'), to_date('17-06-2021', 'dd-mm-yyyy'), '''Plus One''.', 2015, 1290);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3098, 'Immediate Family', 'Suzy', 'Collie', to_date('22-06-2021', 'dd-mm-yyyy'), to_date('13-01-2021', 'dd-mm-yyyy'), '''Plus One''.', 2272, 1032);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3099, 'Neighbors', 'Mykelti', 'Squier', to_date('22-06-2021', 'dd-mm-yyyy'), to_date('10-10-2021', 'dd-mm-yyyy'), 'Confirmed', 2070, 1348);
commit;
prompt 100 records committed...
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3100, 'Neighbors', 'Donald', 'Shepard', to_date('19-12-2021', 'dd-mm-yyyy'), to_date('09-12-2021', 'dd-mm-yyyy'), 'Waitlisted', 2255, 1334);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3101, 'External Invitees', 'Luke', 'Faithfull', to_date('17-02-2021', 'dd-mm-yyyy'), to_date('04-10-2021', 'dd-mm-yyyy'), 'Waitlisted', 2050, 1397);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3102, 'External Invitees', 'Quentin', 'Atlas', to_date('02-09-2021', 'dd-mm-yyyy'), to_date('27-08-2021', 'dd-mm-yyyy'), 'Declined', 2022, 1294);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3103, 'Acquaintances', 'Gil', 'Strathairn', to_date('29-12-2021', 'dd-mm-yyyy'), to_date('07-07-2021', 'dd-mm-yyyy'), 'Cancelled', 2078, 1298);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3104, 'Close Friends', 'Elle', 'Phifer', to_date('26-11-2021', 'dd-mm-yyyy'), to_date('15-01-2021', 'dd-mm-yyyy'), 'Cancelled', 2079, 1288);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3105, 'Close Friends', 'Viggo', 'Aaron', to_date('12-11-2021', 'dd-mm-yyyy'), to_date('21-02-2021', 'dd-mm-yyyy'), 'Cancelled', 2288, 1362);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3106, 'Acquaintances', 'Nicholas', 'Azaria', to_date('12-05-2021', 'dd-mm-yyyy'), to_date('02-06-2021', 'dd-mm-yyyy'), 'No Response', 2031, 1180);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3107, 'Acquaintances', 'Ice', 'Lewis', to_date('25-08-2021', 'dd-mm-yyyy'), to_date('04-09-2021', 'dd-mm-yyyy'), 'Waitlisted', 2197, 1225);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3108, 'Neighbors', 'Molly', 'Torino', to_date('12-12-2021', 'dd-mm-yyyy'), to_date('10-07-2021', 'dd-mm-yyyy'), 'Waitlisted', 2352, 1195);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3109, 'External Invitees', 'Clea', 'Cummings', to_date('25-05-2021', 'dd-mm-yyyy'), to_date('12-01-2021', 'dd-mm-yyyy'), 'Waitlisted', 2084, 1119);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3110, 'External Invitees', 'Elle', 'Gordon', to_date('18-11-2021', 'dd-mm-yyyy'), to_date('09-06-2021', 'dd-mm-yyyy'), 'Waitlisted', 2168, 1195);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3111, 'Immediate Family', 'Benicio', 'Coward', to_date('25-07-2021', 'dd-mm-yyyy'), to_date('08-12-2021', 'dd-mm-yyyy'), '''Plus One''.', 2361, 1153);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3112, 'Immediate Family', 'Morris', 'Weaving', to_date('03-07-2021', 'dd-mm-yyyy'), to_date('08-07-2021', 'dd-mm-yyyy'), 'Declined', 2223, 1151);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3113, 'Neighbors', 'Salma', 'Harmon', to_date('22-09-2021', 'dd-mm-yyyy'), to_date('14-11-2021', 'dd-mm-yyyy'), 'Confirmed', 2152, 1382);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3114, 'Immediate Family', 'Sinead', 'Fonda', to_date('20-05-2021', 'dd-mm-yyyy'), to_date('07-05-2021', 'dd-mm-yyyy'), '''Plus One''.', 2260, 1222);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3115, 'Extended Family', 'Spike', 'Underwood', to_date('11-03-2021', 'dd-mm-yyyy'), to_date('31-12-2021', 'dd-mm-yyyy'), 'No Response', 2263, 1087);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3116, 'Extended Family', 'Gene', 'Kenoly', to_date('06-02-2021', 'dd-mm-yyyy'), to_date('30-08-2021', 'dd-mm-yyyy'), 'No Response', 2396, 1029);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3117, 'Work Colleagues', 'Temuera', 'Moreno', to_date('21-04-2021', 'dd-mm-yyyy'), to_date('11-02-2021', 'dd-mm-yyyy'), 'Confirmed', 2161, 1246);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3118, 'Extended Family', 'Nik', 'Gray', to_date('22-10-2021', 'dd-mm-yyyy'), to_date('18-04-2021', 'dd-mm-yyyy'), 'Cancelled', 2092, 1328);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3119, 'External Invitees', 'Natascha', 'Heche', to_date('05-11-2021', 'dd-mm-yyyy'), to_date('29-07-2021', 'dd-mm-yyyy'), 'Waitlisted', 2148, 1013);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3120, 'Immediate Family', 'Kid', 'Delta', to_date('29-12-2021', 'dd-mm-yyyy'), to_date('10-02-2021', 'dd-mm-yyyy'), 'No Response', 2333, 1286);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3121, 'External Invitees', 'Millie', 'Peet', to_date('07-01-2021', 'dd-mm-yyyy'), to_date('28-03-2021', 'dd-mm-yyyy'), '''Plus One''.', 2336, 1389);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3122, 'Friends', 'Roy', 'Broadbent', to_date('27-10-2021', 'dd-mm-yyyy'), to_date('11-12-2021', 'dd-mm-yyyy'), 'Confirmed', 2201, 1359);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3123, 'Acquaintances', 'Natalie', 'Venora', to_date('18-12-2021', 'dd-mm-yyyy'), to_date('26-05-2021', 'dd-mm-yyyy'), '''Plus One''.', 2021, 1298);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3124, 'External Invitees', 'Ty', 'Christie', to_date('27-12-2021', 'dd-mm-yyyy'), to_date('16-07-2021', 'dd-mm-yyyy'), 'Declined', 2251, 1361);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3125, 'Work Colleagues', 'Neneh', 'Whitwam', to_date('29-06-2021', 'dd-mm-yyyy'), to_date('24-09-2021', 'dd-mm-yyyy'), 'Waitlisted', 2258, 1267);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3126, 'External Invitees', 'Brooke', 'Doucette', to_date('15-06-2021', 'dd-mm-yyyy'), to_date('24-06-2021', 'dd-mm-yyyy'), 'Confirmed', 2284, 1344);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3127, 'External Invitees', 'Horace', 'Kweller', to_date('08-03-2021', 'dd-mm-yyyy'), to_date('20-03-2021', 'dd-mm-yyyy'), 'Cancelled', 2040, 1092);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3128, 'Friends', 'Cheech', 'Field', to_date('07-07-2021', 'dd-mm-yyyy'), to_date('17-02-2021', 'dd-mm-yyyy'), 'Declined', 2325, 1271);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3129, 'Close Friends', 'Treat', 'Kristofferson', to_date('31-05-2021', 'dd-mm-yyyy'), to_date('02-02-2021', 'dd-mm-yyyy'), '''Plus One''.', 2067, 1120);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3130, 'Immediate Family', 'Derrick', 'Polley', to_date('05-11-2021', 'dd-mm-yyyy'), to_date('03-08-2021', 'dd-mm-yyyy'), 'Cancelled', 2393, 1092);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3131, 'Friends', 'Michael', 'Oszajca', to_date('02-09-2021', 'dd-mm-yyyy'), to_date('13-10-2021', 'dd-mm-yyyy'), 'Waitlisted', 2123, 1123);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3132, 'Immediate Family', 'Karon', 'Starr', to_date('07-11-2021', 'dd-mm-yyyy'), to_date('05-08-2021', 'dd-mm-yyyy'), 'Confirmed', 2284, 1218);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3133, 'Work Colleagues', 'Miko', 'Tyler', to_date('19-02-2021', 'dd-mm-yyyy'), to_date('04-11-2021', 'dd-mm-yyyy'), 'Confirmed', 2055, 1169);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3134, 'Immediate Family', 'Phoebe', 'Lane', to_date('27-10-2021', 'dd-mm-yyyy'), to_date('27-06-2021', 'dd-mm-yyyy'), 'Confirmed', 2136, 1394);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3135, 'Friends', 'Maury', 'Polley', to_date('06-05-2021', 'dd-mm-yyyy'), to_date('18-11-2021', 'dd-mm-yyyy'), 'Cancelled', 2341, 1302);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3136, 'Work Colleagues', 'Cole', 'Cornell', to_date('30-11-2021', 'dd-mm-yyyy'), to_date('20-02-2021', 'dd-mm-yyyy'), 'No Response', 2214, 1181);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3137, 'External Invitees', 'Jeffrey', 'Maxwell', to_date('05-04-2021', 'dd-mm-yyyy'), to_date('09-07-2021', 'dd-mm-yyyy'), 'Waitlisted', 2273, 1215);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3138, 'External Invitees', 'Albert', 'Rhymes', to_date('17-01-2021', 'dd-mm-yyyy'), to_date('24-11-2021', 'dd-mm-yyyy'), 'No Response', 2277, 1223);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3139, 'Immediate Family', 'Sal', 'LaSalle', to_date('05-07-2021', 'dd-mm-yyyy'), to_date('22-04-2021', 'dd-mm-yyyy'), 'No Response', 2123, 1123);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3140, 'Extended Family', 'Debbie', 'Rawls', to_date('28-05-2021', 'dd-mm-yyyy'), to_date('05-07-2021', 'dd-mm-yyyy'), 'No Response', 2159, 1325);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3141, 'Neighbors', 'Colm', 'Heslov', to_date('26-02-2021', 'dd-mm-yyyy'), to_date('02-09-2021', 'dd-mm-yyyy'), 'Cancelled', 2127, 1042);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3142, 'Work Colleagues', 'Curtis', 'Santa Rosa', to_date('21-12-2021', 'dd-mm-yyyy'), to_date('25-01-2021', 'dd-mm-yyyy'), 'Cancelled', 2337, 1331);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3143, 'Extended Family', 'Bridgette', 'Magnuson', to_date('14-12-2021', 'dd-mm-yyyy'), to_date('10-11-2021', 'dd-mm-yyyy'), 'Declined', 2254, 1259);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3144, 'Acquaintances', 'Joey', 'Church', to_date('17-09-2021', 'dd-mm-yyyy'), to_date('12-12-2021', 'dd-mm-yyyy'), 'Declined', 2116, 1193);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3145, 'External Invitees', 'Chloe', 'Affleck', to_date('30-04-2021', 'dd-mm-yyyy'), to_date('12-11-2021', 'dd-mm-yyyy'), '''Plus One''.', 2381, 1213);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3146, 'Acquaintances', 'Garth', 'Bello', to_date('30-07-2021', 'dd-mm-yyyy'), to_date('01-10-2021', 'dd-mm-yyyy'), 'Waitlisted', 2193, 1052);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3147, 'Neighbors', 'Lizzy', 'Balaban', to_date('29-12-2021', 'dd-mm-yyyy'), to_date('16-05-2021', 'dd-mm-yyyy'), 'Confirmed', 2074, 1164);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3148, 'Close Friends', 'Lorraine', 'Coverdale', to_date('22-06-2021', 'dd-mm-yyyy'), to_date('23-03-2021', 'dd-mm-yyyy'), '''Plus One''.', 2041, 1310);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3149, 'Immediate Family', 'Terri', 'McPherson', to_date('28-09-2021', 'dd-mm-yyyy'), to_date('07-09-2021', 'dd-mm-yyyy'), '''Plus One''.', 2354, 1074);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3150, 'Extended Family', 'Denise', 'Caine', to_date('25-08-2021', 'dd-mm-yyyy'), to_date('22-03-2021', 'dd-mm-yyyy'), 'Waitlisted', 2078, 1104);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3151, 'Work Colleagues', 'Phoebe', 'Reubens', to_date('19-01-2021', 'dd-mm-yyyy'), to_date('05-09-2021', 'dd-mm-yyyy'), 'Cancelled', 2280, 1075);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3152, 'Friends', 'Bret', 'Rankin', to_date('28-05-2021', 'dd-mm-yyyy'), to_date('14-08-2021', 'dd-mm-yyyy'), 'Confirmed', 2245, 1183);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3153, 'Acquaintances', 'Halle', 'Boone', to_date('09-10-2021', 'dd-mm-yyyy'), to_date('22-09-2021', 'dd-mm-yyyy'), 'Waitlisted', 2320, 1152);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3154, 'Close Friends', 'Lorraine', 'Phifer', to_date('17-08-2021', 'dd-mm-yyyy'), to_date('08-04-2021', 'dd-mm-yyyy'), 'Cancelled', 2181, 1182);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3155, 'Extended Family', 'Jeremy', 'Chaykin', to_date('24-10-2021', 'dd-mm-yyyy'), to_date('20-08-2021', 'dd-mm-yyyy'), 'Confirmed', 2127, 1209);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3156, 'Close Friends', 'Gena', 'Sorvino', to_date('07-09-2021', 'dd-mm-yyyy'), to_date('04-12-2021', 'dd-mm-yyyy'), 'Waitlisted', 2196, 1298);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3157, 'External Invitees', 'Pat', 'Waits', to_date('15-08-2021', 'dd-mm-yyyy'), to_date('07-08-2021', 'dd-mm-yyyy'), 'Waitlisted', 2312, 1154);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3158, 'Acquaintances', 'Susan', 'Orlando', to_date('28-08-2021', 'dd-mm-yyyy'), to_date('13-03-2021', 'dd-mm-yyyy'), 'Cancelled', 2249, 1165);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3159, 'Friends', 'Rene', 'Fishburne', to_date('30-01-2021', 'dd-mm-yyyy'), to_date('11-02-2021', 'dd-mm-yyyy'), 'No Response', 2224, 1365);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3160, 'External Invitees', 'Jessica', 'Pigott-Smith', to_date('20-05-2021', 'dd-mm-yyyy'), to_date('17-06-2021', 'dd-mm-yyyy'), 'No Response', 2118, 1126);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3161, 'Immediate Family', 'Lisa', 'Goodman', to_date('02-05-2021', 'dd-mm-yyyy'), to_date('08-12-2021', 'dd-mm-yyyy'), '''Plus One''.', 2118, 1170);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3162, 'Neighbors', 'Jonatha', 'Arkin', to_date('23-08-2021', 'dd-mm-yyyy'), to_date('28-10-2021', 'dd-mm-yyyy'), 'Declined', 2382, 1112);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3163, 'Neighbors', 'Donal', 'Ward', to_date('01-09-2021', 'dd-mm-yyyy'), to_date('02-01-2021', 'dd-mm-yyyy'), 'Declined', 2136, 1322);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3164, 'Neighbors', 'Jean-Claude', 'Moraz', to_date('01-09-2021', 'dd-mm-yyyy'), to_date('18-01-2021', 'dd-mm-yyyy'), 'No Response', 2190, 1116);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3165, 'Extended Family', 'Ray', 'Buffalo', to_date('26-06-2021', 'dd-mm-yyyy'), to_date('20-05-2021', 'dd-mm-yyyy'), 'No Response', 2080, 1271);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3166, 'Work Colleagues', 'Jose', 'Tippe', to_date('11-04-2021', 'dd-mm-yyyy'), to_date('28-06-2021', 'dd-mm-yyyy'), '''Plus One''.', 2239, 1265);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3167, 'Neighbors', 'Melanie', 'Jane', to_date('05-02-2021', 'dd-mm-yyyy'), to_date('15-03-2021', 'dd-mm-yyyy'), 'Cancelled', 2386, 1241);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3168, 'Neighbors', 'Brothers', 'Blige', to_date('16-12-2021', 'dd-mm-yyyy'), to_date('14-01-2021', 'dd-mm-yyyy'), 'Confirmed', 2149, 1099);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3169, 'Immediate Family', 'Larry', 'Murphy', to_date('29-05-2021', 'dd-mm-yyyy'), to_date('06-08-2021', 'dd-mm-yyyy'), 'Declined', 2301, 1107);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3170, 'External Invitees', 'Steven', 'McPherson', to_date('03-07-2021', 'dd-mm-yyyy'), to_date('17-01-2021', 'dd-mm-yyyy'), 'Declined', 2235, 1245);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3171, 'External Invitees', 'Beverley', 'Scaggs', to_date('01-09-2021', 'dd-mm-yyyy'), to_date('19-08-2021', 'dd-mm-yyyy'), 'Cancelled', 2053, 1266);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3172, 'Work Colleagues', 'Candice', 'O''Donnell', to_date('28-09-2021', 'dd-mm-yyyy'), to_date('13-04-2021', 'dd-mm-yyyy'), 'Confirmed', 2087, 1089);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3173, 'Neighbors', 'Jann', 'Aniston', to_date('22-02-2021', 'dd-mm-yyyy'), to_date('03-04-2021', 'dd-mm-yyyy'), '''Plus One''.', 2235, 1113);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3174, 'Acquaintances', 'Kiefer', 'LuPone', to_date('05-02-2021', 'dd-mm-yyyy'), to_date('08-11-2021', 'dd-mm-yyyy'), 'Confirmed', 2340, 1255);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3175, 'External Invitees', 'Alice', 'Oszajca', to_date('13-08-2021', 'dd-mm-yyyy'), to_date('22-03-2021', 'dd-mm-yyyy'), '''Plus One''.', 2372, 1118);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3176, 'Work Colleagues', 'Tori', 'Candy', to_date('12-05-2021', 'dd-mm-yyyy'), to_date('27-02-2021', 'dd-mm-yyyy'), 'Declined', 2053, 1279);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3177, 'Extended Family', 'Emilio', 'Wiedlin', to_date('29-12-2021', 'dd-mm-yyyy'), to_date('17-01-2021', 'dd-mm-yyyy'), 'Waitlisted', 2297, 1301);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3178, 'Friends', 'Alan', 'Esposito', to_date('13-09-2021', 'dd-mm-yyyy'), to_date('21-10-2021', 'dd-mm-yyyy'), 'Waitlisted', 2081, 1281);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3179, 'Friends', 'Donald', 'Gates', to_date('06-05-2021', 'dd-mm-yyyy'), to_date('03-12-2021', 'dd-mm-yyyy'), 'Cancelled', 2332, 1304);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3180, 'Extended Family', 'Sheryl', 'Goldwyn', to_date('12-08-2021', 'dd-mm-yyyy'), to_date('23-07-2021', 'dd-mm-yyyy'), '''Plus One''.', 2052, 1244);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3181, 'Extended Family', 'Freddy', 'Speaks', to_date('07-11-2021', 'dd-mm-yyyy'), to_date('05-09-2021', 'dd-mm-yyyy'), 'Confirmed', 2255, 1269);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3182, 'External Invitees', 'Rosanne', 'Loveless', to_date('19-06-2021', 'dd-mm-yyyy'), to_date('16-04-2021', 'dd-mm-yyyy'), 'No Response', 2141, 1087);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3183, 'Work Colleagues', 'Sonny', 'Potter', to_date('05-07-2021', 'dd-mm-yyyy'), to_date('13-09-2021', 'dd-mm-yyyy'), 'No Response', 2282, 1110);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3184, 'Acquaintances', 'Anita', 'Hackman', to_date('30-04-2021', 'dd-mm-yyyy'), to_date('20-11-2021', 'dd-mm-yyyy'), 'Declined', 2045, 1140);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3185, 'Friends', 'Antonio', 'Osborne', to_date('20-07-2021', 'dd-mm-yyyy'), to_date('17-11-2021', 'dd-mm-yyyy'), 'No Response', 2035, 1391);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3186, 'Neighbors', 'Donald', 'Charles', to_date('28-05-2021', 'dd-mm-yyyy'), to_date('23-03-2021', 'dd-mm-yyyy'), '''Plus One''.', 2360, 1021);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3187, 'Work Colleagues', 'Giancarlo', 'Herrmann', to_date('30-04-2021', 'dd-mm-yyyy'), to_date('15-07-2021', 'dd-mm-yyyy'), 'No Response', 2325, 1002);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3188, 'Extended Family', 'Jackie', 'Gold', to_date('07-07-2021', 'dd-mm-yyyy'), to_date('25-01-2021', 'dd-mm-yyyy'), 'Waitlisted', 2351, 1307);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3189, 'External Invitees', 'Gerald', 'Beals', to_date('01-07-2021', 'dd-mm-yyyy'), to_date('18-05-2021', 'dd-mm-yyyy'), 'Confirmed', 2118, 1227);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3190, 'Close Friends', 'Jane', 'Brown', to_date('30-06-2021', 'dd-mm-yyyy'), to_date('15-01-2021', 'dd-mm-yyyy'), 'Declined', 2133, 1211);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3191, 'External Invitees', 'Ike', 'McDonnell', to_date('14-09-2021', 'dd-mm-yyyy'), to_date('03-06-2021', 'dd-mm-yyyy'), 'Confirmed', 2320, 1029);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3192, 'External Invitees', 'Rawlins', 'McGinley', to_date('27-10-2021', 'dd-mm-yyyy'), to_date('15-07-2021', 'dd-mm-yyyy'), 'Confirmed', 2042, 1061);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3193, 'External Invitees', 'Grace', 'English', to_date('09-01-2021', 'dd-mm-yyyy'), to_date('07-12-2021', 'dd-mm-yyyy'), 'No Response', 2342, 1116);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3194, 'Neighbors', 'Embeth', 'Liu', to_date('08-05-2021', 'dd-mm-yyyy'), to_date('05-09-2021', 'dd-mm-yyyy'), 'Cancelled', 2012, 1167);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3195, 'Work Colleagues', 'Christopher', 'Carlisle', to_date('19-10-2021', 'dd-mm-yyyy'), to_date('16-05-2021', 'dd-mm-yyyy'), 'No Response', 2284, 1221);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3196, 'Close Friends', 'Pamela', 'MacNeil', to_date('25-07-2021', 'dd-mm-yyyy'), to_date('31-03-2021', 'dd-mm-yyyy'), 'Confirmed', 2149, 1104);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3197, 'Friends', 'Mary', 'English', to_date('06-10-2021', 'dd-mm-yyyy'), to_date('26-04-2021', 'dd-mm-yyyy'), 'Waitlisted', 2302, 1377);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3198, 'External Invitees', 'Malcolm', 'Penn', to_date('15-07-2021', 'dd-mm-yyyy'), to_date('10-08-2021', 'dd-mm-yyyy'), 'Declined', 2106, 1380);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3199, 'Extended Family', 'Armand', 'Lee', to_date('02-09-2021', 'dd-mm-yyyy'), to_date('31-05-2021', 'dd-mm-yyyy'), 'No Response', 2388, 1190);
commit;
prompt 200 records committed...
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3200, 'Neighbors', 'Patrick', 'Schwarzenegger', to_date('26-04-2021', 'dd-mm-yyyy'), to_date('31-08-2021', 'dd-mm-yyyy'), 'Confirmed', 2058, 1116);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3201, 'External Invitees', 'Vonda', 'Miles', to_date('22-10-2021', 'dd-mm-yyyy'), to_date('24-04-2021', 'dd-mm-yyyy'), 'Declined', 2146, 1113);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3202, 'Acquaintances', 'Alannah', 'Allan', to_date('16-01-2021', 'dd-mm-yyyy'), to_date('18-10-2021', 'dd-mm-yyyy'), 'No Response', 2078, 1320);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3203, 'Friends', 'Roberta', 'Stigers', to_date('22-11-2021', 'dd-mm-yyyy'), to_date('04-08-2021', 'dd-mm-yyyy'), 'Cancelled', 2162, 1326);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3204, 'External Invitees', 'Arturo', 'Brown', to_date('19-01-2021', 'dd-mm-yyyy'), to_date('11-10-2021', 'dd-mm-yyyy'), '''Plus One''.', 2311, 1361);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3205, 'External Invitees', 'Liev', 'Kinney', to_date('03-01-2021', 'dd-mm-yyyy'), to_date('18-09-2021', 'dd-mm-yyyy'), 'No Response', 2183, 1007);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3206, 'Immediate Family', 'Tilda', 'Askew', to_date('20-07-2021', 'dd-mm-yyyy'), to_date('27-09-2021', 'dd-mm-yyyy'), 'Declined', 2350, 1043);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3207, 'Extended Family', 'Kevin', 'Winger', to_date('03-01-2021', 'dd-mm-yyyy'), to_date('16-12-2021', 'dd-mm-yyyy'), 'Cancelled', 2090, 1206);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3208, 'External Invitees', 'Rhys', 'Feliciano', to_date('24-01-2021', 'dd-mm-yyyy'), to_date('01-02-2021', 'dd-mm-yyyy'), 'No Response', 2208, 1082);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3209, 'Immediate Family', 'Sydney', 'Pony', to_date('03-01-2021', 'dd-mm-yyyy'), to_date('07-05-2021', 'dd-mm-yyyy'), 'Confirmed', 2075, 1322);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3210, 'External Invitees', 'Marina', 'Hunt', to_date('30-03-2021', 'dd-mm-yyyy'), to_date('12-06-2021', 'dd-mm-yyyy'), 'Waitlisted', 2098, 1181);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3211, 'External Invitees', 'Loren', 'Dooley', to_date('24-08-2021', 'dd-mm-yyyy'), to_date('05-08-2021', 'dd-mm-yyyy'), 'Cancelled', 2013, 1182);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3212, 'Work Colleagues', 'Sharon', 'Hedaya', to_date('04-12-2021', 'dd-mm-yyyy'), to_date('08-08-2021', 'dd-mm-yyyy'), 'Waitlisted', 2203, 1305);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3213, 'External Invitees', 'Ricardo', 'Sedgwick', to_date('29-06-2021', 'dd-mm-yyyy'), to_date('14-01-2021', 'dd-mm-yyyy'), 'Confirmed', 2040, 1105);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3214, 'Work Colleagues', 'Chuck', 'Begley', to_date('02-12-2021', 'dd-mm-yyyy'), to_date('09-06-2021', 'dd-mm-yyyy'), 'Declined', 2055, 1352);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3215, 'Acquaintances', 'Pete', 'Rapaport', to_date('15-08-2021', 'dd-mm-yyyy'), to_date('02-08-2021', 'dd-mm-yyyy'), 'Waitlisted', 2328, 1191);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3216, 'Neighbors', 'Andrew', 'Martin', to_date('03-07-2021', 'dd-mm-yyyy'), to_date('10-11-2021', 'dd-mm-yyyy'), 'Confirmed', 2308, 1235);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3217, 'Extended Family', 'Howard', 'Theron', to_date('01-02-2021', 'dd-mm-yyyy'), to_date('21-08-2021', 'dd-mm-yyyy'), '''Plus One''.', 2055, 1382);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3218, 'Neighbors', 'Kay', 'Stills', to_date('05-10-2021', 'dd-mm-yyyy'), to_date('02-10-2021', 'dd-mm-yyyy'), 'Cancelled', 2111, 1352);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3219, 'External Invitees', 'Benicio', 'Cassidy', to_date('13-07-2021', 'dd-mm-yyyy'), to_date('14-01-2021', 'dd-mm-yyyy'), 'Cancelled', 2388, 1150);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3220, 'Close Friends', 'Stellan', 'Bridges', to_date('31-03-2021', 'dd-mm-yyyy'), to_date('26-11-2021', 'dd-mm-yyyy'), 'Declined', 2090, 1061);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3221, 'Close Friends', 'Corey', 'Pride', to_date('16-12-2021', 'dd-mm-yyyy'), to_date('02-01-2021', 'dd-mm-yyyy'), 'No Response', 2251, 1161);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3222, 'Friends', 'Harvey', 'Yankovic', to_date('30-04-2021', 'dd-mm-yyyy'), to_date('12-12-2021', 'dd-mm-yyyy'), 'No Response', 2112, 1159);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3223, 'Immediate Family', 'Trick', 'Roth', to_date('17-03-2021', 'dd-mm-yyyy'), to_date('27-01-2021', 'dd-mm-yyyy'), 'Declined', 2104, 1358);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3224, 'Friends', 'Rosario', 'Heslov', to_date('03-01-2021', 'dd-mm-yyyy'), to_date('19-04-2021', 'dd-mm-yyyy'), 'No Response', 2272, 1151);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3225, 'Acquaintances', 'Wayman', 'Piven', to_date('01-03-2021', 'dd-mm-yyyy'), to_date('09-01-2021', 'dd-mm-yyyy'), 'Confirmed', 2116, 1031);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3226, 'Immediate Family', 'Goldie', 'O''Sullivan', to_date('10-05-2021', 'dd-mm-yyyy'), to_date('03-02-2021', 'dd-mm-yyyy'), 'Declined', 2259, 1332);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3227, 'Neighbors', 'Boyd', 'Neill', to_date('28-08-2021', 'dd-mm-yyyy'), to_date('29-10-2021', 'dd-mm-yyyy'), 'No Response', 2341, 1295);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3228, 'Acquaintances', 'Bradley', 'Bonneville', to_date('12-05-2021', 'dd-mm-yyyy'), to_date('13-02-2021', 'dd-mm-yyyy'), '''Plus One''.', 2336, 1256);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3229, 'Work Colleagues', 'Sylvester', 'Sweeney', to_date('25-08-2021', 'dd-mm-yyyy'), to_date('01-08-2021', 'dd-mm-yyyy'), 'Confirmed', 2094, 1163);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3230, 'Friends', 'Sally', 'Field', to_date('28-05-2021', 'dd-mm-yyyy'), to_date('09-10-2021', 'dd-mm-yyyy'), '''Plus One''.', 2311, 1014);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3231, 'External Invitees', 'Lena', 'Gertner', to_date('22-10-2021', 'dd-mm-yyyy'), to_date('15-06-2021', 'dd-mm-yyyy'), 'Cancelled', 2122, 1222);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3232, 'Work Colleagues', 'Rachid', 'Shaye', to_date('30-09-2021', 'dd-mm-yyyy'), to_date('18-12-2021', 'dd-mm-yyyy'), 'Waitlisted', 2117, 1307);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3233, 'Extended Family', 'Isabella', 'Warden', to_date('27-07-2021', 'dd-mm-yyyy'), to_date('07-08-2021', 'dd-mm-yyyy'), 'Declined', 2385, 1308);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3234, 'Close Friends', 'Benjamin', 'Hoffman', to_date('20-04-2021', 'dd-mm-yyyy'), to_date('01-02-2021', 'dd-mm-yyyy'), 'Confirmed', 2382, 1125);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3235, 'Close Friends', 'Nils', 'Carrey', to_date('29-06-2021', 'dd-mm-yyyy'), to_date('13-02-2021', 'dd-mm-yyyy'), 'Declined', 2225, 1381);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3236, 'Neighbors', 'Oro', 'Lavigne', to_date('29-01-2021', 'dd-mm-yyyy'), to_date('08-12-2021', 'dd-mm-yyyy'), 'Declined', 2208, 1016);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3237, 'Immediate Family', 'First', 'De Almeida', to_date('21-01-2021', 'dd-mm-yyyy'), to_date('28-12-2021', 'dd-mm-yyyy'), '''Plus One''.', 2145, 1199);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3238, 'Neighbors', 'Brothers', 'Patillo', to_date('05-09-2021', 'dd-mm-yyyy'), to_date('28-08-2021', 'dd-mm-yyyy'), 'No Response', 2142, 1168);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3239, 'External Invitees', 'Elizabeth', 'Tripplehorn', to_date('24-08-2021', 'dd-mm-yyyy'), to_date('03-01-2021', 'dd-mm-yyyy'), 'No Response', 2384, 1196);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3240, 'Work Colleagues', 'Night', 'Bugnon', to_date('11-04-2021', 'dd-mm-yyyy'), to_date('01-09-2021', 'dd-mm-yyyy'), 'Waitlisted', 2357, 1078);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3241, 'Immediate Family', 'Ned', 'Pantoliano', to_date('31-07-2021', 'dd-mm-yyyy'), to_date('15-09-2021', 'dd-mm-yyyy'), 'No Response', 2289, 1351);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3242, 'Neighbors', 'Roy', 'Vanian', to_date('20-05-2021', 'dd-mm-yyyy'), to_date('12-08-2021', 'dd-mm-yyyy'), 'Declined', 2019, 1230);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3243, 'Extended Family', 'Edwin', 'de Lancie', to_date('12-11-2021', 'dd-mm-yyyy'), to_date('26-04-2021', 'dd-mm-yyyy'), 'No Response', 2091, 1271);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3244, 'Extended Family', 'Earl', 'Rizzo', to_date('10-08-2021', 'dd-mm-yyyy'), to_date('17-04-2021', 'dd-mm-yyyy'), 'Waitlisted', 2270, 1168);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3245, 'Neighbors', 'Andrew', 'Underwood', to_date('04-04-2021', 'dd-mm-yyyy'), to_date('12-09-2021', 'dd-mm-yyyy'), 'Waitlisted', 2284, 1059);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3246, 'Neighbors', 'Victoria', 'Burke', to_date('18-12-2021', 'dd-mm-yyyy'), to_date('08-08-2021', 'dd-mm-yyyy'), 'Confirmed', 2396, 1174);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3247, 'Neighbors', 'Arnold', 'Diesel', to_date('24-02-2021', 'dd-mm-yyyy'), to_date('07-04-2021', 'dd-mm-yyyy'), 'Waitlisted', 2193, 1393);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3248, 'Work Colleagues', 'Rachid', 'Ripley', to_date('17-08-2021', 'dd-mm-yyyy'), to_date('21-06-2021', 'dd-mm-yyyy'), 'Declined', 2007, 1141);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3249, 'Immediate Family', 'Brenda', 'Crowe', to_date('21-12-2021', 'dd-mm-yyyy'), to_date('09-12-2021', 'dd-mm-yyyy'), '''Plus One''.', 2156, 1200);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3250, 'Immediate Family', 'Anna', 'Fonda', to_date('06-05-2021', 'dd-mm-yyyy'), to_date('16-10-2021', 'dd-mm-yyyy'), 'Waitlisted', 2011, 1049);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3251, 'Friends', 'Garry', 'Rush', to_date('30-09-2021', 'dd-mm-yyyy'), to_date('29-01-2021', 'dd-mm-yyyy'), '''Plus One''.', 2093, 1329);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3252, 'External Invitees', 'Jared', 'Levert', to_date('29-01-2021', 'dd-mm-yyyy'), to_date('16-05-2021', 'dd-mm-yyyy'), 'Confirmed', 2387, 1036);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3253, 'Neighbors', 'Wendy', 'Heston', to_date('21-02-2021', 'dd-mm-yyyy'), to_date('02-06-2021', 'dd-mm-yyyy'), 'Waitlisted', 2087, 1031);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3254, 'Close Friends', 'Jim', 'Roundtree', to_date('07-01-2021', 'dd-mm-yyyy'), to_date('09-11-2021', 'dd-mm-yyyy'), 'Confirmed', 2362, 1082);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3255, 'Immediate Family', 'Boz', 'Frampton', to_date('27-10-2021', 'dd-mm-yyyy'), to_date('02-01-2021', 'dd-mm-yyyy'), '''Plus One''.', 2152, 1228);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3256, 'Immediate Family', 'Emily', 'Mazar', to_date('15-01-2021', 'dd-mm-yyyy'), to_date('07-09-2021', 'dd-mm-yyyy'), 'No Response', 2184, 1072);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3257, 'Acquaintances', 'Caroline', 'Biel', to_date('29-12-2021', 'dd-mm-yyyy'), to_date('20-02-2021', 'dd-mm-yyyy'), 'No Response', 2014, 1392);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3258, 'Acquaintances', 'Hector', 'Taha', to_date('01-01-2021', 'dd-mm-yyyy'), to_date('31-12-2021', 'dd-mm-yyyy'), 'No Response', 2099, 1283);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3259, 'Friends', 'Nicolas', 'Vaughn', to_date('06-10-2021', 'dd-mm-yyyy'), to_date('22-04-2021', 'dd-mm-yyyy'), '''Plus One''.', 2084, 1219);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3260, 'Neighbors', 'Curtis', 'Newton', to_date('15-05-2021', 'dd-mm-yyyy'), to_date('11-08-2021', 'dd-mm-yyyy'), '''Plus One''.', 2126, 1249);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3261, 'Friends', 'Emm', 'Gore', to_date('17-03-2021', 'dd-mm-yyyy'), to_date('13-02-2021', 'dd-mm-yyyy'), 'Confirmed', 2032, 1104);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3262, 'Neighbors', 'Shawn', 'Cleary', to_date('13-11-2021', 'dd-mm-yyyy'), to_date('03-12-2021', 'dd-mm-yyyy'), 'Waitlisted', 2231, 1042);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3263, 'Friends', 'Russell', 'Hanks', to_date('20-12-2021', 'dd-mm-yyyy'), to_date('05-04-2021', 'dd-mm-yyyy'), '''Plus One''.', 2163, 1014);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3264, 'Immediate Family', 'Shirley', 'Margolyes', to_date('26-06-2021', 'dd-mm-yyyy'), to_date('14-11-2021', 'dd-mm-yyyy'), 'Declined', 2101, 1347);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3265, 'Neighbors', 'Larry', 'Borgnine', to_date('12-07-2021', 'dd-mm-yyyy'), to_date('26-05-2021', 'dd-mm-yyyy'), 'No Response', 2391, 1367);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3266, 'Friends', 'Praga', 'Donelly', to_date('20-07-2021', 'dd-mm-yyyy'), to_date('09-11-2021', 'dd-mm-yyyy'), '''Plus One''.', 2122, 1133);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3267, 'Extended Family', 'Judi', 'Avalon', to_date('03-01-2021', 'dd-mm-yyyy'), to_date('26-02-2021', 'dd-mm-yyyy'), 'Waitlisted', 2016, 1104);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3268, 'Immediate Family', 'Roger', 'Flanagan', to_date('07-01-2021', 'dd-mm-yyyy'), to_date('11-09-2021', 'dd-mm-yyyy'), 'Waitlisted', 2351, 1330);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3269, 'Work Colleagues', 'Gaby', 'Peterson', to_date('24-01-2021', 'dd-mm-yyyy'), to_date('09-01-2021', 'dd-mm-yyyy'), 'No Response', 2297, 1365);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3270, 'External Invitees', 'Penelope', 'Weiland', to_date('24-10-2021', 'dd-mm-yyyy'), to_date('18-07-2021', 'dd-mm-yyyy'), 'Confirmed', 2293, 1307);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3271, 'Extended Family', 'Wendy', 'Tripplehorn', to_date('29-09-2021', 'dd-mm-yyyy'), to_date('22-04-2021', 'dd-mm-yyyy'), 'Declined', 2229, 1164);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3272, 'Friends', 'Heather', 'Zappacosta', to_date('23-03-2021', 'dd-mm-yyyy'), to_date('03-11-2021', 'dd-mm-yyyy'), 'Waitlisted', 2274, 1342);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3273, 'Close Friends', 'Grace', 'Feuerstein', to_date('07-09-2021', 'dd-mm-yyyy'), to_date('23-01-2021', 'dd-mm-yyyy'), 'Waitlisted', 2314, 1063);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3274, 'Extended Family', 'Gilbert', 'de Lancie', to_date('24-03-2021', 'dd-mm-yyyy'), to_date('30-03-2021', 'dd-mm-yyyy'), 'Cancelled', 2020, 1101);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3275, 'Close Friends', 'Whoopi', 'Pepper', to_date('05-04-2021', 'dd-mm-yyyy'), to_date('13-01-2021', 'dd-mm-yyyy'), 'Confirmed', 2342, 1248);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3276, 'Work Colleagues', 'Penelope', 'Tempest', to_date('08-05-2021', 'dd-mm-yyyy'), to_date('26-07-2021', 'dd-mm-yyyy'), 'Waitlisted', 2027, 1308);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3277, 'External Invitees', 'Pablo', 'Milsap', to_date('29-04-2021', 'dd-mm-yyyy'), to_date('05-08-2021', 'dd-mm-yyyy'), 'Declined', 2361, 1205);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3278, 'Friends', 'Steve', 'Cartlidge', to_date('19-01-2021', 'dd-mm-yyyy'), to_date('21-09-2021', 'dd-mm-yyyy'), 'Waitlisted', 2138, 1028);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3279, 'Neighbors', 'Jude', 'Oszajca', to_date('16-01-2021', 'dd-mm-yyyy'), to_date('05-09-2021', 'dd-mm-yyyy'), 'Confirmed', 2053, 1393);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3280, 'External Invitees', 'Terri', 'Hedaya', to_date('13-12-2021', 'dd-mm-yyyy'), to_date('28-08-2021', 'dd-mm-yyyy'), 'Declined', 2119, 1334);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3281, 'Close Friends', 'Rutger', 'Arkin', to_date('26-08-2021', 'dd-mm-yyyy'), to_date('20-09-2021', 'dd-mm-yyyy'), 'Declined', 2112, 1319);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3282, 'Close Friends', 'Laurie', 'Tinsley', to_date('26-01-2021', 'dd-mm-yyyy'), to_date('11-04-2021', 'dd-mm-yyyy'), '''Plus One''.', 2235, 1387);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3283, 'External Invitees', 'Rene', 'Salonga', to_date('21-07-2021', 'dd-mm-yyyy'), to_date('06-08-2021', 'dd-mm-yyyy'), 'No Response', 2015, 1215);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3284, 'Extended Family', 'Owen', 'Belle', to_date('09-10-2021', 'dd-mm-yyyy'), to_date('29-05-2021', 'dd-mm-yyyy'), '''Plus One''.', 2219, 1308);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3285, 'Extended Family', 'Humberto', 'Loggia', to_date('28-02-2021', 'dd-mm-yyyy'), to_date('21-07-2021', 'dd-mm-yyyy'), 'Confirmed', 2199, 1312);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3286, 'External Invitees', 'Gavin', 'Thomson', to_date('04-02-2021', 'dd-mm-yyyy'), to_date('16-09-2021', 'dd-mm-yyyy'), 'Cancelled', 2257, 1055);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3287, 'Work Colleagues', 'Kurtwood', 'Navarro', to_date('26-02-2021', 'dd-mm-yyyy'), to_date('26-02-2021', 'dd-mm-yyyy'), 'No Response', 2237, 1114);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3288, 'Close Friends', 'Ryan', 'Lyonne', to_date('26-08-2021', 'dd-mm-yyyy'), to_date('18-08-2021', 'dd-mm-yyyy'), 'Waitlisted', 2351, 1298);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3289, 'Neighbors', 'Jude', 'Savage', to_date('22-09-2021', 'dd-mm-yyyy'), to_date('21-03-2021', 'dd-mm-yyyy'), 'Confirmed', 2211, 1073);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3290, 'Immediate Family', 'Anthony', 'Mollard', to_date('02-09-2021', 'dd-mm-yyyy'), to_date('03-05-2021', 'dd-mm-yyyy'), 'Cancelled', 2105, 1093);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3291, 'Immediate Family', 'Nicholas', 'Imbruglia', to_date('19-12-2021', 'dd-mm-yyyy'), to_date('29-09-2021', 'dd-mm-yyyy'), '''Plus One''.', 2087, 1068);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3292, 'Immediate Family', 'Patrick', 'Peebles', to_date('31-07-2021', 'dd-mm-yyyy'), to_date('27-08-2021', 'dd-mm-yyyy'), 'No Response', 2094, 1156);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3293, 'Acquaintances', 'Johnette', 'Carnes', to_date('25-05-2021', 'dd-mm-yyyy'), to_date('12-11-2021', 'dd-mm-yyyy'), 'Confirmed', 2291, 1274);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3294, 'Immediate Family', 'Grant', 'Plummer', to_date('04-08-2021', 'dd-mm-yyyy'), to_date('30-12-2021', 'dd-mm-yyyy'), '''Plus One''.', 2039, 1140);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3295, 'External Invitees', 'Lonnie', 'Belles', to_date('12-10-2021', 'dd-mm-yyyy'), to_date('07-10-2021', 'dd-mm-yyyy'), 'Confirmed', 2285, 1040);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3296, 'Neighbors', 'Pelvic', 'Jones', to_date('14-05-2021', 'dd-mm-yyyy'), to_date('27-04-2021', 'dd-mm-yyyy'), 'Waitlisted', 2185, 1312);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3297, 'Acquaintances', 'Avenged', 'Janney', to_date('14-11-2021', 'dd-mm-yyyy'), to_date('25-08-2021', 'dd-mm-yyyy'), 'Cancelled', 2340, 1365);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3298, 'Work Colleagues', 'Pierce', 'Weber', to_date('05-01-2021', 'dd-mm-yyyy'), to_date('16-01-2021', 'dd-mm-yyyy'), 'No Response', 2272, 1020);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3299, 'Work Colleagues', 'Robert', 'Adams', to_date('17-07-2021', 'dd-mm-yyyy'), to_date('21-08-2021', 'dd-mm-yyyy'), 'Cancelled', 2111, 1371);
commit;
prompt 300 records committed...
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3300, 'Close Friends', 'Aida', 'Wakeling', to_date('23-12-2021', 'dd-mm-yyyy'), to_date('29-12-2021', 'dd-mm-yyyy'), 'Waitlisted', 2116, 1178);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3301, 'External Invitees', 'Frankie', 'Gates', to_date('13-03-2021', 'dd-mm-yyyy'), to_date('30-09-2021', 'dd-mm-yyyy'), 'Declined', 2014, 1180);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3302, 'Extended Family', 'Kurtwood', 'Englund', to_date('17-07-2021', 'dd-mm-yyyy'), to_date('05-05-2021', 'dd-mm-yyyy'), 'Confirmed', 2175, 1135);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3303, 'External Invitees', 'Gavin', 'Holm', to_date('09-07-2021', 'dd-mm-yyyy'), to_date('17-10-2021', 'dd-mm-yyyy'), 'No Response', 2199, 1186);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3304, 'External Invitees', 'Julie', 'Herrmann', to_date('06-10-2021', 'dd-mm-yyyy'), to_date('17-07-2021', 'dd-mm-yyyy'), 'Declined', 2135, 1150);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3305, 'Neighbors', 'Lois', 'Ali', to_date('20-07-2021', 'dd-mm-yyyy'), to_date('08-05-2021', 'dd-mm-yyyy'), 'Confirmed', 2326, 1332);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3306, 'Neighbors', 'Ruth', 'Reinhold', to_date('04-02-2021', 'dd-mm-yyyy'), to_date('10-04-2021', 'dd-mm-yyyy'), 'Waitlisted', 2276, 1269);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3307, 'Immediate Family', 'Jay', 'Brock', to_date('06-12-2021', 'dd-mm-yyyy'), to_date('06-09-2021', 'dd-mm-yyyy'), 'Declined', 2140, 1188);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3308, 'Acquaintances', 'Alan', 'Daniels', to_date('13-10-2021', 'dd-mm-yyyy'), to_date('12-05-2021', 'dd-mm-yyyy'), 'Confirmed', 2049, 1001);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3309, 'Immediate Family', 'Linda', 'Gandolfini', to_date('26-06-2021', 'dd-mm-yyyy'), to_date('01-09-2021', 'dd-mm-yyyy'), 'Confirmed', 2046, 1218);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3310, 'Close Friends', 'Maura', 'Masur', to_date('24-02-2021', 'dd-mm-yyyy'), to_date('26-09-2021', 'dd-mm-yyyy'), 'Waitlisted', 2256, 1389);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3311, 'Neighbors', 'Olga', 'Karyo', to_date('03-05-2021', 'dd-mm-yyyy'), to_date('07-10-2021', 'dd-mm-yyyy'), 'Confirmed', 2082, 1264);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3312, 'Immediate Family', 'Collective', 'Torino', to_date('24-01-2021', 'dd-mm-yyyy'), to_date('10-05-2021', 'dd-mm-yyyy'), 'No Response', 2019, 1089);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3313, 'Acquaintances', 'Forest', 'Sainte-Marie', to_date('24-08-2021', 'dd-mm-yyyy'), to_date('03-12-2021', 'dd-mm-yyyy'), '''Plus One''.', 2098, 1014);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3314, 'Acquaintances', 'Nikka', 'Branch', to_date('30-11-2021', 'dd-mm-yyyy'), to_date('23-02-2021', 'dd-mm-yyyy'), 'Declined', 2156, 1241);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3315, 'Work Colleagues', 'Cevin', 'McDonnell', to_date('28-09-2021', 'dd-mm-yyyy'), to_date('12-07-2021', 'dd-mm-yyyy'), 'No Response', 2327, 1282);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3316, 'External Invitees', 'Juan', 'Child', to_date('17-11-2021', 'dd-mm-yyyy'), to_date('12-12-2021', 'dd-mm-yyyy'), 'Declined', 2161, 1150);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3317, 'Work Colleagues', 'Cate', 'Lovitz', to_date('18-02-2021', 'dd-mm-yyyy'), to_date('07-05-2021', 'dd-mm-yyyy'), '''Plus One''.', 2364, 1278);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3318, 'Immediate Family', 'Neneh', 'Russo', to_date('27-03-2021', 'dd-mm-yyyy'), to_date('08-06-2021', 'dd-mm-yyyy'), 'Confirmed', 2371, 1155);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3319, 'Extended Family', 'Vendetta', 'Coolidge', to_date('20-05-2021', 'dd-mm-yyyy'), to_date('18-06-2021', 'dd-mm-yyyy'), 'Cancelled', 2136, 1090);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3320, 'Work Colleagues', 'Clint', 'Reid', to_date('27-07-2021', 'dd-mm-yyyy'), to_date('27-01-2021', 'dd-mm-yyyy'), '''Plus One''.', 2149, 1105);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3321, 'Friends', 'Patty', 'Glenn', to_date('17-07-2021', 'dd-mm-yyyy'), to_date('15-03-2021', 'dd-mm-yyyy'), 'Declined', 2082, 1350);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3322, 'Work Colleagues', 'Ann', 'Fiennes', to_date('28-10-2021', 'dd-mm-yyyy'), to_date('16-01-2021', 'dd-mm-yyyy'), '''Plus One''.', 2054, 1238);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3323, 'Work Colleagues', 'Rachel', 'McGovern', to_date('25-05-2021', 'dd-mm-yyyy'), to_date('31-01-2021', 'dd-mm-yyyy'), 'Cancelled', 2125, 1317);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3324, 'Work Colleagues', 'Howie', 'Nightingale', to_date('25-05-2021', 'dd-mm-yyyy'), to_date('09-03-2021', 'dd-mm-yyyy'), 'Confirmed', 2015, 1053);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3325, 'External Invitees', 'Cate', 'Nelson', to_date('05-02-2021', 'dd-mm-yyyy'), to_date('02-10-2021', 'dd-mm-yyyy'), '''Plus One''.', 2246, 1349);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3326, 'Extended Family', 'Allison', 'Hawthorne', to_date('22-11-2021', 'dd-mm-yyyy'), to_date('07-12-2021', 'dd-mm-yyyy'), 'Waitlisted', 2311, 1383);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3327, 'Extended Family', 'Jude', 'Sepulveda', to_date('20-09-2021', 'dd-mm-yyyy'), to_date('01-12-2021', 'dd-mm-yyyy'), 'Cancelled', 2265, 1375);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3328, 'External Invitees', 'Beth', 'Wainwright', to_date('10-04-2021', 'dd-mm-yyyy'), to_date('03-04-2021', 'dd-mm-yyyy'), 'Cancelled', 2143, 1275);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3329, 'Immediate Family', 'Mia', 'Koteas', to_date('31-07-2021', 'dd-mm-yyyy'), to_date('14-04-2021', 'dd-mm-yyyy'), 'Declined', 2007, 1377);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3330, 'Acquaintances', 'Phil', 'Williamson', to_date('07-01-2021', 'dd-mm-yyyy'), to_date('01-08-2021', 'dd-mm-yyyy'), 'Cancelled', 2208, 1261);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3331, 'Acquaintances', 'Hank', 'Klugh', to_date('12-12-2021', 'dd-mm-yyyy'), to_date('03-07-2021', 'dd-mm-yyyy'), 'Confirmed', 2285, 1057);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3332, 'Acquaintances', 'Willem', 'Spiner', to_date('01-03-2021', 'dd-mm-yyyy'), to_date('06-10-2021', 'dd-mm-yyyy'), 'Confirmed', 2077, 1034);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3333, 'Acquaintances', 'Vern', 'Masur', to_date('25-05-2021', 'dd-mm-yyyy'), to_date('05-02-2021', 'dd-mm-yyyy'), '''Plus One''.', 2271, 1117);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3334, 'Immediate Family', 'Cheryl', 'Brock', to_date('08-02-2021', 'dd-mm-yyyy'), to_date('25-12-2021', 'dd-mm-yyyy'), 'Declined', 2366, 1125);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3335, 'Acquaintances', 'Adam', 'Stamp', to_date('10-09-2021', 'dd-mm-yyyy'), to_date('28-05-2021', 'dd-mm-yyyy'), '''Plus One''.', 2070, 1335);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3336, 'Acquaintances', 'Pamela', 'Rifkin', to_date('27-03-2021', 'dd-mm-yyyy'), to_date('17-09-2021', 'dd-mm-yyyy'), 'Declined', 2115, 1374);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3337, 'Acquaintances', 'Anne', 'Donelly', to_date('05-12-2021', 'dd-mm-yyyy'), to_date('06-07-2021', 'dd-mm-yyyy'), 'Confirmed', 2100, 1035);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3338, 'External Invitees', 'Adrien', 'Walken', to_date('29-04-2021', 'dd-mm-yyyy'), to_date('22-08-2021', 'dd-mm-yyyy'), 'Cancelled', 2161, 1010);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3339, 'Extended Family', 'Emm', 'Steenburgen', to_date('29-12-2021', 'dd-mm-yyyy'), to_date('12-03-2021', 'dd-mm-yyyy'), 'No Response', 2061, 1165);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3340, 'Friends', 'Patricia', 'Colman', to_date('15-04-2021', 'dd-mm-yyyy'), to_date('13-08-2021', 'dd-mm-yyyy'), 'Confirmed', 2112, 1121);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3341, 'Neighbors', 'Devon', 'Latifah', to_date('09-10-2021', 'dd-mm-yyyy'), to_date('09-11-2021', 'dd-mm-yyyy'), 'Cancelled', 2315, 1174);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3342, 'Friends', 'Stanley', 'Spector', to_date('30-07-2021', 'dd-mm-yyyy'), to_date('31-07-2021', 'dd-mm-yyyy'), '''Plus One''.', 2126, 1132);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3343, 'External Invitees', 'Joaquim', 'Beck', to_date('28-06-2021', 'dd-mm-yyyy'), to_date('18-06-2021', 'dd-mm-yyyy'), 'Declined', 2055, 1082);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3344, 'External Invitees', 'Dorry', 'Rain', to_date('03-01-2021', 'dd-mm-yyyy'), to_date('05-07-2021', 'dd-mm-yyyy'), 'No Response', 2280, 1280);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3345, 'Friends', 'Colleen', 'Warwick', to_date('30-07-2021', 'dd-mm-yyyy'), to_date('24-06-2021', 'dd-mm-yyyy'), 'Cancelled', 2289, 1161);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3346, 'Extended Family', 'Davey', 'Fichtner', to_date('16-05-2021', 'dd-mm-yyyy'), to_date('05-05-2021', 'dd-mm-yyyy'), 'Declined', 2351, 1087);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3347, 'Friends', 'Beverley', 'Miller', to_date('03-01-2021', 'dd-mm-yyyy'), to_date('23-10-2021', 'dd-mm-yyyy'), 'Waitlisted', 2006, 1205);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3348, 'Close Friends', 'Hal', 'DiCaprio', to_date('24-08-2021', 'dd-mm-yyyy'), to_date('06-12-2021', 'dd-mm-yyyy'), '''Plus One''.', 2386, 1039);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3349, 'Acquaintances', 'Shelby', 'Starr', to_date('30-05-2021', 'dd-mm-yyyy'), to_date('28-09-2021', 'dd-mm-yyyy'), 'No Response', 2356, 1006);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3350, 'Extended Family', 'Dionne', 'Swayze', to_date('08-02-2021', 'dd-mm-yyyy'), to_date('23-12-2021', 'dd-mm-yyyy'), 'No Response', 2081, 1055);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3351, 'Extended Family', 'Annie', 'Harrison', to_date('25-08-2021', 'dd-mm-yyyy'), to_date('11-11-2021', 'dd-mm-yyyy'), 'Waitlisted', 2023, 1231);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3352, 'Work Colleagues', 'Willie', 'Moriarty', to_date('02-04-2021', 'dd-mm-yyyy'), to_date('14-12-2021', 'dd-mm-yyyy'), 'Waitlisted', 2154, 1367);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3353, 'Work Colleagues', 'Loreena', 'Chandler', to_date('21-04-2021', 'dd-mm-yyyy'), to_date('09-01-2021', 'dd-mm-yyyy'), 'Cancelled', 2202, 1096);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3354, 'Immediate Family', 'Armand', 'Gugino', to_date('24-10-2021', 'dd-mm-yyyy'), to_date('21-01-2021', 'dd-mm-yyyy'), 'Confirmed', 2119, 1394);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3355, 'Neighbors', 'Lloyd', 'Sisto', to_date('08-02-2021', 'dd-mm-yyyy'), to_date('04-04-2021', 'dd-mm-yyyy'), 'Declined', 2372, 1241);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3356, 'Work Colleagues', 'Sharon', 'Weller', to_date('05-02-2021', 'dd-mm-yyyy'), to_date('23-02-2021', 'dd-mm-yyyy'), 'Waitlisted', 2064, 1015);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3357, 'Immediate Family', 'Wade', 'Gates', to_date('22-09-2021', 'dd-mm-yyyy'), to_date('21-09-2021', 'dd-mm-yyyy'), 'Confirmed', 2072, 1003);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3358, 'Acquaintances', 'Lance', 'Neill', to_date('29-12-2021', 'dd-mm-yyyy'), to_date('02-09-2021', 'dd-mm-yyyy'), 'Cancelled', 2022, 1045);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3359, 'Extended Family', 'Debra', 'Broderick', to_date('27-07-2021', 'dd-mm-yyyy'), to_date('23-08-2021', 'dd-mm-yyyy'), 'No Response', 2276, 1295);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3360, 'Work Colleagues', 'Lee', 'Karyo', to_date('22-11-2021', 'dd-mm-yyyy'), to_date('10-08-2021', 'dd-mm-yyyy'), 'Cancelled', 2152, 1313);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3361, 'Acquaintances', 'Aaron', 'Morrison', to_date('10-06-2021', 'dd-mm-yyyy'), to_date('30-03-2021', 'dd-mm-yyyy'), 'No Response', 2367, 1078);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3362, 'Work Colleagues', 'Jeanne', 'Rankin', to_date('28-07-2021', 'dd-mm-yyyy'), to_date('31-05-2021', 'dd-mm-yyyy'), 'No Response', 2106, 1131);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3363, 'Work Colleagues', 'Selma', 'Torino', to_date('30-03-2021', 'dd-mm-yyyy'), to_date('09-09-2021', 'dd-mm-yyyy'), 'Cancelled', 2313, 1036);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3364, 'Extended Family', 'Jimmy', 'Klugh', to_date('21-08-2021', 'dd-mm-yyyy'), to_date('12-12-2021', 'dd-mm-yyyy'), 'No Response', 2010, 1374);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3365, 'Immediate Family', 'Tyrone', 'Smurfit', to_date('12-01-2021', 'dd-mm-yyyy'), to_date('06-01-2021', 'dd-mm-yyyy'), 'Cancelled', 2042, 1253);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3366, 'Extended Family', 'First', 'Simpson', to_date('13-06-2021', 'dd-mm-yyyy'), to_date('29-05-2021', 'dd-mm-yyyy'), 'Waitlisted', 2239, 1354);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3367, 'Immediate Family', 'Nancy', 'Paquin', to_date('25-03-2021', 'dd-mm-yyyy'), to_date('29-01-2021', 'dd-mm-yyyy'), 'Cancelled', 2017, 1288);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3368, 'Work Colleagues', 'Rhys', 'Leto', to_date('12-10-2021', 'dd-mm-yyyy'), to_date('15-04-2021', 'dd-mm-yyyy'), 'Declined', 2388, 1292);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3369, 'Extended Family', 'Jeremy', 'Jovovich', to_date('29-12-2021', 'dd-mm-yyyy'), to_date('25-06-2021', 'dd-mm-yyyy'), 'Confirmed', 2210, 1044);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3370, 'Work Colleagues', 'Kirsten', 'Dillane', to_date('17-07-2021', 'dd-mm-yyyy'), to_date('14-04-2021', 'dd-mm-yyyy'), 'No Response', 2250, 1199);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3371, 'Friends', 'Derrick', 'Jackman', to_date('25-07-2021', 'dd-mm-yyyy'), to_date('06-07-2021', 'dd-mm-yyyy'), 'Declined', 2280, 1254);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3372, 'Friends', 'Marie', 'Crouch', to_date('15-06-2021', 'dd-mm-yyyy'), to_date('08-04-2021', 'dd-mm-yyyy'), 'Confirmed', 2391, 1343);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3373, 'Immediate Family', 'Jared', 'Matarazzo', to_date('01-07-2021', 'dd-mm-yyyy'), to_date('03-02-2021', 'dd-mm-yyyy'), '''Plus One''.', 2142, 1146);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3374, 'Close Friends', 'Gavin', 'Hudson', to_date('21-07-2021', 'dd-mm-yyyy'), to_date('11-03-2021', 'dd-mm-yyyy'), 'Confirmed', 2322, 1132);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3375, 'Acquaintances', 'Harvey', 'Stuart', to_date('22-02-2021', 'dd-mm-yyyy'), to_date('14-09-2021', 'dd-mm-yyyy'), 'Declined', 2148, 1322);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3376, 'Close Friends', 'Roberta', 'Flatts', to_date('09-07-2021', 'dd-mm-yyyy'), to_date('18-01-2021', 'dd-mm-yyyy'), 'No Response', 2279, 1183);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3377, 'Acquaintances', 'Claude', 'Visnjic', to_date('23-10-2021', 'dd-mm-yyyy'), to_date('29-04-2021', 'dd-mm-yyyy'), 'Cancelled', 2061, 1035);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3378, 'External Invitees', 'Pete', 'Williamson', to_date('02-12-2021', 'dd-mm-yyyy'), to_date('17-10-2021', 'dd-mm-yyyy'), 'No Response', 2194, 1000);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3379, 'Acquaintances', 'Ethan', 'Fishburne', to_date('27-07-2021', 'dd-mm-yyyy'), to_date('20-05-2021', 'dd-mm-yyyy'), '''Plus One''.', 2026, 1059);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3380, 'Friends', 'Beverley', 'Richards', to_date('27-03-2021', 'dd-mm-yyyy'), to_date('19-04-2021', 'dd-mm-yyyy'), 'Cancelled', 2271, 1048);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3381, 'Friends', 'Ernest', 'Walken', to_date('08-04-2021', 'dd-mm-yyyy'), to_date('01-09-2021', 'dd-mm-yyyy'), 'Cancelled', 2350, 1369);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3382, 'Immediate Family', 'Miki', 'Morrison', to_date('26-11-2021', 'dd-mm-yyyy'), to_date('09-04-2021', 'dd-mm-yyyy'), 'Cancelled', 2361, 1231);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3383, 'Neighbors', 'Junior', 'Parish', to_date('12-05-2021', 'dd-mm-yyyy'), to_date('18-04-2021', 'dd-mm-yyyy'), '''Plus One''.', 2073, 1213);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3384, 'Close Friends', 'Vienna', 'Miles', to_date('18-11-2021', 'dd-mm-yyyy'), to_date('16-03-2021', 'dd-mm-yyyy'), 'Confirmed', 2140, 1360);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3385, 'External Invitees', 'Nicky', 'Moorer', to_date('15-08-2021', 'dd-mm-yyyy'), to_date('16-08-2021', 'dd-mm-yyyy'), 'No Response', 2346, 1188);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3386, 'Friends', 'Rade', 'Duke', to_date('03-07-2021', 'dd-mm-yyyy'), to_date('25-04-2021', 'dd-mm-yyyy'), 'Cancelled', 2077, 1234);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3387, 'External Invitees', 'Sal', 'Michael', to_date('13-11-2021', 'dd-mm-yyyy'), to_date('16-03-2021', 'dd-mm-yyyy'), '''Plus One''.', 2205, 1315);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3388, 'Extended Family', 'Roscoe', 'Berenger', to_date('04-09-2021', 'dd-mm-yyyy'), to_date('22-06-2021', 'dd-mm-yyyy'), 'Confirmed', 2016, 1116);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3389, 'Immediate Family', 'Moe', 'Nelson', to_date('01-03-2021', 'dd-mm-yyyy'), to_date('17-09-2021', 'dd-mm-yyyy'), 'Waitlisted', 2344, 1112);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3390, 'Immediate Family', 'Louise', 'Tempest', to_date('31-03-2021', 'dd-mm-yyyy'), to_date('21-02-2021', 'dd-mm-yyyy'), '''Plus One''.', 2147, 1002);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3391, 'Friends', 'Juliette', 'Garcia', to_date('20-06-2021', 'dd-mm-yyyy'), to_date('20-11-2021', 'dd-mm-yyyy'), 'No Response', 2094, 1274);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3392, 'External Invitees', 'Selma', 'Jessee', to_date('10-10-2021', 'dd-mm-yyyy'), to_date('27-04-2021', 'dd-mm-yyyy'), 'Declined', 2385, 1099);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3393, 'Work Colleagues', 'Richie', 'Foxx', to_date('08-11-2021', 'dd-mm-yyyy'), to_date('20-06-2021', 'dd-mm-yyyy'), 'No Response', 2394, 1343);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3394, 'Friends', 'Julianne', 'Paul', to_date('25-03-2021', 'dd-mm-yyyy'), to_date('22-06-2021', 'dd-mm-yyyy'), 'Declined', 2138, 1104);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3395, 'Extended Family', 'Victoria', 'Price', to_date('29-04-2021', 'dd-mm-yyyy'), to_date('18-02-2021', 'dd-mm-yyyy'), 'Declined', 2369, 1384);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3396, 'Friends', 'Bo', 'Dourif', to_date('29-05-2021', 'dd-mm-yyyy'), to_date('24-06-2021', 'dd-mm-yyyy'), 'Declined', 2090, 1072);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3397, 'Acquaintances', 'Vondie', 'McGoohan', to_date('16-07-2021', 'dd-mm-yyyy'), to_date('10-06-2021', 'dd-mm-yyyy'), 'Waitlisted', 2302, 1263);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3398, 'Neighbors', 'Mika', 'Visnjic', to_date('12-11-2021', 'dd-mm-yyyy'), to_date('22-07-2021', 'dd-mm-yyyy'), 'Cancelled', 2370, 1095);
insert into GUSTS (gustid, relationshiplevel, firstname, lastname, invitationdate, confirmationdate, rsvpstatus, eventid, customerid)
values (3399, 'Friends', 'Ben', 'Foxx', to_date('23-08-2021', 'dd-mm-yyyy'), to_date('02-10-2021', 'dd-mm-yyyy'), 'Confirmed', 2214, 1118);
commit;
prompt 400 records loaded
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
