#!/bin/bash

function usage() {
    echo "Usage:" >&2
    echo "$0 title message [error|warning|info|success] [tags...]" >&2
    echo " title:  The title of this event    i.e, 'Foo Restarted'" >&2
    echo "message: The message for this event   i.e, 'Foo was restarted by pavan'" >&2
    echo "type:    The event type, one of 'info', 'error', 'warning' or 'success'" >&2
    echo "tags:     Optional tags in key:value format o.e, 'app:foo group:bar'" >&2
    echo >&2
    echo "Examples:" >&2
    echo "$0 'Test Event' 'This event is just for testing' info 'test:true foo:bar'" >&2
    echo "$0 'Another Event' 'This event is just for testing'" >&2
    exit 1
}

title="$1"
message="$2"
alert_type="$3"

dd_config='/etc/dd-agent/datadog.conf'

if [[ -n "$DATADOG_API_KEY" ]]; then
    api_key="$DATADOG_API_KEY"
else
    api_key=$(grep '^api_key:' $dd_config | cut -d' ' -f2)
fi

if [[ -z "$api_key" ]]; then
    echo "Could not find Datadog APi key in either ${dd_config} or DATADOG_API_KEY environment variable." >&2
    echo "Please provide your API key in one of these locations" >&2
    usage
fi

if [[ -z "$title" || -z "$message" ]]; then
    usage
fi

if [[ -z "$alert_type" ]]; then
    echo "No level set, assuming 'info'" >&2
    alert_type='info'
fi

if $(echo "$alert_type" | grep -qv 'error\|warning\|info\|success'); then
    echo "Failed: alert_type was '$alert_type', needs to be one of 'success', 'info', 'error' or 'warning'" >&2
    echo >&2
    usage
fi

tag="environment:$(hostname) $4"
tags=$(echo $tag | sed -e 's/[\.-zA-Z:0-9]*/\"&\"/g' -e 's/\" \"/\", \"/g' )

api="https://app.datadoghq.com/api/v1"
datadog="${api}/events?api_key=${api_key}"

payload=$(cat <<-EOJ
    {
        "title": "$title",
        "text": "$message",
        "tags": [$tags]
        "alert_type": "$alert_type"
    }
EOJ
)

#echo -e "$payload"

curl -s -X POST -H "Content-type: application/json" -d "$(echo "${payload}" | sed ':a;N;$!ba;s/\n/ /g')" "$datadog"
