#!  /bin/bash

#Site configuration options
SITE_TITLE="WordPress Dev Site"
ADMIN_USER=admin
ADMIN_PASS=password
ADMIN_EMAIL="admin@localhost.com"
#Space-separated list of plugin ID's to install and activate
PLUGINS="query-monitor rewrite-rules-inspector fakerpress wp-mail-logging"

#Set to true to wipe out and reset your wordpress install (on next container rebuild)
WP_RESET=true

echo "Setting up WordPress"
DEVDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd /var/www/html;

# if [ ! -f wp-config.php ]; then
    echo "Configuring";
	cp /var/www/html/wp-content/themes/theme-name/.devcontainer/wp-config.php /var/www/html/wp-config.php;
    chmod 777 /var/www/html/wp-content/themes/theme-name/.devcontainer/wp-config.php;

    cd /var/www/html/wp-content/plugins;

    curl -O https://siteurl.com/wp-content/plugins.zip;
    curl -O https://siteurl.com/wp-content/db.sql.gz;
    unzip -qq -o plugins.zip;
    gzip -d db.sql.gz;
    rm plugins.zip;


    #Data import
    wp db import db.sql;

    rm db.sql;

    cd /var/www/html;

    # wp config create --dbhost="db" --dbname="wordpress" --dbuser="wp_user" --dbpass="wp_pass" --skip-check;
    wp user create admin test@live.com --role=administrator --user_pass="$ADMIN_PASS";

    #wp rewrite structure '/%postname%/';
    #wp rewrite flush --hard;
    #wp plugin install $PLUGINS --activate;
    # wp theme install twentytwelve --activate;
    # curl -N http://loripsum.net/api/5 | wp post generate --count=100 --post_type=question;
    # wp user generate --count=100;

    # cp -r plugins/* /var/www/html/wp-content/plugins
    # for p in plugins/*; do
    #     wp plugin activate $(basename $p)
    # done
# else
#     echo "Already configured"
# fi