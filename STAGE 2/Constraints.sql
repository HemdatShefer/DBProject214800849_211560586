--------------------------------------------------------
-- Constraints
--------------------------------------------------------

-- Adding NOT NULL constraint to Customers' PhoneNumber
ALTER TABLE Customers
MODIFY (PhoneNumber VARCHAR(15) NOT NULL);

-- Adding CHECK constraint to Venues' Capacity to be greater than 0
ALTER TABLE Venues
ADD CONSTRAINT chk_capacity CHECK (Capacity > 0);

-- Adding DEFAULT constraint to Payments' ProcessedDate to SYSDATE
ALTER TABLE Payments
MODIFY (ProcessedDate DATE DEFAULT SYSDATE);
