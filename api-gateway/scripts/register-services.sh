#!/bin/bash

curl "http://127.0.0.1:8500/v1/agent/service/register" -X PUT \
  -H "Content-Type: application/json" \
  -d '{
    "ID": "pymongo-api-1",
    "Name": "pymongo-api",
    "Tags": ["pymongo-api", "v1"],
    "Address": "'173.17.0.111'",
    "Port": 8080,
    "Weights": {
      "Passing": 10,
      "Warning": 1
    }
  }'

curl "http://127.0.0.1:8500/v1/agent/service/register" -X PUT \
  -H "Content-Type: application/json" \
  -d '{
    "ID": "pymongo-api-2",
    "Name": "pymongo-api",
    "Tags": ["pymongo-api", "v1"],
    "Address": "'173.17.0.112'",
    "Port": 8080,
    "Weights": {
      "Passing": 10,
      "Warning": 1
    }
  }'

curl "http://127.0.0.1:8500/v1/catalog/service/pymongo-api"

read -p $'\n'"Press Enter to exit"
