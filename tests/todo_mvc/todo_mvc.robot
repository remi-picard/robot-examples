*** Settings ***
Library     Browser
Resource    resources/todo_mvc/todo_mvc.resource


*** Test Cases ***
Créer Une Nouvelle Tâche
    # Open Browser
    New Browser    browser=firefox    headless=${False}    slowMo=0.3 seconds

    Go To Todo Mvc
    Create Task    Python
    Create Task    Robot Framework
    Create Task    Playwright

    # Take Screenshot

    ${tasks}    Get All Tasks
    Length Should Be    ${tasks}    3
    List Should Contain Value    ${tasks}    Python
#    Get Element States    .todo-list li label >> "Robot Framework"    contains    visible
    List Should Contain Value    ${tasks}    Robot Framework
    List Should Contain Value    ${tasks}    Playwright

    Toggle Task    Robot Framework

    ${tasks}    Get Active Tasks
    Length Should Be    ${tasks}    2

    ${tasks}    Get Completed Tasks
    Length Should Be    ${tasks}    1

    Get All Tasks
    Remove Task    Python

    Assert Number Of Left Tasks Is ${1}

    Clear Tasks

    ${tasks}    Get Completed Tasks
    Length Should Be    ${tasks}    0

    # Close Browser

Test Headless In Docker
    New Browser
    # Décommenter en cas de problème SSL
    # New Context    ignoreHTTPSErrors=${True}
    New Page    https://todomvc.com/examples/react/dist/
    Take Screenshot
