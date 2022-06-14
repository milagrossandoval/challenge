*** Settings ***
Resource          load_resources.resource
Test Teardown     Close Browser
Force Tags        add_cart

*** Test Cases ***
Add a laptop into cart
    Go To Demoblaze    ${URL_DEMOBLAZE}
    Create an user
    Login with user created
    Add a laptop to cart
    Verify if product was added
    Logout