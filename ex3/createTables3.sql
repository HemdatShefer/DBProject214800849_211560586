-- Define the Customers table
CREATE TABLE Customers (
    CustomerID NUMBER PRIMARY KEY,
    FirstName VARCHAR2(50),
    LastName VARCHAR2(50),
    PhoneNumber VARCHAR2(20),
    BirthdayDate DATE,
    LastPurchaseDate DATE
);

-- Define the Events_ table
CREATE TABLE Events_ (
    EventID NUMBER PRIMARY KEY,
    EventDate DATE,
    EndTime TIMESTAMP,
    CustomerID NUMBER,
    VenueID NUMBER,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Define the Venues table
CREATE TABLE Venues (
    VenueID NUMBER PRIMARY KEY,
    Name VARCHAR2(100),
    Location VARCHAR2(100),
    Capacity NUMBER,
    OpenDate DATE,
    RenovationDate DATE
);

-- Define the Guests table
CREATE TABLE Guests (
    GuestID NUMBER PRIMARY KEY,
    RelationshipLevel VARCHAR2(50),
    FirstName VARCHAR2(50),
    LastName VARCHAR2(50),
    InvitationDate DATE,
    BirthdayDate DATE,
    EventID NUMBER,
    CustomerID NUMBER,
    FOREIGN KEY (EventID) REFERENCES Events_(EventID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Define the Payments table
CREATE TABLE Payments (
    PaymentID NUMBER PRIMARY KEY,
    Amount NUMBER,
    PaymentDate DATE,
    ProcessedDate DATE,
    CustomerID NUMBER,
    EventID NUMBER,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (EventID) REFERENCES Events_(EventID)
);

-- Define the Catering table
CREATE TABLE Catering (
    CateringID NUMBER PRIMARY KEY,
    Name VARCHAR2(100),
    MenuDescription VARCHAR2(255),
    ContractStartDate DATE,
    ContractEndDate DATE
);
-- Define the has_catering table
CREATE TABLE has_catering (
    CateringID NUMBER,
    EventID NUMBER,
    PRIMARY KEY (CateringID, EventID),
    FOREIGN KEY (CateringID) REFERENCES Catering(CateringID),
    FOREIGN KEY (EventID) REFERENCES Events_(EventID)
);
