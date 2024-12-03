--query 1 - identify customers based on their event count
SELECT
    CustomerName,
    COUNT(EventID) AS NumberOfEvents
FROM
    Basic_Event_Customer_View
GROUP BY
    CustomerName
ORDER BY
    NumberOfEvents DESC;

--query 2 - analyze and rank venues based on the average number of guests per event
SELECT
    VenueName,
    ROUND(AVG(NumberOfGuests)) AS AverageGuestsPerEvent
FROM
    Basic_Event_Customer_View
GROUP BY
    VenueName
ORDER BY
    AverageGuestsPerEvent DESC;

