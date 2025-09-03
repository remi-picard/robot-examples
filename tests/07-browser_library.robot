*** Settings ***
Library     Browser


*** Test Cases ***
Go To Playwright With Browser Library
    # Opens a new browser instance. Use this keyword for quick experiments or debugging sessions.
    Open Browser

    New Page    https://playwright.dev/
    Get Title    contains    Playwright
    Take Screenshot

    Click    a >> "Get started"
    Get Element States    h1 >> "Installation"    contains    visible
    Take Screenshot
