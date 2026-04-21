# LDAP Digital Phonebook Setup

## Overview
This project demonstrates how to set up a centralized directory using OpenLDAP. Instead of managing users on multiple systems, LDAP allows all systems to reference a single source of truth.

---

## structure.ldif

The `structure.ldif` file defines the organizational layout of the directory by creating two Organizational Units (OUs):

- **People**: Stores all user accounts
- **Groups**: Stores group-related information

### Contents:
```ldif
dn: ou=People,dc=ec2,dc=internalclass,dc=local
objectClass: organizationalUnit
ou: People

dn: ou=Groups,dc=ec2,dc=internalclass,dc=local
objectClass: organizationalUnit
ou: Groups

dn: uid=student1,ou=People,dc=ec2,dc=internalclass,dc=local
objectClass: inetOrgPerson
objectClass: posixAccount
objectClass: shadowAccount
uid: student1
sn: Lastname
givenName: Firstname
cn: Firstname Lastname
displayName: Firstname Lastname
uidNumber: 10001
gidNumber: 10001
userPassword: password123
homeDirectory: /home/student1
loginShell: /bin/bash

dn: uid=testuser,ou=People,dc=ec2,dc=internalclass,dc=local
objectClass: inetOrgPerson
objectClass: posixAccount
objectClass: shadowAccount
uid: testuser
sn: User
givenName: Test
cn: Test User
displayName: Test User
uidNumber: 10002
gidNumber: 10002
userPassword: password123
homeDirectory: /home/testuser
loginShell: /bin/bash