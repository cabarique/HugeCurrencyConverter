#Mobile Coding Challenge 
##Introduction to the problem
Any native mobile programming language can be used to solve the problem. Please provide a complete working project (including build files, image resources, source files, libraries) and instructions on how to build and run the application.
Along with the project please include enough tests to ensure the applications functionality. If you use a testing framework other than XCTest, please include instructions on how to run the tests.

## 1. An Army of Ones ­ Currency Converter
You plan on traveling around the world using a stack of 1 US dollar bills. Write an app that will calculate the exchange rate for any number of dollar bills, represented by an integer value, into the following currencies: GBP, EUR, JPY, BRL.

###Input:
The app should have at least one text input to enter the number of dollars. You can use the currency api from fixer.io to retrieve exchange rates from USD to the following currencies:
UK Pounds (GBP) EU Euro (EUR) Japan Yen ­ (JPY) Brazil Reais ­ (BRL)
All conversions rates can be obtained from one call to: http://api.fixer.io/latest?base=USD

###Expected Output
The results for each currency.

###Expected Output ­ Bonus
A chart displaying the results for each currency. Each result should update the screen as each value is returned from the api call. Each bar should animate from a value of 0 to its value.