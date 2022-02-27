#--------------------------------------Short-Hand-operator--------------------------------------------------
#!/bin/bash
# Declare a string array
arrVar=("AC" "TV" "Mobile" "Fridge" "Oven" "Blender")
# Add new element at the end of the array
arrVar+=("Dish Washer")
# Iterate the loop to read and print each array element
for value in "${arrVar[@]}"; do
    echo $value
done
#--------------------------------------Last-Index-----------------------------------------------------------
#!/bin/bash
# Declare a string array
arrVar=("PHP" "MySQL" "Bash" "Oracle")
# Add new element at the end of the array
arrVar[${#arrVar[@]}]="Python"
# Iterate the loop to read and print each array element
for value in "${arrVar[@]}"; do
    echo $value
done
#---------------------------------------Using-Bracket-------------------------------------------------------
#!/bin/bash
# Declare a string array
arrVar=("Banana" "Mango" "Watermelon" "Grape")
# Add new element at the end of the array
arrVar=(${arrVar[@]} "Jack Fruit")
# Iterate the loop to read and print each array element
for value in "${arrVar[@]}"; do
    echo $value
done
#---------------------------------------Appending-Another-Array---------------------------------------------
#!/bin/bash
# Declare two string arrays
arrVar1=("John" "Watson" "Micheal" "Lisa")
arrVar2=("Ella" "Mila" "Abir" "Hossain")
# Add the second array at the end of the first array
arrVar=(${arrVar1[@]} ${arrVar2[@]})
# Iterate the loop to read and print each array element
for value in "${arrVar[@]}"; do
    echo $value
done