*** Settings ***
Resource    ../resources/common.resource
Resource    ../resources/home.resource
Suite Setup    Start Browser Session
Suite Teardown    Close Browser Session
Test Setup    Open Home Page
Test Teardown    Close Test Context

*** Test Cases ***
Page title and metadata are correct
    [Tags]    smoke
    Home Page Title And Metadata Should Be Correct

Home page shows a main heading
    [Tags]    smoke
    Main Heading Should Be Visible

Header shows private and business links
    [Tags]    smoke
    Header Should Show Private And Business Links

Navigate to business
    Navigate To Business Page

Menu button opens menu dialog on mobile
    Menu Dialog Should Open

Home page renders at different viewports
    [Template]    Home Page Should Render At Viewport
    [Tags]    responsive
    390    844
    1440    900

No broken internal links
    Internal Links Should Respond Without Errors
