*** Settings ***
Documentation    This file contain test cases comes under Login endpoint.
Resource    ../configuration/session.robot
Resource    ../configuration/commonMethod.robot
Suite Setup    session.Create HTTP Session
Suite Teardown    session.Delete Session
*** Variable ***
${login_data_file_path}    ${CURDIR}/../test_data/login_data.yaml
${login_uri}    /api/login
*** Test Cases ***
TC01_Login_Success
    ${login_data}=    commonMethod.Get yaml file content    ${login_data_file_path}
    ${response}=    commonMethod.Post HTTP Request    ${login_uri}    ${login_data}[login_success]    200      
    Should Contain    ${response}    token
    Log    ***TC01_Login_Success*** Passed successfully    console=True     

TC02_Login_Failed_Empty_Data
    ${login_data}=    commonMethod.Get yaml file content    ${login_data_file_path}
    ${response}=    commonMethod.Post HTTP Request    ${login_uri}   ${login_data}[login_fail_empty_data]     400      
    Should Be Equal As Strings    ${response}    {'error': 'Missing email or username'}    
    Log    ***TC02_Login_Failed_Empty_Data*** Passed successfully    console=True     

TC03_Login_Failed_No_Password
    ${login_data}=    commonMethod.Get yaml file content    ${login_data_file_path}
    ${response}=    commonMethod.Post HTTP Request    ${login_uri}   ${login_data}[login_fail_no_password]     400      
    Should Be Equal As Strings    ${response}    {'error': 'Missing password'}   
    Log    ***TC03_Login_Failed_No_Password*** Passed successfully    console=True         
     
TC04_Login_Failed_No_email/username
    ${login_data}=    commonMethod.Get yaml file content    ${login_data_file_path}
    ${response}=    commonMethod.Post HTTP Request    ${login_uri}   ${login_data}[login_fail_no_email]     400      
    Should Be Equal As Strings    ${response}    {'error': 'Missing email or username'}   
    Log    ***TC04_Login_Failed_No_email/username*** Passed successfully    console=True         

TC05_Login_Failed_Incorrect_username_and_password
    ${login_data}=    commonMethod.Get yaml file content    ${login_data_file_path}
    #test for incorrect email/username
    ${response}=    commonMethod.Post HTTP Request    ${login_uri}   ${login_data}[login_fail_incorrect_username]     400      
    Should Be Equal As Strings    ${response}    {'error': 'user not found'}
    #test for incorrect password
    ${response}=    commonMethod.Post HTTP Request    ${login_uri}   ${login_data}[login_fail_incorrect_password]     400      
    Should Be Equal As Strings    ${response}    {'error': 'Incorrect password'}
    Log    ***TC05_Login_Failed_Incorrect_username_and_password*** Passed successfully    console=True         

      