*** Keywords ***
Home Page Title And Metadata Should Be Correct
    ${title}=    Get Title
    Should Match Regexp    ${title}    ICS .*creditcarduitgever
    ${canonical}=    Get Attribute    css=link[rel="canonical"]    href
    Should Be Equal    ${canonical}    https://www.icscards.nl/
    ${description}=    Get Attribute    css=meta[name="description"]    content
    Should Contain    ${description}    creditcard
    ${language}=    Get Attribute    html    lang
    Should Be Equal    ${language}    nl

Main Heading Should Be Visible
    Wait For Elements State    h1    visible

Header Should Show Private And Business Links
    ${private_current}=    Get Attribute    role=link[name="Privé"]    aria-current
    Should Be Equal    ${private_current}    page
    ${business_href}=    Get Attribute    role=link[name="Zakelijk"]    href
    Should Be Equal    ${business_href}    /zakelijk

Navigate To Business Page
    Click    role=link[name="Zakelijk"]
    ${url}=    Get Url
    Should Match Regexp    ${url}    /zakelijk/?$

Menu Dialog Should Open
    Set Viewport Size    390    844
    Click    css=button[aria-label="Open menudialoog"], button[aria-label="Open menu dialog"]
    Wait For Elements State    css=dialog[open], [role="dialog"]    visible

Home Page Should Render At Viewport
    [Arguments]    ${width}    ${height}
    Set Viewport Size    ${width}    ${height}
    Wait For Elements State    h1    visible

Internal Links Should Respond Without Errors
    ${broken_links}=    Evaluate JavaScript    body    (element) => [...new Set([...document.querySelectorAll("a[href^='/']:not([href^='//'])")].map(a => a.getAttribute('href')))].slice(0, 25).reduce(async (previous, href) => { const failures = await previous; const status = await fetch(href.split('#')[0] || '/').then(response => response.status).catch(() => 0); if (status >= 400) failures.push([href, status]); return failures; }, Promise.resolve([]))
    Should Be Empty    ${broken_links}    Broken internal links: ${broken_links}
