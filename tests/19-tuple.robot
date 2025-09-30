*** Test Cases ***
Teste Les Tuples
    ${robots}=    Get Robots
    Log    ${robots}
    ${robots_type}=    Evaluate    type($robots)
    Log    ${robots_type}
    Log    ${robots[0]}
    Log    ${robots[1]}


*** Keywords ***
Get Robots
    ${robots}=    Evaluate    ("R2D2", "C3PO")
    RETURN    ${robots}
