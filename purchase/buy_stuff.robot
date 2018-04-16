*** Settings ***
Documentation     A test suite with a single test for valid login.
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Resource          ../common.robot

*** Variables ***
${PRODUCT_NUMBER}    68862
${PRODUCT_PAGE}      https://www.verkkokauppa.com/fi/product/68862/jqkgr/Fuj-tech-microUSB-USB-C-adapteri

# ${PRODUCT_NUMBER}    39787
# ${PRODUCT_PAGE}      https://www.verkkokauppa.com/fi/product/39787/hbmdh/Acer-Iconia-B3-A30-10-1-16-Gt-Wi-Fi-Android-6-0-tablet-valko


*** Test Cases ***
Buy Sale Item
    [tags]    buy
    Open Browser                     ${PRODUCT_PAGE}
    Log To Console                   \nWaiting for keyword to succeed
    Wait Until Keyword Succeeds      1200 sec  1 sec    Check If Available    css=div.add-to-cart:nth-child(4) > div:nth-child(1) > button:nth-child(1)
    Log To Console                   \n ... Continuing with the purchase
    Click Button                     css=div.add-to-cart:nth-child(4) > div:nth-child(1) > button:nth-child(1)
    Click Element                    css=a.navigation-icons__link:nth-child(4)
    Page Should Contain              Tuotenumero ${PRODUCT_NUMBER}
    Click Element                    css=.vk-pointy-button__label
    # login
    Input Username                   ${VALID_USER}
    Input Password                   ${VALID_PASSWORD}
    Submit Credentials
    # Sleep  0.5
    # Continue shopping
    Log To Console                   \nContinue shopping
    Wait Until Keyword Succeeds      600 sec  0.2 sec
    ...    Click Element             css=a.vk-pointy-button:nth-child(2) > span:nth-child(1)
    # Valitse Toimitustapa
    Log To Console                   \nValitse Toimitustapa
    Click Element                    css=.panel__label--shipment-method-1 > a:nth-child(1)
    Wait Until Keyword Succeeds      600 sec  0.2 sec
    ...    Click Element             css=a.vk-pointy-button:nth-child(2) > span:nth-child(1)
    # Valitse maksutapa
    Log To Console                   \nValitse maksutapa
    Click Element                    css=.panel__label--nouto > a:nth-child(1)
    Wait Until Keyword Succeeds      600 sec  0.2 sec
    ...    Click Element             css=a.vk-pointy-button:nth-child(2) > span:nth-child(1)
    # Vahvista Tilaus
    Log To Console                   \nVahvista Tilaus
    # Wait Until Keyword Succeeds      600 sec  0.2 sec
    # ...    Click Element             css=a.vk-pointy-button:nth-child(3) > span:nth-child(1)

    Sleep  2
    Capture Page Screenshot

    [Teardown]    Close Browser