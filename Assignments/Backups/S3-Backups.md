# Cloud Backups with AWS S3

## Overview

In this assignment, I configured a cloud backup solution using **Amazon S3**. The goal was to simulate an **offsite backup system** that follows the **3-2-1 Backup Rule**:

* **3 copies** of data
* **2 different storage types**
* **1 offsite backup**

In this setup:

* The primary system stores data locally.
* A compressed backup archive is created.
* The archive is uploaded to a **private AWS S3 bucket** for offsite storage.

---

# Step 1: Create the S3 Bucket

1. Logged into the **AWS Management Console**.
2. Navigated to:

```
Services → S3 → Buckets
```

3. Clicked **Create bucket**.
4. Created a new bucket named:

```
bryce-web-backups
```

5. Selected region:

```
US East (N. Virginia) us-east-1
```

---

# Step 2: Configure Security Settings

To protect backup data, the following settings were enabled:

### Block Public Access

All public access settings were enabled:

* Block public access to buckets and objects
* Block public access via access control lists (ACLs)
* Block public access via bucket policies
* Block public and cross-account access

This ensures that backup files **cannot be accessed publicly on the internet**.

---

### Default Encryption

Default encryption was enabled using:

```
Server-side encryption with Amazon S3 managed keys (SSE-S3)
```

This uses **AES-256 encryption** to protect data stored in the bucket.

Encryption is important because backup archives may contain **sensitive configuration files or system data**.

---

# Step 3: Create a Backup Archive

To simulate a backup file, a compressed archive was created using PowerShell on Windows.

Command used:

```powershell
tar -czvf backup-test.tar.gz Documents
```

This command:

* Creates a **compressed tar archive**
* Uses **gzip compression**
* Stores the backup as:

```
backup-test.tar.gz
```

---

# Step 4: Upload Backup to S3

The backup archive was uploaded manually through the AWS console.

Steps:

1. Open the **S3 bucket**
2. Click **Upload**
3. Select the backup archive:

```
backup-test.tar.gz
```

4. Click **Upload**

Once uploaded, the backup archive appears inside the S3 bucket.

---

# Step 5: Verification

### Uploaded Backup File

The S3 console shows the uploaded backup archive:

```
backup-test.tar.gz
```

This confirms that the bucket is successfully storing backup files.

---

### Bucket Permissions

The **Permissions tab** confirms that:

```
Block all public access = Enabled
```

This ensures that backup data is secure and cannot be accessed publicly.

---

# Endpoint Behavior

If someone attempts to access the backup file using a public URL such as:

```
https://bryce-web-backups.s3.amazonaws.com/backup-test.tar.gz
```

The expected result is:

```
AccessDenied
```

This happens because:

* The bucket blocks all public access.
* Only authorized AWS IAM users can access the data.

---

# Security Considerations

Backup archives may contain sensitive configuration data from directories such as:

```
/etc/apache2
/etc/nginx
```

These files could expose:

* Server configuration
* Internal network information
* SSL certificate paths
* Authentication settings

Because of this, **backup storage must remain private and encrypted**.

---

# Conclusion

This assignment demonstrated how cloud storage can be used as an **offsite backup solution**. By storing compressed backup archives in a **private and encrypted S3 bucket**, organizations can protect critical data while ensuring it remains secure and recoverable.
