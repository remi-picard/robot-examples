*** Settings ***
Resource    resources/robot_flower_princess/robot_flower_princess_api.resource
Resource    resources/robot_flower_princess/board.resource


*** Test Cases ***
Deliver Flower To Princess
    ${response}=    Create Game
    ### Intéressant de tester sur un petit board
    # ${response}=    Create Game    3    3
    ${game_id}=    Set Variable    ${response}[game_id]

    ${board}=    Build And Display Board    ${game_id}
    ${flower}=    Get Piece Position    ${board}    F

    ### Sécurise le chemin vers la fleur
    ${robot}=    Clean Path To Flower    ${game_id}    ${flower}

    ### Prend et dépose la fleur sur une case sûre
    ${flower}=    Secure Flower    ${game_id}    ${flower}

    ### Va vers la princesse
    ${princess}=    Get Piece Position    ${board}    P
    ${robot}=    Clean Path To Princess    ${game_id}    ${princess}

    ### Sécurise le chemin entre la princesse et la fleur
    ${robot}=    Clean Path To Flower    ${game_id}    ${flower}

    ### Récupère la fleur
    ${dist}=    Compute Distance    ${robot}    ${flower}
    IF    ${dist.x} == ${-1}
        Pick Up Flower    ${game_id}    G
    ELSE
        Pick Up Flower    ${game_id}    H
    END

    ### Va vers la princesse avec la fleur (le chemin a été sécurisé)
    ${robot}=    Clean Path To Princess    ${game_id}    ${princess}

    ### Offre la fleur à la princesse
    ${dist}=    Compute Distance    ${robot}    ${princess}
    IF    ${dist.x} == ${1}
        Drop Flower    ${game_id}    D
    ELSE
        Drop Flower    ${game_id}    B
    END

    ### Vérifie la victoire
    Assert Win    ${game_id}


*** Keywords ***
Secure Flower
    [Arguments]
    ...    ${game_id}
    ...    ${flower}
    ${board}    ${robot}=    Refresh Board And Get Robot Position    ${game_id}    display=${False}
    ${dist}=    Compute Distance    ${robot}    ${flower}

    IF    ${dist.x} == ${1} and ${dist.y} == ${0}
        # Fleur à droite
        ${pickup_dir}=    Set Variable    D
        IF    ${robot.x} == 0
            ${drop_x}=    Set Variable    ${robot.x}
            ${drop_y}=    Set Variable    ${${robot.y} + 1}
            ${drop_dir}=    Set Variable    B
        ELSE
            ${drop_x}=    Set Variable    ${${robot.x} - 1}
            ${drop_y}=    Set Variable    ${robot.y}
            ${drop_dir}=    Set Variable    G
        END
    ELSE IF    ${dist.x} == ${0} and ${dist.y} == ${1}
        # Fleur en bas
        ${pickup_dir}=    Set Variable    B
        IF    ${robot.y} == 0
            ${drop_x}=    Set Variable    ${${robot.x} - 1}
            ${drop_y}=    Set Variable    ${robot.y}
            ${drop_dir}=    Set Variable    G
        ELSE
            ${drop_x}=    Set Variable    ${robot.x}
            ${drop_y}=    Set Variable    ${${robot.y} -1}
            ${drop_dir}=    Set Variable    H
        END
    END
    Pick Up Flower    ${game_id}    ${pickup_dir}
    # Clean
    ${drop_piece}=    Get Piece    ${board}    ${drop_x}    ${drop_y}
    IF    "${drop_piece}" == "D"    Clean Waste    ${game_id}    ${drop_dir}
    Drop Flower    ${game_id}    ${drop_dir}

    Build And Display Board    ${game_id}
    ${flower}=    Build Position    ${drop_x}    ${drop_y}
    RETURN    ${flower}

Clean Path To Flower
    [Arguments]
    ...    ${game_id}
    ...    ${flower}
    WHILE    ${True}
        ${board}    ${robot}=    Refresh Board And Get Robot Position    ${game_id}    display=${False}

        ${dist}=    Compute Distance    ${robot}    ${flower}
        # Log    ${dist}
        IF    ${dist.x} > 0
            ${piece}=    Get Piece    ${board}    ${${robot.x} + 1}    ${robot.y}
            IF    "${piece}" == 'D'
                Clean Waste    ${game_id}    D
            ELSE IF    "${piece}" == 'F'
                BREAK
            END
            Move Robot    ${game_id}    D
        ELSE IF    ${dist.y} > 0
            ${piece}=    Get Piece    ${board}    ${robot.x}    ${${robot.y} + 1}
            IF    "${piece}" == 'D'
                Clean Waste    ${game_id}    B
            ELSE IF    "${piece}" == 'F'
                BREAK
            END
            Move Robot    ${game_id}    B
        ELSE IF    ${dist.y} < 0
            ${piece}=    Get Piece    ${board}    ${robot.x}    ${${robot.y} - 1}
            IF    "${piece}" == 'D'
                Clean Waste    ${game_id}    H
            ELSE IF    "${piece}" == 'F'
                BREAK
            END
            Move Robot    ${game_id}    H
        ELSE
            ${piece}=    Get Piece    ${board}    ${${robot.x} - 1}    ${robot.y}
            IF    "${piece}" == 'D'
                Clean Waste    ${game_id}    G
            ELSE IF    "${piece}" == 'F'
                BREAK
            END
            Move Robot    ${game_id}    G
        END
    END
    ${board}    ${robot}=    Refresh Board And Get Robot Position    ${game_id}
    RETURN    ${robot}

Clean Path To Princess
    [Arguments]
    ...    ${game_id}
    ...    ${princess}
    WHILE    ${True}
        ${board}    ${robot}=    Refresh Board And Get Robot Position    ${game_id}    display=${False}

        ${dist}=    Compute Distance    ${robot}    ${princess}
        # Log    ${dist}
        IF    ${dist.x} > 0
            ${piece}=    Get Piece    ${board}    ${${robot.x} + 1}    ${robot.y}
            IF    "${piece}" == 'D'
                Clean Waste    ${game_id}    D
            ELSE IF    "${piece}" == 'P'
                BREAK
            END
            Move Robot    ${game_id}    D
        ELSE IF    ${dist.y} > 0
            ${piece}=    Get Piece    ${board}    ${robot.x}    ${${robot.y} + 1}
            IF    "${piece}" == 'D'
                Clean Waste    ${game_id}    B
            ELSE IF    "${piece}" == 'P'
                BREAK
            END
            Move Robot    ${game_id}    B
        END
    END
    ${board}    ${robot}=    Refresh Board And Get Robot Position    ${game_id}
    RETURN    ${robot}

Assert Win
    [Arguments]
    ...    ${game_id}
    ${board}=    Get Board    ${game_id}
    Should Be Equal As Strings    ${board}[status]    GAGNE
