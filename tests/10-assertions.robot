*** Test Cases ***
Some Assertions
    ${var}=    Set Variable    1.0
    Should Not Be Equal    1    ${var}
    Should Be Equal As Numbers    1    ${var}
    Should Be Equal As Strings    1.0    ${var}
    Should Be True    ${var} == 1.0
    Should Not Be True    ${var} > 10

    ${string}=    Set Variable    My String
    Should Start With    ${string}    My
    Length Should Be    ${string}    9
