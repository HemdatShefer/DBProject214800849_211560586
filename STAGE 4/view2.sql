CREATE OR REPLACE VIEW Basic_Event_Financial_View AS
SELECT
    e.EventID,
    e.EventDate, 
    e.Total_Price AS EventRevenue,
    p.Price AS ProducerCost,
    s.Price AS SingerCost,
    cat.CateringCost AS CateringCost,
    (e.Total_Price - (p.Price + s.Price + cat.CateringCost)) AS NetProfit,
    ROUND(( (e.Total_Price - (p.Price + s.Price + cat.CateringCost)) / NULLIF(e.Total_Price, 0) ) * 100, 2) AS ProfitMarginPercent
FROM
    Events_ e
LEFT JOIN
    Producer p ON e.ProducerID = p.ProducerID
LEFT JOIN
    Singer s ON e.SingerID = s.SingerID
LEFT JOIN
    has_catering hc ON e.EventID = hc.EventID
LEFT JOIN
    Catering cat ON hc.CateringID = cat.CateringID;
