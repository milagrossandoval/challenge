*** Keywords ***
Create an user
    ${user} =            Generate Random String  10  [LETTERS]
    ${password} =        Generate Random String  8  [NUMBERS]
    Click Element        id:signin2
    Wait Until Element Is Visible       id:signInModalLabel
    Input Text           id:sign-username    ${user}
    Wait Until Element Is Visible       id:sign-password
    Input Text           id:sign-password    ${password}
    Capture Page Screenshot
    Click Element        xpath://button[@onclick='register()']
    Handle Alert	     action=ACCEPT
    Log                  User: ${user} pass:${password}    console=True
    Set Test Variable    ${user}
    Set Test Variable    ${password}

Login with user created
    Wait Until Element Is Visible       id:login2
    Click Element        id:login2
    Wait Until Element Is Visible       id:logInModalLabel
    Input Text           id:loginusername    ${user}
    Input Text           id:loginpassword    ${password}
    Capture Page Screenshot
    Click Element        xpath://button[@onclick='logIn()']
    Wait Until Element Is Not Visible       id:logInModalLabel
    Wait Until Element Is Visible           id:nameofuser
    ${user_expected}=    Get Text           id:nameofuser
    Should Be Equal      Welcome ${user}    ${user_expected}

Add a laptop to cart
    Click Element                     xpath://a[contains(text(),'Laptops')]    action_chain=True
    Wait Until Element Is Visible     xpath:(//*[@class='card h-100'])[1]
    Capture Page Screenshot
    @{laptops}=          Get WebElements     xpath:(//*[@class='card h-100'])
    ${random_option}=    Evaluate   random.choice($laptops)   random
    Click Element                    ${random_option}    action_chain=True
    Wait Until Element Is Visible    xpath://*[contains(text(),'Add to cart')]
    ${product_name}=                 Get Text    xpath://h2
    Capture Page Screenshot
    Click Element                    xpath://*[contains(text(),'Add to cart')]
    Handle Alert	                 action=ACCEPT
    Set Test Variable                ${product_name}

Verify if product was added
    Click Element    id:cartur
    Wait Until Element Is Visible    xpath://*[@class='success']
    Table Cell Should Contain        xpath://*[contains(@class,'table-hover')]    2    2    ${product_name}
    Capture Page Screenshot

Logout
    Click Element             id:logout2
    Element Text Should Be    id:signin2    Sign up
    Capture Page Screenshot