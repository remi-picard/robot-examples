*** Settings ***
Library     OperatingSystem


*** Test Cases ***
Attendre Creation Fichier
    Démarrer Batch
    Wait Until Keyword Succeeds    2x    1s    File Should Exist    path=output.txt
    ${fichier}    Get File    path=output.txt
    # ... Assertion sur le fichier


*** Keywords ***
Démarrer Batch
    Log    Start Batch
