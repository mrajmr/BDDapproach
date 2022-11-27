Feature: CSV data

	Scenario Outline:
	Given request <csvfile>
	And print <csvfile>

	Examples:
	|csvfile|
	|read('Data.csv')|
