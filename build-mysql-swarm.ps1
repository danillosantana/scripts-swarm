﻿docker service create --name=dbSisget  -p 3306:3306  --mount type=bind,source=D:\Danillo\Desenvolvimento\mysql\datadir\database,destination=/var/lib/mysql  --network=netApp -e MYSQL_ROOT_PASSWORD=root -d mysql