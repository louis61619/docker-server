#!/bin/bash

cd /blog/blog-server
pm2 start server.js

# cd /blog/blog-backstage
# pm2 serve build 3001 --spa

# cd /blog/blog-frontstage
# pm2 start npm --name "next" -- start

mysqld

