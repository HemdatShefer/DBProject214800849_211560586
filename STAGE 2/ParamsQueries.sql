--------------------------------------------------------
-- Parametrized Queries
--------------------------------------------------------

-- Query 1: Get Events by Venue Name
--------------------------------------------------------
-- This query retrieves events based on the venue name provided as a parameter.
SELECT e.EventID, e.EventDate, e.CustomerID, e.VenueID
FROM Events_ e
JOIN Venues v ON e.VenueID = v.VenueID
WHERE v.Name = '&VenueName';

-- Query 2: Get Customers with Purchases in a Date Range
--------------------------------------------------------
-- This query retrieves customers who made purchases within a specified date range.
SELECT c.CustomerID, c.FirstName, c.LastName, SUM(p.Amount) AS TotalSpent
FROM Customers c
JOIN Payments p ON c.CustomerID = p.CustomerID
WHERE p.PaymentDate BETWEEN TO_DATE('&StartDate', 'YYYY-MM-DD') AND TO_DATE('&EndDate', 'YYYY-MM-DD')
GROUP BY c.CustomerID, c.FirstName, c.LastName
ORDER BY TotalSpent DESC;

-- Query 3: Get Popular Venues by Season
--------------------------------------------------------
-- This query retrieves popular venues by the specified season (e.g., 'Summer' or 'Winter').
WITH SeasonalEvents AS (
    SELECT 
        VenueID, EventDate, EventID, 
        CASE 
            WHEN EXTRACT(MONTH FROM EventDate) IN (6, 7, 8) THEN 'Summer'
            WHEN EXTRACT(MONTH FROM EventDate) IN (12, 1, 2) THEN 'Winter'
            ELSE 'Other'
        END AS Season
    FROM Events_
)
SELECT v.Name, COUNT(e.EventID) AS EventCount
FROM Venues v
JOIN SeasonalEvents e ON v.VenueID = e.VenueID
WHERE e.Season = '&Season'
GROUP BY v.Name
ORDER BY EventCount DESC;


-- Query 4: Get Venues by Capacity Range
--------------------------------------------------------
-- This query retrieves venues within a specified capacity range.
SELECT v.VenueID, v.Name, v.Capacity
FROM Venues v
WHERE v.Capacity BETWEEN &MinCapacity AND &MaxCapacity
ORDER BY v.Capacity;

