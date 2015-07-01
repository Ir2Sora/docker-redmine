#!/bin/bash

docker run --name mysql-redmine -e MYSQL_ROOT_PASSWORD=mysqlpw -d mysql:5.5
docker run --link mysql-redmine:waitcontainer --rm aanand/wait
docker run --link mysql-redmine:mysql --rm mysql:5.5 sh -c 'exec mysql -h"$MYSQL_PORT_3306_TCP_ADDR" -P"$MYSQL_PORT_3306_TCP_PORT" -uroot -p"$MYSQL_ENV_MYSQL_ROOT_PASSWORD" -e"grant all privileges on redmine.* to redmine@'\''%'\'' identified by '\''my_password'\'';"'

docker run --link mysql-redmine:mysql --rm --env RAILS_ENV=production ir2sora/redmine:2.6.3 ./internal-init.sh
