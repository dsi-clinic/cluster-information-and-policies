---
title: "Data Protection"
layout: single
permalink: /sfa-policies/data-protection/
classes: [wide, left-aligned]
hide_hero: True
---

# Data Protection Policy & Procedure

This document defines the DSI HPC cluster's policies and procedures for protecting data at rest, in transit, and in use, and for ensuring the integrity of backups. It applies to all data stored on or transmitted through cluster systems and to the DSI Techstaff team responsible for managing cluster storage and infrastructure.

## Context

The DSI cluster is an open research computing environment. General-purpose cluster systems are **not authorized for restricted research data** (e.g., HIPAA, FERPA, CUI, export-controlled data). Researchers with restricted data requirements should use the university's Secure Data Enclave. The data protection controls described here are appropriate for the non-restricted research data that the cluster is designed to handle.

The cluster provides 1.5 PB of shared storage across three tiers:

| Tier | Mount Point | Default Quota | Backed Up | Purpose |
|:-----|:------------|:--------------|:----------|:--------|
| Home | `/home` | 50 GB per user | Yes | Personal configs, scripts, source code |
| Project | `/project` | 500 GB per group (up to 10 TB) | Yes | Shared research data, results |
| Scratch | `/scratch` | 50 GB per user per volume | No | Temporary job I/O (60-day purge) |

---

## Policy

### Data Classification (PR.DS-01, PR.DS-02)

All data on the DSI cluster is classified as **non-restricted research data**. This classification is enforced by policy: restricted data is prohibited on general-purpose cluster systems. Users who need to work with restricted data must use the Secure Data Enclave.

Within the non-restricted category, data on the cluster falls into two handling classes:

| Handling Class | Storage Tiers | Characteristics |
|:---------------|:--------------|:----------------|
| **Persistent research data** | `/home`, `/project` | Backed up, subject to quotas, retained until user or group removal or explicit deletion |
| **Transient computational data** | `/scratch` | Not backed up, subject to 60-day purge, intended for temporary job I/O only |

Users are responsible for ensuring that no restricted data is placed on the cluster. The [general cluster policies]({{ '/policies/general/' | relative_url }}) document this requirement.

### Data in Transit (PR.DS-01)

Data transmitted to, from, and within the cluster shall be protected against unauthorized interception:

- **External access** -- all user access to the cluster is via SSH, which provides encryption of data in transit. No unencrypted remote access protocols (telnet, FTP, rsh) are enabled on cluster systems.
- **Internal transfers** -- data transfers between cluster nodes (compute-to-storage, login-to-storage) occur over the internal 10 Gbps network, which is not routable from outside the cluster. While internal traffic is not encrypted at the network layer, physical and logical network isolation provides protection.
- **Data transfers to external systems** -- users are encouraged to use encrypted transfer methods (SCP, SFTP, rsync over SSH) when moving data between the cluster and external systems. Unencrypted transfer tools should be avoided.

### Data at Rest (PR.DS-01)

Data stored on the cluster is protected through the following controls:

- **Access controls** -- POSIX file permissions govern access to all files. Home directories are readable only by the owning user by default. Project directories use group-based permissions managed by DSI Techstaff.
- **Physical security** -- cluster storage systems reside in a UChicago-managed data center with controlled physical access.
- **No full-disk encryption** -- the cluster does not employ encryption at rest for its shared storage systems. This is appropriate for the non-restricted data classification. The primary protections for data at rest are access controls and physical security. Restricted data requiring encryption at rest must use the Secure Data Enclave.

### Data in Use (PR.DS-02)

Data being actively processed on compute nodes is protected through:

- **SLURM resource isolation** -- jobs run within SLURM-managed allocations. Users can only access compute nodes to which they have an active job allocation.
- **Process isolation** -- standard Linux process isolation prevents users from accessing other users' running processes or memory.
- **No Docker** -- Docker containers are not permitted on the cluster due to the privilege escalation risks they present. Container workloads must use rootless alternatives (e.g., Apptainer/Singularity) that do not require elevated privileges.
- **No restricted data in memory** -- because restricted data is prohibited on the cluster, there is no requirement for specialized in-memory encryption (e.g., SGX, SEV). Standard process isolation is sufficient.

### Backup and Recovery (PR.DS-11)

Backups protect persistent research data against accidental deletion, corruption, and storage system failure:

- **Backed-up tiers** -- `/home` and `/project` are backed up regularly. Backup schedules and retention periods are managed by DSI Techstaff based on storage system capabilities and capacity.
- **Not backed up** -- `/scratch` is explicitly not backed up. Users are responsible for copying important results from `/scratch` to `/project` before the 60-day purge window expires.
- **Backup storage** -- backup copies are stored on separate storage systems from the primary data to protect against single points of failure.
- **Backup integrity** -- DSI Techstaff shall periodically verify that backup jobs complete successfully and that backed-up data can be restored.

### Data Integrity (PR.DS-10)

The integrity of data on the cluster shall be maintained through:

- **Filesystem integrity** -- the cluster's shared storage systems use filesystems with built-in integrity features (e.g., checksums, journaling, RAID) to protect against silent data corruption and disk failures.
- **Quota enforcement** -- storage quotas prevent individual users or groups from consuming all available space, which protects system stability and other users' data.
- **Access control** -- POSIX permissions prevent unauthorized modification of files. Users cannot modify other users' files unless group permissions explicitly allow it.
- **Monitoring** -- DSI Techstaff monitors storage system health, including disk status, filesystem utilization, and error logs.

---

## Procedures

### Quarterly Backup Verification

| Item | Detail |
|:-----|:-------|
| **What** | Verify that backups for `/home` and `/project` are completing successfully and that data can be restored |
| **Who** | DSI Techstaff |
| **When** | Quarterly, aligned with the start of each academic quarter |
| **How** | 1. Review backup job logs for `/home` and `/project` to confirm successful completion over the past quarter. Investigate and resolve any failures. 2. Select a small sample of files from each tier (at least one file from `/home` and one from `/project`). 3. Restore the selected files to a temporary location. 4. Verify the restored files match the originals (compare checksums). 5. Delete the temporary restored copies. 6. Document the verification results in the review log below. |

### Annual Access Control Review

| Item | Detail |
|:-----|:-------|
| **What** | Review file and directory permissions on shared storage to ensure they conform to policy |
| **Who** | DSI Techstaff |
| **When** | Annually, aligned with the start of autumn quarter |
| **How** | 1. Verify that home directory permissions default to user-only read/write (mode 700 or equivalent). 2. Review project directory group memberships against current research group rosters. Remove access for users no longer affiliated with a project. 3. Verify that no world-readable or world-writable directories exist in `/home` or `/project` root levels. 4. Check that scratch directories have appropriate permissions. 5. Document findings and any corrective actions in the review log below. |

### Storage System Health Review

| Item | Detail |
|:-----|:-------|
| **What** | Review storage system health indicators |
| **Who** | DSI Techstaff |
| **When** | Monthly (automated monitoring provides continuous coverage; this is a manual review) |
| **How** | 1. Review storage system dashboards or logs for disk errors, failed drives, or degraded RAID arrays. 2. Check filesystem utilization across all tiers. If any tier exceeds 85% capacity, plan capacity action (cleanup communication to users, quota review, or expansion). 3. Verify that storage monitoring alerts are functioning (confirm a recent alert was received or trigger a test alert). 4. Document any findings requiring action. |

### New User Storage Provisioning

When a new user account is created:

1. A home directory is created at `/home/<cnetid>` with permissions set to mode 700 (owner only) and a 50 GB quota.
2. The user is added to the appropriate project group(s) as specified by their PI, granting access to the corresponding `/project` directory.
3. Scratch space is provisioned with default 50 GB quotas on each scratch volume.

### Restricted Data Incident Response

If DSI Techstaff discovers or is notified that restricted data has been placed on the cluster:

1. Notify the user and their PI immediately.
2. Work with the user to identify the scope of the restricted data (which files, which storage tier, how long it has been present).
3. Coordinate with UChicago IT Security and the relevant compliance office (e.g., HIPAA Privacy Office, Export Control) as required.
4. Remove or securely delete the restricted data from cluster systems once approved by the compliance office.
5. If the data was on a backed-up tier, coordinate removal of the data from backup systems.
6. Document the incident and any corrective actions.

### Review Log

| Date | Reviewer | Activity | Summary |
|:-----|:---------|:---------|:--------|
| 2026-04-06 | DSI Techstaff | Initial version | Policy and procedure document created |

---

## NIST CSF 2.0 Control Mapping

| Control ID | Control Name | How Addressed |
|:-----------|:-------------|:--------------|
| PR.DS-01.01 | The confidentiality, integrity, and availability of data-at-rest are protected | Data at rest is protected by POSIX access controls, physical security of the data center, and filesystem integrity features. Full-disk encryption is not used, consistent with the non-restricted data classification. Restricted data is prohibited on the cluster. |
| PR.DS-02.01 | The confidentiality, integrity, and availability of data-in-transit are protected | All external access uses SSH, providing encryption in transit. Internal transfers are protected by network isolation (non-routable internal network). Users are directed to use encrypted transfer methods for external data movement. |
| PR.DS-10.01 | The confidentiality, integrity, and availability of data-in-use are protected | SLURM resource isolation, Linux process isolation, and the prohibition of Docker containers protect data in use. No restricted data is processed on the cluster, so standard isolation controls are sufficient. |
| PR.DS-11.01 | Backups of data are created, protected, maintained, and tested sufficient to allow data recovery | `/home` and `/project` tiers are backed up regularly to separate storage. Quarterly backup verification procedure tests restore capability. `/scratch` is explicitly excluded from backup with user notification. |
