*** Settings ***
Library    Browser
Library    Collections

*** Variables ***
${ENV}          qa
${BASE_URL}     ${EMPTY}
${BROWSER}      chromium
${HEADLESS}     ${TRUE}
${SLOWMO}       0
&{ENVIRONMENTS}    qa=https://www.qa.icscards.nl    prod=https://www.icscards.nl

*** Keywords ***
Start Browser Session
    Should Contain    ${ENVIRONMENTS}    ${ENV}
    IF    not $BASE_URL
        ${base_url}=    Get From Dictionary    ${ENVIRONMENTS}    ${ENV}
        Set Suite Variable    \${BASE_URL}    ${base_url}
    END
    New Browser    ${BROWSER}    headless=${HEADLESS}    slowMo=${SLOWMO}

Open Home Page
    New Context    locale=nl-NL    timezoneId=Europe/Amsterdam    viewport={'width': 1440, 'height': 900}
    New Page    ${BASE_URL}/

Close Browser Session
    Close Browser

Close Test Context
    Run Keyword If Test Failed    Take Screenshot    EMBED
    Close Context
