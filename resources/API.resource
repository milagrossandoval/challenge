*** Keywords ***
Generate a pet information
    [Arguments]          ${PET_INF}
    &{pet_dict}=         Create Dictionary
    &{category_dict}=    Create Dictionary
    &{tag_dict}=         Create Dictionary
    @{tags}=             Create List
    @{photos}=           Create List
    ${id}=               Generate Random String  4  [NUMBERS]
    ${index_cat}=        Set Variable    0
    ${index_tag}=        Set Variable    0
    FOR    ${key}    ${value}    IN    &{PET_INF}
        IF     "${key}" in ["id", "name", "status"]
                Set to dictionary    ${pet_dict}    ${key}     ${value}
        ELSE IF     '${key}'=='category'
                Set to dictionary    ${category_dict}    id      ${index_cat}
                Set to dictionary    ${category_dict}    name    ${value}
                Set to dictionary    ${pet_dict}         category     ${category_dict}
                ${index_cat}=    Evaluate    ${index_cat} + 1
        ELSE IF    '${key}'=='tags'
            Set to dictionary    ${tag_dict}    id      ${index_tag}
            Set to dictionary    ${tag_dict}    name    ${value}
            Append To List       ${tags}        ${tag_dict}
            Set to dictionary    ${pet_dict}    tags     ${tags}
            ${index_tag}=    Evaluate    ${index_tag} + 1
        ELSE IF    '${key}'=='photoUrls'
            Append To List       ${photos}    ${value}
            Set to dictionary    ${pet_dict}    photoUrls     ${photos}
        ELSE
            Log    Field doesn't exist.
        END
    END
    Set Test Variable     ${PET_DATA}    ${pet_dict}

Add a pet
    [Arguments]    ${PET_INFORMATION}
    Generate a pet information    ${PET_INFORMATION}
    ${header}=          Create Dictionary   Content-Type=application/json
    ${endpoint}=        Set Variable    /v2/pet
    Create Session      pet    ${URL_API}
    ${api_response}=    POST On Session    pet    ${endpoint}    json=${PET_DATA}    headers=${header}
    Should Be Equal As Integers     ${api_response.status_code}    200
    Validate the response           ${api_response.json()}

Get pet by id
    ${endpoint}=        Set Variable    /v2/pet/${PET_DATA['id']}
    Create Session      pet    ${URL_API}
    ${api_response}=    GET On Session    pet    ${endpoint}
    Should Be Equal As Integers     ${api_response.status_code}    200
    Validate the response           ${api_response.json()}

Update a pet
    [Arguments]    ${PET_INFORMATION}
    Generate a pet information    ${PET_INFORMATION}
    ${header}=          Create Dictionary   Content-Type=application/json
    ${endpoint}=        Set Variable    /v2/pet
    Create Session      pet    ${URL_API}
    ${api_response}=    PUT On Session    pet    ${endpoint}    json=${PET_DATA}    headers=${header}
    Should Be Equal As Integers     ${api_response.status_code}    200
    Validate the response           ${api_response.json()}

Delete a pet
    ${header}=          Create Dictionary   Content-Type=application/json
    ${endpoint}=        Set Variable    /v2/pet/${PET_DATA['id']}
    Create Session      pet    ${URL_API}
    ${api_response}=    DELETE On Session    pet    ${endpoint}    headers=${header}
    Log                 ${api_response.json()}    formatter=repr
    Should Not Be Empty              ${api_response.json()}
    Should Be Equal As Integers      ${api_response.status_code}    200

Validate the response
    [Arguments]                  ${PET_RESPONSE}
    Log                          ${PET_RESPONSE}    formatter=repr
    Should Not Be Empty          ${PET_RESPONSE}
    Should Not Be Equal         '${PET_RESPONSE['id']}'                   'None'
    Should Not Be Equal         '${PET_RESPONSE['name']}'                 'None'
    Should Not Be Equal         '${PET_RESPONSE['photoUrls']}'            'None'
    Should Not Be Equal         '${PET_RESPONSE['tags']}'                 'None'
    Should Not Be Equal         '${PET_RESPONSE['category']['id']}'       'None'
    Should Not Be Equal         '${PET_RESPONSE['category']['name']}'     'None'
    Should Not Be Equal         '${PET_RESPONSE['status']}'               'None'