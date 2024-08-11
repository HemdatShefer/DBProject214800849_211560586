CREATE OR REPLACE FUNCTION GetCustomerTotalPayments(p_CustomerID IN NUMBER) RETURN NUMBER IS
    v_TotalPayments NUMBER;
BEGIN
    SELECT SUM(Amount)
    INTO v_TotalPayments
    FROM Payments
    WHERE CustomerID = p_CustomerID;

    RETURN NVL(v_TotalPayments, 0);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
    WHEN OTHERS THEN
        RETURN -1; -- Error indicator
END GetCustomerTotalPayments;
/





CREATE OR REPLACE FUNCTION GetEventGuestCount(p_EventID IN NUMBER) RETURN NUMBER IS
    v_GuestCount NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_GuestCount
    FROM Guests
    WHERE EventID = p_EventID;

    RETURN v_GuestCount;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
    WHEN OTHERS THEN
        RETURN -1; -- Error indicator
END GetEventGuestCount;
/



