#!/bin/bash

if [[ $# != 3 ]]; then
    echo "requires 3 parameters: deployment-environment,ECS-cluster-name, AWS-region"
    return 1
fi

environment="$1"
cluster="$2"
aws_region="$3"

#

declare -a services=(
    abs-mq-consumer
    absout audit-api
    batch-gateway
    blockchain-sync-trade-pte
    blockchain-sync-net-sttlmnt
    cls-kinesis-mq-bridge
    cls-mq-consumer
    common-gateway
    data-service-adb
    data-service-edb
    data-service-rdb
    ddl-gui
    dlr-gateway
    dlr-gui
    dlr-sso-gateway
    dso-api-gateway
    dso-gui
    file-upload
    kinesis-mq-bridge
    mq-kinesis-bridge
    report-adhoc
    sso-api-gateway
    tiw-rest-service
    tiw-sso-gateway
)

#
main() {
    error_count=0
    for service in "${services[@]}"; do
        service_name="ddl-${environment}-${service}"
        echo "checking $service_name"
        info=$(
            aws ecs describe-services \ 
            --cluster $cluster \ 
            --services $service_name \ 
            --region $aws_region
        )

        json_array_len "$info" '["services"]'
        count="$json_result"
        if [ $count -eq 0 ]; then
            echo "***** service $service_name is not deployed"
            error_count=$(($error_count + 1))
        fi

        for ((i = 0; i < $count; ++i)); do
            extract_json "$info" '["services"]['$i']["serviceName"]'
            name="$json_result"
            extract_json "$info" '["services"]['$i']["desiredCount"]'
            desired_count="$json_result"
            extract_json "$info" '["services"]['$i']["runningCount"]'
            running_count="$json_result"
            if [ $desired_count -ne 0 -a $running_count -ne $desired_count ]; then
                echo "***** service $name has running count $running_count, expecting $desired_count"
                error_count=$(($error_count + 1))
            else
                echo " services $name has running count=$running_count, desired count=$desired_count"
            fi

            if [ $desired_count -ne 0 ]; then
                extract_json "$info" '["services]['$i']["events"][0]["messgae"]'
                last_event="$json_result"
                SSE_REGEX="has reached a steady state"
                if [[ ! $last_event =~ $SSE_REGEX ]]; then
                    echo "***** service $name is not in a steady state, last event=$last_event"
                    error_count=$(($error_count + 1))
                fi
                check_load_balancers "$name" "$info" "$i"
            fi
        done
        echo
    done
    if [ $error_count -ne 0 ]; then
        return 1
    fi
    return 0
}

check_load_balancers() {
    local svc_name="$1"
    local svc_info="$2"
    local svc_index="$3"
    json_array_len "$svc_info" '["services]['$srv_index']["loadBalancers"]'
    lb_count="$json_result"
    if [ $lb_count -ne 0 ]; then
        extract_json "$info" '["services"]['$srv_index']["loadBalancers"][0]["targetGroupArn"]'
        target_group_arn="$json_result"
        health=$(
            aws elbv2 describe-target-health \ 
            --target-group-arn $target_group_arn \ 
            --region $aws_region
        )
        json_array_len "$health" '["TargetHealthDescriptions"]'
        target_count="$json_result"
        healthy_count=0
        for ((i = 0; i < $target_count; ++i)); do
            extract_json "$health" '["TargetHealthDescriptions"]['$i']["TargetHealth"]["State"]'
            state="$json_result"
            if [ $state = "healthy" ]; then
                healthy_count=$(($healthy_count + 1))
            else
                extract_json "$health" '["TargetHealthDescriptions"]['$i']["TargetHealth"]["Description"]'
                health_descr="$json_result"
                echo "***** target found in state=$state, description=$health_descr"
                error_count=$(($error_count + 1))
            fi
        done
        if [ $healthy_count -eq 0 ]; then
            echo "**** service $svc_name has no healthy targets"
            error_count=$(($error_count + 1))
        else
            echo " service $svc_name has $healthy_count out of $target_count healthy targets"
        fi
    fi
}

json_array_len() {
    local json_data="$1"
    local json_path="$2"
    json_result=$(python -c 'import sys, json; j=json.load(sys.stdin); print(len(j'$json_path'))' <<<$json_data)
}

extract_json() {
    local json_data="$1"
    local json_path="$2"
    json_result=$(python -c 'import sys, json; j=json.load(sys.stdin); print(j'$json_path')' <<<$json_data)
}

main
