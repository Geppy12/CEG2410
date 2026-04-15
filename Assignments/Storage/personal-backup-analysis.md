# Personal Data Sovereignty & Backup Analysis

## 1. Risk Assessment (The "Why")

### Crown Jewels (Critical Data)

The most important data that I cannot lose includes:

* **School Projects and Code Repositories**

  * Programming assignments
  * Unity game development projects
  * Cybersecurity lab work and scripts
* **Personal Documents**

  * Tax documents
  * Financial records
  * Resume and professional documents
* **Photography**

  * Personal photo archive
  * Edited and raw photography files
* **Business Data**

  * Files related to my online clothing stores
  * Website assets and design files

### Risk Scenario: Laptop Failure or Theft

If my primary laptop failed today or was stolen, the consequences would be significant:

* Loss of active school projects
* Loss of important documents
* Potential loss of personal photos
* Loss of business-related files

This could set me back **weeks or months of work**, especially if the files were not backed up anywhere else.

### Recovery Time Objective (RTO)

My estimated **Recovery Time Objective (RTO)** is **24–48 hours**.

Within that time I should be able to:

1. Acquire or set up a replacement computer
2. Restore my files from backups
3. Resume school or development work

---

## 2. Current Strategy Evaluation

### Current Backup Habits

Currently, my data is mostly stored on my **primary laptop's internal SSD**. Some files are also stored in cloud services such as **GitHub and Google Drive**.

My current strategy is partially dependent on **cloud syncing and manual uploads** rather than a structured backup plan.

### Risks of Current Strategy

The risks of my current setup include:

* If my laptop fails, **some files may be permanently lost**
* Cloud sync services do not guarantee version history
* Files accidentally deleted may be removed from all synced devices

### Sync vs Backup

It is important to understand the difference between **syncing** and **backups**.

**Syncing (Example: Google Drive, iCloud)**

* Files stay identical across devices
* If a file is deleted locally, it may also be deleted in the cloud
* Sync does **not always protect against accidental deletion**

**Backup**

* A backup is a **point-in-time copy of your data**
* Files remain recoverable even if deleted or corrupted
* Multiple versions may exist

Currently, my system relies more on **syncing than true backups**, which creates a potential **single point of failure**.

---

## 3. Proposed 3-2-1 Backup Implementation

To properly protect my data, I would implement the **3-2-1 Backup Strategy**.

This requires:

* **3 copies of data**
* **2 different storage media**
* **1 offsite backup**

### Primary Data (Working Copy)

Location:

* My **primary laptop SSD**

This is where I actively work on:

* School assignments
* Code repositories
* Photography edits
* Personal and business documents

Important repositories are also pushed to **GitHub**, which provides an additional layer of redundancy for code.

---

### Local Backup

Hardware:

* **External 2TB Hard Drive**

Software:

* Windows File History or automated backup scripts
* Scheduled nightly backups

Backup Frequency:

* **Daily incremental backups**
* **Weekly full backup**

This provides fast recovery if files are accidentally deleted or if the laptop fails.

---

### Offsite Backup

Service Options:

* **Backblaze Personal Backup**
* **AWS S3 Glacier**
* **Google Drive backup archive**

Chosen Approach:

* Cloud backup through **Backblaze or AWS S3 Glacier**

Advantages:

* Data stored in a different geographic location
* Protection from theft, fire, or hardware failure
* Version history for files

Backup Frequency:

* Automatic daily upload

This ensures that even if both my laptop and external drive are lost, my data still exists offsite.

---

## 4. Implementation Costs & Tools

### Tools

Software tools I would use include:

* **Restic or Duplicati**

  * Automated encrypted backups
* **GitHub**

  * Version control for code projects
* **Windows File History**

  * Local file recovery
* **Cron Jobs or Scheduled Tasks**

  * Automate backup execution

### Hardware Cost

| Item             | Cost    |
| ---------------- | ------- |
| External 2TB HDD | $60–$80 |

### Cloud Storage Cost

| Service        | Monthly Cost              |
| -------------- | ------------------------- |
| Backblaze      | ~$7/month                 |
| AWS S3 Glacier | ~$1–$5 depending on usage |

### Estimated Budget

One-time cost:

* **$60–$80 for an external hard drive**

Recurring cost:

* **$5–$7 per month for cloud storage**

This cost is minimal compared to the potential loss of important personal and professional data.

---

## 5. The "Fire Drill" Plan

To ensure that backups are functional, I would perform a **yearly recovery test**.

Steps:

1. Select a set of important files from the backup.
2. Restore them to a temporary folder.
3. Verify that:

   * Files open correctly
   * File sizes match
   * No corruption occurred.

Additionally:

* Run checksum verification when possible.
* Confirm that backup logs report successful completion.

This process ensures that my backups are **actually usable** and not silently failing.

---

## Conclusion

Data loss can occur at any time due to hardware failure, theft, or accidental deletion. By implementing the **3-2-1 backup strategy**, I can ensure that my important data remains protected.

My plan includes:

* Primary data on my laptop
* Local backups to an external hard drive
* Offsite backups through cloud storage

This layered approach eliminates single points of failure and provides a reliable recovery path if something goes wrong.
