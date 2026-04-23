# LDAP Authentication Configuration

Now that you have a centralized directory service running, it's time to put it to work. In this assignment, you will configure a Linux client machine to authenticate users against your LDAP server. This means that instead of managing local user accounts on every computer, users can log in with their directory credentials.

**Real-World Context:**  
System administrators use LDAP authentication across Unix/Linux networks to centralize user management—when a user is hired, they get one login that works on every system without administrators having to create accounts on each machine.

---

## Key Concepts

- **NSS (Name Service Switch):** Tells the system where to look for user information  
- **PAM (Pluggable Authentication Modules):** Handles the actual authentication process  
- **LDAP Client Libraries:** Software that communicates with the LDAP server  

---

## Learning Objectives

- Configure LDAP client libraries on a Linux system  
- Understand NSS and how services query for user information  
- Configure PAM to authenticate users against LDAP  
- Test LDAP authentication by logging in with directory credentials  
- Diagnose common LDAP authentication issues  

---

## Part 1: Set Up the LDAP Client Environment

On a second Linux machine (your **test client**), install and configure LDAP client libraries.

### Tasks:

- Install LDAP client packages:
  ```bash
  sudo apt install libnss-ldap libpam-ldap ldap-utils