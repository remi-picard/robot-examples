*** Settings ***
Library     RequestsLibrary


*** Variables ***
${API_BASE_URL}     http://localhost:8000


*** Keywords ***
Create Game
    [Arguments]
    ...    ${width}=10
    ...    ${height}=10
    ${json}=    Create Dictionary    width=${width}    height=${height}
    ${response}=    POST    ${API_BASE_URL}/games    json=${json}    expected_status=200
    ${response}=    Handle Response    ${response}
    RETURN    ${response}

Get Games
    ${response}=    GET    ${API_BASE_URL}/games    expected_status=200
    ${response}=    Handle Response    ${response}
    RETURN    ${response}

Get Board
    [Arguments]
    ...    ${game_id}
    ${response}=    GET    ${API_BASE_URL}/games/${game_id}/board    expected_status=200
    ${response}=    Handle Response    ${response}
    RETURN    ${response}

Move Robot
    [Arguments]
    ...    ${game_id}
    ...    ${direction}
    ${json}=    Create Dictionary    direction=${direction}
    ${response}=    POST    ${API_BASE_URL}/games/${game_id}/move    json=${json}    expected_status=200
    ${response}=    Handle Response    ${response}
    Should Be Equal    ${response}[success]    ${True}
    RETURN    ${response}

Clean Waste
    [Arguments]
    ...    ${game_id}
    ...    ${direction}
    ${json}=    Create Dictionary    direction=${direction}
    ${response}=    POST    ${API_BASE_URL}/games/${game_id}/clean    json=${json}    expected_status=200
    ${response}=    Handle Response    ${response}
    Should Be Equal    ${response}[success]    ${True}
    RETURN    ${response}

Pick Up Flower
    [Arguments]
    ...    ${game_id}
    ...    ${direction}
    ...    ${expected_status}=200
    ${json}=    Create Dictionary    direction=${direction}
    ${response}=    POST    ${API_BASE_URL}/games/${game_id}/pickup    json=${json}    expected_status=200
    ${response}=    Handle Response    ${response}
    Should Be Equal    ${response}[success]    ${True}
    RETURN    ${response}

Drop Flower
    [Arguments]
    ...    ${game_id}
    ...    ${direction}
    ${json}=    Create Dictionary    direction=${direction}
    ${response}=    POST    ${API_BASE_URL}/games/${game_id}/drop    json=${json}    expected_status=200
    ${response}=    Handle Response    ${response}
    Should Be Equal    ${response}[success]    ${True}
    RETURN    ${response}

Handle Response
    [Tags]    robot:private
    [Arguments]    ${response}
    IF    ${response.status_code} == 200
        RETURN    ${response.json()}
    ELSE
        RETURN    ${response}
    END
