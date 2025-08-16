#!/bin/bash -xe

for ip in $(cat ip.txt) 10.118,10.119; do
    curl -u GITLAB:Token -X PUT --data \
        '{"update":{"labels":[{"add":""$TEAMNAME-$version""}]}}' --header "Content-Type:application/json" https://jira.com/rest/api/2/issue/2341
    curl -u GITLAB:Token -X PUT --data \
        '{"update":{"comment":[{"add":{"body":""$version""}}]}}' --header "Content-Type:application/json" https://jira.com/rest/api/2/issue/$line
    echo "Name read from file - $line"
done
