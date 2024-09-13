CREATE OR REPLACE VIEW Detailed_Event_Payments_View AS
SELECT 
    e.EventID,
    e.EventDate,
    e.Total_Price,
    p.PaymentID,
    p.Amount AS PaymentAmount,
    p.PaymentDate,
    c.CustomerID,
    c.FIRSTNAME AS CustomerName,
    v.VenueID,
    v.Name AS VenueName
FROM 
    Events_ e
JOIN 
    Payments p ON e.EventID = p.EventID
JOIN 
    Customers c ON e.CustomerID = c.CustomerID
JOIN 
    Venues v ON e.VenueID = v.VenueID;
    
    
    


