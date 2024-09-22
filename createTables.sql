-- Create Table : 'Customers'
-- CustomerID : Primary Key
-- FirstName :
-- LastName :
-- PhoneNumber :
-- BirthdayDate :
-- LastPurchaseDate :
CREATE TABLE Customers (
    CustomerID INT NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    PhoneNumber VARCHAR(15) NOT NULL,
    BirthdayDate DATE NOT NULL,
    LastPurchaseDate DATE NOT NULL,
    PRIMARY KEY (CustomerID)
);

-- Create Table : 'Venues'
-- VenueID : Primary Key
-- Name :
-- Location :
-- Capacity :
-- OpenDate :
-- RenovationDate :
CREATE TABLE Venues (
    VenueID INT NOT NULL,
    Name VARCHAR(100) NOT NULL,
    Location VARCHAR(255) NOT NULL,
    Capacity INT NOT NULL,
    OpenDate DATE NOT NULL,
    RenovationDate DATE NOT NULL,
    PRIMARY KEY (VenueID)
);

-- Create Table : 'Catering'
-- CateringID : Primary Key
-- Name :
-- MenuDescription :
-- ContractStartDate :
-- ContractEndDate :
CREATE TABLE Catering (
    CateringID INT NOT NULL,
    Name VARCHAR(100) NOT NULL,
    MenuDescription VARCHAR(500) NOT NULL,
    ContractStartDate DATE NOT NULL,
    ContractEndDate DATE NOT NULL,
    PRIMARY KEY (CateringID)
);

-- Create Table : 'Events_'
-- EventID : Primary Key
-- EventDate :
-- EventConfirmationDate :
-- CustomerID : Foreign Key References Customers(CustomerID)
-- VenueID : Foreign Key References Venues(VenueID)
CREATE TABLE Events_ (
    EventID INT NOT NULL,
    EventDate DATE NOT NULL,
    EventConfirmationDate DATE NOT NULL,
    CustomerID INT NOT NULL,
    VenueID INT NOT NULL,
    PRIMARY KEY (EventID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (VenueID) REFERENCES Venues(VenueID)
);

-- Create Table : 'Guests'
-- GuestID : Primary Key
-- RelationshipLevel :
-- FirstName :
-- LastName :
-- InvitationDate :
-- ConfirmationDate :
-- RSVPStatus :
-- EventID : Foreign Key References Events_(EventID)
-- CustomerID : Foreign Key References Customers(CustomerID)
CREATE TABLE Guests (
    GuestID INT NOT NULL,
    RelationshipLevel VARCHAR(50) NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    InvitationDate DATE NOT NULL,
    ConfirmationDate DATE NOT NULL,
    RSVPStatus VARCHAR(50) NOT NULL,
    EventID INT NOT NULL,
    CustomerID INT NOT NULL,
    PRIMARY KEY (GuestID),
    FOREIGN KEY (EventID) REFERENCES Events_(EventID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Create Table : 'Payments'
-- PaymentID : Primary Key
-- Amount :
-- PaymentDate :
-- PaymentDeadlineDate :
-- CustomerID : Foreign Key References Customers(CustomerID)
-- EventID : Foreign Key References Events_(EventID)
CREATE TABLE Payments (
    PaymentID INT NOT NULL,
    Amount DECIMAL(10, 2) NOT NULL,
    PaymentDate DATE NOT NULL,
    PaymentDeadlineDate DATE NOT NULL,
    CustomerID INT NOT NULL,
    EventID INT NOT NULL,
    PRIMARY KEY (PaymentID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (EventID) REFERENCES Events_(EventID)
);

-- Create Table : 'Has_Catering'
-- CateringID : Foreign Key References Catering(CateringID)
-- EventID : Foreign Key References Events_(EventID)
CREATE TABLE Has_Catering (
    CateringID INT NOT NULL,
    EventID INT NOT NULL,
    PRIMARY KEY (CateringID, EventID),
    FOREIGN KEY (CateringID) REFERENCES Catering(CateringID),
    FOREIGN KEY (EventID) REFERENCES Events_(EventID)
);
