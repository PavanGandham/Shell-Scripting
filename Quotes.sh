'''Shell Scripting Tutorial Quotes Double, Single and Reverse Quote
While Writing Shell Scripts very important is keeping quotes without missing them. 
Using quotes simple but when to use and where to use will make the good step. 
In this Article, We are going to see Shell Scripting Tutorial Quotes Double, Single and Reverse Quote.'''

” “ = Double Quotes
‘ ‘ = Single Quotes

“ = Reverse Quotes

# Shell Scripting Tutorial Quotes Double, Single and Reverse Quote
# Within Double quotes, variables and special variables will execute
# Single quote we call it as strict quotes within single quotes whatever you type same will be printed as it is
# Reverse quotes are used to executes commands
# Let’s see few examples

#!/bin/bash
## Purpose: Examples for Quotes

## Start
VAR=123
TEST=Ravi

## Double Quote example
echo "Execute Double Quote $VAR"
echo 'Executing Single Quote $VAR $TEST'

echo "This Host Name: `hostname`"

## END

sh quotes.sh
Execute Double Quote 123
Executing Single Quote $VAR $TEST
This Host Name: ArkITShell

# After executing written script is given output as above. 
# As per the above output, Double quote is executed Variable values well. 
# Single quote example printed as it is without variable values. 
# Reverse quote executed command hostname within quotes. 