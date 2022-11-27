Feature: sample API test



  Scenario: To validate POST method by reading files
    * def reqbody = read('classpath:Data/Testcase2.json')
    Given url 'https://reqres.in/api/users'
    And request reqbody
    When method POST
    Then status 201

  Scenario: To validate POST method by updating attribute
    * def reqbody = read('classpath:Data/Testcase2.json')
    And reqbody.name = 'zzz'
    Given url 'https://reqres.in/api/users'
    And request reqbody
    When method POST
    Then status 201
