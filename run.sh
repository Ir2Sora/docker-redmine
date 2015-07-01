#!/bin/bash

if !(docker inspect -f '{{.Id}}' mysql-redmine &> /dev/null)
then
	./init.sh
fi

docker start mysql-redmine
docker run --link mysql-redmine:mysql --rm -p 3000:3000 --name redmine ir2sora/redmine:2.6.3 ruby script/rails server webrick -e production
