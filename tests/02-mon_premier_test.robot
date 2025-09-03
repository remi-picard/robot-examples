*** Settings ***
Library     String


*** Test Cases ***
Mon Premier Test
    ${chaine}=    Generate Random String    10
    Log    Hello ${chaine}
