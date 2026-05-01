# Self-Hosted Grafana on AWS EC2

## Project Description

### Software Overview

This project documents the deployment of **Grafana** on an AWS EC2 instance.

Grafana is an open-source monitoring and visualization platform used to:

* Display system metrics
* Create dashboards
* Monitor infrastructure performance

### Project Scope

This document covers:

* AWS networking configuration
* EC2 instance setup
* Grafana installation
* Security configuration
* Feature demonstration
* Backup strategy
* Troubleshooting

---

## AWS VPC Setup

### VPC Configuration

* Default VPC used
* CIDR Block: 172.31.0.0/16

**Justification:**
The default VPC provides internet connectivity and simplifies deployment.

---

### Subnet Configuration

* Public subnet used

**Justification:**
Allows external access to Grafana web interface.

---

### Route Table

* Route: 0.0.0.0/0 → Internet Gateway

**Justification:**
Enables internet access for updates and user access.

---

### Network ACL

* Default allow rules used

**Justification:**
Simplifies configuration while maintaining connectivity.

---

### Security Group Rules

Inbound:

* SSH (22) → 0.0.0.0/0
* Custom TCP (3000) → 0.0.0.0/0

Outbound:

* Allow all traffic

**Justification:**

* Port 22 allows remote administration
* Port 3000 allows access to Grafana web interface

*(Insert Screenshot: Security Group Rules)*

---

## AWS Instance Setup

### Instance Type

* t3.micro

**Justification:**
Grafana is lightweight and does not require high resources.

---

### AMI

* Ubuntu Server 22.04 LTS

**Justification:**
Stable, widely supported, and compatible with Grafana.

---

### Storage

* 20 GB EBS volume

**Justification:**
Enough for OS, Grafana, and logs.

---

*(Insert Screenshot: EC2 Instance Running)*

---

## Cost Estimates

### Summary

* Estimated monthly cost: ~$8–$12

### Breakdown

* t3.micro: ~$7–$10/month
* EBS storage (20GB): ~$2/month
* Elastic IP: Free while running

*(Insert Screenshot: AWS Cost Dashboard)*

---

## Installation Instructions

### Reference

* https://grafana.com/docs/grafana/latest/setup-grafana/installation/debian/

### Steps Performed

1. Updated system:

```
sudo apt update && sudo apt upgrade -y
```

2. Installed dependencies:

```
sudo apt install -y apt-transport-https software-properties-common wget
```

3. Added Grafana repository and key

4. Installed Grafana:

```
sudo apt install grafana -y
```

5. Started service:

```
sudo systemctl start grafana-server
sudo systemctl enable grafana-server
```

6. Verified service:

```
sudo systemctl status grafana-server
```

*(Insert Screenshot: Grafana Installation Output)*
*(Insert Screenshot: Service Running)*

---

## Security

### Server Administration

* SSH access enabled via port 22
* Controlled through Security Groups

### Application Access

* Grafana accessible via port 3000

### User Management

* Admin account created
* Additional user created with Viewer role

**Justification:**
Separates administrative access from application users.

*(Insert Screenshot: User Roles)*

---

## Software Features

### Demonstrated Features

* Web-based dashboard
* User authentication
* Dashboard creation

### Example

* Created a sample dashboard
* Added a panel

*(Insert Screenshot: Grafana Dashboard)*

---

## Backup Policy / Disaster Recovery

### Strategy

* Created AMI image for full system backup

### 3-2-1 Rule

* 3 copies: live system, AMI snapshot, local config
* 2 storage types: EC2 + snapshot
* 1 offsite: AWS infrastructure

### Estimated Data Size

* ~5–10 GB

### Recovery Time

* Instance restore: ~10–15 minutes

*(Insert Screenshot: AMI Creation)*

---

## Common Troubleshooting

### 1. SSH Connection Refused

* Cause: Instance rebooting
* Fix: Wait until status checks pass

---

### 2. Grafana Service Not Found

* Cause: Installation not completed
* Fix: Reinstall Grafana

---

### 3. Cannot Access Web Interface

* Cause: Port 3000 not open
* Fix: Update Security Group rules

---

## Sources

* Grafana Documentation
* AWS Documentation
* Course Materials
* ChatGPT (used for guidance and troubleshooting)


username: admin
password: Butoply98!@