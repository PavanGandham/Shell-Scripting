#!/bin/bash

CICD=true
WORKSPACE=/apps/opt/users
JOB_BASE_NAME=Test_demo

if [[ $CICD == true ]]
then
echo "CICD Pipeline Check"
file="${WORKSPACE}/html/basic_report.html"
REPORTNAME=${JOB_BASE_NAME}_${BUILD_NUMBER} #Test_demo_10
echo "CICD Check starting"
if [ -f "$file" ]; then
echo "testReport file found sending to artifactory" #-T--→ Target
curl -H X-JFrog-Art-Api:Token -T $file https://oneartifactorycloud/artifactory/CICD/Reports/$REPORTNAME.html
else
echo "testReport not found"
fi
fi
