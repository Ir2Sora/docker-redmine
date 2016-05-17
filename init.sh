#!/bin/bash

docker run --name mysql-redmine --env MYSQL_ROOT_PASSWORD=mysqlpw -d mysql:5.7.12
docker run --link mysql-redmine:waitcontainer --rm aanand/wait

# init db
docker exec mysql-redmine mysql -uroot -pmysqlpw -e"grant all privileges on redmine.* to redmine@'%' identified by 'my_password';"
docker run --link mysql-redmine:mysql --rm --env RAILS_ENV=production --env REDMINE_LANG=ru ir2sora/redmine:3.2.2 /bin/bash -c "rake db:create; rake db:migrate; rake redmine:load_default_data"