*** Settings ***
Resource    resources/booker/booker_api.resource


*** Test Cases ***
Create And Update Booking
    ${response}    Create Booking    Rémi    PICARD    300    True    2025-10-01    2025-10-03    Breakfast
    ${booking_id}    Set Variable    ${response}[bookingid]
    ${response}    Get Booking    ${booking_id}
    Should Be Equal As Strings    ${response}[firstname]    Rémi
    Should Be Equal As Strings    ${response}[lastname]    PICARD
    Should Be Equal As Strings    ${response}[totalprice]    300
    Should Be Equal As Strings    ${response}[depositpaid]    True
    Should Be Equal As Strings    ${response}[bookingdates][checkin]    2025-10-01
    Should Be Equal As Strings    ${response}[bookingdates][checkout]    2025-10-03
    Should Be Equal As Strings    ${response}[additionalneeds]    Breakfast

    ${response}    Get Auth Token    admin    password123
    ${token}    Set Variable    ${response}[token]

    ${response}    Update Booking
    ...    ${booking_id}
    ...    ${token}
    ...    Rémi
    ...    PICARD
    ...    342
    ...    True
    ...    2025-10-01
    ...    2025-10-03
    ...    Parking
    Should Be Equal As Strings    ${response}[firstname]    Rémi
    Should Be Equal As Strings    ${response}[lastname]    PICARD
    Should Be Equal As Strings    ${response}[totalprice]    342
    Should Be Equal As Strings    ${response}[depositpaid]    True
    Should Be Equal As Strings    ${response}[bookingdates][checkin]    2025-10-01
    Should Be Equal As Strings    ${response}[bookingdates][checkout]    2025-10-03
    Should Be Equal As Strings    ${response}[additionalneeds]    Parking

Update Booking Without Token
    ${response}    Create Booking    Rémi    PICARD    300    True    2025-10-01    2025-10-03    Breakfast
    ${booking_id}    Set Variable    ${response}[bookingid]

    ${response}    Update Booking
    ...    ${booking_id}
    ...    ${EMPTY}
    ...    Rémi
    ...    PICARD
    ...    342
    ...    True
    ...    2025-10-01
    ...    2025-10-03
    ...    Parking
    ...    expected_status=403

Delete Booking
    ${response}    Create Booking    Rémi    PICARD    300    True    2025-10-01    2025-10-03    Breakfast
    ${booking_id}    Set Variable    ${response}[bookingid]

    ${response}    Get Auth Token    admin    password123
    ${token}    Set Variable    ${response}[token]

    Delete Booking    ${booking_id}    ${token}

    Get Booking    ${booking_id}    expected_status=404

Delete Booking With Invalid Token
    ${response}    Create Booking    Rémi    PICARD    300    True    2025-10-01    2025-10-03    Breakfast
    ${booking_id}    Set Variable    ${response}[bookingid]

    Delete Booking    ${booking_id}    WrongToken    expected_status=403
