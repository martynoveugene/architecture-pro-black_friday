#!/bin/bash

curl http://127.0.0.1:9092/v1/discovery/consul/dump

echo $'\n'
echo $'\n'

curl "http://127.0.0.1:9180/apisix/admin/routes" -H 'X-API-KEY: edd1c9f034335f136f87ad84b625c8f1' -X PUT -d '
{
  "id": "consul-web-route",
  "uri": "/*",
  "upstream": {
    "service_name": "pymongo-api",
    "discovery_type": "consul",
    "type": "roundrobin"
  }
}'

echo $'\n'
echo $'\n'

curl http://127.0.0.1:9180/apisix/admin/routes -H 'X-API-KEY: edd1c9f034335f136f87ad84b625c8f1'

read -p $'\n'"Press Enter to exit"
