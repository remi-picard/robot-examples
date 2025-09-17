*** Settings ***
Library     String
Library     Collections
Library     OperatingSystem
Library     resources/robot_flower_princess/board_helper.py


*** Keywords ***
Compute Distance
    [Arguments]
    ...    ${pos1}
    ...    ${pos2}
    ${delta_x}=    Evaluate    ${pos2.x} - ${pos1.x}
    ${delta_y}=    Evaluate    ${pos2.y} - ${pos1.y}
    ${pos}=    Build Position    ${delta_x}    ${delta_y}
    RETURN    ${pos}

Get Piece Position
    [Arguments]
    ...    ${board}
    ...    ${piece}
    ${result}=    Evaluate    next(c.pos for c in $board if c.piece == "${piece}")
    RETURN    ${result}

Build And Display Board
    [Arguments]
    ...    ${game_id}
    ...    ${display}=${True}
    ${board}=    Get Board    ${game_id}
    ${board}=    Set Variable    ${board}[board]
    IF    ${display}    Display Board As Table    ${board}
    # Console Pause
    ${board}=    Build Board    ${board}
    RETURN    ${board}

Refresh Board And Get Robot Position
    [Arguments]
    ...    ${game_id}
    ...    ${display}=${True}
    ${board}=    Build And Display Board    ${game_id}    ${display}
    ${robot}=    Get Piece Position    ${board}    R
    RETURN    ${board}    ${robot}

Get Piece
    [Arguments]
    ...    ${board}
    ...    ${x}
    ...    ${y}
    ${piece}=    Evaluate    next(c.piece for c in $board if c.pos.x == ${x} and c.pos.y == ${y})
    RETURN    ${piece}

Console Pause
    [Documentation]    Met en pause Robot. Utile en cas de DEBUG.
    Log To Console    \nPress ENTER to continue...
    Run    read ignore

Build Board
    [Tags]    robot:private
    [Arguments]    ${board}
    ${cells}=    Create List
    @{board_lines}=    Split String    ${board}    \n
    ${y}=    Set Variable    ${0}
    FOR    ${board_line}    IN    @{board_lines}
        ${x}=    Set Variable    ${0}
        ${cols}=    Split String To Characters    ${board_line}
        FOR    ${col}    IN    @{cols}
            ${cell}=    Build Cell    ${x}    ${y}    ${col}
            Append To List    ${cells}    ${cell}
            ${x}=    Set Variable    ${${x} + 1}
        END
        ${y}=    Set Variable    ${${y} + 1}
    END
    RETURN    ${cells}

Display Board As Table
    [Tags]    robot:private
    [Arguments]    ${board}
    @{board_lines}=    Split String    ${board}    \n

    ${lines}=    Create List

    FOR    ${board_line}    IN    @{board_lines}
        ${line}=    Set Variable    ${EMPTY}

        ${cols}=    Split String To Characters    ${board_line}
        FOR    ${col}    IN    @{cols}
            ${col}=    Format Cell    ${col}
            ${cell}=    Format String    <td style="padding: 5px 10px; border: 1px solid;">{}</td>    ${col}
            ${line}=    Catenate    SEPARATOR=    ${line}    ${cell}
        END
        ${line}=    Format String    <tr>{}</tr>    ${line}
        Append To List    ${lines}    ${line}
    END
    ${lines_str}=    Evaluate    "".join(${lines})

    ${board_table}=    Format String    <table style="border-spacing: 0;">{}</table>    ${lines_str}
    Log    ${board_table}    html=${True}

Format Cell
    [Tags]    robot:private
    [Arguments]    ${cell}
    IF    "${cell}" == "V"
        ${formatted_cell}=    Set Variable    ${SPACE}
    ELSE IF    "${cell}" == "R"
        ${formatted_cell}=    Set Variable    🤖
    ELSE IF    "${cell}" == "D"
        ${formatted_cell}=    Set Variable    🗑
    ELSE IF    "${cell}" == "F"
        ${formatted_cell}=    Set Variable    🌷
    ELSE IF    "${cell}" == "P"
        ${formatted_cell}=    Set Variable    👸🏻
    END
    RETURN    ${formatted_cell}
