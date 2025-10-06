*** Settings ***
Library     Browser
Resource    resources/todo_mvc/todo_mvc.resource


*** Test Cases ***
Manage Tasks
    [Documentation]    Create, Toggle, Delete, List And Filter Tasks
    # Open Browser
    New Browser    browser=firefox    headless=${False}    slowMo=0.3 seconds

    Go To Todo Mvc
    Create Task    Python
    Create Task    Robot Framework
    Create Task    Playwright

    # Take Screenshot

    ${tasks}    Get All Tasks
    Assert Tasks    ${tasks}    Python    Robot Framework    Playwright

    Toggle Task    Robot Framework

    ${tasks}    Get Active Tasks
    Assert Tasks    ${tasks}    Python    Playwright

    ${tasks}    Get Completed Tasks
    Assert Tasks    ${tasks}    Robot Framework

    # List All Tasks Before Removing Python Task
    Get All Tasks

    Remove Task    Python

    ${tasks}    Get All Tasks
    Assert Tasks    ${tasks}    Robot Framework    Playwright
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
