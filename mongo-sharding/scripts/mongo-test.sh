#!/bin/bash

###
# тетсируем шарды и общее количество
###

TOTAL=$(docker compose exec -T mongos_router mongosh --port 27020 --quiet --eval "db.getSiblingDB('somedb').helloDoc.countDocuments()" | tr -d '\r')

SHARD1=$(docker compose exec -T shard1-1 mongosh --port 27011 --quiet --eval "db.getSiblingDB('somedb').helloDoc.countDocuments()" | tr -d '\r')

SHARD2=$(docker compose exec -T shard2-1 mongosh --port 27021 --quiet --eval "db.getSiblingDB('somedb').helloDoc.countDocuments()" | tr -d '\r')

SHARDS_SUM=$((SHARD1 + SHARD2))

echo "shard1 count: $SHARD1"
echo "shard2 count: $SHARD2"
echo "shards   sum: $SHARDS_SUM"
echo "total  count: $TOTAL"

if [ "$TOTAL" -eq "$SHARDS_SUM" ]; then
    echo -e $'\n'"Success: Counts match"
else
    echo -e $'\n'"Error: Counts do not match"
fi

read -p $'\n'"Press Enter to exit"

