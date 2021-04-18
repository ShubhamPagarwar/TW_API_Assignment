*** Settings ***
Documentation    session.robot is responsible for handling session i.e. create, delete and update session
Library    RequestsLibrary
Resource    commonMethod.robot
*** Variable ***
${setup_data_file_path}   ${CURDIR}/../test_data/setup_data.yaml     
*** Keywords ***
Create HTTP Session  
    ${setup_data}=  commonMethod.Get yaml file content    ${setup_data_file_path}     
    RequestsLibrary.Create Session  httpbin    ${setup_data}[api_url]    verify=True
    
Delete Session
    RequestsLibrary.Delete All Sessions
