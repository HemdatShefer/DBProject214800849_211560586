--------------------------------------------------------
-- SELECT Queries
--------------------------------------------------------

-- Query 1: Identifying the Most Popular Venues by Season
--------------------------------------------------------
-- This query categorizes events by season and counts the number of events at each venue during summer and winter.
WITH SeasonalEvents AS (
    SELECT 
        VenueID, EventDate,
        CASE 
            WHEN EXTRACT(MONTH FROM EventDate) IN (6, 7, 8) THEN 'Summer'
            WHEN EXTRACT(MONTH FROM EventDate) IN (12, 1, 2) THEN 'Winter'
            ELSE 'Other'
        END AS Season
    FROM Events_
),
PopularVenues AS (
    SELECT
        VenueID,
        Season,
        COUNT(*) AS EventCount
    FROM SeasonalEvents
    WHERE Season IN ('Summer', 'Winter')
    GROUP BY VenueID, Season
)
SELECT 
    v.VenueID, pv.Season, pv.EventCount
FROM 
    PopularVenues pv
JOIN Venues v ON pv.VenueID = v.VenueID
ORDER BY 
    pv.Season, pv.EventCount DESC;

-- Query 2: Events Exceeding Venue Capacity with Over 100 Confirmed Guests
--------------------------------------------------------
SELECT 
    e.EventID, e.EventDate, COUNT(g.GustID) AS GuestCount, v.Capacity
FROM 
    Events_ e
JOIN 
    Gusts g ON e.EventID = g.EventID
JOIN 
    Venues v ON e.VenueID = v.VenueID
WHERE 
    g.RSVPStatus = 'Confirmed'
GROUP BY 
    e.EventID, e.EventDate, v.Capacity
HAVING 
    COUNT(g.GustID) > 100;


----------------------------------
-- This query finds events where the number of confirmed guests exceeds the venue's capacity.
WITH EventsWithGuests AS (
    SELECT 
        e.EventID, e.EventDate, e.VenueID,
        COUNT(g.GustID) AS GuestCount
    FROM 
        Events_ e
    JOIN 
        Gusts g ON e.EventID = g.EventID
    WHERE 
        g.RSVPStatus = 'Confirmed'
    GROUP BY 
        e.EventID, e.EventDate, e.VenueID
    HAVING 
        COUNT(g.GustID) > 100
),
EventsExceedingCapacity AS (
    SELECT
        eg.EventID, eg.EventDate, eg.VenueID, eg.GuestCount, v.Capacity
    FROM 
        EventsWithGuests eg
    JOIN 
        Venues v ON eg.VenueID = v.VenueID
    WHERE 
        eg.GuestCount > v.Capacity
)
SELECT
    ee.EventID, ee.EventDate, ee.VenueID, v.Name AS VenueName, ee.GuestCount, v.Capacity
FROM
    EventsExceedingCapacity ee
JOIN 
    Venues v ON ee.VenueID = v.VenueID
ORDER BY 
    ee.EventDate;

-- Query 3: Revenue Calculation for All Venues over the Past Five Years
--------------------------------------------------------
-- This query calculates the total revenue generated by each venue over the past five years.
WITH RecentEvents AS (
    SELECT 
        e.EventID, e.EventDate, e.VenueID
    FROM 
        Events_ e
    WHERE 
        e.EventDate >= ADD_MONTHS(SYSDATE, -60) -- Adjusting for a 5-year period
),
TotalPayments AS (
    SELECT
        re.VenueID,
        SUM(p.Amount) AS TotalRevenue
    FROM 
        RecentEvents re 
    JOIN Payments p ON re.EventID = p.EventID
    GROUP BY re.VenueID
)
SELECT
    v.Name AS VenueName, tp.TotalRevenue, ADD_MONTHS(SYSDATE, -60) AS StartDate,
    SYSDATE AS EndDate
FROM 
    TotalPayments tp
JOIN 
    Venues v ON tp.VenueID = v.VenueID
ORDER BY tp.TotalRevenue DESC;



-- Query 4: List of Venues without Renovations in Recent Years and Their Revenues
--------------------------------------------------------
-- This query lists venues that have not been renovated in the last five years along with their total revenues.
SELECT 
    v.Name AS VenueName, 
    SUM(p.Amount) AS TotalRevenue,
    MIN(p.PaymentDate) AS StartPeriod,
    MAX(p.PaymentDate) AS EndPeriod
FROM 
    Venues v
JOIN 
    Events_ e ON v.VenueID = e.VenueID
JOIN 
    Payments p ON e.EventID = p.EventID
WHERE 
    v.RenovationDate IS NULL OR v.RenovationDate < ADD_MONTHS(SYSDATE, -60)
GROUP BY 
    v.Name
ORDER BY 
    v.Name;

--------------------------------------------------------
-- DELETE Queries
--------------------------------------------------------

-- Query 5: Delete Guests Who Did Not Confirm Attendance One Week Before the Event
--------------------------------------------------------
-- This query deletes guests who have not confirmed their attendance at least one week before the event date.
DELETE FROM Gusts
WHERE RSVPStatus != 'Confirmed'
  AND EventID IN (
    SELECT e.EventID
    FROM Events_ e
    WHERE e.EventDate <= TRUNC(SYSDATE) + INTERVAL '7' DAY
  );

-- Query 6: Delete Customers with No Payments in the Last Five Years
--------------------------------------------------------
-- This query deletes customers who have not made any payments in the last five years.
DELETE FROM Customers
WHERE CustomerID NOT IN (
    SELECT DISTINCT CustomerID
    FROM Payments
    WHERE PaymentDate >= ADD_MONTHS(SYSDATE, -60)
);



--------------------------------------------------------
-- UPDATE Queries
--------------------------------------------------------

-- Query 7: Update Renovation Date for Venues with Upcoming Events
--------------------------------------------------------
-- This query updates the renovation date for venues that have upcoming events.
UPDATE Venues v
SET RenovationDate = (
    SELECT MIN(EventDate) + INTERVAL '6' MONTH
    FROM Events_ e
    WHERE e.VenueID = v.VenueID
      AND e.EventDate > SYSDATE
)
WHERE EXISTS (
    SELECT 1
    FROM Events_ e
    WHERE e.VenueID = v.VenueID
      AND e.EventDate > SYSDATE
);

-- Query 8: Extend Catering Contract End Date Based on Upcoming Events
--------------------------------------------------------
-- This query extends the contract end date for catering services that have upcoming events.
UPDATE Catering c
SET ContractEndDate = (
    SELECT MIN(e.EventDate) + INTERVAL '1' YEAR
    FROM has_catering hc
    JOIN Events_ e ON hc.EventID = e.EventID
    WHERE hc.CateringID = c.CateringID
      AND e.EventDate > SYSDATE
)
WHERE EXISTS (
    SELECT 1
    FROM has_catering hc
    JOIN Events_ e ON hc.EventID = e.EventID
    WHERE hc.CateringID = c.CateringID
      AND e.EventDate > SYSDATE
);

INSERT INTO Catering (CateringID, Name, MenuDescription, ContractStartDate, ContractEndDate)
VALUES (9999, 'New Catering Service', 'Delicious food and excellent service', TO_DATE('01/01/2023', 'DD/MM/YYYY'), TO_DATE('31/12/2023', 'DD/MM/YYYY'));

INSERT INTO has_catering (CateringID, EventID)
VALUES (9999, 3000);

SELECT e.EventID, e.EventDate, e.EventConfirmationDate, e.CustomerID, e.VenueID,
       c.CateringID, c.Name, c.MenuDescription, c.ContractStartDate, c.ContractEndDate
FROM Events_ e
JOIN has_catering hc ON e.EventID = hc.EventID
JOIN Catering c ON hc.CateringID = c.CateringID
WHERE c.CateringID = 9999 AND e.EventID = 3000;


SELECT CateringID, Name, MenuDescription, ContractStartDate, ContractEndDate
FROM Catering
WHERE CateringID = 9999;
--------------------------------------------------------
-- DISPLAY QUERIES FOR UPDATES
--------------------------------------------------------

-- Display Query for Venue Renovation Date Update
SELECT v.VenueID, v.Name, v.RenovationDate, MIN(e.EventDate) AS NextEventDate
FROM Venues v
JOIN Events_ e ON v.VenueID = e.VenueID
WHERE e.EventDate > SYSDATE
GROUP BY v.VenueID, v.Name, v.RenovationDate
ORDER BY v.VenueID;

-- Display Query for Catering Contract End Date Update
SELECT c.CateringID, c.Name, c.ContractEndDate, MIN(e.EventDate) AS NextEventDate
FROM Catering c
JOIN has_catering hc ON c.CateringID = hc.CateringID
JOIN Events_ e ON hc.EventID = e.EventID
WHERE e.EventDate > SYSDATE
GROUP BY c.CateringID, c.Name, c.ContractEndDate
ORDER BY c.CateringID;

