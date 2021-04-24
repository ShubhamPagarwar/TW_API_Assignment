### TW_API_Assignment

All Manual test cases given in the assignment are covered in Manual test cases.xlsx. It consist total 9 Testcases covered under Login, Register, User endpoints.

Robot Framework technology has been used to build the automation framework with the help of RequestsLibrary. Below is the directory structure.
#### Directory structure
###### configuration 
     - session.robot : It has created to handle all the api session related activity like create, delete, update session. It has been called in setup and teardown
     - commonMethod.robot : This file consist of commonMethods which has been called under multiple TestCases. To avoid redundancy of code and to introduce reusability feature this file has built.
     - get_variable_type.py : this is python script which act as an library and provide support to robot framework to capture data type of variable. It has used under get list of user test cases to validate json schema and its value type.
###### test_cases 
     - login_TC.robot - It contains all the test cases which come under the Login endpoint.
     - register_TC.robot - It contains all the test cases which come under the Register endpoint.
     - user_TC.robot - It contains all the test cases which come under the User endpoint.
###### test_data 
     - setup.yaml - It contains the test data which do needful to build configuration. As of now, domain url has mentioned and it has been used while creating session at session.robot.
     - login_data.yaml - It represents the test data which has used in all Login endpoint related TC.
     - register_data.yaml - It represents the test data which has used in all Register endpoint related TC.
     - user_data.yaml - It represents the test data which has used in all User endpoint related TC.

#### **********How to trigger Test Suite***********
###### Pre-reuisite -
     - Install python3.8
     - Install robot-framework using below command
       > pip install robotframework
     - Install RequestsLibrary using below command
       > pip install robotframework-requests
###### Execution -
     1. Clone this repo on local machine
     2. go to /TW_API_Assignment/test_cases via terminal
     3. Execute below command to run execution suite
        > robot *.robot
     4. You will see all the execution result on terminal. 
     Note:- It can be executed via any IDE like eclipse.
            
