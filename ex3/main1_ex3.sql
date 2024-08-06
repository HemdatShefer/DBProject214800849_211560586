DECLARE
    v_TotalPayments NUMBER;
BEGIN
    v_TotalPayments := GetCustomerTotalPayments(1000);
    DBMS_OUTPUT.PUT_LINE('Total Payments for Customer 1000: ' || v_TotalPayments);

    UpdateCustomerPhoneNumber(1000, '1111111111');
    DBMS_OUTPUT.PUT_LINE('Phone number updated for Customer 1000.');
END;
/
