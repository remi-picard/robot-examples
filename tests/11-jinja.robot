*** Settings ***
Library     OperatingSystem
Library     resources/file_helper.py


*** Test Cases ***
Creer Fichier Avec Un Template
    ${ligne1}    Create Dictionary    variable=Ligne 1
    ${ligne2}    Create Dictionary    variable=Ligne 2
    ${data}    Create List    ${ligne1}    ${ligne2}
    Creer Fichier    data/output/mon_fichier.csv    ${data}


*** Keywords ***
Creer Fichier
    [Arguments]    ${path}    ${data}
    ${contenu}    Charger Template    ${data}
    ${fichier}    Create File    ${path}    ${contenu}
    ${contenu}    Get File    ${path}
    Log    ${contenu}
