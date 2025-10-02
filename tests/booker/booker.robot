*** Settings ***
Resource    resources/booker/booker_api.resource


*** Test Cases ***
Create And Update Booking
    ${response}    Create Booking    Rémi    PICARD    300    True    2025-10-01    2025-10-03    Breakfast
    ${booking_id}    Set Variable    ${response}[bookingid]
    ${response}    Get Booking    ${booking_id}

    VAR    &{booking_dates}    checkin=2025-10-01    checkout=2025-10-03
    Assert Booking
...    firstname=Rémi
...    lastname=PICARD
...    totalprice=300
...    depositpaid=True
...    bookingdates=${booking_dates}
...    additionalneeds=Breakfast

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

    Assert Booking
...    firstname=Rémi
...    lastname=PICARD
...    totalprice=342
...    depositpaid=True
...    bookingdates=${booking_dates}
...    additionalneeds=Parking

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


*** Keywords ***
Assert Booking
    [Arguments]    &{booking}
    FOR    ${field}    ${expected}    IN    &{booking}
        ${is_dict}    Evaluate    isinstance($expected, dict)
        IF    ${is_dict}
            FOR    ${field_level2}    ${expected}    IN    &{booking}[${field}]
                Should Be Equal As Strings    ${booking}[${field}][${field_level2}]    ${expected}
            END
        ELSE
            Should Be Equal As Strings    ${booking}[${field}]    ${expected}
        END
    END
