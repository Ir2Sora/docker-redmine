#!/bin/bash

RAILS_ENV=production

rake db:create
rake db:migrate
rake redmine:load_default_data