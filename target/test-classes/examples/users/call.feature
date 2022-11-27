Feature: Calling Java method

  Background: 
    * def dg = Java.type('helpers.DataGenerator')
    Given url BaseURL

@smoke
  Scenario: way of calling method1
    * def setName = dg.randomName()
    And request
      """
      {
      "name": #(setName),
      "job": "leader"
      }
      """
    When method POST
    Then status 201

  Scenario: way of calling method2
    * def setName = dg.randomName()
    * def reqbody = read('classpath:Data/Testcase2.json')
    #And reqbody.name = #(setName)
    #And request reqbody.name = #(setName)
    And request reqbody
    And request {"name":#(setName)}
    When method POST
    Then status 201

  Scenario Outline: way of calling method3 <scenario>
    * def setName = dg.randomName()
    * def reqbody = read('classpath:Data/Testcase2.json')
    And request {"name":"<col1>"}
    When method POST
    Then status <col2>

    Examples: 
      | col1       | col2 | scenario   |
      | #(setName) |  201 | scenario 1 |
      | #(setName) |  201 | scenario 2 |
      | #(setName) |  201 | scenario 3 |
      | #(setName) |  201 | scenario 4 |

  Scenario Outline: having data in csv and also having body in scenarios
    * def setName = dg.randomName()

    And request { name: '#(name)', job: '#(job)' }
    When method POST
    Then status 201

    Examples:
    |read('classpath:Data/Testcase7.csv')| 
    
  Scenario Outline: having data in csv but not the body in scenarios
    * def setName = dg.randomName()


    And request <csvfile>
    When method POST
    Then status 201
    #Then match response.name == exp
		#Then match response == { name: '#(expected)' }
		
    Examples:
    |csvfile|
    |read('classpath:Data/Testcase7.csv')| 


  Scenario: updated the random function on json itself
    * def setName = dg.randomName()
    * def reqbody = read('classpath:Data/Testcase2.json')
    And request reqbody
    When method POST
    Then status 201

  Scenario Outline: way of calling method having dummy data in json itself
    * def setName = dg.randomName()
    * def reqbody = read('classpath:Data/Testcase5.json')
    And request reqbody
    When method POST
    Then status <col2>

    Examples: 
      | col1 | col2 |
      | AA   |  201 |
      | BB   |  201 |
      | CC   |  201 |
      | DD   |  201 |
