create table CUSTOMER
(
  customer_id NUMBER(5) not null,
  name        VARCHAR2(15) not null,
  email       VARCHAR2(15) not null,
  address     VARCHAR2(15) not null
)
;
alter table CUSTOMER
  add primary key (CUSTOMER_ID);

create table PAYMENT_TYPE
(
  payment_id NUMBER(5) not null,
  ptype      VARCHAR2(15) not null
)
;
alter table PAYMENT_TYPE
  add primary key (PAYMENT_ID);

-- Prompt Creating PRODUCER...
create table PRODUCER
(
  producer_id   NUMBER(5) not null,
  producer_name VARCHAR2(15) not null,
  price         NUMBER(5) not null
)
;
alter table PRODUCER
  add primary key (PRODUCER_ID);

-- Prompt Creating EVENT...
create table EVENT
(
  event_date   DATE not null,
  location     VARCHAR2(15) not null,
  total_price_ NUMBER(5) not null,
  event_id     NUMBER(5) not null,
  producer_id  NUMBER(5) not null,
  singer_id    NUMBER(5) not null,
  customer_id  NUMBER(5) not null,
  payment_id   NUMBER(5) not null
)
;
alter table EVENT
  add primary key (EVENT_ID);
alter table EVENT
  add foreign key (PRODUCER_ID)
  references PRODUCER (PRODUCER_ID);
alter table EVENT
  add foreign key (CUSTOMER_ID)
  references CUSTOMER (CUSTOMER_ID);
alter table EVENT
  add foreign key (PAYMENT_ID)
  references PAYMENT_TYPE (PAYMENT_ID);

-- Prompt Creating INSTRUMENT...
create table INSTRUMENT
(
  instrument_name VARCHAR2(15) not null,
  price           NUMBER(5) not null,
  instrument_id   NUMBER(5) not null
)
;
alter table INSTRUMENT
  add primary key (INSTRUMENT_ID);

-- Prompt Creating INSTRUMENT_EVENT...
create table INSTRUMENT_EVENT
(
  instrument_id NUMBER(5) not null,
  event_id      NUMBER(5) not null
)
;
alter table INSTRUMENT_EVENT
  add primary key (INSTRUMENT_ID, EVENT_ID);
alter table INSTRUMENT_EVENT
  add foreign key (INSTRUMENT_ID)
  references INSTRUMENT (INSTRUMENT_ID);
alter table INSTRUMENT_EVENT
  add foreign key (EVENT_ID)
  references EVENT (EVENT_ID);

-- Prompt Creating SINGER...
create table SINGER
(
  sname     VARCHAR2(15) not null,
  singer_id NUMBER(5) not null,
  price     NUMBER(5) not null
)
;
alter table SINGER
  add primary key (SINGER_ID);
