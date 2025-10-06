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
    ### Solution 1 :
    ### Recherche de l'indice de la tâche recherchée
    ### Sélecteur CSS
    # ${i}    Get Num Task    ${search}
    # Click    .todo-list li:nth-child(${i}) .toggle

    ### Solution 2 :
    ### Recherche de l'indice de la tâche recherchée
    ### Sélecteur XPATH
    # ${i}    Get Num Task    ${search}
    # Click    xpath=//ul[@class="todo-list"]/li[${i}]/*/input[@class="toggle"]

    ### Solution 3 :
    ### Sélecteur CSS ET pseudo-classe Playwright :has-text
    # Click    li[data-testid="todo-item"]:has-text("${search}") >> input.toggle

    ### Solution 4 :
    ### Syntaxe Playwright pour trouver la liste avec le texte recherché
    ### Syntaxe Playwright pour remonter d'un cran (avec ..)
    ### Utilisation du Keyword Check Checkbox
    Check Checkbox    "${search}" >> .. >> input.toggle

Remove Task
    [Arguments]    ${search}
    ### Solution 1 :
    ### Recherche de l'indice de la tâche recherchée
    ### Sélecteur CSS
    # ${i}    Get Num Task    ${search}
    # VAR    ${li_selector}    .todo-list li:nth-child(${i})
    # Hover    ${li_selector}
    # Click    ${li_selector} button.destroy

    ### Solution 2 :
    ### Recherche de l'indice de la tâche recherchée
    ### Sélecteur XPATH
    # ${i}    Get Num Task    ${search}
    # Hover    xpath=//ul[@class="todo-list"]/li[${i}]
    # Click    xpath=//ul[@class="todo-list"]/li[${i}]/*/button[@class="destroy"]

    ### Solution 3 :
    ### Selecteur text pour Hover la liste
    ### Syntaxe Playwright pour trouver la liste avec le texte recherché
    ### Syntaxe Playwright pour remonter d'un cran (avec ..)
    Hover    text=${search}
    Click    "${search}" >> .. >> button.destroy

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
