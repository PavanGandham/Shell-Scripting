#!/bin/bash

sudo apt update
sudo apt install jq -y

curl -u "GITLAB:$gitlab" "https://sonar/api/qualitygates/project_status?projectKey=${sonarProjectKey}&branch=${PIPELINE_GIT_BRANCH}" >> status.json
curl --request POST --header "PRIVATE-TOKEN: $TOKEN" \
"https://gitlab/api/v4/projects/$PROJECT_ID/protected_branches?name=$MS_TARGET_BRANCH&push_access_level=40&merge_access_level=40" >> protectedbranches.txt

# Add the below json data to file vim json.sh
# {
#  "employee": {
#  "name": "sonoo",
#  "ID": 56000,
#  "Status": true
#  }
# }
# Run commands
cat status.json| jq '.employee'
cat status.json| jq '.employee.name'

