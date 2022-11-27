Feature: Calling Java method

  Background: 
    Given url 'https://reqres.in/api/users'

  Scenario Outline: To validate POST method by embeded options
    And request { "name": '#(col1)',"job": '#(col2)' }
    When method POST
    Then status <status>

    Examples: 
      | col1 | col2 | status |
      | RM   | Lead |    201 |
      | SR   | HW   |    201 |

  Scenario Outline: To validate POST method by variables
    And request '<col1>','<col2>'
    When method POST
    Then status <status>

    Examples: 
      | col1 | col2     | status |
      | AAA  | Manager  |    201 |
      | BBB  | Director |    201 |

  Scenario Outline: To validate POST method by reading files in example
    And request <jsonfile>
    When method POST
    Then status <status>
    Then match response.name == '<expectedName>'
    Then match response.job == '<expectedJob>'

    Examples: 
      | jsonfile                              | status | expectedName | expectedJob |
      | read('classpath:Data/Testcase2.json') |    201 | xyz          | leader      |
      | read('classpath:Data/Testcase3.json') |    201 | aaa          | Trader      |
      | read('classpath:Data/Testcase4.json') |    201 | pqr          | Invmanager  |

  Scenario Outline: To validate POST method by reading CSV files in example
    And request <csvfile>
    When method POST
    Then status <status>
    Then match response == <schema>

    Examples: 
      | csvfile                              | status | schema   |
      | read('classpath:Data/Testcase6.csv') |    201 | '#array' |

  Scenario Outline: To validate POST method by reading CSV files in example
    And request <csvfile>
    When method POST
    Then status <status>


    Examples: 
      | csvfile                              | status |
      | read('classpath:Data/Testcase7.csv') |    201 |
