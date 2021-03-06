#!/bin/sh

# Create /wwww directory
mkdir -p /www

# Generate (initially)
/server/gen-index-html.sh /www/index.html

# Install gen-index-html as cron-job to run every minute
mkdir -p /var/spool/cron/crontabs
echo "* * * * * /server/gen-index-html.sh /www/index.html" > /var/spool/cron/crontabs/root
crond

tar xf /server/nweb.tar.gz -C /server/
rm /server/nweb.tar.gz

# Start tiny web server
/server/nweb 80 /www
touch /www/nweb.log
tail -f /www/nweb.log
