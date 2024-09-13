SELECT EventID, EventDate, CustomerName, VenueName, PaymentAmount, PaymentDate
FROM Detailed_Event_Payments_View
WHERE EventDate > TO_DATE('2023-12-01', 'YYYY-MM-DD')
ORDER BY EventDate;


SELECT VenueName, SUM(PaymentAmount) AS TotalPayments
FROM Detailed_Event_Payments_View
WHERE VenueName = 'Grand Hall'
GROUP BY VenueName;
