DECLARE
    v_GuestCount NUMBER;
BEGIN
    v_GuestCount := GetEventGuestCount(1000);
    DBMS_OUTPUT.PUT_LINE('Guest Count for Event 1000: ' || v_GuestCount);

    CreatePayment(1000, 1000, 250.00);
    DBMS_OUTPUT.PUT_LINE('Payment created for Customer 1000 and Event 1000.');
END;
/


