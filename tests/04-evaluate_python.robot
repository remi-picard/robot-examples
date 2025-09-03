*** Test Cases ***
Teste Evaluate
    ${nb}=    Evaluate    41 + 1
    Log    nb=${nb}

Teste Evaluate Autre Syntaxe
    ${nb}=    Set Variable    ${{41 + 1}}
    Log    nb=${nb}
