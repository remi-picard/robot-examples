*** Settings ***
Library     RequestsLibrary


*** Test Cases ***
Quick Get Request Test
    ${response}    GET    https://www.google.com

Quick Get Request With Parameters Test
    ${response}    GET    https://www.google.com/search    params=query=ciao    expected_status=200

Quick Get A JSON Body Test
    ${response}    GET    https://jsonplaceholder.typicode.com/posts/1
    Should Be Equal As Strings    1    ${response.json()}[id]

Create Booking
    ${booking_dates}    Create Dictionary    checkin=2022-12-31    checkout=2023-01-01
    ${body}    Create Dictionary
    ...    firstname=Hans
    ...    lastname=Gruber
    ...    totalprice=200
    ...    depositpaid=false
    ...    bookingdates=${booking_dates}
    ${response}    POST    url=https://restful-booker.herokuapp.com/booking    json=${body}
    ${id}    Set Variable    ${response.json()}[bookingid]
