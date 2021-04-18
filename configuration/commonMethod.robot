*** Settings ***
Documentation    This file contains common methods which are used in number of TC.
Library    RequestsLibrary
Library    DateTime
Library    yaml
Library    OperatingSystem  
Library    Collections  
*** Keywords ***
Get yaml file content
    [Arguments]    ${file_path}
    ${yaml_file}=    Get File  ${file_path}      
    ${yaml_data}=    yaml.Safe Load    ${yaml_file} 
    [Return]    ${yaml_data}    

Get HTTP Request
    [Arguments]    ${URI}    ${expected_staus_code}    ${response_time_limit}=${10}
    ${Result}=    RequestsLibrary.Get On Session   httpbin    url=${URI}    expected_status=${expected_staus_code}
    ${response_time}=  Convert Time    ${Result.elapsed}
    Should Be True    ${response_time} <= ${response_time_limit}    validation of response time   
    ${data}=  evaluate    json.loads('''${Result.content}''')    json
    Log    Get request result ${data}    
    [Return]    ${data}

Post HTTP Request
    [Arguments]    ${URI}    ${json_data}    ${expected_status_code}    ${response_time_limit}=${10} 
    ${Result}=    RequestsLibrary.Post On Session    httpbin    url=${URI}    json=${json_data}    expected_status=${expected_status_code}
    ${response_time}=  Convert Time    ${Result.elapsed}
    Should Be True    ${response_time} <= ${response_time_limit}    validation of response time   
    ${data}=  evaluate    json.loads('''${Result.content}''')    json
    Log    Post request result ${data}    
    [Return]    ${data}

Delete HTTP Request 
    [Arguments]    ${URI}    ${expected_staus_code}    ${response_time_limit}=${10}
    ${Result}=    RequestsLibrary.Delete On Session   httpbin    url=${URI}    expected_status=${expected_staus_code}
    ${response_time}=  Convert Time    ${Result.elapsed}
    Should Be True    ${response_time} <= ${response_time_limit}    validation of response time   
    Log    Delete request response ${Result}    
  
verify User based on ID
    [Arguments]    ${id}
    ${user_detail_response}=    commonMethod.Get HTTP Request    /api/users/${id}    200
    Log    Registered user details=${user_detail_response}    console=True
    
    Should Contain    ${user_detail_response}    data
    Should Contain    ${user_detail_response}    support
    #check user detailed parameter in data key
    Should Contain    ${user_detail_response}[data]    id
    Should Contain    ${user_detail_response}[data]    email
    Should Contain    ${user_detail_response}[data]    first_name
    Should Contain    ${user_detail_response}[data]    last_name
    Should Contain    ${user_detail_response}[data]    avatar
    #check user detailed parameter in support key
    Should Contain    ${user_detail_response}[support]    url
    Should Contain    ${user_detail_response}[support]    text
    [Return]    ${user_detail_response}