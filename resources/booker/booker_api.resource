*** Settings ***
Library     RequestsLibrary


*** Variables ***
${BOOKER_API_URL}       https://restful-booker.herokuapp.com


*** Keywords ***
Create Booking
    [Arguments]
    ...    ${firstname}
    ...    ${lastname}
    ...    ${total_price}
    ...    ${deposit_paid}
    ...    ${checkin}
    ...    ${checkout}
    ...    ${additional_needs}
    ...    ${expected_status}=200
    ${booking_dates}=    Create Dictionary    checkin=${checkin}    checkout=${checkout}
    ${json}=    Create Dictionary    firstname=${firstname}    lastname=${lastname}    totalprice=${total_price}
    ...    depositpaid=${deposit_paid}    bookingdates=${booking_dates}    additionalneeds=${additional_needs}
    ${response}=    POST    ${BOOKER_API_URL}/booking    json=${json}    expected_status=${expected_status}
    ${response}=    Handle Response    ${response}
    RETURN    ${response}

Update Booking
    [Documentation]    Update Booking using Cookie Header with auth token
    [Arguments]
    ...    ${booking_id}
    ...    ${token}
    ...    ${firstname}
    ...    ${lastname}
    ...    ${total_price}
    ...    ${deposit_paid}
    ...    ${checkin}
    ...    ${checkout}
    ...    ${additional_needs}
    ...    ${expected_status}=200
    ${booking_dates}=    Create Dictionary    checkin=${checkin}    checkout=${checkout}
    ${json}=    Create Dictionary    firstname=${firstname}    lastname=${lastname}    totalprice=${total_price}
    ...    depositpaid=${deposit_paid}    bookingdates=${booking_dates}    additionalneeds=${additional_needs}
    ${headers}=    Create Dictionary    Cookie=token=${token}
    ${response}=    PUT
    ...    ${BOOKER_API_URL}/booking/${booking_id}
    ...    json=${json}
    ...    expected_status=${expected_status}
    ...    headers=${headers}
    ${response}=    Handle Response    ${response}
    RETURN    ${response}

Get Booking
    [Arguments]    ${booking_id}    ${expected_status}=200
    ${response}=    GET    ${BOOKER_API_URL}/booking/${booking_id}    expected_status=${expected_status}
    ${response}=    Handle Response    ${response}
    RETURN    ${response}

Delete Booking
    [Documentation]    Delete Booking using Basic Auth
    [Arguments]    ${booking_id}    ${auth}    ${expected_status}=201
    ${response}=    DELETE    ${BOOKER_API_URL}/booking/${booking_id}    expected_status=${expected_status}
    ...    auth=${auth}
    ${response}=    Handle Response    ${response}
    RETURN    ${response}

Get Auth Token
    [Arguments]    ${username}    ${password}    ${expected_status}=200
    ${json}=    Create Dictionary    username=${username}    password=${password}
    ${response}=    POST    ${BOOKER_API_URL}/auth    json=${json}    expected_status=${expected_status}
    ${response}=    Handle Response    ${response}
    RETURN    ${response}

Handle Response
    [Tags]    robot:private
    [Arguments]    ${response}
    IF    ${response.status_code} == 200
        RETURN    ${response.json()}
    ELSE
        RETURN    ${response}
    END
