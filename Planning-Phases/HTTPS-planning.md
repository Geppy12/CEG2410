# HTTPS & SSL/TLS Configuration

## Overview

In this assignment, HTTPS was configured on the web server so that traffic between the browser and server is encrypted. Previously, the sites were served over HTTP on port 80, which sends data in plain text. HTTPS uses SSL/TLS encryption over port 443 to protect the data being transmitted.

Two self-signed certificates were created for the domains:

* lastname.wsukduncan.com
* something-menu.com

These certificates were then configured in Apache virtual hosts to enable encrypted connections.



# SSL/TLS Concepts

## Private Key vs Public Certificate

SSL/TLS encryption uses two different keys.

A **Private Key** is a secret key stored on the web server. It is used to decrypt encrypted data and should never be shared publicly. Because of its importance, the private key must only be readable by the root user.

A **Public Certificate** contains the server's public key and identifying information about the server. This certificate is shared with the browser during the HTTPS handshake so the browser can encrypt communication with the server.

In summary:

* The **private key stays on the server**
* The **public certificate is shared with the browser**



## Self-Signed Certificates

A **self-signed certificate** is a certificate that is generated and signed by the same server that uses it. Unlike certificates issued by trusted Certificate Authorities (CAs) such as Let's Encrypt or DigiCert, self-signed certificates are not verified by a trusted organization.

Because the certificate is not issued by a trusted CA, modern browsers display the warning:

"Your connection is not private"

This warning appears because the browser cannot verify the authenticity of the certificate. However, the connection is still encrypted; it simply is not trusted automatically.



# Command Syntax

The following OpenSSL command was used to generate the private key and certificate:


openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
-keyout lastname.wsukduncan.com.key \
-out lastname.wsukduncan.com.crt


This command creates both the private key and the self-signed certificate.

### Explanation of flags


This flag tells OpenSSL to generate a self-signed certificate instead of creating a certificate signing request.



This option means "no DES encryption." It prevents the private key from being password protected so the web server can access it automatically during startup.



This sets the certificate validity period to 365 days.

# HTTPS Virtual Host Configuration

The Apache virtual host was configured to listen on port 443 and use the SSL certificate and key.

Example configuration:

<VirtualHost *:443>
    ServerName lastname.wsukduncan.com
    DocumentRoot /var/www/lastname

    SSLEngine on
    SSLCertificateFile /etc/apache2/ssl/lastname.wsukduncan.com.crt
    SSLCertificateKeyFile /etc/apache2/ssl/lastname.wsukduncan.com.key
</VirtualHost>

The `SSLCertificateFile` directive points to the public certificate, while `SSLCertificateKeyFile` points to the private key.

---

# HTTP to HTTPS Redirect

To ensure users always access the secure version of the site, the HTTP virtual host redirects traffic to HTTPS.

Configuration example:

```
<VirtualHost *:80>
    ServerName lastname.wsukduncan.com
    Redirect permanent / https://lastname.wsukduncan.com/
</VirtualHost>
```

This redirect forces any request made over HTTP (port 80) to automatically load the HTTPS version (port 443). This ensures all traffic is encrypted.

---

# Firewall Configuration

The firewall was updated to allow HTTPS traffic on port 443.

Example command:

```
sudo ufw allow 443
```

In addition, the AWS Security Group was updated to allow inbound traffic on port 443 so that HTTPS connections from the internet could reach the server.

---

# Verification Screenshots

The following screenshots were taken to verify the configuration:

1. Browser showing the **"Your connection is not private"** warning.
2. The site successfully loading after selecting **Advanced → Proceed**.
3. Certificate details showing the **Common Name (CN)** matching the configured domain.

These screenshots confirm that the SSL certificate is correctly associated with the domain.

---

# Service Logs

To verify the HTTPS connection from the command line, the following command was used:

```
curl -I -k https://localhost
```

Explanation:

* `-I` retrieves only the HTTP headers
* `-k` allows curl to ignore certificate verification errors

The `-k` flag is required because the certificate is self-signed and not trusted by the system's certificate authority list.

Example output:

```
HTTP/1.1 200 OK
Date: Tue, 25 Mar 2026
Server: Apache/2.4
Content-Type: text/html
```

The `HTTP/1.1 200 OK` response confirms the server successfully responded over HTTPS.

---

# Conclusion

HTTPS was successfully configured using self-signed certificates. Apache virtual hosts were updated to support encrypted traffic on port 443, HTTP traffic was redirected to HTTPS, and the firewall was configured to allow secure connections.

Testing with both a browser and the curl command confirmed that the server is correctly serving content over HTTPS.
