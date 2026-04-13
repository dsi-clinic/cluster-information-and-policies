---
title: "Platform Security"
layout: single
permalink: /sfa-policies/platform-security/
classes: [wide, left-aligned]
hide_hero: True
---

# Platform Security Policy & Procedures

This document establishes the platform security policies and procedures for the DSI HPC cluster, covering configuration management, software and hardware maintenance, log generation, unauthorized software prevention, and secure development practices for infrastructure.

## Policy

### PR.PS-01: Configuration Management

Configuration management practices shall be established and applied to maintain the integrity and consistency of all cluster systems.

- **Standardized node configurations.** All compute nodes within a given series shall run identical operating system, driver, and software configurations. Login nodes and infrastructure nodes shall each have documented baseline configurations.
- **Configuration baselines.** The approved configuration for each node class (compute, login, management) shall be documented and maintained under version control. Baselines shall specify the OS version, kernel version, CUDA toolkit version, GPU driver version, SLURM version, and installed system packages.
- **Drift detection.** Configuration management tooling shall be used to detect and report deviations from approved baselines. Detected drift shall be remediated promptly or, if intentional, documented as an approved exception.
- **Change control.** Changes to node configurations shall follow a defined process: propose the change, test on a non-production node where feasible, document the change, apply during a scheduled maintenance window, and update the configuration baseline.

### PR.PS-02: Software Maintenance and Patching

Software on cluster systems shall be maintained, replaced, and removed in accordance with defined policies.

- **Scheduled maintenance.** The cluster undergoes [scheduled maintenance]({{ '/using-the-cluster/scheduled-maintenance/' | relative_url }}) twice yearly (typically June and December), during which the operating system (Ubuntu), CUDA toolkit, GPU drivers, SLURM, and other system packages are updated. Maintenance windows are announced with at least one week of advance notice.
- **Security patches.** Critical security patches for the operating system or key infrastructure components (SSH, SLURM, kernel) shall be evaluated within 7 days of release. Patches rated critical by the vendor or by UChicago IT Security shall be applied at the next available opportunity, which may require an unscheduled maintenance window.
- **End-of-life software.** Software that has reached end of life (no longer receiving security updates from its vendor) shall be replaced or upgraded within 90 days of the end-of-life date, or mitigating controls shall be documented.
- **User software.** Users manage their own software environments via conda/mamba within their home or project directories. User-installed software does not have root privileges and runs within SLURM resource allocations.

### PR.PS-03: Hardware Maintenance

Hardware platforms shall be maintained in accordance with defined policies to ensure continued reliability and security.

- **Lifecycle management.** Cluster hardware shall be evaluated for replacement or upgrade on an approximate five-year lifecycle. Replacement decisions shall consider vendor support status, failure rates, performance relative to current workloads, and availability of security updates (firmware, BIOS).
- **GPU monitoring.** GPU health shall be monitored continuously, including temperature, ECC memory error counts, and utilization. GPUs exhibiting degradation (e.g., rising ECC error rates, thermal throttling) shall be scheduled for replacement.
- **Preventive maintenance.** During each scheduled maintenance window, DSI Techstaff shall inspect hardware health indicators, verify firmware versions, and replace any components identified as degraded through monitoring.
- **Failure response.** When a node experiences a hardware failure, DSI Techstaff shall remove the node from the SLURM pool, diagnose the failure, and either repair/replace the component or retire the node. Users with jobs affected by hardware failure shall be notified.

### PR.PS-04: Log Generation

Logs shall be generated and made available for continuous monitoring across all cluster systems.

- **System logs.** All nodes shall generate syslog output, including kernel messages, service status changes, and hardware errors. Syslog shall be forwarded to a central log collection point.
- **Authentication logs.** SSH authentication logs on login nodes shall capture all login attempts (successful and failed), including timestamp, source IP, username, and authentication method.
- **SLURM accounting.** The SLURM controller shall maintain complete job accounting records, including submitting user, job ID, submission time, start time, end time, node allocation, resource usage, and exit status. SLURM accounting data shall be retained for a minimum of one year.
- **Administrative logs.** All sudo commands executed on cluster systems shall be logged with the executing user, timestamp, and command.
- **Log retention.** System logs, authentication logs, and administrative logs shall be retained for a minimum of 90 days. SLURM accounting data shall be retained for a minimum of one year. Longer retention may be implemented as storage permits.
- **Log protection.** Log files shall be writable only by the system logging processes and readable only by DSI Techstaff. Users shall not have the ability to modify or delete system logs.

### PR.PS-05: Unauthorized Software Prevention

Installation of unauthorized software shall be prevented through technical controls.

- **No root access.** Users are not granted root (sudo) access on any cluster node. This prevents users from installing system-level software, modifying system configurations, or altering security controls.
- **No Docker.** Docker is not available on the cluster because it requires root-equivalent privileges that would compromise system security. Users requiring containerized workflows may use rootless alternatives (e.g., Apptainer/Singularity), though these are not formally supported. See the [FAQ]({{ '/faq/faq/' | relative_url }}).
- **Module system.** System-level software available to users is managed through the environment module system, which is administered by DSI Techstaff. Only DSI Techstaff can add, modify, or remove modules.
- **User-space software.** Users may install software in their home and project directories using tools like conda/mamba. This software runs with the user's own permissions and within SLURM resource allocations, limiting its impact on the broader system.
- **Package repository controls.** Compute nodes' access to external package repositories shall be limited to trusted sources. DSI Techstaff shall review and approve any additions to the set of configured repositories.

### PR.PS-06: Secure Development Practices

Secure development practices shall be integrated into the management of cluster infrastructure.

- **Infrastructure as code.** Cluster configuration and deployment shall be managed through configuration management tools and scripts maintained under version control. Changes to infrastructure code shall be reviewed before application.
- **Change management.** Infrastructure changes shall follow the change control process defined in PR.PS-01. Changes shall be tested where feasible before production deployment, documented with rationale, and applied during scheduled maintenance windows when they require service disruption.
- **Credential management.** Administrative credentials, SSH keys, and service account passwords shall not be stored in version control repositories, configuration files accessible to users, or other insecure locations. Credentials shall be rotated when staff depart or when compromise is suspected.
- **Peer review.** Significant infrastructure changes (e.g., new node deployment scripts, SLURM configuration changes, firewall rule modifications) shall be reviewed by at least one other Techstaff member before deployment.

---

## Procedures

### Scheduled Maintenance Execution

| Item | Detail |
|:-----|:-------|
| **What** | Perform scheduled software and hardware maintenance on the cluster |
| **Who** | DSI Techstaff |
| **When** | Twice yearly (typically June and December), as announced with at least one week of notice |
| **How** | (1) Announce the maintenance window via the official Slack channel and any other communication channels. (2) Drain the SLURM queue and wait for running jobs to complete or reach the maintenance start time. (3) Update the operating system (Ubuntu packages, kernel). (4) Update CUDA toolkit and GPU drivers. (5) Update SLURM to the target version. (6) Update other system packages as needed. (7) Inspect hardware health on all nodes (GPU temperatures, ECC errors, disk SMART, ZFS pool status). (8) Replace or schedule replacement for degraded components. (9) Verify configuration baselines match across all nodes of each class. (10) Run validation tests (SLURM test jobs, GPU verification, storage I/O check). (11) Return nodes to the SLURM pool and reopen the cluster. (12) Announce maintenance completion. (13) Update configuration baselines and record the maintenance in the log below. |

### Critical Security Patch Application

| Item | Detail |
|:-----|:-------|
| **What** | Evaluate and apply critical security patches outside of scheduled maintenance |
| **Who** | DSI Techstaff |
| **When** | Within 7 days of a critical security advisory affecting cluster software |
| **How** | (1) Review the advisory to confirm it affects the cluster (check installed versions, assess exploitability). (2) If applicable, determine whether the patch can be applied without a full maintenance window (e.g., rolling restart) or requires cluster downtime. (3) Test the patch on a non-production node if feasible. (4) Announce any required downtime with as much advance notice as practical. (5) Apply the patch. (6) Verify system functionality after patching. (7) Update configuration baselines. (8) Document the patch application in the log below. |

### Configuration Baseline Review

| Item | Detail |
|:-----|:-------|
| **What** | Review and verify configuration baselines for all node classes |
| **Who** | DSI Techstaff |
| **When** | During each scheduled maintenance window, and after any configuration change |
| **How** | (1) For each node class (compute, login, management), compare the current running configuration against the documented baseline. (2) Verify OS version, kernel version, CUDA version, GPU driver version, SLURM version, and key package versions. (3) Identify and remediate any unauthorized drift. (4) Update baseline documentation if intentional changes have been made. (5) Record the review. |

### Log Infrastructure Verification

| Item | Detail |
|:-----|:-------|
| **What** | Verify that log generation and collection are functioning correctly across all nodes |
| **Who** | DSI Techstaff |
| **When** | During each scheduled maintenance window, and after any node addition or replacement |
| **How** | (1) Verify syslog forwarding is active on all nodes by checking for recent entries at the central collection point. (2) Confirm SSH authentication logging is enabled on all login nodes. (3) Verify SLURM accounting is recording job data by querying recent records with `sacct`. (4) Check that sudo logging is active on all nodes. (5) Confirm log retention policies are being enforced (logs older than retention period are rotated, recent logs are present). (6) Verify log file permissions (not readable or writable by non-privileged users). |

### Hardware Lifecycle Review

| Item | Detail |
|:-----|:-------|
| **What** | Assess cluster hardware against lifecycle and support criteria |
| **Who** | DSI Techstaff |
| **When** | Annually, aligned with the start of autumn quarter |
| **How** | (1) Review the age and vendor support status of each node series. (2) Compile failure rates and hardware incident history for the review period. (3) Assess whether any nodes have reached end of vendor support or are exhibiting elevated failure rates. (4) For nodes approaching five years of age, evaluate replacement options and budget requirements. (5) Document recommendations and present to DSI leadership for planning. |

### Review Log

| Date | Reviewer | Summary |
|:-----|:---------|:--------|
| 2026-04-06 | DSI Techstaff | Initial version |

---

## NIST CSF 2.0 Control Mapping

| Control ID | Control Name | How Addressed |
|:-----------|:-------------|:--------------|
| PR.PS-01.01 | Configuration management practices are established and applied | Standardized node configurations, documented baselines under version control, drift detection, and change control process. Baseline review procedure during each maintenance window. |
| PR.PS-02.01 | Software is maintained, replaced, and removed consistent with risk | Twice-yearly scheduled maintenance for OS, CUDA, SLURM, and drivers. Critical security patches evaluated within 7 days. End-of-life software replaced within 90 days. |
| PR.PS-03.01 | Hardware is maintained consistent with risk | Five-year lifecycle evaluation, continuous GPU health monitoring, preventive maintenance during scheduled windows, and defined failure response procedures. Annual lifecycle review. |
| PR.PS-04.01 | Log records are generated and made available for continuous monitoring | Syslog on all nodes forwarded centrally, SSH authentication logging, SLURM accounting (1-year retention), sudo logging, 90-day minimum log retention, and log protection controls. Verification procedure during each maintenance window. |
| PR.PS-05.01 | Installation of unauthorized software is prevented | No root access for users, no Docker, module system managed by Techstaff, user software confined to user-space with SLURM resource limits, and package repository controls. |
| PR.PS-06.01 | Secure development practices are integrated | Infrastructure managed as code under version control, change management process with testing and documentation, secure credential management, and peer review for significant changes. |
