SELECT EventID, EventDate, CustomerName, ProducerName, Total_Price
FROM Customer_Event_Details_View
WHERE ProducerName = 'John Producer'
ORDER BY EventDate;


SELECT CustomerName, SUM(Total_Price) AS TotalEventPrice
FROM Customer_Event_Details_View
WHERE EventDate > TO_DATE('2023-12-01', 'YYYY-MM-DD')
GROUP BY CustomerName;
