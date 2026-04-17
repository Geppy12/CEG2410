# Data Storage - Planning Phase (RAID)

## Administration

**Current AWS Budget**

My current AWS budget is under $40. If my costs begin to exceed $40, I will consider setting up a new stack in the second AWS pool to avoid exceeding the limit.

---

# Research

## Difference Between Hardware RAID and Software RAID

**Hardware RAID**
- Managed by a dedicated RAID controller (a physical card or chip).
- The controller handles the RAID processing instead of the operating system.
- Usually faster and more reliable for enterprise systems.
- Requires specialized hardware.

**Software RAID**
- Managed by the operating system using software tools.
- Does not require special hardware.
- Easier to configure and cheaper.
- Uses system CPU resources to manage the RAID.

---

## RAID Type Available in AWS

In AWS, I will be using **Software RAID**.

AWS instances use virtualized storage devices, meaning we do not have access to physical RAID controller hardware. Because of this limitation, RAID must be implemented through the operating system using tools like `mdadm` in Linux.

---

# Storage Media Ranking for RAID

| Rank | Storage Type | Reason |
|-----|--------------|-------|
| 1 | NVMe | NVMe drives provide the fastest performance with extremely high read/write speeds and low latency, making them ideal for high-performance RAID setups. |
| 2 | SSD | SSDs are significantly faster and more reliable than HDDs because they have no moving parts. They are well suited for RAID environments. |
| 3 | HDD | HDDs are slower because they rely on spinning disks and mechanical parts, which increases latency and failure risk compared to SSD and NVMe drives. |

---

# RAID Types

| RAID Level | Purpose | Identifying Features |
|------------|--------|---------------------|
| RAID 0 | Performance | Data is striped across multiple drives for faster speeds, but there is **no redundancy**. If one drive fails, all data is lost. |
| RAID 1 | Redundancy | Data is mirrored across two drives. If one drive fails, the other still contains the data. |
| RAID 5 | Balanced Performance and Redundancy | Uses striping with parity. Requires at least 3 drives and can survive the failure of one drive. |
| RAID 6 | Higher Redundancy | Similar to RAID 5 but uses double parity. Requires at least 4 drives and can survive two drive failures. |
| RAID 10 | Performance and Redundancy | Combines RAID 1 and RAID 0 (mirroring + striping). Requires at least 4 drives and provides both speed and fault tolerance. |

---

# Questions Before Determining RAID Type

1. How important is **data redundancy and fault tolerance** for the system?
2. What level of **performance (read/write speed)** is required?
3. How many **storage drives are available** for the RAID setup?

---

# Questions Before Determining RAID Size

1. How much **total storage capacity** is needed for the application?
2. How quickly will the data storage **grow over time**?
3. What level of **backup and redundancy space** should be reserved?
