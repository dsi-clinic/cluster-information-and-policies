---
title: "SFA Compliance Action Items"
layout: single
permalink: /sfa-policies/compliance-actions/
classes: [wide, left-aligned]
hide_hero: True
---

<style>
.category-header {
  color: #800000;
  border-bottom: 2px solid #800000;
  padding-bottom: 0.4rem;
  margin-top: 2.5rem;
}
.controls-note {
  font-size: 0.85em;
  color: #666;
  font-style: italic;
  margin-top: -0.5rem;
  margin-bottom: 1rem;
}
.back-link {
  display: inline-block;
  margin-bottom: 1.5rem;
  color: #800000;
  font-weight: 600;
  text-decoration: none;
}
.back-link:hover {
  text-decoration: underline;
}
</style>

<a href="/sfa-policies/" class="back-link">&larr; Back to SFA Policies Index</a>

This page tracks the concrete action items required to bring the DSI HPC Cluster into compliance with NIST CSF 2.0 Tier 2 (Risk Informed). These are the tasks that must be **completed** -- not just documented -- to support the policies and procedures described in the SFA policy documents.

Items are organized by category. Each category notes the relevant NIST CSF 2.0 functions and controls it supports.

---

<h3 class="category-header">Asset Inventories & Diagrams</h3>
<p class="controls-note">Supports: ID.AM (Asset Management), ID.AM-01 through ID.AM-05</p>

- [ ] Create and maintain a network architecture diagram showing all zones, data flows, and firewall boundaries (**CRITICAL** -- Tier 2 gate)
- [ ] Create a hardware inventory spreadsheet/database with per-node details (hostname, role, CPU, GPU, RAM, storage, rack location, purchase date, warranty status)
- [ ] Create a software inventory tracking OS versions, SLURM version, CUDA versions, and driver versions per node
- [ ] Create a third-party services inventory (cloud services, external tools, vendor software)

<h3 class="category-header">Access Management</h3>
<p class="controls-note">Supports: PR.AA (Identity Management, Authentication, and Access Control), PR.AA-01 through PR.AA-06</p>

- [ ] Establish a periodic access review process (at least annual) -- review all active accounts against current PI approvals
- [ ] Define and document an SSH key rotation policy and communicate to users
- [ ] Document the account deprovisioning procedure (what happens when someone leaves)
- [ ] Create a physical access log or audit trail for the server room
- [ ] Document the SLURM partition/QOS access control scheme

<h3 class="category-header">Incident Response</h3>
<p class="controls-note">Supports: RS.MA (Incident Management), RS.CO (Incident Reporting and Communication), RS.AN (Incident Analysis)</p>

- [ ] Create an escalation contact list (DSI Techstaff -> Faculty Committee -> UChicago IT Security -> CISO) with names, roles, phone numbers, emails
- [ ] Develop incident notification templates (email/Slack templates for different severity levels)
- [ ] Create an incident log/tracking system (spreadsheet, ticketing system, etc.)
- [ ] Conduct a tabletop exercise to test the incident response plan
- [ ] Establish a relationship/communication channel with UChicago IT Security for incident coordination

<h3 class="category-header">Risk Management</h3>
<p class="controls-note">Supports: ID.RA (Risk Assessment), ID.RA-01 through ID.RA-06, GV.RM (Risk Management Strategy)</p>

- [ ] Designate a risk assessment manager (DSI Techstaff lead or faculty committee member)
- [ ] Create a risk register to track identified risks, their ratings, and response status
- [ ] Subscribe to relevant vulnerability feeds (NVIDIA security bulletins, Ubuntu USNs, SLURM advisories)
- [ ] Conduct an initial risk assessment of the cluster
- [ ] Establish a change management log for tracking system changes
- [ ] Define a vulnerability disclosure process (how external researchers report issues)

<h3 class="category-header">Data Protection</h3>
<p class="controls-note">Supports: PR.DS (Data Security), PR.DS-01, PR.DS-02, PR.DS-10, PR.DS-11</p>

- [ ] Document the current backup system configuration (frequency, retention, what's covered)
- [ ] Schedule and document quarterly backup restoration tests
- [ ] Create a data classification guide for users (what data can/cannot go on the cluster)
- [ ] Document encryption status for all storage tiers (at-rest and in-transit)

<h3 class="category-header">Monitoring & Detection</h3>
<p class="controls-note">Supports: DE.CM (Continuous Monitoring), DE.AE (Adverse Event Analysis), DE.CM-01 through DE.CM-09</p>

- [ ] Document all current monitoring tools and their coverage
- [ ] Set up or document centralized log collection (syslog server)
- [ ] Define log retention periods and verify they're being met
- [ ] Create monitoring alert thresholds and notification procedures
- [ ] Document the integration (or plan for integration) with UChicago central SIEM

<h3 class="category-header">Platform Security</h3>
<p class="controls-note">Supports: PR.PS (Platform Security), PR.PS-01 through PR.PS-06</p>

- [ ] Document the standard node configuration baseline
- [ ] Implement or document configuration drift detection
- [ ] Create a patch management calendar and tracking log
- [ ] Document the software module system and how unauthorized software is prevented
- [ ] Verify and document log generation on all nodes (syslog, auth, SLURM)

<h3 class="category-header">Training</h3>
<p class="controls-note">Supports: PR.AT (Awareness and Training), PR.AT-01, PR.AT-02</p>

- [ ] Develop or adopt a cybersecurity awareness training program for cluster users
- [ ] Develop specialized security training for DSI Techstaff
- [ ] Create a training records tracking system
- [ ] Schedule first annual security training session
- [ ] Create onboarding security training materials for new users

<h3 class="category-header">Infrastructure & Resilience</h3>
<p class="controls-note">Supports: PR.IR (Technology Infrastructure Resilience), PR.IR-01 through PR.IR-04</p>

- [ ] Document UPS and power redundancy for the server room
- [ ] Document cooling and environmental controls
- [ ] Verify and document fire suppression systems
- [ ] Create a capacity planning model (current utilization vs. growth projections)
- [ ] Document SLURM resilience features (job requeue, node failover)

<h3 class="category-header">Recovery</h3>
<p class="controls-note">Supports: RC.RP (Incident Recovery Plan Execution), RC.CO (Recovery Communication)</p>

- [ ] Define RTO (Recovery Time Objective) and RPO (Recovery Point Objective) for each system component
- [ ] Document the node rebuild procedure (bare metal to production)
- [ ] Document SLURM database backup and restore procedure
- [ ] Test and document user data restoration procedures
- [ ] Create recovery communication templates
- [ ] Designate a recovery communication team

<h3 class="category-header">Continuous Improvement</h3>
<p class="controls-note">Supports: ID.IM (Improvement), ID.IM-01 through ID.IM-04</p>

- [ ] Create an improvement tracking log/system
- [ ] Schedule an annual security policy review (all SFA policies)
- [ ] Plan for a post-SFA assessment lessons-learned session
- [ ] Establish a feedback mechanism for security improvement suggestions

<h3 class="category-header">Governance</h3>
<p class="controls-note">Supports: GV.OC (Organizational Context), GV.RR (Roles, Responsibilities, and Authorities), GV.PO (Policy)</p>

- [ ] Schedule regular (quarterly) security review meetings with the faculty oversight committee
- [ ] Assign ownership for each policy document (who is responsible for keeping it current)
- [ ] Establish a document review/approval workflow
