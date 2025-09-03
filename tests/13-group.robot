*** Test Cases ***
Mon Test Avec Groupes
    GROUP    Groupement de 2 Keywords
        Premier Keyword
        Deuxieme Keyword
    END

    Troisieme Keyword
    Quatrieme Keyword


*** Keywords ***
Premier Keyword
    Log    Keyword1

Deuxieme Keyword
    Log    Keyword2

Troisieme Keyword
    Log    Keyword3

Quatrieme Keyword
    GROUP    Groupe dans un Keyword
        Log    Keyword4
        Log    Keyword4bis
    END
