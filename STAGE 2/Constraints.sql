--------------------------------------------------------
-- Constraints
--------------------------------------------------------

-- This constraint ensures that the ContractEndDate in the Catering table
-- is later than the ContractStartDate. It prevents inserting invalid data
-- where the contract end date is before the start date.
ALTER TABLE Catering
ADD CONSTRAINT chk_contract_dates CHECK (ContractEndDate > ContractStartDate);

-- Trying to insert data that violates chk_contract_dates constraint
INSERT INTO Catering (CateringID, Name, MenuDescription, ContractStartDate, ContractEndDate)
VALUES (9999, 'Faulty Catering', 'Description', TO_DATE('01/01/2023', 'DD/MM/YYYY'), TO_DATE('01/01/2022', 'DD/MM/YYYY'));


-- This constraint ensures that the PhoneNumber in the Customers table
-- is exactly 10 digits long. It prevents inserting phone numbers that do not meet the required length.
ALTER TABLE Customers
ADD CONSTRAINT phone_number_length CHECK (LENGTH(PhoneNumber) = 10);

-- Trying to insert data that violates phone_number_length constraint
INSERT INTO Customers (CustomerID, FirstName, LastName, PhoneNumber, BirthdayDate, LastPurchaseDate)
VALUES (1050, 'Invalid', 'Customer', '12345678901', TO_DATE('01/01/1990', 'DD/MM/YYYY'), TO_DATE('01/01/2020', 'DD/MM/YYYY'));


-- This constraint ensures that the Amount in the Payments table
-- is a positive number (greater than 0). It prevents inserting negative values or zero,
-- ensuring that all payments are valid from a financial perspective.
ALTER TABLE Payments
ADD CONSTRAINT chk_amount_positive CHECK (Amount > 0);

-- Example of inserting valid data into Payments that follows the chk_amount_positive constraint
INSERT INTO Payments (PaymentID, Amount, PaymentDate, ProcessedDate, CustomerID, EventID)
VALUES (600005, 1500.00, TO_DATE('10/06/2023', 'DD/MM/YYYY'), TO_DATE('11/06/2023', 'DD/MM/YYYY'), 400005, 300005);

-- Example of inserting data that violates chk_amount_positive constraint
INSERT INTO Payments (PaymentID, Amount, PaymentDate, ProcessedDate, CustomerID, EventID)
VALUES (600006, -1500.00, TO_DATE('10/06/2023', 'DD/MM/YYYY'), TO_DATE('11/06/2023', 'DD/MM/YYYY'), 400006, 300006);
