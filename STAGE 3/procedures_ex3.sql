CREATE OR REPLACE PROCEDURE UpdateCustomerPhoneNumber(p_CustomerID IN NUMBER, p_NewPhoneNumber IN VARCHAR2) IS
BEGIN
    UPDATE Customers
    SET PhoneNumber = p_NewPhoneNumber
    WHERE CustomerID = p_CustomerID;

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END UpdateCustomerPhoneNumber;
/





CREATE OR REPLACE PROCEDURE CreatePayment(p_CustomerID IN NUMBER, p_EventID IN NUMBER, p_Amount IN NUMBER) IS
BEGIN
    INSERT INTO Payments (PaymentID, Amount, PaymentDate, ProcessedDate, CustomerID, EventID)
    VALUES (Payments_seq.NEXTVAL, p_Amount, SYSDATE, SYSDATE, p_CustomerID, p_EventID);

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END CreatePayment;
/
