--query 1 -  identify customers based on their event count
SELECT
    EventID,
    ProfitMarginPercent
FROM
    Basic_Event_Financial_View
ORDER BY
    ProfitMarginPercent DESC

--query 2 - analyze and rank venues based on the average number of guests per event
SELECT
    EXTRACT(YEAR FROM EventDate) AS EventYear,
    SUM(EventRevenue) AS TotalRevenue,
    SUM(ProducerCost + SingerCost + CateringCost) AS TotalCosts,
    SUM(NetProfit) AS TotalNetProfit
FROM
    Basic_Event_Financial_View
WHERE
    EXTRACT(YEAR FROM EventDate) >= EXTRACT(YEAR FROM SYSDATE) - 2
GROUP BY
    EXTRACT(YEAR FROM EventDate)
ORDER BY
    EXTRACT(YEAR FROM EventDate);
