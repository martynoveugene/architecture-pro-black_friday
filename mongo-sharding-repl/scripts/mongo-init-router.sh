#!/bin/bash

###
# Инициализируем роутер mongodb
###

docker compose exec -T mongos_router mongosh --port 27020 <<EOF
sh.addShard( "shard1/shard1-1:27011");
sh.addShard( "shard2/shard2-1:27021");

sh.enableSharding("somedb");
sh.shardCollection("somedb.helloDoc", { "name" : "hashed" } )
exit();
EOF

read -p $'\n'"Press Enter to exit"
