Permissions Configuration – Secure SFTP Web Access
Web Root Directories

The web server hosts two separate websites with different access requirements.

/var/www/main_site
/var/www/menu_site

Each site contains a writable folder used by SFTP users:

/var/www/main_site/public_html
/var/www/menu_site/public_html

The parent directories are owned by root:root to satisfy the security requirements of SSH’s ChrootDirectory feature.

Example verification:

ls -ld /var/www/main_site
ls -ld /var/www/menu_site

Example output:

drwxr-xr-x root root /var/www/main_site
drwxr-xr-x root root /var/www/menu_site
User Structure Plan

Three different roles require different access levels.

Role	Access
Business Owner	Edit both sites
Tech Help	Edit both sites
Menu Staff	Edit menu site only
Group and User Creation

Two Linux groups were created:

web-admins
menu-staff

Commands used:

sudo groupadd web-admins
sudo groupadd menu-staff

Three users were created using useradd.

sudo useradd -M -s /usr/sbin/nologin -G web-admins owner
sudo useradd -M -s /usr/sbin/nologin -G web-admins techsupport
sudo useradd -M -s /usr/sbin/nologin -G menu-staff staffmember

Passwords were assigned with:

sudo passwd owner
sudo passwd techsupport
sudo passwd staffmember
User Access Matrix
User	Group	Main Site	Menu Site
owner	web-admins	Yes	Yes
techsupport	web-admins	Yes	Yes
staffmember	menu-staff	No	Yes

Members of web-admins can edit both sites.
Members of menu-staff can only edit the menu site.

Command Logic
useradd -m vs useradd -M

useradd -m

Creates a home directory for the user, usually located in:

/home/username

useradd -M

Does not create a home directory.

In this scenario, -M was used because users will be restricted to website directories using the SSH Chroot jail, rather than needing a personal home directory.

Purpose of /usr/sbin/nologin

Users were created with the shell:

/usr/sbin/nologin

This prevents users from opening a normal SSH shell session.
If a user attempts to log in via SSH, the system will deny the shell.

This ensures users can only access the system through SFTP, not execute commands.

SSH Configuration (SFTP Jail)

The SSH configuration file was modified:

/etc/ssh/sshd_config

Example configuration used:

Match Group web-admins
    ChrootDirectory /var/www/main_site
    ForceCommand internal-sftp -d public_html
    AllowTcpForwarding no
    X11Forwarding no

Match Group menu-staff
    ChrootDirectory /var/www/menu_site
    ForceCommand internal-sftp -d public_html
    AllowTcpForwarding no
    X11Forwarding no
SSH Configuration Explained
ChrootDirectory

ChrootDirectory restricts users to a specific directory.
This creates a "jail", preventing users from navigating outside their assigned directory.

Example:

ChrootDirectory /var/www/main_site

For security reasons, the chroot directory must be:

owned by root
not writable by the user

This prevents users from escaping the jail.

ForceCommand internal-sftp
ForceCommand internal-sftp

This forces SSH to run the SFTP subsystem only.

Users cannot:

execute commands
open a shell
run programs

They can only transfer files using SFTP.

Directory Permissions

Permissions were configured so group members can edit files while Apache can still serve the content.

Commands used:

sudo chown -R root:web-admins /var/www/main_site/public_html
sudo chown -R root:menu-staff /var/www/menu_site/public_html

sudo chmod -R 775 /var/www/main_site/public_html
sudo chmod -R 775 /var/www/menu_site/public_html

Permission explanation:

Permission	Meaning
root	directory owner
group	web-admins or menu-staff
775	owner and group can edit

The web server runs as:

www-data

Since the permissions allow read access, the web server can still serve the files.

Testing and Logs
Successful SFTP Login

Example command:

sftp owner@server-ip

Expected output:

Connected to server
sftp>
Denied SSH Login

Example command:

ssh owner@server-ip

Expected result:

This account is currently not available

This confirms shell access is blocked.

Log Verification

Logs were checked using:

sudo tail /var/log/auth.log

Example log entry:

Accepted password for owner
subsystem request for sftp
session opened for user owner

This confirms a successful SFTP session.

Permission Verification

Command used:

ls -la /var/www

Example output:

drwxr-xr-x root root main_site
drwxr-xr-x root root menu_site

/var/www/main_site
drwxrwxr-x root web-admins public_html

/var/www/menu_site
drwxrwxr-x root menu-staff public_html

Explanation:

root ownership maintains chroot security
groups control editing access
Apache can still read files
Extra Credit – SGID and ACLs
SGID Bit

The SGID bit ensures new files inherit the parent directory's group.

Command used:

sudo chmod g+s /var/www/main_site/public_html
sudo chmod g+s /var/www/menu_site/public_html

Example result:

drwxrwsr-x

The s indicates SGID is active.

Access Control Lists (ACLs)

ACLs allow more flexible permissions than traditional Linux permissions.

Standard permissions support:

owner
group
others

ACLs allow permissions for multiple users or groups.

ACL package installation:

sudo apt install acl

Default ACL configuration:

sudo setfacl -d -m g:web-admins:rwx /var/www/main_site/public_html
sudo setfacl -d -m g:menu-staff:rwx /var/www/menu_site/public_html

This ensures newly uploaded files automatically allow group members to edit them.

Proof of Persistent Permissions

When a user uploads a file via SFTP:

touch test.html

Checking permissions:

ls -la

Example output:

-rw-rw-r-- 1 owner web-admins test.html

This confirms:

correct group ownership
group write permissions
SGID working correctly