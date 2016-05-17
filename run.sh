#!/bin/bash

if !(docker inspect -f '{{.Id}}' mysql-redmine &> /dev/null)
then
	./init.sh
fi

docker start mysql-redmine
docker run --link mysql-redmine:mysql --rm -p 3000:3000 --name redmine ir2sora/redmine:3.2.2 rails server webrick -e production -b "0.0.0.0"