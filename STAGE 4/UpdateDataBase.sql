
-- Step 1: Ensure the necessary records exist in the Instrument table

-- Insert the missing Instrument records if they do not exist
MERGE INTO Instrument i
USING (SELECT 1 AS InstrumentID, 'Piano' AS InstrumentName, 1500 AS Price FROM dual) src
ON (i.InstrumentID = src.InstrumentID)
WHEN NOT MATCHED THEN
  INSERT (InstrumentID, InstrumentName, Price)
  VALUES (src.InstrumentID, src.InstrumentName, src.Price);

MERGE INTO Instrument i
USING (SELECT 2 AS InstrumentID, 'Violin' AS InstrumentName, 1200 AS Price FROM dual) src
ON (i.InstrumentID = src.InstrumentID)
WHEN NOT MATCHED THEN
  INSERT (InstrumentID, InstrumentName, Price)
  VALUES (src.InstrumentID, src.InstrumentName, src.Price);

MERGE INTO Instrument i
USING (SELECT 3 AS InstrumentID, 'Guitar' AS InstrumentName, 1000 AS Price FROM dual) src
ON (i.InstrumentID = src.InstrumentID)
WHEN NOT MATCHED THEN
  INSERT (InstrumentID, InstrumentName, Price)
  VALUES (src.InstrumentID, src.InstrumentName, src.Price);

-- Step 2: Insert into Instrument_Event after ensuring the Instrument records exist

MERGE INTO Instrument_Event ie
USING (SELECT 1 AS InstrumentID, 1000 AS EventID FROM dual) src
ON (ie.InstrumentID = src.InstrumentID AND ie.EventID = src.EventID)
WHEN NOT MATCHED THEN
  INSERT (InstrumentID, EventID)
  VALUES (src.InstrumentID, src.EventID);

MERGE INTO Instrument_Event ie
USING (SELECT 2 AS InstrumentID, 2000 AS EventID FROM dual) src
ON (ie.InstrumentID = src.InstrumentID AND ie.EventID = src.EventID)
WHEN NOT MATCHED THEN
  INSERT (InstrumentID, EventID)
  VALUES (src.InstrumentID, src.EventID);

MERGE INTO Instrument_Event ie
USING (SELECT 3 AS InstrumentID, 1000 AS EventID FROM dual) src
ON (ie.InstrumentID = src.InstrumentID AND ie.EventID = src.EventID)
WHEN NOT MATCHED THEN
  INSERT (InstrumentID, EventID)
  VALUES (src.InstrumentID, src.EventID);



-- Step 1: Ensure the necessary records exist in the Producer table

-- Insert the missing Producer records if they do not exist
MERGE INTO Producer p
USING (SELECT 1 AS ProducerID, 'John Producer' AS ProducerName, 3000 AS Price FROM dual) src
ON (p.ProducerID = src.ProducerID)
WHEN NOT MATCHED THEN
  INSERT (ProducerID, ProducerName, Price)
  VALUES (src.ProducerID, src.ProducerName, src.Price);

MERGE INTO Producer p
USING (SELECT 2 AS ProducerID, 'Jane Producer' AS ProducerName, 3500 AS Price FROM dual) src
ON (p.ProducerID = src.ProducerID)
WHEN NOT MATCHED THEN
  INSERT (ProducerID, ProducerName, Price)
  VALUES (src.ProducerID, src.ProducerName, src.Price);

-- Step 2: Ensure the necessary records exist in the Singer table

-- Insert the missing Singer records if they do not exist
MERGE INTO Singer s
USING (SELECT 1 AS SingerID, 'Alice Singer' AS Sname, 2000 AS Price FROM dual) src
ON (s.SingerID = src.SingerID)
WHEN NOT MATCHED THEN
  INSERT (SingerID, Sname, Price)
  VALUES (src.SingerID, src.Sname, src.Price);

MERGE INTO Singer s
USING (SELECT 2 AS SingerID, 'Bob Singer' AS Sname, 2500 AS Price FROM dual) src
ON (s.SingerID = src.SingerID)
WHEN NOT MATCHED THEN
  INSERT (SingerID, Sname, Price)
  VALUES (src.SingerID, src.Sname, src.Price);


-- Step 3: Update existing Customers records with new Email information

-- Update Customers with new Emails
UPDATE Customers
SET Email = 'john.doe@example.com'
WHERE CustomerID = 1000;

UPDATE Customers
SET Email = 'jane.smith@example.com'
WHERE CustomerID = 2000;


UPDATE Events_
SET Total_Price = 2000, ProducerID = 1, SingerID = 1
WHERE EventID = 1000;

UPDATE Events_
SET Total_Price = 3000, ProducerID = 2, SingerID = 2
WHERE EventID = 2000;


-- Update Venues with LastRenovationDate if it is not set
UPDATE Venues
SET LastRenovationDate = TO_DATE('01-01-2020', 'DD-MM-YYYY')
WHERE VenueID = 1000;

UPDATE Venues
SET LastRenovationDate = TO_DATE('05-05-2015', 'DD-MM-YYYY')
WHERE VenueID = 2000;



MERGE INTO Instrument_Event ie
USING (SELECT 1 AS InstrumentID, 1000 AS EventID FROM dual) src
ON (ie.InstrumentID = src.InstrumentID AND ie.EventID = src.EventID)
WHEN NOT MATCHED THEN
  INSERT (InstrumentID, EventID)
  VALUES (src.InstrumentID, src.EventID);


MERGE INTO Instrument_Event ie
USING (SELECT 2 AS InstrumentID, 2000 AS EventID FROM dual) src
ON (ie.InstrumentID = src.InstrumentID AND ie.EventID = src.EventID)
WHEN NOT MATCHED THEN
  INSERT (InstrumentID, EventID)
  VALUES (src.InstrumentID, src.EventID);

-- Update Guests to ensure they have the correct RelationshipLevel
UPDATE Guests
SET RelationshipLevel = 'Friend'
WHERE GuestID = 1000;

UPDATE Guests
SET RelationshipLevel = 'Colleague'
WHERE GuestID = 2000;

MERGE INTO has_catering hc
USING (SELECT 1000 AS CateringID, 1000 AS EventID FROM dual) src
ON (hc.CateringID = src.CateringID AND hc.EventID = src.EventID)
WHEN NOT MATCHED THEN
  INSERT (CateringID, EventID)
  VALUES (src.CateringID, src.EventID);

MERGE INTO has_catering hc
USING (SELECT 2000 AS CateringID, 2000 AS EventID FROM dual) src
ON (hc.CateringID = src.CateringID AND hc.EventID = src.EventID)
WHEN NOT MATCHED THEN
  INSERT (CateringID, EventID)
  VALUES (src.CateringID, src.EventID);
