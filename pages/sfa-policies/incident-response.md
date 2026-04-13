---
title: "Incident Response Plan"
layout: single
permalink: /sfa-policies/incident-response/
classes: [wide, left-aligned]
hide_hero: True
---

# Incident Response Plan

## 1. Policy Statement

The University of Chicago Data Science Institute (DSI) maintains a formal incident response capability to detect, analyze, contain, eradicate, and recover from cybersecurity incidents affecting the DSI HPC cluster (29 nodes, 2,720 cores, 140 GPUs, 1.5 PB storage). This plan ensures that:

- Security incidents are declared promptly using defined criteria.
- Incidents are triaged, categorized, and prioritized consistently using the [Techstaff SLA](/policies/techstaff-sla/) priority framework (P1/P2/P3).
- Escalation follows a clear path: **DSI Techstaff -> DSI Faculty Committee -> UChicago IT Security -> CISO**.
- Containment and eradication actions are proportional to incident severity and preserve forensic evidence.
- Root cause analysis and magnitude estimation inform recovery decisions and future prevention.
- Stakeholders are notified in a timely manner through designated channels.
- Lessons learned feed back into improved controls.

This plan applies to all users, administrators, and systems associated with the DSI HPC cluster.

**Review cycle:** This plan is reviewed annually by DSI Techstaff and the cluster oversight faculty committee, or after any P1 incident, whichever comes first.

---

## 2. Roles and Responsibilities

| Role | Responsibility |
|------|---------------|
| **DSI Techstaff** | First responders. Detect, triage, contain, eradicate, and recover. Maintain logs and evidence. |
| **DSI Cluster Oversight Faculty Committee** | Governance and oversight. Approve policy changes. Consulted on P1 incidents and post-incident reviews. |
| **UChicago IT Security** | Escalation point for incidents that may affect the broader university network or involve regulated data. Provides forensic and threat intelligence support. |
| **UChicago CISO Office** | Final escalation for incidents with university-wide impact, legal/regulatory implications, or external reporting requirements. |
| **Cluster Users** | Report suspicious activity promptly via the designated communication channels. Cooperate with investigations. |

---

## 3. Incident Declaration Criteria

A **security incident** is any event that actually or potentially compromises the confidentiality, integrity, or availability of the DSI HPC cluster, its data, or its users. The following are declarable incidents:

| Category | Examples |
|----------|----------|
| **Unauthorized access** | Compromised user credentials, unauthorized SSH sessions, privilege escalation |
| **Malicious software** | Cryptomining processes on compute nodes, malware, rootkits |
| **Vulnerability exploitation** | Exploitation of GPU driver vulnerabilities, unpatched OS or application flaws |
| **Data compromise** | Unauthorized access to project directories, data exfiltration from `/home` or `/project` |
| **Resource abuse** | Unauthorized resource consumption, job queue manipulation, policy-violating workloads |
| **Denial of service** | Resource exhaustion attacks, storage filling, network flooding |
| **Policy violations** | Circumventing SLURM resource limits, sharing credentials, running prohibited workloads |

Any cluster user or administrator who observes indicators of the above must report them immediately:

- **Ticket system:** [techstaff@cs.uchicago.edu](mailto:techstaff@cs.uchicago.edu) (response within 1 business day)
- **Public Slack channel:** #dsi-cluster-information (response within 2 business days)
- **For suspected active compromise:** Email techstaff@cs.uchicago.edu with subject line prefixed `[SECURITY]` for expedited handling

---

## 4. Triage and Validation

Upon receiving a report, DSI Techstaff performs initial triage:

1. **Acknowledge** the report within SLA response times (1 business day for tickets, 2 business days for Slack).
2. **Validate** whether the event constitutes a security incident:
   - Review relevant logs: SLURM job logs, system authentication logs (`/var/log/auth.log`, `journalctl`), network flow data.
   - Check for indicators of compromise (IOCs): unexpected processes, unusual network connections, unauthorized cron jobs.
   - Correlate with known threats or recent vulnerability advisories.
3. **Determine** if the event is a true positive, false positive, or requires further investigation.
4. If validated as an incident, proceed to categorization and prioritization.

---

## 5. Categorization and Prioritization

Validated incidents are categorized by type (see Section 3) and assigned a priority level aligned with the [Techstaff SLA](/policies/techstaff-sla/):

| Priority | Criteria | Target Response | Examples |
|----------|----------|----------------|----------|
| **P1 -- Emergency** | Active compromise, cluster-wide impact, data breach, or ongoing attack | Immediate (within 1 hour during business hours; next business day opening otherwise) | Active cryptomining across multiple nodes, confirmed credential compromise with lateral movement, cluster-wide service disruption from attack |
| **P2 -- Significant** | Confirmed incident with limited scope, vulnerability actively being exploited on single system, or potential for escalation | Within 4 business hours | Single compromised user account, GPU driver vulnerability with known exploit on one node, unauthorized data access to single project directory |
| **P3 -- Low** | Policy violation without active threat, suspicious activity requiring investigation, minor vulnerability | Within 1 business day | Failed brute-force attempts (blocked), user running a policy-violating workload, minor misconfiguration discovered |

Priority is determined by DSI Techstaff based on impact and urgency, not by the reporter.

---

## 6. Escalation Matrix

| Condition | Escalate To | Method | Timeline |
|-----------|------------|--------|----------|
| All validated incidents | DSI Techstaff (internal coordination) | Ticket system + Slack | Immediate |
| P1 incident or any incident with potential data breach | DSI Faculty Committee | Email to committee chair | Within 2 hours of validation |
| Incident may affect university network, involves regulated data, or requires forensic support beyond DSI capability | UChicago IT Security | UChicago IT Security incident reporting process | Within 4 hours of validation |
| Legal/regulatory reporting required, university-wide impact, or external notification needed | UChicago CISO Office | Through UChicago IT Security | As directed by IT Security |
| Incident unresolved after 48 hours at P1 | DSI Faculty Committee + UChicago IT Security | Email | At 48-hour mark |

All escalations are documented in the incident ticket.

---

## 7. Containment Procedures

Containment aims to limit the scope and impact of an incident. Actions are proportional to severity and selected based on the incident type.

### 7.1 Immediate Containment (P1 incidents)

| Action | Procedure | Authority |
|--------|-----------|-----------|
| **Node isolation** | Remove affected node(s) from SLURM (`scontrol update nodename=<node> state=drain reason="security incident"`). If active compromise is confirmed, additionally disconnect the node from the network at the switch level. | DSI Techstaff |
| **Account suspension** | Disable the compromised CNetID on the cluster (`usermod -L <username>` and revoke SLURM associations). Notify the user separately if they are not the threat actor. | DSI Techstaff |
| **Network segmentation** | Apply firewall rules to isolate affected node(s) from storage servers and other compute nodes. Block outbound connections from compromised systems. | DSI Techstaff |
| **Job termination** | Cancel all running and pending jobs from the compromised account (`scancel -u <username>`). If a node is compromised, cancel all jobs on that node. | DSI Techstaff |

### 7.2 Standard Containment (P2/P3 incidents)

- Drain the affected node from SLURM while investigation proceeds; do not disconnect from network unless active exfiltration is observed.
- Reset the affected user's password and SSH keys if credential compromise is suspected.
- Restrict the user's SLURM account to prevent new job submission during investigation.
- For policy violations without active threat, issue a warning and monitor.

### 7.3 Storage Containment

- If unauthorized access to `/project` or `/home` directories is confirmed, immediately revoke the compromised account's filesystem permissions.
- If data exfiltration is suspected, capture a snapshot of the affected directories (where filesystem supports it) before making changes.
- Do not delete or modify potentially compromised files until evidence preservation (Section 9) is complete.

---

## 8. Eradication Procedures

After containment, DSI Techstaff removes the root cause and restores system integrity.

| Step | Action | Details |
|------|--------|---------|
| 1 | **Identify root cause** | Analyze logs, malicious processes, and attack vectors. Determine how the compromise occurred. |
| 2 | **Remove malicious artifacts** | Kill unauthorized processes, remove malware/scripts, clean cron jobs, remove unauthorized SSH keys. |
| 3 | **Patch vulnerabilities** | Apply security patches to the exploited vulnerability (OS packages, GPU drivers, SLURM, etc.). If a patch is unavailable, implement a compensating control (firewall rule, configuration change). |
| 4 | **Credential rotation** | Force password reset for all affected accounts. Regenerate SSH host keys if a node's host key may be compromised. Rotate any service account credentials that were accessible from the compromised system. |
| 5 | **Configuration hardening** | Review and tighten configurations that contributed to the incident (e.g., file permissions, SLURM limits, firewall rules). |
| 6 | **Verify eradication** | Re-scan the affected systems. Confirm no persistence mechanisms remain (cron jobs, systemd services, authorized_keys entries). |

---

## 9. Evidence Preservation

Evidence must be preserved for all P1 and P2 incidents, and for P3 incidents where escalation is possible.

### 9.1 Log Collection

- Collect and archive the following from affected systems **before** any eradication steps:
  - System logs: `/var/log/auth.log`, `/var/log/syslog`, `journalctl` output
  - SLURM logs: job submission records, accounting data (`sacct` output for affected user/time period)
  - Network logs: firewall logs, connection records
  - Application logs: any relevant service logs (e.g., GPU driver logs)
  - File system metadata: timestamps, permissions, ownership of suspicious files

### 9.2 Chain of Custody

- Store collected evidence in a dedicated, access-restricted directory on a system not involved in the incident.
- Record who collected the evidence, when, from which system, and using what method.
- Maintain a log of everyone who accesses the evidence.
- Evidence is retained for a minimum of 90 days, or longer if required by an ongoing investigation or university policy.

### 9.3 Forensic Imaging

- For P1 incidents, create a disk image of the affected node's local storage before eradication, if operationally feasible.
- For incidents escalated to UChicago IT Security, coordinate evidence handling with their forensic procedures.

---

## 10. Root Cause Analysis

A root cause analysis (RCA) is performed for all P1 incidents and for P2 incidents at the discretion of DSI Techstaff.

| Step | Action |
|------|--------|
| 1 | Assemble an RCA team (DSI Techstaff; include faculty committee representative for P1). |
| 2 | Construct an incident timeline from initial compromise through detection, containment, and eradication. |
| 3 | Identify the root cause: what vulnerability, misconfiguration, or process failure allowed the incident. |
| 4 | Identify contributing factors: what made detection or response slower than expected. |
| 5 | Produce an RCA report with findings and recommended corrective actions. |
| 6 | Present findings to DSI Faculty Committee (P1) or retain internally (P2). |
| 7 | Track corrective actions to completion. |

RCA reports are completed within **10 business days** of incident closure for P1, and **20 business days** for P2.

---

## 11. Magnitude Estimation

For each validated incident, DSI Techstaff estimates the magnitude of impact across the following dimensions:

| Dimension | Assessment Questions |
|-----------|---------------------|
| **Scope** | How many nodes, users, or jobs were affected? Was the impact confined to a single node or cluster-wide? |
| **Data impact** | Was any data accessed, modified, or exfiltrated? What type and volume? Does it include restricted research data? |
| **Operational impact** | How long was the cluster (or part of it) unavailable? How many user jobs were disrupted? |
| **Reputational/compliance impact** | Does this trigger university reporting requirements? Are there external notification obligations? |

Magnitude estimation informs escalation decisions, stakeholder notification scope, and post-incident review priority.

---

## 12. Stakeholder Notification

### 12.1 Internal Notifications

| Stakeholder | Trigger | Method | Timeline |
|------------|---------|--------|----------|
| **Directly affected users** | Their account, jobs, or data were involved | Email from techstaff@cs.uchicago.edu | Within 1 business day of containment |
| **All cluster users** | Cluster-wide impact or downtime (P1) | Slack #dsi-cluster-information + email | As soon as impact is confirmed |
| **DSI Faculty Committee** | All P1 incidents; P2 incidents with data impact | Email to committee chair | Per escalation matrix (Section 6) |
| **DSI Leadership** | P1 incidents; incidents with reputational or compliance implications | Email from Faculty Committee chair or Techstaff lead | Within 4 hours of P1 validation |

### 12.2 External Notifications

| Stakeholder | Trigger | Method | Timeline |
|------------|---------|--------|----------|
| **UChicago IT Security** | Per escalation matrix | UChicago IT Security reporting process | Per escalation matrix (Section 6) |
| **UChicago CISO** | Legal/regulatory triggers, university-wide impact | Through IT Security | As directed |

### 12.3 Information Sharing

- Incident details shared with UChicago IT Security include: incident type, affected systems, timeline, containment actions taken, and indicators of compromise.
- Personally identifiable information is shared only as necessary for investigation and in accordance with university data handling policies.
- Threat intelligence derived from incidents (IOCs, attack patterns) may be shared with UChicago IT Security for broader university protection.
- Public disclosure of incident details requires approval from the DSI Faculty Committee and the CISO Office.

---

## 13. Recovery Initiation Criteria

Recovery (returning affected systems to normal operation) proceeds only when **all** of the following criteria are met:

| # | Criterion |
|---|-----------|
| 1 | Root cause has been identified and eradicated (or a compensating control is in place). |
| 2 | Evidence preservation is complete for the affected systems. |
| 3 | Patches or configuration changes addressing the vulnerability have been applied and verified. |
| 4 | Compromised credentials have been rotated. |
| 5 | DSI Techstaff has verified no persistence mechanisms remain on affected systems. |
| 6 | For P1 incidents: DSI Faculty Committee has approved the return to service. |
| 7 | Monitoring is in place to detect recurrence (enhanced logging or alerting as needed). |

### Recovery Steps

1. Restore the node to SLURM service (`scontrol update nodename=<node> state=resume`).
2. Re-enable affected user accounts after credential rotation is confirmed.
3. Monitor the recovered systems closely for **72 hours** for signs of reinfection or recurrence.
4. Notify affected users that service has been restored and provide any required guidance (e.g., "rotate your SSH keys").
5. Close the incident ticket once the monitoring period concludes without further issues.

---

## 14. HPC-Specific Incident Scenarios

### 14.1 Compromised User Credentials

**Indicators:** Logins from unusual IP addresses, SSH sessions at atypical hours, jobs submitted that do not match the user's research profile.

**Response:**
1. Immediately suspend the account (Section 7.1).
2. Cancel all running and pending jobs from the account.
3. Audit the account's activity: `sacct -u <user> --starttime=<date>`, review `~/.bash_history`, check `~/.ssh/authorized_keys` for unauthorized keys.
4. Check for lateral movement: did the compromised account access other users' data or attempt privilege escalation?
5. Rotate credentials and re-enable after verification.
6. Notify the user and require confirmation of new credentials before re-enabling access.

### 14.2 Cryptomining on Compute Nodes

**Indicators:** Unexplained high CPU/GPU utilization on nodes, SLURM jobs consuming full node resources with no corresponding legitimate user activity, outbound connections to mining pool IP addresses.

**Response:**
1. Identify the malicious processes and the user/job responsible.
2. Cancel the job and kill the processes immediately.
3. Drain the affected node from SLURM.
4. Determine entry vector: compromised credentials, exploited vulnerability, or insider misuse.
5. If credentials were compromised, follow Scenario 14.1.
6. Check all other nodes for similar activity (`clush` or parallel SSH to run process checks cluster-wide).
7. Block known mining pool IPs at the firewall.

### 14.3 GPU Driver Vulnerability Exploitation

**Indicators:** Kernel panics or GPU errors on specific nodes, unexpected processes running with GPU access, exploitation attempts matching known CVEs.

**Response:**
1. Drain the affected node(s) from SLURM.
2. Identify the vulnerable driver version and the CVE.
3. If an active exploit is running, isolate the node from the network.
4. Apply the patched driver version. If no patch is available, disable GPU access on the node until one is released.
5. Audit all nodes running the same driver version and patch proactively.
6. Notify users of affected GPU partitions about temporary unavailability.

### 14.4 Unauthorized Data Access

**Indicators:** Anomalous file access patterns in `/project` or `/home` directories, user reports of unexpected data modifications, audit log entries showing access by unauthorized accounts.

**Response:**
1. Immediately revoke the unauthorized account's access to the affected directories.
2. Capture filesystem metadata (timestamps, permissions) for evidence.
3. Determine scope: what data was accessed, was it copied or exfiltrated?
4. Assess whether restricted research data was involved (triggers mandatory escalation to UChicago IT Security).
5. Notify the data owner (PI or user) of the access.
6. Review and tighten directory permissions across related project directories.

### 14.5 Resource Exhaustion

**Indicators:** Storage filesystems approaching capacity (`/home`, `/project`, `/net/scratch`), SLURM queue backlog from a single user or group consuming disproportionate resources, network bandwidth saturation.

**Response:**
1. Identify the source: which user, job, or process is causing the exhaustion.
2. For storage: if a user or job is filling scratch or project space, contact the user and, if necessary, suspend the offending job.
3. For compute: adjust SLURM fair-share parameters or apply temporary resource limits to the offending account.
4. For network: identify and throttle or block the traffic source.
5. Determine if the exhaustion is accidental (runaway job) or malicious (intentional DoS). If malicious, escalate to P1.
6. Communicate to affected users via Slack if cluster performance is degraded.

---

## 15. Post-Incident Review

After every P1 incident and select P2 incidents, a post-incident review is conducted:

1. **Timeline reconstruction** -- Document the complete incident timeline from initial indicator through resolution.
2. **Effectiveness assessment** -- Evaluate how well detection, containment, eradication, and recovery procedures worked.
3. **Gap identification** -- Identify any gaps in monitoring, tooling, procedures, or training.
4. **Corrective actions** -- Define specific improvements with owners and deadlines.
5. **Plan update** -- Update this incident response plan if the review identifies procedural gaps.
6. **Distribute findings** -- Share the post-incident review summary with DSI Techstaff and the Faculty Committee. Share relevant threat indicators with UChicago IT Security.

---

## 16. NIST CSF 2.0 Control Mapping

| Control ID | Control Description | Addressed In |
|------------|--------------------|--------------|
| **RS.MA-01.01** | Incident response plan is executed | Sections 1--14 (entire plan) |
| **RS.MA-02.01** | Incident reports are triaged and validated | Section 4 (Triage and Validation) |
| **RS.MA-03.01** | Incidents are categorized and prioritized | Section 5 (Categorization and Prioritization) |
| **RS.MA-04.01** | Incidents are escalated or elevated as needed | Section 6 (Escalation Matrix) |
| **RS.MA-05.01** | Criteria for initiating incident recovery are applied | Section 13 (Recovery Initiation Criteria) |
| **RS.AN-03.01** | Root cause analysis is performed | Section 10 (Root Cause Analysis) |
| **RS.AN-06.01** | Actions performed during investigation are recorded | Section 9 (Evidence Preservation) |
| **RS.AN-07.01** | Incident data and metadata are collected and integrity preserved | Section 9 (Evidence Preservation) |
| **RS.AN-08.01** | Magnitude of an incident is estimated | Section 11 (Magnitude Estimation) |
| **RS.CO-02.01** | Internal stakeholders are notified of incidents | Section 12.1 (Internal Notifications) |
| **RS.CO-03.01** | Information is shared with designated internal and external stakeholders | Section 12.2--12.3 (External Notifications, Information Sharing) |
| **RS.MI-01.01** | Incidents are contained | Section 7 (Containment Procedures) |
| **RS.MI-02.01** | Incidents are eradicated | Section 8 (Eradication Procedures) |

---

*Last updated: {{ "now" | date: "%Y-%m-%d" }}*
