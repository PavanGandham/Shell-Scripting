#---------------------------------Break-Continue---------------------------------------------------------------------
#!/bin/bash
read -p "Enter the AWS Region u want to go to : " want
Regions=(us-east-1 us-east-2 us-west-1 us-west-2 ca-central-1 ap-south-1)
i=0
while (($i < ${#Regions[@]})); do
    echo "Checking for the Matching $want Region in : ${Regions[$i]}"
    if [[ "${Regions[$i]}" == "$want" ]]; then
        echo "Match Found after $i outcomes.Entering into ${Regions[$i]} Successfully ...."
        break
    else
        echo "Match not Found.... Still searching for it ...!!!"
        echo "-----------------------------------------------------------------------"
        i=$(($i + 1))
        continue
    fi
done
#-----------------------------------Return-----------------------------------------------------------------------------
#!/bin/bash
function result {
opr=(Addition Multiply Subtraction)
for i in ${opr[@]}
do
echo -e "$i\n"
done
read -p "Choose the any Operation from above to perform :" choice
if [ -z ${choice} ]
then
echo "Invalid Input !!"
else
for i in ${opr[@]}
do
if [[ "$i" == "$choice" ]]
then

}