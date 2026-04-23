# LDAP Client Authentication Configuration

## Overview

This project configures a Linux client machine to authenticate users using an LDAP server. This enables centralized authentication, allowing users to log in with one account across multiple systems instead of managing separate local accounts.

---

## LDAP Client Libraries Installation

```bash
sudo apt update
sudo apt install libnss-ldap libpam-ldap ldap-utils nslcd nscd
```

---

## LDAP Client Configuration

### File: /etc/ldap/ldap.conf

```conf
BASE dc=ec2,dc=internalclass,dc=local
URI ldap://localhost:389
```

---

## LDAP Connectivity Verification

```bash
ldapsearch -x -b "dc=ec2,dc=internalclass,dc=local" "uid=student1"
```

---

## NSS Configuration

### File: /etc/nsswitch.conf

```conf
passwd: files ldap
shadow: files ldap
group:  files ldap
hosts:  files dns
```

---

## NSS Verification

```bash
getent passwd student1
```

```bash
id student1
```

---

## PAM Configuration

### File: /etc/pam.d/common-auth

```conf
auth sufficient pam_ldap.so
auth [success=1 default=ignore] pam_unix.so nullok
auth [success=1 default=ignore] pam_ldap.so minimum_uid=1000
```

---

## LDAP Login Test

```bash
su - student1
whoami
```

---

## Screenshots Required

- getent passwd student1
- id student1
- whoami

---

## Explanation

Centralized authentication allows administrators to manage users from a single system instead of configuring each machine individually. This improves efficiency, reduces errors, and ensures consistency across systems.
