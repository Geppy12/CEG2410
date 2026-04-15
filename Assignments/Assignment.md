1. Block 203.0.113.5 from reaching any resource in the subnets.
    - SOURCE: 203.0.113.5/32
    - PORTS = ALL
    - PROTOCOLS = ALL
    - NACL INBOUND - subnets

2. Block customers devices from talking to servers.
    - SOURCE: 10.0.0.0/24
    - PORTS = ALL
    - PROTOCOLS = ALL 
    - NACL INBOUND / OUTBOUND - subnets
    - DESIGN CHANGE - we need NACL to apply unique to subnets

3. Allow HTTP/S traffic from the entire internet to the Web Server.
    - SOURCE: 0.0.0.0/0 
    - PORTS = 80 & 443
    - PROTOCOLS = HTTP and HTTPS
    - SG allow inbound; MUST HANDLE SYS if ENABLED

4. Allow SSH (Port 22) only from known admin network IPs (other servers on the subnet; any WSU IP / OAR; Admin home - public IP via ISP).
    - SOURCE: 10.0.1.96/28; 130.108.0.0/16; Run a what is my ip at home /32
    - PORT: 22
    - PROTOCOL: SSH
    - NACL - does it allow that traffic in; SG allow inbound; MUST HANDLE SYS if ENABLED

5. Allow SSH (Port 22) only for a specific user ID on the Linux server.
    - iptables can do; we want investigate later

6. Allow the DB server to accept traffic only if it comes from the Web Server SG.
- port 3306
- private Ip of the we server
- SG allow SG connection

7. Block an entire country's IP range from the VPC. (Let's use China as the strawman)
  - china has lots 
  - 
8. Allow an EC2 instance in a private subnet to download updates from the internet via a NAT Gateway.
 - we want to allow 443 out
 - we make the allow the return in, ephermal port range 1024-65535

9. A user sends an HTTPS request to your web server; the server needs to send the webpage data back.
 - source: User IP (or 0.0.0.0/0)
 - desentation: Web server
 - port: 443
 - protocl: TCP
10. Prevent two different instances within the same subnet from talking to each other.
 - source: Subnet CIDR 
 - desentation: Subnet CIDR
 - port: ALL
 - protocl: ALL


 


11. Immediately block a known botnet range (e.g., 192.0.2.0/24) before it even reaches your web server.
 - source 192.0.2.0/24
 - destenation: subnet CIDR
 - protocol: all
 - action deny

12. We want to allow ping for troubleshooting, but only from our office IP.
 - ICMP
 - istance
 
13. Traffic arrives on Port 80 but needs to be redirected to an internal service running on Port 8080.
 - NACLs and security groups wont support port fowarding
 - iptables support port foward