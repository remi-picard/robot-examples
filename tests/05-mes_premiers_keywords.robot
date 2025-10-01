*** Test Cases ***
Appel Keywords
    Mon Premier Keyword
    Mon Premier Keyword Avec Argument    R2D2
    ${nb}    Mon Premier Keyword Avec Argument Et Return    R2D2

    ${arg1}    Set Variable    Ma Variable
    Keyword Avec ${arg1} Intégré
    Keyword Avec ${arg1} Intégré Et Arguments    Arg2

    ${list}    Create List    1    2    3
    # Nouvelle syntaxe
    VAR    @{list}    1    2    3
    Keyword Avec Args    ${list}

    ${map}    Create Dictionary    cle1=valeur1    cle2=valeur2
    # Nouvelle syntaxe
    VAR    &{map}    cle1=valeur1    cle2=valeur2
    Keyword Avec Kwargs    &{map}


*** Keywords ***
Mon Premier Keyword
    Log    Hello World

Mon Premier Keyword Avec Argument
    [Arguments]    ${name}
    Log    Hello ${name}

Mon Premier Keyword Avec Argument Et Return
    [Arguments]    ${name}
    Log    Hello ${name}
    RETURN    42

Keyword Avec ${arg1} Intégré
    Log    Hello ${arg1}

Keyword Avec ${arg1} Intégré Et Arguments
    [Arguments]    ${name}
    Log    Hello ${arg1}, ${name}

Keyword Avec Args
    [Arguments]    @{list}
    FOR    ${i}    IN    @{list}
        Log    i=${i}
    END

Keyword Avec Kwargs
    [Arguments]    &{map}
    FOR    ${k}    ${v}    IN    &{map}
        Log    key=${k}, value=${v}
    END
