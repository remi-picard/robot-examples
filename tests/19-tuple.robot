*** Test Cases ***
Teste Les Tuples
    ${robots}=    Get Robots
    Log    ${robots}
    Log    ${robots[0]}
    Log    ${robots[1]}


*** Keywords ***
Get Robots
    RETURN    R2D2    C3PO
