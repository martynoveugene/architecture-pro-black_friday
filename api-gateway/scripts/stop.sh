#!/bin/bash

docker-compose stop pymongo_api mongos_router

docker-compose stop shard1-1 shard1-2 shard1-3 shard2-1 shard2-2 shard2-3

docker-compose stop configSrv

docker-compose stop redis

read -p $'\n'"Press Enter to exit"
