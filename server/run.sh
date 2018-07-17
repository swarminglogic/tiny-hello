#!/bin/sh

# Create /wwww directory
mkdir -p /www

# Generate (initially)
/server/gen-index-html.sh

# Install gen-index-html as cron-job to run every minute
mkdir -p /var/spool/cron/crontabs
echo "* * * * * /server/gen-index-html.sh" > /var/spool/cron/crontabs/root
crond

tar xf /server/nweb.tar.gz -C /server/
rm /server/nweb.tar.gz

# Start tiny web server
/server/nweb 80 /www
tail -f /www/nweb.log
