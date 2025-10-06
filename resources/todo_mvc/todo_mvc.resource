*** Settings ***
Library     Browser
Library     Collections


*** Variables ***
${TODO_MVC_URL}         https://todomvc.com/examples/react/dist/
${TODO_LIST}            css=.todo-list li label
${TODO_INPUT}           id=todo-input
${CLEAR_COMPLETED}      css=footer > .clear-completed
${TODO_COUNT}           css=footer > .todo-count


*** Keywords ***
Go To Todo Mvc
    New Page    ${TODO_MVC_URL}
    Get Title    contains    TodoMVC

Create Task
    [Arguments]    ${task}
    Fill Text    ${TODO_INPUT}    ${task}
    Keyboard Key    press    Enter

Get All Tasks
    ${tasks}    Get Tasks    All
    RETURN    ${tasks}

Get Active Tasks
    ${tasks}    Get Tasks    Active
    RETURN    ${tasks}

Get Completed Tasks
    ${tasks}    Get Tasks    Completed
    RETURN    ${tasks}

Get Tasks
    [Tags]    robot:private
    [Arguments]    ${filter}
    Click    footer > ul a >> "${filter}"
    ${elements}    Get Elements    ${TODO_LIST}
    ${tasks}    Create List
    FOR    ${element}    IN    @{elements}
        ${text}    Get Text    ${element}
        Append To List    ${tasks}    ${text}
    END
    RETURN    ${tasks}

Toggle Task
    [Arguments]    ${search}
    ${i}    Get Num Task    ${search}
    Click    .todo-list li:nth-child(${i}) .toggle

Remove Task
    [Arguments]    ${search}
    ${i}    Get Num Task    ${search}
    Hover    .todo-list li:nth-child(${i})
    Click    .todo-list li:nth-child(${i}) button.destroy
    Take Screenshot

Assert Number Of Left Tasks Is ${nb}
    ${text}    Get Text    ${TODO_COUNT}
    IF    ${nb} == 1
        Should Be Equal As Strings    ${text}    1 item left!
    ELSE
        Should Be Equal As Strings    ${text}    ${nb} items left!
    END

Clear Tasks
    Click    ${CLEAR_COMPLETED}

Assert Tasks
    [Arguments]    ${tasks}    @{expected_tasks}
    Lists Should Be Equal    ${tasks}    ${expected_tasks}

Get Num Task
    [Tags]    robot:private
    [Arguments]    ${search}
    ${elements}    Get Elements    ${TODO_LIST}
    ${i}    Set Variable    1
    ${found}    Set Variable    ${False}
    FOR    ${element}    IN    @{elements}
        ${text}    Get Text    ${element}
        IF    "${text}" == "${search}"
            ${found}    Set Variable    ${True}
            BREAK
        ELSE
            ${i}    Evaluate    ${i} + 1
        END
    END
    IF    not(${found})    Fail    Impossible de trouver la tâche "${search}"
    RETURN    ${i}
