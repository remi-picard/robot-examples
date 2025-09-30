*** Settings ***
Variables       resources/mes_variables_python.py


*** Variables ***
${nombre}       42
${chaine}       Ma chaîne de caractères
@{tab}          1    2    3
&{map}          clef1=valeur1    clef2=valeur2


*** Test Cases ***
Creation Variable
    ${ma_variable}    Set Variable    C3PO
    Log    ma_variable=${ma_variable}

    # Nouvelle syntaxe RF>=7.0
    VAR    ${ma_variable}    C3PO
    Log    ma_variable=${ma_variable}

Utiliser Variable Python
    Log    variable_python=${variable_python}

Teste Variables
    Log    nombre=${nombre}
    Log    chaine=${chaine}
    Log    tab=${tab}
    Log    map=${map}
