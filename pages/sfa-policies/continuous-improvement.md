---
title: "Continuous Improvement"
layout: single
permalink: /sfa-policies/continuous-improvement/
classes: [wide, left-aligned]
hide_hero: True
---

# Continuous Improvement

This document establishes the policy and procedures for continuously improving the security posture of the DSI HPC cluster. Improvements are driven by formal evaluations (such as SFA assessments), security tests and exercises, day-to-day operational experience, and lessons learned from incidents. This process ensures that identified gaps are tracked, prioritized, and addressed systematically.

## Policy

### Improvements from Evaluations (ID.IM-01)

Findings and recommendations from security evaluations -- including NIST CSF Self-Assessment (SFA) reviews, internal audits, and external assessments -- shall be tracked and used to improve the cluster's cybersecurity posture. After each evaluation, Techstaff shall document identified gaps, prioritize remediation actions, assign owners, and track progress to completion.

### Improvements from Security Tests and Exercises (ID.IM-02)

Findings from security tests, exercises, and drills (e.g., vulnerability scans, backup restoration tests, incident response tabletop exercises) shall be documented and used to improve security controls and procedures. Test results that reveal weaknesses or gaps shall be treated as improvement items and tracked through the same process as evaluation findings.

### Improvements from Operational Processes (ID.IM-03)

Observations and lessons learned from routine cluster operations -- including monitoring alerts, user-reported issues, near-misses, and day-to-day administration -- shall be captured and used to refine security policies, procedures, and configurations. Techstaff members are encouraged to identify and propose improvements as part of their regular work.

### Incident Response Plan Maintenance (ID.IM-04)

The incident response plan and related recovery procedures shall be reviewed and updated based on lessons learned from actual incidents, tabletop exercises, changes in the threat landscape, and changes to cluster infrastructure. The plan shall be reviewed at least annually and updated whenever significant gaps are identified.

---

## Procedures

### Post-Evaluation Improvement Tracking

| Item | Detail |
|:-----|:-------|
| **What** | Track and remediate findings from security evaluations |
| **Who** | DSI Techstaff lead (owns tracking); individual Techstaff members (own remediation actions) |
| **When** | Within 30 days of completing an evaluation |
| **How** | 1. Review evaluation findings and recommendations. 2. Document each finding as an improvement item, including: description, severity or priority, affected controls, and recommended action. 3. Assign an owner and target completion date for each item. 4. Track items in the improvement log (below). 5. Review progress at Techstaff team meetings. 6. Close items when remediation is complete, documenting the action taken and date. |

### Post-Test and Exercise Improvement Tracking

| Item | Detail |
|:-----|:-------|
| **What** | Capture and act on findings from security tests and exercises |
| **Who** | DSI Techstaff |
| **When** | Within 14 days of completing a test or exercise |
| **How** | 1. Conduct an after-action review of the test or exercise. 2. Document findings: what worked well, what did not, and what needs improvement. 3. Create improvement items for identified gaps or weaknesses. 4. Add items to the improvement log with owner and target date. 5. For critical findings (e.g., backup restoration failure), initiate remediation immediately. |

### Operational Improvement Capture

| Item | Detail |
|:-----|:-------|
| **What** | Capture improvement opportunities from day-to-day operations |
| **Who** | All DSI Techstaff members |
| **When** | Ongoing; reviewed at Techstaff team meetings |
| **How** | Techstaff members identify potential improvements during routine operations (e.g., a monitoring gap discovered during troubleshooting, a manual process that should be automated, a policy that does not reflect current practice). Improvements are proposed via Slack or Techstaff meetings and, if accepted, added to the improvement log. Small improvements (e.g., configuration tweaks, documentation updates) may be implemented directly and logged after the fact. |

### Incident Response Plan Review and Update

| Item | Detail |
|:-----|:-------|
| **What** | Review and update the incident response plan and recovery procedures |
| **Who** | DSI Techstaff lead, with input from the Techstaff team |
| **When** | Annually (aligned with autumn quarter), after any significant incident, or when triggered by improvement items |
| **How** | 1. Review the current incident response plan, recovery plan, and related procedures. 2. Incorporate lessons learned from any incidents or exercises since the last review. 3. Evaluate whether changes in cluster infrastructure, personnel, or the threat landscape require plan updates. 4. Update procedures, contact lists, communication templates, and recovery priorities as needed. 5. Communicate significant changes to the Techstaff team. 6. Record the review in the review log below. |

### Annual Improvement Review

| Item | Detail |
|:-----|:-------|
| **What** | Review the overall improvement process and outstanding items |
| **Who** | DSI Techstaff lead |
| **When** | Annually, aligned with autumn quarter |
| **How** | 1. Review all open improvement items in the log. Reprioritize or close stale items as appropriate. 2. Assess whether the improvement process is working effectively (are items being closed in a timely manner? are sources of improvement being captured?). 3. Summarize the year's improvement activities (items opened, items closed, major changes implemented) for the faculty committee. 4. Identify any systemic issues that require broader action. |

### Improvement Log

The improvement log tracks all identified improvement items. Items are added as they are identified and updated as they progress.

| ID | Date Identified | Source | Description | Priority | Owner | Target Date | Status | Date Closed | Action Taken |
|:---|:----------------|:-------|:------------|:---------|:------|:------------|:-------|:------------|:-------------|
| 001 | 2026-04-06 | SFA Assessment | Initial SFA assessment improvement items (see individual policy documents) | -- | Techstaff Lead | -- | Open | -- | -- |

*Items are added to this log as they are identified from evaluations, tests, operations, and incidents.*

### Review Log

| Date | Reviewer | Summary of Changes |
|:-----|:---------|:-------------------|
| 2026-04-06 | DSI Techstaff | Initial version |

---

## NIST CSF 2.0 Control Mapping

| Control ID | Control Name | How Addressed |
|:-----------|:-------------|:--------------|
| ID.IM-01.01 | Improvements are identified from evaluations of the organization's cybersecurity posture | Findings from SFA assessments and other evaluations are documented as improvement items, assigned owners and target dates, and tracked to completion in the improvement log. Annual review ensures items are progressing. |
| ID.IM-02.01 | Improvements are identified from security tests and exercises, including those done in coordination with suppliers and relevant third parties | Findings from vulnerability scans, backup tests, tabletop exercises, and other security tests are captured through after-action reviews and tracked as improvement items. Critical findings trigger immediate remediation. |
| ID.IM-03.01 | Improvements are identified from execution of operational processes | Techstaff members identify operational improvements during routine work. Improvements are proposed at team meetings, added to the improvement log, and tracked. Small improvements may be implemented directly. |
| ID.IM-04.01 | Incident response plans and other cybersecurity plans that affect operations are established, communicated, maintained, and improved | The incident response plan is reviewed annually and after significant incidents. Lessons learned from incidents and exercises are incorporated. Changes are communicated to the team. Reviews are documented in the review log. |
