---
title: "Monitoring and Detection"
layout: single
permalink: /sfa-policies/monitoring-detection/
classes: [wide, left-aligned]
hide_hero: True
---

# Monitoring and Detection Policy & Procedures

This document establishes the monitoring, detection, and analysis policies and procedures for the DSI HPC cluster. Effective monitoring enables early detection of security events, operational anomalies, and policy violations. As stated in the [General Policy]({{ '/policies/general/' | relative_url }}), all activities on DSI systems are subject to monitoring.

## Policy

### Continuous Monitoring (DE.CM)

#### DE.CM-01: Network Monitoring

Networks and network services shall be monitored for potentially adverse events on a continuous basis.

- **Perimeter monitoring.** The UChicago campus firewall provides network-level intrusion detection and prevention (IDS/IPS) for traffic entering and leaving the cluster. DSI Techstaff shall coordinate with UChicago central IT to ensure cluster subnets are covered by campus network monitoring.
- **Internal traffic.** DSI Techstaff shall monitor internal cluster network traffic for anomalies, including unexpected inter-node communication patterns, unusual data transfer volumes, and connections to unauthorized external endpoints.
- **Alerting.** Automated alerts shall be configured for network events that exceed defined thresholds (e.g., sustained high-bandwidth transfers from login nodes, connections to known-malicious IP addresses).

#### DE.CM-02: Physical Environment Monitoring

The physical environment of the cluster shall be monitored for potentially adverse events.

- **Data center access.** The cluster resides in a UChicago-managed data center with controlled physical access, including badge-based entry, surveillance cameras, and visitor management procedures administered by UChicago Facilities.
- **Environmental controls.** Temperature, humidity, and power conditions in the data center are monitored by UChicago Facilities. DSI Techstaff shall confirm with Facilities at least annually that environmental monitoring and alerting are operational for the cluster's location.
- **Asset tracking.** DSI Techstaff shall maintain an inventory of all physical cluster assets (nodes, switches, storage devices) and verify physical presence during scheduled maintenance windows.

#### DE.CM-03: Personnel Activity Monitoring

Personnel activity and technology usage shall be monitored for potentially adverse events.

- **Authentication logging.** All SSH authentication attempts (successful and failed) on login nodes shall be logged. Logs shall capture the timestamp, source IP address, username, and authentication method.
- **SLURM accounting.** The SLURM job scheduler shall maintain complete accounting records for all jobs, including the submitting user, submission time, start time, end time, allocated resources, and exit status. SLURM accounting provides a job-level audit trail of all compute activity.
- **Privileged access.** All administrative (sudo) commands executed by DSI Techstaff shall be logged. Privileged access logs shall be reviewed periodically for anomalous activity.
- **Login node activity.** Process activity on login nodes shall be monitored to detect resource abuse (e.g., compute-intensive processes that should be submitted as SLURM jobs).

#### DE.CM-06: External Service Provider Activity Monitoring

External service provider activities and services shall be monitored for potentially adverse events.

- **UChicago central IT services.** DSI Techstaff shall maintain awareness of the security monitoring services provided by UChicago central IT (firewall, DNS, network IDS/IPS, identity services) and shall coordinate on any alerts or incidents affecting cluster infrastructure.
- **Third-party software.** When external software repositories or package mirrors are used for cluster updates, DSI Techstaff shall verify package integrity using checksums or GPG signatures.
- **Cloud or external integrations.** Any future integrations with external services (cloud storage, external authentication providers) shall include monitoring requirements defined before deployment.

#### DE.CM-09: Computing Hardware, Software, and Services Monitoring

Computing hardware, software, runtime environments, and their data shall be monitored for potentially adverse events.

- **System health.** DSI Techstaff shall monitor CPU, memory, GPU, disk, and network utilization on all nodes. Hardware health indicators (GPU temperatures, ECC memory errors, disk SMART status) shall be collected and reviewed.
- **System logs.** Syslog output from all nodes shall be collected centrally. Logs shall include kernel messages, service status changes, and hardware error reports.
- **Software integrity.** The operating system and installed software on compute nodes shall be monitored for unauthorized modifications. Configuration management tools shall detect and report drift from the approved baseline.
- **Storage monitoring.** Storage capacity, I/O performance, and filesystem health (ZFS pool status) shall be monitored continuously, with alerts for degraded states or capacity thresholds.

---

### Adverse Event Analysis (DE.AE)

#### DE.AE-02: Security Event Analysis

Potentially adverse events shall be analyzed to better understand associated activities.

- **Log aggregation.** Security-relevant logs (authentication, SLURM accounting, syslog, firewall) shall be aggregated to support correlation and analysis.
- **Correlation.** When a potential security event is identified, DSI Techstaff shall correlate data across multiple log sources to determine the scope and nature of the activity (e.g., correlating a failed SSH brute-force attempt with SLURM job submissions from the same user or time period).
- **Baseline awareness.** DSI Techstaff shall maintain familiarity with normal cluster usage patterns (typical job sizes, login times, data transfer volumes) to support identification of anomalous behavior.

#### DE.AE-03: Security Event Impact Assessment

When an adverse event is confirmed or strongly suspected, an initial impact assessment shall be performed.

- **Severity classification.** Events shall be assessed using a three-tier severity rating:
  - **High:** Confirmed unauthorized access, data exfiltration, malware execution, or compromise of administrative credentials.
  - **Medium:** Suspicious activity that has not yet resulted in confirmed compromise (e.g., successful login from an unusual location, unauthorized software installation attempt).
  - **Low:** Policy violations or anomalies with limited security impact (e.g., login node resource abuse, failed authentication spikes from a single source).
- **Scope determination.** The assessment shall identify which systems, users, and data may be affected.

#### DE.AE-04: Impact Estimation of Adverse Events

The estimated impact and scope of adverse events shall be understood.

- **Impact factors.** When estimating impact, DSI Techstaff shall consider: the number of affected users, whether research data may have been accessed or corrupted, whether the event affects cluster availability, and whether the event could propagate to other UChicago systems.
- **Documentation.** Impact estimates shall be documented as part of the incident record, including the rationale for the severity classification.

#### DE.AE-06: Notification of Adverse Events

Information on adverse events shall be provided to authorized staff and tools.

- **Internal notification.** When a security event of medium or high severity is detected, DSI Techstaff shall notify all Techstaff team members promptly via the internal communication channel (e.g., Slack, email).
- **UChicago IT Security.** High-severity events shall be reported to UChicago IT Security in accordance with university incident reporting requirements.
- **Affected users.** Users whose accounts or data may be affected by a confirmed security event shall be notified by DSI Techstaff with appropriate detail about the event and any required actions (e.g., credential reset).
- **Management notification.** High-severity events shall be escalated to DSI leadership.

#### DE.AE-07: Cyber Threat Intelligence Integration

Cyber threat intelligence shall be integrated into the analysis of adverse events.

- **University threat feeds.** DSI Techstaff shall subscribe to and review threat intelligence communications provided by UChicago IT Security (e.g., alerts about active campaigns targeting higher education, known compromised credentials).
- **Vendor advisories.** DSI Techstaff shall monitor security advisories from key vendors (Ubuntu/Canonical, NVIDIA, SchedMD/SLURM) and assess their relevance to the cluster environment.
- **Contextual analysis.** When analyzing security events, DSI Techstaff shall consider whether the observed activity matches known threat patterns or indicators of compromise shared through university or vendor channels.

#### DE.AE-08: Incident Declaration

Adverse events shall be declared as incidents when they meet defined criteria.

- **Declaration criteria.** An adverse event shall be declared a security incident when any of the following are confirmed or strongly suspected:
  - Unauthorized access to a user account or administrative credentials
  - Execution of malware or unauthorized code with elevated privileges
  - Unauthorized access to or exfiltration of research data
  - Compromise of cluster infrastructure (nodes, storage, SLURM controller)
  - Any high-severity event as classified under DE.AE-03
- **Declaration authority.** Any DSI Techstaff member may declare an incident. Incidents shall be documented and managed according to the [Incident Response Policy]({{ '/sfa-policies/incident-response/' | relative_url }}).
- **Incident record.** Upon declaration, an incident record shall be created that captures: the date and time of detection, the declaring staff member, a description of the event, the initial severity classification, and the estimated scope.

---

## Procedures

### Network Monitoring Setup and Review

| Item | Detail |
|:-----|:-------|
| **What** | Verify that network monitoring coverage is in place and functioning for all cluster subnets |
| **Who** | DSI Techstaff |
| **When** | Annually at the start of autumn quarter, and after any network topology change |
| **How** | (1) Confirm with UChicago central IT that cluster subnets are included in campus IDS/IPS monitoring. (2) Verify that firewall logging is active for cluster traffic. (3) Review any internal network monitoring tools for correct configuration and alert thresholds. (4) Document the review in the log below. |

### Authentication Log Review

| Item | Detail |
|:-----|:-------|
| **What** | Review SSH authentication logs for anomalous patterns |
| **Who** | DSI Techstaff |
| **When** | Monthly, or immediately upon alert trigger |
| **How** | (1) Query authentication logs on login nodes for the review period. (2) Identify patterns of concern: high volumes of failed attempts from single sources, successful logins from unusual geographic locations, logins at unusual hours. (3) For any suspicious findings, correlate with SLURM accounting and other logs. (4) Take action as warranted (account lock, IP block, incident declaration). (5) Record review completion and any findings. |

### SLURM Accounting Review

| Item | Detail |
|:-----|:-------|
| **What** | Review SLURM job accounting records for anomalous usage patterns |
| **Who** | DSI Techstaff |
| **When** | Monthly, or upon detection of unusual resource consumption |
| **How** | (1) Query SLURM accounting data for the review period using `sacct`. (2) Look for anomalies: jobs with unusual resource requests, jobs from accounts that should be inactive, patterns suggesting cryptocurrency mining or other unauthorized use. (3) Correlate any findings with authentication and system logs. (4) Take action as warranted. |

### Hardware Health Check

| Item | Detail |
|:-----|:-------|
| **What** | Review hardware health indicators across all nodes |
| **Who** | DSI Techstaff |
| **When** | During each scheduled maintenance window (twice yearly), and continuously via automated monitoring |
| **How** | (1) Review GPU temperatures and ECC error counts via `nvidia-smi`. (2) Check disk SMART status on all nodes. (3) Review ZFS pool status for degraded or faulted vdevs. (4) Check system logs for hardware error messages (MCE, PCIe errors). (5) Schedule replacement for any components showing degradation. |

### Security Event Response

| Item | Detail |
|:-----|:-------|
| **What** | Respond to a detected security event |
| **Who** | DSI Techstaff |
| **When** | Upon detection of any potential security event |
| **How** | (1) Assess severity using the three-tier classification (High/Medium/Low). (2) For High or Medium events, notify all Techstaff immediately. (3) Gather and preserve relevant logs. (4) Correlate across log sources to determine scope. (5) Estimate impact (affected users, data, systems). (6) For High events, notify UChicago IT Security and DSI leadership. (7) If declaration criteria are met, declare an incident and create an incident record. (8) Notify affected users as appropriate. (9) Document the event and response actions. |

### Threat Intelligence Review

| Item | Detail |
|:-----|:-------|
| **What** | Review threat intelligence relevant to the cluster environment |
| **Who** | DSI Techstaff |
| **When** | Quarterly, and immediately upon receipt of high-priority advisories |
| **How** | (1) Review communications from UChicago IT Security for relevant threat information. (2) Check security advisories from Ubuntu/Canonical, NVIDIA, and SchedMD. (3) Assess whether any advisories require immediate action (patching, configuration changes, enhanced monitoring). (4) Update monitoring rules or alert thresholds as indicated by new threat information. (5) Record the review. |

### Review Log

| Date | Reviewer | Summary |
|:-----|:---------|:--------|
| 2026-04-06 | DSI Techstaff | Initial version |

---

## NIST CSF 2.0 Control Mapping

| Control ID | Control Name | How Addressed |
|:-----------|:-------------|:--------------|
| DE.CM-01.01 | Networks and network services are monitored to find potentially adverse events | Network monitoring policy requires campus IDS/IPS coverage of cluster subnets, internal traffic monitoring, and automated alerting. Annual review procedure verifies coverage. |
| DE.CM-02.01 | The physical environment is monitored to find potentially adverse events | Physical security relies on UChicago-managed data center controls (badge access, surveillance, environmental monitoring). Annual verification with Facilities and asset tracking during maintenance windows. |
| DE.CM-03.01 | Personnel activity and technology usage are monitored to find potentially adverse events | SSH authentication logging, SLURM job accounting, sudo logging, and login node process monitoring provide comprehensive personnel activity visibility. Monthly review procedures defined. |
| DE.CM-06.01 | External service provider activities and services are monitored to find potentially adverse events | Policy requires coordination with UChicago central IT on security services, package integrity verification, and monitoring requirements for any external integrations. |
| DE.CM-09.01 | Computing hardware, software, runtime environments, and their data are monitored to find potentially adverse events | System health monitoring (CPU, GPU, memory, disk), centralized syslog collection, configuration drift detection, and storage monitoring procedures cover all computing resources. |
| DE.AE-02.01 | Potentially adverse events are analyzed to better understand associated activities | Log aggregation, cross-source correlation, and baseline awareness enable analysis of potentially adverse events. |
| DE.AE-03.01 | Information is extracted from sources to support finding of potentially adverse events | Three-tier severity classification (High/Medium/Low) and scope determination procedures guide impact assessment of confirmed or suspected events. |
| DE.AE-04.01 | The estimated impact and scope of adverse events are understood | Impact estimation considers affected users, data, availability, and propagation potential. Estimates are documented in incident records. |
| DE.AE-06.01 | Information on adverse events is provided to authorized staff and tools | Notification procedures define escalation paths: internal Techstaff notification for Medium+ events, UChicago IT Security for High events, affected user notification, and management escalation. |
| DE.AE-07.01 | Cyber threat intelligence and other contextual information are integrated into the analysis | Quarterly review of university threat feeds and vendor advisories. Threat context applied during security event analysis. |
| DE.AE-08.01 | Incidents are declared when adverse events meet the defined incident criteria | Explicit declaration criteria defined (unauthorized access, malware, data exfiltration, infrastructure compromise). Any Techstaff member may declare. Incident records capture key details. |
