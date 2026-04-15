# Automated Backups with RAID

## Overview

In this assignment, a RAID array was configured to act as a backup target for the web server. A Bash script was created to archive the Apache configuration files and store them on the RAID array with a timestamp. The script is automated using cron so backups occur automatically at scheduled intervals.

---

# Backup Script

The following Bash script (`backup_web.sh`) creates a compressed archive of the Apache configuration directory and moves it to the RAID backup directory.

```bash
#!/bin/bash

BACKUP_DIR="/mnt/raid_data/backups"

DATE=$(date +"%Y-%m-%d_%H-%M-%S")
ARCHIVE_NAME="web-config-$DATE.tar.gz"

# Create compressed archive of Apache configuration
tar -czf /tmp/$ARCHIVE_NAME /etc/apache2

# Move archive to RAID backup directory
mv /tmp/$ARCHIVE_NAME $BACKUP_DIR

# Delete backups older than 7 days
find $BACKUP_DIR -type f -name "web-config-*.tar.gz" -mtime +7 -delete
```

### Script Explanation

* `BACKUP_DIR` defines the RAID backup location.
* `date` generates a timestamp to make each backup filename unique.
* `tar -czf` creates a compressed `.tar.gz` archive of `/etc/apache2`.
* The archive is first created in `/tmp` and then moved to the RAID backup directory.
* The `find` command removes backups older than 7 days to prevent the RAID storage from filling up.

---

# Cron Automation

To automate the backup process, the script was scheduled using `crontab`.

Command used to edit the cron table:

```
crontab -e
```

Cron entry added:

```
0 * * * * /home/ubuntu/backup_web.sh
```

### Cron Expression Explanation

```
0 * * * *
```


This configuration runs the backup script **once every hour**. This schedule was used for testing purposes so multiple backups could be generated quickly.

---

# Verification

To confirm that the script worked correctly, the RAID backup directory was checked after running the script multiple times.

Command used:

```
ls /mnt/raid_data/backups
```

Example output:

```
web-config-2026-04-03_19-10-21.tar.gz
web-config-2026-04-03_20-10-21.tar.gz
```

This shows that the backup script successfully created multiple archived backups of the Apache configuration.

---

# Cron Log Verification

To verify that cron executed the backup script, the system log was checked using:

```
grep CRON /var/log/syslog
```

Example output:

```
CRON[1105]: (ubuntu) CMD (/home/ubuntu/backup_web.sh)
```

This confirms that the cron scheduler triggered the backup script as expected.

