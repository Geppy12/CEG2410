# AWS Network and Firewall Configuration
CEG2410 – AWS Firewall Lab

---

## 1. VPC Configuration

### VPC Name
coffee shop

### Configuration
- VPC ID: vpc-08e7954ddf214685b
- DNS Resolution: Enabled
- Dedicated tenancy: Default
- Custom VPC created to isolate coffee shop infrastructure.

### Intent
The VPC provides logical isolation between:
- Public server resources
- Customer devices
- Future advertising devices

### Screenshot
(Insert VPC screenshot here)

---

## 2. Subnet Configuration

### Server Subnet
**Purpose**
- Hosts public-facing server instance.
- Allows controlled internet access.

**Characteristics**
- Public subnet
- Connected to Internet Gateway
- Assigned Elastic IP

---

### Customer Device Subnet
**Purpose**
- Simulates customer devices accessing services.
- Restricted inbound access.

**Characteristics**
- Private subnet
- No direct public exposure
- Internal communication only

---

### Design Intent
Network separation ensures:
- Customers cannot directly manage servers.
- Servers expose only required services.
- Future scalability for additional device classes.

### Screenshot(s)
(Insert subnet screenshots)

---

## 3. Route Table Configuration

### Server Route Table
Routes:
- Local VPC traffic > local
- Internet traffic > Internet Gateway (0.0.0.0/0)

**Reason**
Allows public HTTP access while maintaining VPC routing.

---

### Customer Route Table
Routes:
- Local traffic only

**Reason**
Customer devices should not be publicly reachable.

---

### Design Justification
Public access exists only where required (server subnet).
All other subnets remain isolated.

### Screenshot(s)
(Insert route table screenshots)

---

## 4. Network ACL Configuration

## Customer NACL (customer-Nacl)

### Inbound Rules
| Rule | Type | Source | Purpose |
|------|------|--------|---------|
|100|Allow All|0.0.0.0/0|Permit controlled testing traffic|
|*|Deny All|All|Default protection|

### Outbound Rules
| Rule | Type | Destination |
|------|------|-------------|
|1|Allow All|Specific external IP|
|100|Allow All|0.0.0.0/0|

### Intent
Stateless filtering applied at subnet level:
- Allows outbound communication
- Prevents unintended inbound sessions

---

## Default NACL
Used for server subnet with controlled allow rules including:
- SSH
- HTTP
- ICMP testing

### Screenshot(s)
(Insert NACL screenshots)

---

## 5. Security Group Configuration

Security Groups provide **stateful instance-level protection**.

---

### Server Security Group (Server-good)

#### Inbound Rules
| Protocol | Port | Source |
|----------|------|--------|
|SSH|22|Authorized IP|
|HTTP|80|0.0.0.0/0|

#### Outbound Rules
| Type | Destination |
|------|-------------|
|All Traffic|0.0.0.0/0|

**Purpose**
- Public web access allowed
- Administrative SSH restricted

---

### Customer Security Group (Customer-SG)

#### Inbound Rules
 Protocol  Port Source

SSH 22 10.0.1.28/32 

#### Outbound Rules
 Type  Destination 
All Traffic 0.0.0.0/0

**Purpose*
- Customers initiate connections only.
- Prevent unsolicited inbound access.

### Screenshot(s)
(Insert SG screenshots)

---

## 6. Instance System-Level Firewall Rules




### Active Rules
- Allow SSH management traffic
- Allow HTTP service traffic
- Drop unauthorized inbound packets
- Maintain connection tracking

### Example Chain Behavior
- INPUT chain filters incoming traffic
- ESTABLISHED,RELATED allowed
- Default DROP policy enforced

### Screenshot(s)
(Insert iptables -L screenshot)

---

## 7. Instances on Different Subnets (Verification)

### Server Instance
- Private IP: 10.0.1.28
- Elastic IP attached
- Accessible via HTTP externally

### Customer Device
- Private IP: 10.0.2.110
- No public IP

---

### Experimental Validation



---

### Security Goals
- Prevent tampering
- Prevent pivot attacks
- Maintain centralized control

---

## Conclusion

This AWS environment demonstrates layered security using:

- VPC segmentation
- Subnets
- Route tables
- Network ACLs
- Security Groups
- Host-based firewalls

Defense-in-depth ensures secure separation between servers, customers, and future advertising infrastructure.