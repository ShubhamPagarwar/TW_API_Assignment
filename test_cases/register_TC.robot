*** Settings ***
Documentation    This file contain test cases comes under Register endpoint.
Resource    ../configuration/session.robot
Resource    ../configuration/commonMethod.robot
Suite Setup    session.Create HTTP Session
Suite Teardown    session.Delete Session
*** Variable ***
${register_data_file_path}    ${CURDIR}/../test_data/register_data.yaml
${register_uri}    /api/register
*** Test Cases ***
TC06_Register_Success
    ${register_data}=    commonMethod.Get yaml file content    ${register_data_file_path}
    ${response}=    commonMethod.Post HTTP Request    ${register_uri}    ${register_data}[register_success]    200      
    Log    Register success response = ${response}
    Should Contain    ${response}    id 
    Should Contain    ${response}    token
    # verify registered user by doing get request to id
    ${user_detail_response}=    commonMethod.verify User based on ID    ${response}[id]
    # verify email id of registered user from get request
    Should Be Equal   ${user_detail_response}[data][email]        ${register_data}[register_success][email]
    #verify registered user by calling login api
    ${login_response}=    commonMethod.Post HTTP Request    /api/login    ${register_data}[register_verify_through_login]    200      
    Should Contain    ${login_response}    token
    Log    ***TC06_Register_Success*** Passed successfully    console=True
             
     

