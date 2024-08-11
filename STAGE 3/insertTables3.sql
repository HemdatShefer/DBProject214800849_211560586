-- Insert data into Customers
INSERT INTO Customers (CustomerID, FirstName, LastName, PhoneNumber, BirthdayDate, LastPurchaseDate)
VALUES (1000, 'John', 'Doe', '1234567890', TO_DATE('01-01-1980', 'DD-MM-YYYY'), TO_DATE('01-06-2023', 'DD-MM-YYYY'));

INSERT INTO Customers (CustomerID, FirstName, LastName, PhoneNumber, BirthdayDate, LastPurchaseDate)
VALUES (2000, 'Jane', 'Smith', '0987654321', TO_DATE('02-02-1990', 'DD-MM-YYYY'), TO_DATE('02-06-2023', 'DD-MM-YYYY'));

-- Insert data into Venues
INSERT INTO Venues (VenueID, Name, Location, Capacity, OpenDate, RenovationDate)
VALUES (1000, 'Grand Hall', '123 Main St', 500, TO_DATE('01-01-2000', 'DD-MM-YYYY'), TO_DATE('01-01-2020', 'DD-MM-YYYY'));

INSERT INTO Venues (VenueID, Name, Location, Capacity, OpenDate, RenovationDate)
VALUES (2000, 'Conference Center', '456 Elm St', 200, TO_DATE('05-05-2005', 'DD-MM-YYYY'), TO_DATE('05-05-2015', 'DD-MM-YYYY'));

-- Insert data into Catering
INSERT INTO Catering (CateringID, Name, MenuDescription, ContractStartDate, ContractEndDate)
VALUES (1000, 'Gourmet Catering', 'Full service catering with a wide variety of menu options', TO_DATE('01-01-2020', 'DD-MM-YYYY'), TO_DATE('01-01-2025', 'DD-MM-YYYY'));

INSERT INTO Catering (CateringID, Name, MenuDescription, ContractStartDate, ContractEndDate)
VALUES (2000, 'Event Catering', 'Specializing in corporate and private events', TO_DATE('01-06-2019', 'DD-MM-YYYY'), TO_DATE('01-06-2024', 'DD-MM-YYYY'));

-- Insert data into Events_
INSERT INTO Events_ (EventID, EventDate, EndTime, CustomerID, VenueID)
VALUES (1000, TO_DATE('25-12-2023', 'DD-MM-YYYY'), TO_TIMESTAMP('25-12-2023 18:00', 'DD-MM-YYYY HH24:MI'), 1000, 1000);

INSERT INTO Events_ (EventID, EventDate, EndTime, CustomerID, VenueID)
VALUES (2000, TO_DATE('31-12-2023', 'DD-MM-YYYY'), TO_TIMESTAMP('31-12-2023 23:00', 'DD-MM-YYYY HH24:MI'), 2000, 2000);

-- Insert data into Guests
INSERT INTO Guests (GuestID, RelationshipLevel, FirstName, LastName, InvitationDate, BirthdayDate, EventID, CustomerID)
VALUES (1000, 'Friend', 'Alice', 'Brown', TO_DATE('01-11-2023', 'DD-MM-YYYY'), TO_DATE('15-03-1985', 'DD-MM-YYYY'), 1000, 1000);

INSERT INTO Guests (GuestID, RelationshipLevel, FirstName, LastName, InvitationDate, BirthdayDate, EventID, CustomerID)
VALUES (2000, 'Colleague', 'Bob', 'Green', TO_DATE('15-11-2023', 'DD-MM-YYYY'), TO_DATE('30-07-1992', 'DD-MM-YYYY'), 2000, 2000);

-- Insert data into Payments
INSERT INTO Payments (PaymentID, Amount, PaymentDate, ProcessedDate, CustomerID, EventID)
VALUES (1000, 500.00, TO_DATE('10-06-2023', 'DD-MM-YYYY'), TO_DATE('11-06-2023', 'DD-MM-YYYY'), 1000, 1000);

INSERT INTO Payments (PaymentID, Amount, PaymentDate, ProcessedDate, CustomerID, EventID)
VALUES (2000, 750.00, TO_DATE('15-06-2023', 'DD-MM-YYYY'), TO_DATE('16-06-2023', 'DD-MM-YYYY'), 2000, 2000);

-- Insert data into has_catering
INSERT INTO has_catering (CateringID, EventID)
VALUES (1000, 1000);

INSERT INTO has_catering (CateringID, EventID)
VALUES (2000, 2000);
