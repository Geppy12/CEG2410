# Self-Hosted Proxmox VE on AWS EC2

## Project Description

### Software Overview
This project documents the deployment of **Proxmox Virtual Environment (Proxmox VE)** on an AWS EC2 instance.

Proxmox VE is an open-source server management platform that combines:
- KVM virtualization (virtual machines)
- LXC containers
- Software-defined storage and networking

It provides a web-based interface for managing infrastructure, making it a powerful tool for system administrators.

### Project Scope
This document covers:
- AWS VPC and networking configuration
- EC2 instance setup and cost considerations
- Installation and configuration of Proxmox
- Security configurations
- Feature demonstration
- Backup and disaster recovery strategy
- Common troubleshooting issues

---

## AWS VPC Setup

### VPC Configuration
- **CIDR Block:** 10.0.0.0/16  
- **Justification:**  
  Provides a large private address space for scalability and subnet segmentation.

### Subnet Configuration
- **Public Subnet:** 10.0.1.0/24  
- **Justification:**  
  Allows external access to Proxmox web interface and SSH.

### Route Table
- Route: `0.0.0.0/0 → Internet Gateway`  
- **Justification:**  
  Enables internet access for updates and remote administration.

### Network ACL Rules
Inbound:
- Allow HTTP (80)
- Allow HTTPS (443)
- Allow SSH (22)
- Allow Proxmox Web UI (8006)

Outbound:
- Allow all traffic

**Justification:**  
Ensures required access while maintaining controlled exposure.

### Security Group Rules
Inbound:
- SSH (22) → My IP only
- HTTPS (443) → 0.0.0.0/0
- Proxmox UI (8006) → My IP only

Outbound:
- Allow all

**Justification:**  
Restricts administrative access while allowing web-based services.

---

## AWS Instance Setup

### Instance Type
- **t3.medium (2 vCPU, 4GB RAM)**  
- **Justification:**  
  Provides enough resources for Proxmox and lightweight VMs while keeping cost low.

### AMI
- **Debian 12 (Bookworm)**  
- **Justification:**  
  Proxmox is Debian-based, ensuring compatibility and stability.

### Storage
- **30 GB GP2 volume**  
- **Justification:**  
  Enough for OS, Proxmox installation, and small virtual machines.

---

## Cost Estimates

### Summary
- Estimated monthly cost: ~$20–$30

### Breakdown
- EC2 t3.medium: ~$15–$20/month
- EBS Storage (30GB): ~$3/month
- Elastic IP: Free when in use
- AMI snapshots: ~$0.05/GB

### Notes
Costs may vary depending on usage and uptime.

---

## Installation Instructions

### Reference Documentation
- https://pve.proxmox.com/wiki/Install_Proxmox_VE

### Installation Steps (Summary)

1. Launch EC2 instance with Debian 12
2. Update system:
   ```bash
   sudo apt update && sudo apt upgrade -y


username: admin
password: Butoply98!@