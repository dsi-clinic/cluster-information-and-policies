---
title: "Recovery Plan"
layout: single
permalink: /sfa-policies/recovery-plan/
classes: [wide, left-aligned]
hide_hero: True
---

# Recovery Plan

This document establishes the policy and procedures for recovering the DSI HPC cluster from security incidents, hardware failures, and other disruptions. It covers recovery execution, prioritization, backup restoration, service verification, communication, and closure. This plan is activated when normal incident response has contained a threat and the focus shifts to restoring operations.

## Policy

### Recovery Execution (RC.RP-01)

The recovery portion of the incident response plan shall be executed when a security incident, hardware failure, or other disruption has been contained and the cluster (or components thereof) must be restored to operational status. Recovery actions shall follow documented procedures and be coordinated by the DSI Techstaff lead or designated recovery coordinator.

### Recovery Prioritization (RC.RP-02)

Recovery actions shall be prioritized based on the impact to research operations and the criticality of affected systems. The following priority order shall guide recovery efforts:

1. **SLURM controller and scheduling services** -- restoring the ability to submit and manage jobs
2. **Login nodes** -- restoring user access to the cluster
3. **Shared storage** (`/home`, `/project`) -- restoring access to user data and research data
4. **Compute nodes** -- restoring compute capacity
5. **Scratch storage** (`/scratch`) -- restoring temporary workspace (not backed up; users are informed that scratch data may be lost)
6. **Monitoring and ancillary services** -- restoring observability and supporting tools

The recovery coordinator may adjust priorities based on the specific circumstances of the incident.

### Backup Integrity Verification (RC.RP-03)

Before restoring data from backups, Techstaff shall verify backup integrity to ensure that restored data is complete, uncorrupted, and free of any artifacts from the incident. No backup restoration shall proceed without an integrity check.

### Restoring Operational Norms (RC.RP-04)

Following recovery, the cluster shall be returned to its documented operational baseline. This includes verifying that security controls, access policies, SLURM configurations, and monitoring are functioning as expected before the cluster is reopened to general users.

### Asset Restoration and Service Verification (RC.RP-05)

All restored or rebuilt systems shall be verified for correct operation before being returned to production. Verification includes confirming hardware health, operating system integrity, software stack correctness, network connectivity, and SLURM integration. Services are not considered recovered until verification is complete.

### Recovery Closure (RC.RP-06)

Each recovery effort shall be formally closed with documentation that includes: a summary of the incident and recovery actions taken, the timeline of key events, systems affected and restored, data loss (if any), lessons learned, and recommendations for improvement. Recovery closure documentation is reviewed by the Techstaff lead and retained with incident records.

### Recovery Communication (RC.CO-03, RC.CO-04)

Recovery status and activities shall be communicated to affected stakeholders throughout the recovery process:

- **Internal communication** -- Techstaff coordinates recovery activities through Slack and internal channels. The Techstaff lead or designated communication coordinator ensures the team has consistent, accurate information.
- **User communication** -- Affected users are notified of recovery status through the cluster status page, email to impacted users, and Slack announcements. Updates are provided at regular intervals (at minimum every 24 hours during active recovery) and when significant milestones are reached (e.g., login nodes restored, jobs resuming).
- **Stakeholder communication** -- The faculty committee and UChicago central IT are informed of significant incidents and recovery progress as appropriate.
- **Accuracy** -- All external communications are reviewed for accuracy before distribution. Speculative information is avoided.
- **Archiving** -- Recovery communications are archived with incident records.

### Recovery Time and Recovery Point Objectives

The following targets guide recovery planning. These are objectives, not guarantees, and actual recovery times depend on the nature and scope of the disruption.

| System | Recovery Time Objective (RTO) | Recovery Point Objective (RPO) | Notes |
|:-------|:------------------------------|:-------------------------------|:------|
| Login nodes | 4 hours | N/A (stateless) | Rebuild from configuration management |
| SLURM controller | 4 hours | 24 hours (database backup) | SLURM database backed up daily |
| `/home` storage | 24 hours | 24 hours | Restored from daily backups |
| `/project` storage | 48 hours | 24 hours | Restored from daily backups; larger volume |
| `/scratch` storage | 24 hours | N/A (not backed up) | Scratch data is not recoverable; users notified |
| Compute nodes | 8 hours per node | N/A (stateless) | Rebuild from configuration management |
| Monitoring services | 24 hours | N/A | Lower priority; rebuild from configuration |

---

## Procedures

### Recovery Activation

| Item | Detail |
|:-----|:-------|
| **What** | Activate the recovery plan following incident containment |
| **Who** | Techstaff lead or designated recovery coordinator |
| **When** | When incident response has contained the threat and recovery can safely begin |
| **How** | The recovery coordinator confirms with the incident response team that containment is complete and it is safe to begin recovery. The coordinator reviews the scope of impact, identifies affected systems, and establishes recovery priorities per the policy above. A recovery coordination channel is established in Slack. Initial status is communicated to affected users. |

### Node Rebuild

| Item | Detail |
|:-----|:-------|
| **What** | Rebuild a compromised or failed compute node or login node |
| **Who** | DSI Techstaff |
| **When** | When a node must be restored to a known-good state |
| **How** | 1. Remove the node from SLURM scheduling (`scontrol update NodeName=<node> State=DRAIN Reason="rebuild"`). 2. Reimage the node using the standard OS image from configuration management. 3. Apply current patches and configuration. 4. Verify hardware health (memory, disk, GPU if applicable). 5. Verify network connectivity and storage mounts. 6. Run a test SLURM job to confirm job execution. 7. Return the node to production (`scontrol update NodeName=<node> State=RESUME`). 8. Document the rebuild in the recovery log. |

### SLURM Database Backup and Restore

| Item | Detail |
|:-----|:-------|
| **What** | Back up and restore the SLURM accounting database |
| **Who** | DSI Techstaff |
| **When** | Backups: daily (automated). Restore: when the SLURM database is corrupted or lost. |
| **How** | **Backup:** The SLURM accounting database is backed up daily using `sacctmgr dump` or equivalent database dump. Backups are stored on backed-up storage separate from the SLURM controller. **Restore:** 1. Stop SLURM controller services. 2. Identify the most recent clean backup (pre-incident if incident-related). 3. Verify backup integrity (file completeness, checksums). 4. Restore the database from the backup. 5. Restart SLURM controller services. 6. Verify SLURM scheduling and accounting are functioning correctly. 7. Document any data gap between the backup point and the incident. |

### User Data Restoration

| Item | Detail |
|:-----|:-------|
| **What** | Restore user data from backups for `/home` or `/project` |
| **Who** | DSI Techstaff |
| **When** | When user data has been lost, corrupted, or must be restored to a pre-incident state |
| **How** | 1. Identify the scope of data to restore (specific users, directories, or full volume). 2. Identify the appropriate backup snapshot (most recent clean backup before the incident). 3. Verify backup integrity before restoration (checksums, test extraction of sample files). 4. For targeted restores, restore to a temporary location first and verify contents before overwriting. 5. For full volume restores, coordinate with affected users to minimize data conflicts. 6. Restore data and verify file permissions and ownership are correct. 7. Notify affected users when restoration is complete. 8. Document what was restored, from which backup, and any data gaps. |

### Backup Integrity Verification

| Item | Detail |
|:-----|:-------|
| **What** | Verify that a backup is suitable for restoration |
| **Who** | DSI Techstaff |
| **When** | Before any restoration from backup |
| **How** | 1. Confirm the backup timestamp and scope. 2. Verify file/volume checksums match expected values. 3. Test-extract a sample of files to confirm readability and data integrity. 4. For incident-related restores, confirm the backup predates the incident (i.e., is not contaminated). 5. Document the verification result. Proceed with restoration only if verification passes. |

### Post-Recovery Service Verification

| Item | Detail |
|:-----|:-------|
| **What** | Verify that recovered systems are functioning correctly before returning to production |
| **Who** | DSI Techstaff |
| **When** | After recovery actions are complete, before reopening the cluster to users |
| **How** | Techstaff performs the following verification checks: 1. Login nodes accept SSH connections and authenticate users. 2. SLURM controller is scheduling jobs correctly. 3. Compute nodes report healthy status in SLURM. 4. Shared storage mounts are accessible from login and compute nodes. 5. Monitoring and alerting systems are collecting data. 6. Firewall rules and access controls are in their expected state. 7. A test job completes successfully across the job submission, scheduling, execution, and output pipeline. Results are documented. Only after verification passes is the cluster reopened to users. |

### Recovery Closure and Documentation

| Item | Detail |
|:-----|:-------|
| **What** | Formally close the recovery effort and document outcomes |
| **Who** | Techstaff lead or recovery coordinator |
| **When** | When all affected systems have been restored and verified |
| **How** | The recovery coordinator prepares a recovery closure report including: incident summary, timeline of recovery actions, systems affected and restored, data loss or gaps (if any), RTO/RPO performance versus targets, communication log, lessons learned, and recommendations for improvement. The report is reviewed by the Techstaff lead, shared with the faculty committee for significant incidents, and archived with incident records. Recommendations are tracked through the [Continuous Improvement](/sfa-policies/continuous-improvement/) process. |

### Recovery Communication

| Item | Detail |
|:-----|:-------|
| **What** | Communicate recovery status to stakeholders throughout the recovery process |
| **Who** | Techstaff lead or designated communication coordinator |
| **When** | At recovery activation, at regular intervals during recovery, and at recovery closure |
| **How** | 1. At recovery activation: notify affected users via email and Slack of the disruption, expected impact, and estimated recovery timeline. Update the cluster status page. 2. During recovery: provide updates at least every 24 hours and at significant milestones. Use Slack, email, and the cluster status page. 3. At recovery closure: notify users that services are restored, summarize any lasting impact (e.g., data loss on `/scratch`), and provide guidance for resuming work. 4. For significant incidents: notify the faculty committee and UChicago central IT. 5. All communications are reviewed for accuracy before distribution and archived with incident records. |

### Review Log

| Date | Reviewer | Summary of Changes |
|:-----|:---------|:-------------------|
| 2026-04-06 | DSI Techstaff | Initial version |

---

## NIST CSF 2.0 Control Mapping

| Control ID | Control Name | How Addressed |
|:-----------|:-------------|:--------------|
| RC.RP-01.01 | The recovery portion of the incident response plan is executed once initiated from the incident response process | Recovery plan is activated upon incident containment. Recovery coordinator manages execution per documented procedures. |
| RC.RP-02.01 | Recovery actions are selected, scoped, and prioritized considering the categorization of the incident | Recovery actions are prioritized by system criticality (SLURM controller, login nodes, storage, compute, monitoring). Recovery coordinator may adjust priorities based on incident specifics. |
| RC.RP-03.01 | The integrity of backups and other restoration assets is verified before using them for restoration | Backup integrity verification is required before any restoration. Procedure includes checksum verification, test extraction, and confirmation that backups predate the incident. |
| RC.RP-04.01 | Critical missions and business functions, and cybersecurity risk management, are considered to establish post-incident operational norms | Post-recovery verification confirms security controls, access policies, SLURM configurations, and monitoring are restored to documented baseline before reopening the cluster. |
| RC.RP-05.01 | The integrity of restored assets is verified, stakeholders are informed, and normal operations are confirmed | Restored systems undergo verification (SSH, SLURM scheduling, storage mounts, monitoring, test jobs) before returning to production. Users are notified when services are restored. |
| RC.RP-06.01 | The end of incident recovery is declared based on criteria, and incident-related documentation is completed | Recovery closure includes a formal report with timeline, actions taken, data loss summary, RTO/RPO performance, lessons learned, and recommendations. Reviewed by Techstaff lead and archived. |
| RC.CO-03.01 | Recovery activities and progress in restoring operational capabilities are communicated to designated internal and external stakeholders | Recovery status communicated via Slack, email, and cluster status page. Updates at least every 24 hours and at milestones. Faculty committee and UChicago central IT informed of significant incidents. Communications reviewed for accuracy and archived. |
| RC.CO-04.01 | Public updates on incident recovery are shared using approved methods and messaging | User-facing communications are posted to the cluster status page, email, and Slack. All communications are reviewed for accuracy before distribution. Speculative information is avoided. |
