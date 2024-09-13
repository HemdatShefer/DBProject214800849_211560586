-- Add new columns to existing Customers table
ALTER TABLE Customers
ADD Email VARCHAR2(100);

-- Add new columns to existing Events_ table
ALTER TABLE Events_
ADD Total_Price NUMBER;

-- Add new columns to the Venues table
ALTER TABLE Venues
ADD LastRenovationDate DATE;

-- Add a new Instrument table
CREATE TABLE Instrument (
    InstrumentID NUMBER PRIMARY KEY,
    InstrumentName VARCHAR2(50),
    Price NUMBER
);

-- Add a new Instrument_Event table for the relationship between Instruments and Events_
CREATE TABLE Instrument_Event (
    InstrumentID NUMBER,
    EventID NUMBER,
    PRIMARY KEY (InstrumentID, EventID),
    FOREIGN KEY (InstrumentID) REFERENCES Instrument(InstrumentID),
    FOREIGN KEY (EventID) REFERENCES Events_(EventID)
);

-- Add a new Producer table
CREATE TABLE Producer (
    ProducerID NUMBER PRIMARY KEY,
    ProducerName VARCHAR2(50),
    Price NUMBER
);

-- Add foreign key relationship between Events_ and Producer table
ALTER TABLE Events_
ADD ProducerID NUMBER;

ALTER TABLE Events_
ADD CONSTRAINT FK_Events_Producer
FOREIGN KEY (ProducerID) REFERENCES Producer(ProducerID);

-- Add a Singer table
CREATE TABLE Singer (
    SingerID NUMBER PRIMARY KEY,
    Sname VARCHAR2(50),
    Price NUMBER
);

-- Add a new column to Events_ table for Singer relationships
ALTER TABLE Events_
ADD SingerID NUMBER;

ALTER TABLE Events_
ADD CONSTRAINT FK_Events_Singer
FOREIGN KEY (SingerID) REFERENCES Singer(SingerID);
