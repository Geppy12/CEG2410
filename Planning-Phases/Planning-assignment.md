Web Hosting 
Planning Phase

Web Serving Stack
Door Side Server: Apache HTTP Server
Non-Door Side Server: Nginx
Both servers will host two websites using virtual hosts.

Ports:

Inbound Ports
80 TCP - Any source - HTTP traffic
443 TCP - Any source - HTTPS traffic
22 TCP - Admin IP only - SSH access

Outbound Ports
80 TCP - Internet - Updates
443 TCP - Internet - Secure updates
53 UDP - DNS Servers - Domain lookup

Firewall Levels:

NACL
Allows HTTP and HTTPS traffic into the network and allows outbound internet traffic.

Security Group
Inbound: 80, 443, 22 (admin only)
Outbound: allow internet access

System Firewall
Using ufw or iptables
allow 22/tcp
allow 80/tcp
allow 443/tcp
deny all other inbound

Configuration:

Apache Config Files
/etc/apache2/apache2.conf
/etc/apache2/sites-available/
site1.conf
site2.conf

Nginx Config Files
/etc/nginx/nginx.conf
/etc/nginx/sites-available/
/etc/nginx/sites-enabled/

Virtual Hosts:

Two sites will be hosted:
site1.local
site2.local

Directories:
/var/www/site1
/var/www/site2

Other Server Changes:

/etc/hosts
192.168.x.x site1.local
192.168.x.x site2.local

SSL (Stretch Goal)
Using Let's Encrypt
Certificates stored in /etc/letsencrypt/

Logging:

Apache Logs
/var/log/apache2/access.log
/var/log/apache2/error.log

Nginx Logs
/var/log/nginx/access.log
/var/log/nginx/error.log

Controlling the Web Server:

Start
sudo systemctl start apache2
sudo systemctl start nginx

Stop
sudo systemctl stop apache2
sudo systemctl stop nginx

Restart
sudo systemctl restart apache2
sudo systemctl restart nginx

Check Status
sudo systemctl status apache2
sudo systemctl status nginx

Web Content Location
/var/www/

Example Structure
/var/www/site1/public_html/index.html
/var/www/site2/public_html/index.html

Web Server User
www-data

File Permissions
Directories: 755
Files: 644

Example (for me because I am a visual learner)
sudo chown -R www-data:www-data /var/www/site1

Developer Access
Developers will upload content using SFTP.
(Secure file transfer protocol)
Developer Permissions
groupadd developers
chown -R root:developers /var/www/site1
chmod -R 775 /var/www/site1
