use
        location / {
	    try_files $uri $uri/ /index.php?$query_string;
        }

construction in your nginx.conf file

run create_base.php for database creation
set database login & password in sql_pdo.php
