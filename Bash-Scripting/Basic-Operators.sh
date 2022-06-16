#--------------------------------------Arithmetic-Operators--------------------------------------------------
#!/bin/bash
read -p "Enter a  number: " Num
SQR=$(expr $Num \* $Num)
ADD=$(expr $Num)
echo $SQR
echo $ADD
echo $(expr 2 + 3 - 5 \* $(expr 6 / 5))
echo $(expr 30 % 2)
if [ $(expr $Num % 2) -eq 0 ]; then
    echo "$Num is an Even Number"
else
    echo "$Num is Odd Number"
fi
echo "------------------------------------------------"
if [ $(expr $Num % 2) -ne 0 ]; then
    echo "$Num is an Odd Number"
else
    echo "$Num is Even Number"
fi
#-------------------------------------Relational-Operators--------------------------------------------------
#!/bin/sh
a=10
b=20
if [ $a -eq $b ]; then
    echo "$a -eq $b : a is equal to b"
else
    echo "$a -eq $b: a is not equal to b"
fi
if [ $a -ne $b ]; then
    echo "$a -ne $b: a is not equal to b"
else
    echo "$a -ne $b : a is equal to b"
fi
if [ $a -gt $b ]; then
    echo "$a -gt $b: a is greater than b"
else
    echo "$a -gt $b: a is not greater than b"
fi
if [ $a -lt $b ]; then
    echo "$a -lt $b: a is less than b"
else
    echo "$a -lt $b: a is not less than b"
fi
if [ $a -ge $b ]; then
    echo "$a -ge $b: a is greater or  equal to b"
else
    echo "$a -ge $b: a is not greater or equal to b"
fi
if [ $a -le $b ]; then
    echo "$a -le $b: a is less or  equal to b"
else
    echo "$a -le $b: a is not less or equal to b"
fi
#---------------------------------------Boolean-Operators----------------------------------------------------
#!/bin/sh
a=10
b=20
if [ $a != $b ]; then
    echo "$a != $b : a is not equal to b"
else
    echo "$a != $b: a is equal to b"
fi
if [ $a -lt 100 -a $b -gt 15 ]; then
    echo "$a -lt 100 -a $b -gt 15 : returns true"
else
    echo "$a -lt 100 -a $b -gt 15 : returns false"
fi
if [ $a -lt 100 -o $b -gt 100 ]; then
    echo "$a -lt 100 -o $b -gt 100 : returns true"
else
    echo "$a -lt 100 -o $b -gt 100 : returns false"
fi
if [ $a -lt 5 -o $b -gt 100 ]; then
    echo "$a -lt 100 -o $b -gt 100 : returns true"
else
    echo "$a -lt 100 -o $b -gt 100 : returns false"
fi