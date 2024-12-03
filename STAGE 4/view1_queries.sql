SELECT
    CustomerName,
    COUNT(EventID) AS NumberOfEvents
FROM
    Basic_Event_Customer_View
GROUP BY
    CustomerName
ORDER BY
    NumberOfEvents DESC;


SELECT
    VenueName,
    ROUND(AVG(NumberOfGuests)) AS AverageGuestsPerEvent
FROM
    Basic_Event_Customer_View
GROUP BY
    VenueName
ORDER BY
    AverageGuestsPerEvent DESC;

