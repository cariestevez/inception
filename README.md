# inception

1. how to route php requests to wordpress-php container?
- through container port specification in nginx config file?

2. what does php interpreter need in order to be able to reach the wordpress .php files for execution?

3. Where to indicate that the place to retrieve other data is mariadb in case of needing the content?
- WordPress executes an initialization script (wp-config.php) that loads configuration files, sets up error handling, and establishes database connections. Credentials for connecting to the database are specified here

4. How does the execution take place? 
- php retrieves or writes content from/to the database, renders templates with the dynamic content that PHP snippets (which you can see in any template file that is typically a mix of HTML and PHP) generated, and executes plugins.


https://www.php.net/manual/en/install.fpm.php
https://www.php.net/manual/en/install.unix.debian.php
https://www.php.net/manual/en/book.mysqli.php