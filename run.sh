#!/bin/bash

docker start mysql-redmine
docker run --link mysql-redmine:mysql --rm -p 3000:3000 --name redmine ir2sora/redmine ruby script/rails server webrick -e production
