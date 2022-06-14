*** Keywords ***
*** Settings ***
Resource          load_resources.resource
Test Teardown     Delete a pet
Force Tags        api

*** Variables ***
&{PET_ADD}
...    id=100
...    name=Sirius
...    category=dog
...    tags=osito
...    photoUrls=prueba
...    status=available

&{PET_UPDATE}
...    id=100
...    name=Kylo
...    category=dog
...    tags=perrito
...    photoUrls=prueba
...    status=available

*** Test Cases ***
Pet Catalog
    Add a pet        ${PET_ADD}
    Get pet by id
    Update a pet     ${PET_UPDATE}
