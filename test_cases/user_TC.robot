*** Settings ***
Documentation    This file contain test cases comes under User endpoint.
Library    DateTime
Library    Collections
Resource    ../configuration/session.robot
Resource    ../configuration/commonMethod.robot
Library     ../configuration/get_variable_type.py    
Suite Setup    session.Create HTTP Session
Suite Teardown    session.Delete Session
*** Variable ***
${user_data_file_path}    ${CURDIR}/../test_data/user_data.yaml
${user_uri}    /api/users
*** Test Cases ***
TC07_Create_User
    ${user_data}=    commonMethod.Get yaml file content    ${user_data_file_path}
    ${response}=    commonMethod.Post HTTP Request    ${user_uri}    ${user_data}[create_user]    201      
    Log    Create user api response= ${response}    
    Should Contain    ${response}    name    
    Should Contain    ${response}    job    
    Should Contain    ${response}    id
    Should Contain    ${response}    createdAt
    # compare name, job data with the input data
    Should Be Equal    ${response}[name]        ${user_data}[create_user][name]
    Should Be Equal    ${response}[job]        ${user_data}[create_user][job]
    # verify current date
    ${current_date}=    DateTime.Get Current Date    result_format=datetime	
    ${current_date}=    DateTime.Convert Date    ${current_date}    result_format=%d.%m.%Y    
    ${created_date}=    DateTime.Convert Date    ${response}[createdAt]    result_format=%d.%m.%Y    
    Should Be Equal    ${current_date}    ${created_date}    
    #verify created user using GET api call
    ${user_details}=    commonMethod.verify User based on ID    ${response}[id]
    #verify its detail first_name with input data
    Should Be Equal    ${user_details}[first_name]    ${user_data}[create_user][name]    
    Log    ***TC07_Create_User*** Passed successfully    console=True

TC08_List_All_Users
    ${user_list_response}=    commonMethod.Get HTTP Request    /api/unknown    200
    #verify parent keys
    Should Contain    ${user_list_response}    page
    Should Contain    ${user_list_response}    per_page
    Should Contain    ${user_list_response}    total
    Should Contain    ${user_list_response}    total_pages
    Should Contain    ${user_list_response}    data
    Should Contain    ${user_list_response}    support
    #verify values under support
    Should Contain    ${user_list_response}[support]    url
    Should Contain    ${user_list_response}[support]    text
    
    #verify type of data
    ${type_page}=    get_variable_type.Get Type    ${user_list_response}[page] 
    Should Contain    ${type_page}    int
    ${type_per_page}=    get_variable_type.Get Type    ${user_list_response}[per_page] 
    Should Contain    ${type_per_page}    int
    ${type_total}=    get_variable_type.Get Type    ${user_list_response}[total] 
    Should Contain    ${type_total}    int
    ${type_total_pages}=    get_variable_type.Get Type    ${user_list_response}[total_pages] 
    Should Contain    ${type_total_pages}    int
    ${type_data}=    get_variable_type.Get Type    ${user_list_response}[data] 
    Should Contain    ${type_data}    list
    ${type_url}=    get_variable_type.Get Type    ${user_list_response}[support][url] 
    Should Contain    ${type_url}    str
    ${type_text}=    get_variable_type.Get Type    ${user_list_response}[support][text] 
    Should Contain    ${type_text}    str
    #verify content of user details under data 
    @{user_details}=    Collections.Convert To List    ${user_list_response}[data]
    FOR  ${item}  IN  @{user_details}
        ${type_id}=    get_variable_type.Get Type    ${item}[id] 
        Should Contain    ${type_id}    int
        ${type_name}=    get_variable_type.Get Type    ${item}[name] 
        Should Contain    ${type_name}    str
        ${type_year}=    get_variable_type.Get Type    ${item}[year] 
        Should Contain    ${type_year}    int
        ${type_color}=    get_variable_type.Get Type    ${item}[color] 
        Should Contain    ${type_color}    str
        ${type_pantone_value}=    get_variable_type.Get Type    ${item}[pantone_value] 
        Should Contain    ${type_pantone_value}    str
    END
    Log    ***TC08_List_All_Users*** Passed successfully    console=True
                        
 TC09_Delete_User
    ${user_data}=    commonMethod.Get yaml file content    ${user_data_file_path}
    commonMethod.Delete HTTP Request    ${user_uri}/${user_data}[delete_user][id]    204
    #verify the user should be deleted, so status code should be 404
    ${response}=    commonMethod.Get HTTP Request    ${user_uri}/${user_data}[delete_user][id]    404
    Should Be Equal As Strings    ${response}    {}        
    Log    ***TC09_Delete_User*** Passed successfully    console=True
   
