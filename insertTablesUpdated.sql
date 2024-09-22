-- Insert data into Venues
INSERT INTO Venues (VenueID, Name, Location, Capacity, OpenDate, RenovationDate)
VALUES (100001, 'Grand Hall', '123 Main St', 500, TO_DATE('01-01-2000', 'DD-MM-YYYY'), TO_DATE('01-01-2020', 'DD-MM-YYYY'));

INSERT INTO Venues (VenueID, Name, Location, Capacity, OpenDate, RenovationDate)
VALUES (100002, 'Conference Center', '456 Elm St', 200, TO_DATE('05-05-2005', 'DD-MM-YYYY'), TO_DATE('05-05-2015', 'DD-MM-YYYY'));

INSERT INTO Venues (VenueID, Name, Location, Capacity, OpenDate, RenovationDate)
VALUES (100003, 'Sunset Venue', '789 Oak St', 300, TO_DATE('12-06-2010', 'DD-MM-YYYY'), TO_DATE('12-06-2020', 'DD-MM-YYYY'));

INSERT INTO Venues (VenueID, Name, Location, Capacity, OpenDate, RenovationDate)
VALUES (100004, 'Lakeside Pavilion', '101 Maple St', 400, TO_DATE('22-04-2012', 'DD-MM-YYYY'), TO_DATE('22-04-2022', 'DD-MM-YYYY'));



-- Insert data into Customers
INSERT INTO Customers (CustomerID, FirstName, LastName, PhoneNumber, BirthdayDate, LastPurchaseDate)
VALUES (1000, 'John', 'Doe', '1234567890', TO_DATE('01-01-1980', 'DD-MM-YYYY'), TO_DATE('01-06-2023', 'DD-MM-YYYY'));

INSERT INTO Customers (CustomerID, FirstName, LastName, PhoneNumber, BirthdayDate, LastPurchaseDate)
VALUES (2000, 'Jane', 'Smith', '0987654321', TO_DATE('02-02-1990', 'DD-MM-YYYY'), TO_DATE('02-06-2023', 'DD-MM-YYYY'));

-- Insert data into Customers
INSERT INTO Customers (CustomerID, FirstName, LastName, PhoneNumber, BirthdayDate, LastPurchaseDate)
VALUES (3000, 'Yuval', 'Lavi', '0537778902', TO_DATE('10-01-1999', 'DD-MM-YYYY'), TO_DATE('01-06-2023', 'DD-MM-YYYY'));

INSERT INTO Customers (CustomerID, FirstName, LastName, PhoneNumber, BirthdayDate, LastPurchaseDate)
VALUES (4000, 'Maya', 'Cohen', '0548930292', TO_DATE('24-09-2000', 'DD-MM-YYYY'), TO_DATE('12-02-2026', 'DD-MM-YYYY'));



-- Insert data into Catering
INSERT INTO Catering (CateringID, Name, MenuDescription, ContractStartDate, ContractEndDate)
VALUES (200001, 'Gourmet Catering', 'Full service catering with a wide variety of menu options', TO_DATE('01-01-2020', 'DD-MM-YYYY'), TO_DATE('01-01-2025', 'DD-MM-YYYY'));

INSERT INTO Catering (CateringID, Name, MenuDescription, ContractStartDate, ContractEndDate)
VALUES (200002, 'Event Catering', 'Specializing in corporate and private events', TO_DATE('01-06-2019', 'DD-MM-YYYY'), TO_DATE('01-06-2024', 'DD-MM-YYYY'));

INSERT INTO Catering (CateringID, Name, MenuDescription, ContractStartDate, ContractEndDate)
VALUES (200003, 'Elegant Eats', 'Delicious meals for all occasions', TO_DATE('01-01-2021', 'DD-MM-YYYY'), TO_DATE('01-01-2026', 'DD-MM-YYYY'));

INSERT INTO Catering (CateringID, Name, MenuDescription, ContractStartDate, ContractEndDate)
VALUES (200004, 'The Chef', 'High-end cuisine for weddings and galas', TO_DATE('01-02-2022', 'DD-MM-YYYY'), TO_DATE('01-02-2027', 'DD-MM-YYYY'));


-- Insert data into Events_
INSERT INTO Events_ (EventID, EventDate, EventConfirmationDate, CustomerID, VenueID)
VALUES (300001, TO_DATE('25-12-2023', 'DD-MM-YYYY'), TO_DATE('29-12-2021', 'DD-MM-YYYY'), 1000, 100001);

INSERT INTO Events_ (EventID, EventDate, EventConfirmationDate, CustomerID, VenueID)
VALUES (300002, TO_DATE('31-12-2023', 'DD-MM-YYYY'), TO_DATE('13-08-2021', 'DD-MM-YYYY'), 2000, 100002);

INSERT INTO Events_ (EventID, EventDate, EventConfirmationDate, CustomerID, VenueID)
VALUES (300003, TO_DATE('10-11-2023', 'DD-MM-YYYY'), TO_DATE('05-09-2021', 'DD-MM-YYYY'), 3000, 100003);

INSERT INTO Events_ (EventID, EventDate, EventConfirmationDate, CustomerID, VenueID)
VALUES (300004, TO_DATE('15-01-2024', 'DD-MM-YYYY'), TO_DATE('02-09-2021', 'DD-MM-YYYY'), 4000, 100004);


-- Insert data into Gusts
INSERT INTO Gusts (GustID, RelationshipLevel, FirstName, LastName, InvitationDate, ConfirmationDate, RSVPStatus, EventID, CustomerID)
VALUES (500001, 'Friend', 'Alice', 'Brown', TO_DATE('11-12-2022', 'DD-MM-YYYY'), TO_DATE('12-12-2022', 'DD-MM-YYYY'), 'Confirmed', 300001, 1000);

INSERT INTO Gusts (GustID, RelationshipLevel, FirstName, LastName, InvitationDate, ConfirmationDate, RSVPStatus, EventID, CustomerID)
VALUES (500002, 'Colleague', 'Bob', 'Green', TO_DATE('15-11-2022', 'DD-MM-YYYY'), TO_DATE('16-11-2022', 'DD-MM-YYYY'), 'Confirmed', 300002, 2000);

INSERT INTO Gusts (GustID, RelationshipLevel, FirstName, LastName, InvitationDate, ConfirmationDate, RSVPStatus, EventID, CustomerID)
VALUES (500003, 'Family', 'Eve', 'Davis', TO_DATE('10-01-2023', 'DD-MM-YYYY'), TO_DATE('11-01-2023', 'DD-MM-YYYY'), 'Confirmed', 300003, 3000);

INSERT INTO Gusts (GustID, RelationshipLevel, FirstName, LastName, InvitationDate, ConfirmationDate, RSVPStatus, EventID, CustomerID)
VALUES (500004, 'Friend', 'Charlie', 'Johnson', TO_DATE('01-11-2022', 'DD-MM-YYYY'), TO_DATE('02-11-2022', 'DD-MM-YYYY'), 'Confirmed', 300004, 4000);

-- Insert data into Payments
INSERT INTO Payments (PaymentID, Amount, PaymentDate, PaymentDeadlineDate, CustomerID, EventID)
VALUES (600001, 500.00, TO_DATE('10-06-2023', 'DD-MM-YYYY'), TO_DATE('01-01-2025', 'DD-MM-YYYY'), 1000, 300001);

INSERT INTO Payments (PaymentID, Amount, PaymentDate, PaymentDeadlineDate, CustomerID, EventID)
VALUES (600002, 750.00, TO_DATE('15-06-2023', 'DD-MM-YYYY'), TO_DATE('01-01-2025', 'DD-MM-YYYY'), 2000, 300002);

INSERT INTO Payments (PaymentID, Amount, PaymentDate, PaymentDeadlineDate, CustomerID, EventID)
VALUES (600003, 300.00, TO_DATE('05-06-2023', 'DD-MM-YYYY'), TO_DATE('01-01-2025', 'DD-MM-YYYY'), 3000, 300003);

INSERT INTO Payments (PaymentID, Amount, PaymentDate, PaymentDeadlineDate, CustomerID, EventID)
VALUES (600004, 1000.00, TO_DATE('20-06-2023', 'DD-MM-YYYY'), TO_DATE('01-01-2025', 'DD-MM-YYYY'), 4000, 300004);

-- Insert data into has_catering
INSERT INTO has_catering (CateringID, EventID)
VALUES (200001, 300001);

INSERT INTO has_catering (CateringID, EventID)
VALUES (200002, 300002);

INSERT INTO has_catering (CateringID, EventID)
VALUES (200003, 300003);

INSERT INTO has_catering (CateringID, EventID)
VALUES (200004, 300004);
