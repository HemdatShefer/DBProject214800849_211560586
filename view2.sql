CREATE OR REPLACE VIEW Customer_Event_Details_View AS
SELECT 
    e.EventID,
    e.EventDate,
    e.Total_Price,
    c.CustomerID,
    c.FIRSTNAME AS CustomerName,  -- Corrected column name
    p.ProducerID,
    p.PRODUCERNAME AS ProducerName,  -- Check actual column name in Producer table
    s.SingerID,
    s.Sname AS SingerName
FROM 
    Events_ e
JOIN 
    Customers c ON e.CustomerID = c.CustomerID
JOIN 
    Producer p ON e.ProducerID = p.ProducerID
JOIN 
    Singer s ON e.SingerID = s.SingerID;



