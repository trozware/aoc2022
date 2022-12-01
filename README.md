# Advent of Code 2022

This is using Swift, so comes as an Xcode project, using the macOS Command Line Tool template.

If you only want to see the code for each day, open the **AoC2022** folder and read the relevant **days/dayXX.swift** file.

### In the Xcode project

- **main.swift** - sets the current day number and runs the code for that day.

- **days/dayXX.swift** - contains the code for each day.

- **Template.swift** - blank version of dayXX.swift.

- **Utils.swift** - parsing and timing routines.

- **data** - folder with text files for the puzzle data for each day.

- **test** - folder with text files for the test data for each day.

### To use the template

- Clone the `blank` branch and start with that.
- In **main.swift**, set the `dayNum`.
- Save the test data to the appropriate day file In the **test** folder.
- Save your input data to the appropriate day file In the **data** folder.
- Open the swift file for the day.
- Set `expectedTestResults` to whatever the test data should give.
- Write your code in the `runCode` method.
- Run the app. If the test data gives the expected result, it will continue to run your input and print the result.
- For part 2, change `expectedTestResults`, modify your code and run again.