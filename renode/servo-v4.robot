*** Settings ***
Suite Setup                   Setup
Suite Teardown                Teardown
Test Setup                    Reset Emulation
Test Teardown                 Test Teardown
Resource                      ${RENODEKEYWORDS}

*** Test Cases ***
Should Boot To Console
    Execute Command          include @${CURDIR}/servo-v4.resc
    Create Terminal Tester   sysbus.usart1  1

    Start Emulation

    Wait For Line On Uart    Console is enabled; type HELP for help.

    Wait For Line On Uart    CL:  # this is to prevent the additional printout mess with our prompt

    Send Key To Uart         0xD

    Wait For Prompt On Uart  >

    Provides                 booted-console


Should Print Help
    Requires                 booted-console

    Write Line To Uart       help

    Wait For Line On Uart    fakedisconnect
    Wait For Line On Uart    tcpc

    Wait For Prompt On Uart  >


Should Print Version
    Requires                 booted-console

    Write Line To Uart       version
    Wait For Line On Uart    Board:
    Wait For Line On Uart    Build:${SPACE}${SPACE}${SPACE}servo_v4_v

    Wait For Prompt On Uart  >

