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

<h3 class="category-header">1. Asset Inventories & Diagrams</h3>
<p class="controls-note">Supports: ID.AM (Asset Management), ID.AM-01 through ID.AM-05</p>

- [ ] **1.1** Create and maintain a network architecture diagram showing all zones, data flows, and firewall boundaries (**CRITICAL** -- Tier 2 gate)
- [ ] **1.2** Create a hardware inventory spreadsheet/database with per-node details (hostname, role, CPU, GPU, RAM, storage, rack location, purchase date, warranty status)
- [ ] **1.3** Create a software inventory tracking OS versions, SLURM version, CUDA versions, and driver versions per node
- [ ] **1.4** Create a third-party services inventory (cloud services, external tools, vendor software)

<h3 class="category-header">2. Access Management</h3>
<p class="controls-note">Supports: PR.AA (Identity Management, Authentication, and Access Control), PR.AA-01 through PR.AA-06</p>

- [ ] **2.1** Establish a periodic access review process (at least annual) -- review all active accounts against current PI approvals
- [ ] **2.2** Define and document an SSH key rotation policy and communicate to users
- [ ] **2.3** Document the account deprovisioning procedure (what happens when someone leaves)
- [ ] **2.4** Create a physical access log or audit trail for the server room
- [ ] **2.5** Document the SLURM partition/QOS access control scheme

<h3 class="category-header">3. Incident Response</h3>
<p class="controls-note">Supports: RS.MA (Incident Management), RS.CO (Incident Reporting and Communication), RS.AN (Incident Analysis)</p>

- [ ] **3.1** Create an escalation contact list (DSI Techstaff -> Faculty Committee -> UChicago IT Security -> CISO) with names, roles, phone numbers, emails
- [ ] **3.2** Develop incident notification templates (email/Slack templates for different severity levels)
- [ ] **3.3** Create an incident log/tracking system (spreadsheet, ticketing system, etc.)
- [ ] **3.4** Conduct a tabletop exercise to test the incident response plan
- [ ] **3.5** Establish a relationship/communication channel with UChicago IT Security for incident coordination

<h3 class="category-header">4. Risk Management</h3>
<p class="controls-note">Supports: ID.RA (Risk Assessment), ID.RA-01 through ID.RA-06, GV.RM (Risk Management Strategy)</p>

- [ ] **4.1** Designate a risk assessment manager (DSI Techstaff lead or faculty committee member)
- [ ] **4.2** Create a risk register to track identified risks, their ratings, and response status
- [ ] **4.3** Subscribe to relevant vulnerability feeds (NVIDIA security bulletins, Ubuntu USNs, SLURM advisories)
- [ ] **4.4** Conduct an initial risk assessment of the cluster
- [ ] **4.5** Establish a change management log for tracking system changes
- [ ] **4.6** Define a vulnerability disclosure process (how external researchers report issues)

<h3 class="category-header">5. Data Protection</h3>
<p class="controls-note">Supports: PR.DS (Data Security), PR.DS-01, PR.DS-02, PR.DS-10, PR.DS-11</p>

- [ ] **5.1** Document the current backup system configuration (frequency, retention, what's covered)
- [ ] **5.2** Schedule and document quarterly backup restoration tests
- [ ] **5.3** Create a data classification guide for users (what data can/cannot go on the cluster)
- [ ] **5.4** Document encryption status for all storage tiers (at-rest and in-transit)

<h3 class="category-header">6. Monitoring & Detection</h3>
<p class="controls-note">Supports: DE.CM (Continuous Monitoring), DE.AE (Adverse Event Analysis), DE.CM-01 through DE.CM-09</p>

- [ ] **6.1** Document all current monitoring tools and their coverage
- [ ] **6.2** Set up or document centralized log collection (syslog server)
- [ ] **6.3** Define log retention periods and verify they're being met
- [ ] **6.4** Create monitoring alert thresholds and notification procedures
- [ ] **6.5** Document the integration (or plan for integration) with UChicago central SIEM

<h3 class="category-header">7. Platform Security</h3>
<p class="controls-note">Supports: PR.PS (Platform Security), PR.PS-01 through PR.PS-06</p>

- [ ] **7.1** Document the standard node configuration baseline
- [ ] **7.2** Implement or document configuration drift detection
- [ ] **7.3** Create a patch management calendar and tracking log
- [ ] **7.4** Document the software module system and how unauthorized software is prevented
- [ ] **7.5** Verify and document log generation on all nodes (syslog, auth, SLURM)

<h3 class="category-header">8. Training</h3>
<p class="controls-note">Supports: PR.AT (Awareness and Training), PR.AT-01, PR.AT-02</p>

- [ ] **8.1** Develop or adopt a cybersecurity awareness training program for cluster users
- [ ] **8.2** Develop specialized security training for DSI Techstaff
- [ ] **8.3** Create a training records tracking system
- [ ] **8.4** Schedule first annual security training session
- [ ] **8.5** Create onboarding security training materials for new users

<h3 class="category-header">9. Infrastructure & Resilience</h3>
<p class="controls-note">Supports: PR.IR (Technology Infrastructure Resilience), PR.IR-01 through PR.IR-04</p>

- [ ] **9.1** Document UPS and power redundancy for the server room
- [ ] **9.2** Document cooling and environmental controls
- [ ] **9.3** Verify and document fire suppression systems
- [ ] **9.4** Create a capacity planning model (current utilization vs. growth projections)
- [ ] **9.5** Document SLURM resilience features (job requeue, node failover)

<h3 class="category-header">10. Recovery</h3>
<p class="controls-note">Supports: RC.RP (Incident Recovery Plan Execution), RC.CO (Recovery Communication)</p>

- [ ] **10.1** Define RTO (Recovery Time Objective) and RPO (Recovery Point Objective) for each system component
- [ ] **10.2** Document the node rebuild procedure (bare metal to production)
- [ ] **10.3** Document SLURM database backup and restore procedure
- [ ] **10.4** Test and document user data restoration procedures
- [ ] **10.5** Create recovery communication templates
- [ ] **10.6** Designate a recovery communication team

<h3 class="category-header">11. Continuous Improvement</h3>
<p class="controls-note">Supports: ID.IM (Improvement), ID.IM-01 through ID.IM-04</p>

- [ ] **11.1** Create an improvement tracking log/system
- [ ] **11.2** Schedule an annual security policy review (all SFA policies)
- [ ] **11.3** Plan for a post-SFA assessment lessons-learned session
- [ ] **11.4** Establish a feedback mechanism for security improvement suggestions

<h3 class="category-header">12. Governance</h3>
<p class="controls-note">Supports: GV.OC (Organizational Context), GV.RR (Roles, Responsibilities, and Authorities), GV.PO (Policy)</p>

- [ ] **12.1** Schedule regular (quarterly) security review meetings with the faculty oversight committee
- [ ] **12.2** Assign ownership for each policy document (who is responsible for keeping it current)
- [ ] **12.3** Establish a document review/approval workflow
