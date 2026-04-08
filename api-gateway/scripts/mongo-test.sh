#!/bin/bash

###
# тетсируем шарды и общее количество
###

TOTAL=$(docker compose exec -T mongos_router mongosh --port 27020 --quiet --eval "db.getSiblingDB('somedb').helloDoc.countDocuments()" | tr -d '\r')

SHARD11=$(docker compose exec -T shard1-1 mongosh --port 27011 --quiet --eval "db.getSiblingDB('somedb').helloDoc.countDocuments()" | tr -d '\r')
SHARD12=$(docker compose exec -T shard1-2 mongosh --port 27012 --quiet --eval "db.getSiblingDB('somedb').helloDoc.countDocuments()" | tr -d '\r')
SHARD13=$(docker compose exec -T shard1-3 mongosh --port 27013 --quiet --eval "db.getSiblingDB('somedb').helloDoc.countDocuments()" | tr -d '\r')

SHARD21=$(docker compose exec -T shard2-1 mongosh --port 27021 --quiet --eval "db.getSiblingDB('somedb').helloDoc.countDocuments()" | tr -d '\r')
SHARD22=$(docker compose exec -T shard2-2 mongosh --port 27022 --quiet --eval "db.getSiblingDB('somedb').helloDoc.countDocuments()" | tr -d '\r')
SHARD23=$(docker compose exec -T shard2-3 mongosh --port 27023 --quiet --eval "db.getSiblingDB('somedb').helloDoc.countDocuments()" | tr -d '\r')

SHARDS_SUM=$((SHARD11 + SHARD21))

echo "shard1-1 count: $SHARD11"
echo $'\n'"shard1-2 count: $SHARD12"
if [ "$SHARD11" -eq "$SHARD12" ]; then
    echo -e "Success: Counts shard1-1 and shard1-2 match"
else
    echo -e "Error: Counts shard1-1 and shard1-2 do not match"
fi

echo $'\n'"shard1-3 count: $SHARD13"
if [ "$SHARD11" -eq "$SHARD13" ]; then
    echo -e "Success: Counts shard1-1 and shard1-3 match"
else
    echo -e "Error: Counts shard1-1 and shard1-3 do not match"
fi

echo $'\n'"shard2-1 count: $SHARD21"
echo $'\n'"shard2-2 count: $SHARD22"
if [ "$SHARD21" -eq "$SHARD22" ]; then
    echo -e "Success: Counts shard2-1 and shard2-2 match"
else
    echo -e "Error: Counts shard2-1 and shard2-2 do not match"
fi

echo $'\n'"shard2-3 count: $SHARD23"
if [ "$SHARD21" -eq "$SHARD23" ]; then
    echo -e "Success: Counts shard2-1 and shard2-3 match"
else
    echo -e "Error: Counts shard2-1 and shard2-3 do not match"
fi


echo $'\n'"shards   sum: $SHARDS_SUM"
echo "total  count: $TOTAL"

if [ "$TOTAL" -eq "$SHARDS_SUM" ]; then
    echo -e $'\n'"Success: Counts match"
else
    echo -e $'\n'"Error: Counts do not match"
fi

read -p $'\n'"Press Enter to exit"
