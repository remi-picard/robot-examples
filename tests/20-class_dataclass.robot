*** Settings ***
Library     resources/robot_helper.py


*** Test Cases ***
Teste Classes Et Dataclasses
    ${c3po}=    Build Robot    C3PO    Jaune
    Log    ${c3po.name}
    Log    ${c3po.color}

    ${r2d2}=    Build Immutable Robot    R2D2    Bleue
    Log    ${r2d2.name}
    Log    ${r2d2.color}
