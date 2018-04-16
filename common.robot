*** Settings ***
Documentation       A resource file with reusable keywords and variables.
...
...                 The system specific keywords created here form our own
...                 domain specific language. They utilize keywords provided
...                 by the imported Selenium2Library.
Library             SeleniumLibrary
Library             BuiltIn
Library             Collections


*** Variables ***
${SERVER}           URL
${PROTOCOL}         https
${BROWSER}          Firefox
${DELAY}            0
${VALID_USER}       USERNAME
${VALID_PASSWORD}   PASSWORD
${WELCOME_URL}      ${protocol}://${SERVER}/
${LOGIN_URL}        ${protocol}://${SERVER}/fi/account/login?next=%2Ffi%2Faccount
${ERROR_URL}        ${protocol}://${SERVER}/error.html
${PURCHASE_URL}     https://shop.worldcon.fi/memberships

*** Keywords ***
Open Browser To Server
    # Register Keyword To Run On Failure    Selenium On Failure
    log             ${WELCOME_URL}
    Open Browser    ${WELCOME_URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    ${DELAY}

Open Browser To Login Page
    Register Keyword To Run On Failure    Selenium On Failure
    Open Browser    ${LOGIN_URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    ${DELAY}
    Login Page Should Be Open

Login Page Should Be Open
    Title Should Be    Kirjaudu sisään – Verkkokauppa.com

Go To Login Page
    Go To    ${LOGIN_URL}
    Login Page Should Be Open

Input Username
    [Arguments]    ${username}
    # Input Text    login-form-email    ${username}
    Input Text    verkkokauppa-login__email    ${username}

Input Password
    [Arguments]    ${password}
    # Input Text    login-form-password    ${password}
    Input Text    verkkokauppa-login__password    ${password}

Submit Credentials
    # Click Button    css=button.vk-button:nth-child(1)
    Click Button    css=button.vk-button:nth-child(2)

Welcome Page Should Be Open
    # Location Should Be    https://www.verkkokauppa.com/fi/account
    Location Should Be    https://www.verkkokauppa.com/fi/account/login?next=%2Ffi%2Faccount

Selenium On Failure
    ${secs} =                   Get Time    epoch
    Capture Page Screenshot     selenium-${secs}.png

Check If Available
    [Arguments]    ${element}
    Reload Page
    # Log To Console    Reloaded the Page
    Element Should Be Enabled    ${element}
