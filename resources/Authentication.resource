*** Keywords ***
Create Browser
    Open Browser                browser=${BROWSER}
    Maximize Browser Window
    Set Screenshot Directory    EMBED

Go To Demoblaze
    [Arguments]    ${URL}
    Create Browser
    Go To          ${URL}
    Wait Until Element Is Visible             id:navbarExample
    Capture Page Screenshot