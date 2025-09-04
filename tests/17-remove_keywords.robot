*** Settings ***
Library     OperatingSystem


*** Test Cases ***
Test Ok
    All Is Ok

Remove Wait Until
    Wait Until Keyword Succeeds    2x    1s    File Should Exist    path=output.txt


*** Keywords ***
All Is Ok
    Should Be Equal    1    1
