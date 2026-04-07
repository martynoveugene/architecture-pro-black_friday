#!/bin/bash

###
# Инициализируем шарды
###

docker compose exec -T shard1-1 mongosh --port 27011 <<EOF
rs.initiate(
    {
      _id : "shard1",
      members: [
        { _id : 0, host : "shard1-1:27011" },
        { _id : 1, host : "shard1-2:27012" },
        { _id : 2, host : "shard1-3:27013" },
      ]
    }
);
exit();
EOF

docker compose exec -T shard2-1 mongosh --port 27021 <<EOF
rs.initiate(
    {
      _id : "shard2",
      members: [
        { _id : 0, host : "shard2-1:27021" },
        { _id : 1, host : "shard2-2:27022" },
        { _id : 2, host : "shard2-3:27023" },
      ]
    }
);
exit();
EOF

read -p $'\n'"Press Enter to exit"
