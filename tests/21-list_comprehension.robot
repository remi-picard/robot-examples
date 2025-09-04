*** Settings ***
Library     resources/robot_helper.py


*** Test Cases ***
Teste List Comprehension
    ${c3po}=    Build Immutable Robot    C3PO    Jaune
    ${r2d2}=    Build Immutable Robot    R2D2    Bleue

    ${robots}=    Create List    ${c3po}    ${r2d2}

    # Utilisez $robots (pas ${robots}) dans les expressions Python
    ${robots_jaunes}=    Evaluate    [r for r in $robots if r.color == "Jaune"]
