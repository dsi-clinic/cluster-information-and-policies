---
title: "Security Awareness and Training"
layout: single
permalink: /sfa-policies/security-training/
classes: [wide, left-aligned]
hide_hero: True
---

# Security Awareness and Training

This document establishes the policy and procedures for security awareness training on the DSI HPC cluster. All personnel who access or administer the cluster must understand their security responsibilities. Training ensures that users and administrators can recognize threats, follow established policies, and respond appropriately to security events.

## Policy

### Security Training for All Personnel (PR.AT-01)

All individuals granted access to the DSI HPC cluster shall complete security awareness training that covers:

- **Information security policies** -- acceptable use, data handling, and access control expectations for the cluster
- **Access controls** -- proper use of SSH keys, CNetID credentials, multi-factor authentication, and the principle of least privilege
- **Incident response** -- how to recognize and report suspected security incidents (e.g., unauthorized access, compromised credentials, suspicious activity)
- **Data protection** -- responsibilities for protecting research data, understanding the difference between backed-up storage (`/home`, `/project`) and non-backed-up storage (`/scratch`), and handling sensitive data appropriately

Training shall be role-based: all users receive general security awareness training, while personnel with elevated privileges receive additional specialized training (see below). Training is required at onboarding and on an ongoing basis thereafter. Training completion records shall be maintained.

### Specialized Training for Administrators (PR.AT-02)

DSI Techstaff members and any personnel with administrative (root) access to cluster systems shall complete specialized security training in addition to general awareness training. Specialized training shall cover:

- **System administration security** -- secure configuration management, patch management, log review, and vulnerability assessment
- **Incident handling** -- procedures for containment, eradication, and recovery specific to HPC infrastructure
- **Access management** -- administration of user accounts, group permissions, SLURM policies, and firewall rules
- **Infrastructure security** -- network segmentation, storage security, and monitoring tools used on the cluster

Specialized training content shall be informed by industry practices (e.g., NIST, SANS, CIS benchmarks) and updated as the threat landscape evolves. Training is required at onboarding into an administrative role and on an ongoing basis thereafter. Training completion records shall be maintained.

---

## Procedures

### New User Onboarding Training

| Item | Detail |
|:-----|:-------|
| **What** | Security awareness orientation for new cluster users |
| **Who** | DSI Techstaff (delivers training); new user (completes training) |
| **When** | Before or within the first two weeks of account provisioning |
| **How** | New users are provided with a security awareness briefing covering the topics listed in the general training policy above. This may be delivered as a written guide, a recorded presentation, or a live orientation session. The user acknowledges completion. Techstaff records the completion date. |

### Annual Refresher Training

| Item | Detail |
|:-----|:-------|
| **What** | Annual security awareness refresher for all active cluster users |
| **Who** | DSI Techstaff (coordinates and tracks); all active users (complete training) |
| **When** | Annually, aligned with the start of autumn quarter |
| **How** | Techstaff distributes a refresher covering any policy updates, recent threat trends relevant to HPC environments, and reminders of key security practices (credential handling, incident reporting, data protection). Refresher may be delivered via email summary, recorded presentation, or live session at a User Group meeting. Completion is tracked. Users who do not complete the refresher within 60 days receive a follow-up reminder. Accounts for users who remain non-compliant after 90 days may be flagged for review. |

### Specialized Techstaff Training

| Item | Detail |
|:-----|:-------|
| **What** | Role-specific security training for DSI Techstaff and other administrators |
| **Who** | DSI Techstaff members with administrative access |
| **When** | Within 30 days of assuming an administrative role, and annually thereafter |
| **How** | Specialized training is delivered through a combination of: (1) internal knowledge transfer covering cluster-specific administration procedures, incident response playbooks, and configuration management practices; (2) external training resources such as SANS courses, vendor security webinars, or UChicago IT security training offerings. Techstaff members document completed training activities. The Techstaff lead reviews training coverage annually to identify gaps. |

### Training Delivery Methods

Training may be delivered through any combination of the following methods, at Techstaff discretion:

- **Written guides** -- security awareness documents distributed via email or posted on the cluster documentation site
- **Recorded presentations** -- video or slide-based content that users can review asynchronously
- **Live sessions** -- in-person or virtual presentations, including topics at HPC User Group meetings
- **Email communications** -- security bulletins, policy update summaries, and incident lessons-learned

The choice of delivery method should balance thoroughness with the practical constraints of the cluster user community (primarily researchers and students).

### Training Records

| Item | Detail |
|:-----|:-------|
| **What** | Maintain records of all security training completions |
| **Who** | DSI Techstaff |
| **When** | Updated as training events occur; reviewed annually |
| **How** | Techstaff maintains a training log that records, for each training event: the participant name, training type (general or specialized), delivery method, date of completion, and topics covered. Records are retained for at least three years. The training log is reviewed annually alongside the refresher cycle to verify coverage and identify users or staff who are overdue for training. |

### Training Content Review

| Item | Detail |
|:-----|:-------|
| **What** | Review and update training content for accuracy and relevance |
| **Who** | DSI Techstaff |
| **When** | Annually, or after significant policy changes or security incidents |
| **How** | Techstaff reviews training materials to ensure alignment with current policies, infrastructure changes, and emerging threats. Lessons learned from security incidents or near-misses are incorporated into training content. Updates are documented in the review log below. |

### Review Log

| Date | Reviewer | Summary of Changes |
|:-----|:---------|:-------------------|
| 2026-04-06 | DSI Techstaff | Initial version |

---

## NIST CSF 2.0 Control Mapping

| Control ID | Control Name | How Addressed |
|:-----------|:-------------|:--------------|
| PR.AT-01.01 | Personnel are provided with awareness and training so that they possess the knowledge and skills to perform general tasks with cybersecurity risks in mind | General security awareness training is required for all cluster users at onboarding and annually. Training covers information security policies, access controls, incident response, and data protection. Training is role-based and records are maintained. |
| PR.AT-02.01 | Individuals in specialized roles are provided with awareness and training so that they possess the knowledge and skills to perform relevant tasks with cybersecurity risks in mind | DSI Techstaff with administrative access receive specialized training covering system administration security, incident handling, access management, and infrastructure security. Training is informed by industry practices, required at role assumption and annually, with records maintained. |
