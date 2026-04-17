# Apache HTTP Service Configuration

## Overview

This document explains the installation and configuration of the **Apache HTTP Server** on an Ubuntu AWS instance. The goal of this configuration is to host two separate websites using Apache Virtual Hosts:

1. **main public website** that can be accessed through a public DNS name.
2. **menu website** intended for internal TV displays within a building.

Apache virtual host configuration allows multiple websites to run on the same server by using different domain names and document roots.

---

# Installing Apache HTTP Server

Apache was installed using the Ubuntu package manager.

```bash
sudo apt update
sudo apt install apache2 -y
```

The service was started and enabled to run automatically when the system boots.

```bash
sudo systemctl start apache2
sudo systemctl enable apache2
```

Apache was tested using curl to verify the service was running.

```bash
curl localhost
```

---

# Web Content Directories

Two separate directories were created to store the website content.

```bash
sudo mkdir /var/www/main-site
sudo mkdir /var/www/menu-site
```

These directories contain the HTML files served by Apache.

Main website content:

```
/var/www/main-site
```

Menu website content:

```
/var/www/menu-site
```

Each directory contains an `index.html` file used to verify that the correct site is being served.

Example main site page:

```html
<h1>Main Business Website</h1>
<p>This is the public website.</p>
```

Example menu site page:

```html
<h1>TV Menu</h1>
<p>This page is used by internal menu screens.</p>
```

---

# Apache Virtual Host Configuration

Apache uses **Virtual Hosts** to serve multiple websites from a single server.

Virtual host configuration files are stored in:

```
/etc/apache2/sites-available
```

Two configuration files were created:

```
main-site.conf
menu-site.conf
```

---

# Main Site Configuration

Configuration file:

```
/etc/apache2/sites-available/main-site.conf
```

Example configuration:

```apache
<VirtualHost *:80>
    ServerName lastname.wsukduncan.com

    DocumentRoot /var/www/main-site

    <Directory /var/www/main-site>
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/main-error.log
    CustomLog ${APACHE_LOG_DIR}/main-access.log combined
</VirtualHost>
```

### Key Configuration Lines

| Directive    | Description                                 |
| ------------ | ------------------------------------------- |
| VirtualHost  | Defines which IP and port Apache listens on |
| ServerName   | The domain name used to access the website  |
| DocumentRoot | Directory containing the website files      |
| Directory    | Defines permissions and access settings     |
| ErrorLog     | Records errors related to the site          |
| CustomLog    | Records incoming HTTP requests              |

This configuration allows users to access the website using the DNS name:

```
lastname.wsukduncan.com
```

---

# Menu Site Configuration

Configuration file:

```
/etc/apache2/sites-available/menu-site.conf
```

Example configuration:

```apache
<VirtualHost *:80>
    ServerName something-menu.com

    DocumentRoot /var/www/menu-site

    <Directory /var/www/menu-site>
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/menu-error.log
    CustomLog ${APACHE_LOG_DIR}/menu-access.log combined
</VirtualHost>
```

The menu site serves content specifically for **menu displays inside the building**.

Using a separate hostname allows the system to distinguish between the public website and the internal menu system.

---

# Enabling and Disabling Sites

Apache uses commands to enable or disable site configurations.

To enable a site:

```bash
sudo a2ensite main-site.conf
sudo a2ensite menu-site.conf
```

To disable a site:

```bash
sudo a2dissite filename.conf
```

The default Apache site was disabled:

```bash
sudo a2dissite 000-default.conf
```

After changing site configurations Apache must be restarted.

```bash
sudo systemctl restart apache2
```

---

# Name Configuration

Two different names were configured to access the sites.

### Public Website

```
lastname.wsukduncan.com
```

This name is configured using a **DNS record** that points to the AWS server's public IP address.

When users access this name in a browser or with curl, they reach the main website.

---

### Menu Website

```
something-menu.com
```

This name was configured locally using the hosts file.

Hosts file location:

```
/etc/hosts
```

Example entry:

```
127.0.0.1 something-menu.com
```

This allows the server to resolve the name locally without using external DNS.

The site can then be tested using:

```bash
curl something-menu.com
```

---

# Testing the Web Service

The web service was tested using curl commands.

Test the public website:

```bash
curl lastname.wsukduncan.com
```

Test the menu site:

```bash
curl something-menu.com
```

These commands returned the HTML content from the correct directories, confirming that the virtual host configuration works correctly.

---

# Apache Logs

Apache logs provide information about server activity and errors.

Log directory:

```
/var/log/apache2
```

Access log:

```
/var/log/apache2/access.log
```

Error log:

```
/var/log/apache2/error.log
```

Logs can be viewed using:

```bash
sudo tail /var/log/apache2/access.log
```

The logs show requests when users access the websites through curl or a browser.

---

# Screenshots

Screenshots should be included showing the following:

1. Curl request for the main website
2. Curl request for the menu website
3. Browser access to the public website
4. Apache access logs showing incoming requests
5. Apache error logs if applicable

These screenshots verify that Apache is successfully serving both sites.

---

# Conclusion

Apache HTTP Server was successfully installed and configured to host two separate websites using virtual hosts. The configuration allows the server to serve a public website and an internal menu site from different directories while using different hostnames.
