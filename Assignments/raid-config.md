# RAID Web Storage Migration

## Migration Steps

Created directory for web files on RAID:

sudo mkdir -p /mnt/raid_data/www

Moved web files while preserving permissions:

sudo rsync -av /var/www/html/ /mnt/raid_data/www/

Verified files:

ls /mnt/raid_data/www

Removed old directory:

sudo rm -rf /var/www/html

Created symbolic link:

sudo ln -s /mnt/raid_data/www /var/www/html

Ensured Apache could access RAID directories:

sudo chmod o+x /mnt
sudo chmod o+x /mnt/raid_data

Restarted Apache:

sudo systemctl restart apache2


## Configuration Snippet

Symbolic link from Apache directory to RAID storage:

/var/www/html -> /mnt/raid_data/www
