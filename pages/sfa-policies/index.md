---
title: "SFA Compliance: Policies and Procedures"
layout: single
permalink: /sfa-policies/
classes: [wide, left-aligned]
hide_hero: True
---

<style>
.tile-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 1.5rem;
  padding: 1.5rem 0;
  list-style: none;
  margin: 0;
}

@media (max-width: 1024px) {
  .tile-grid {
    grid-template-columns: repeat(2, 1fr);
  }
}
@media (max-width: 600px) {
  .tile-grid {
    grid-template-columns: 1fr;
  }
}

.tile {
  display: block;
  padding: 2rem;
  border: 1px solid #ddd;
  border-radius: 8px;
  text-decoration: none;
  color: inherit;
  background-color: #fff;
  transition: transform 0.2s, box-shadow 0.2s;
  height: 100%;
}
.tile:hover {
  transform: translateY(-5px);
  box-shadow: 0 4px 12px rgba(0,0,0,0.1);
  text-decoration: none;
}
.tile h4 {
  margin-top: 0;
  color: #800000;
}
.tile p {
  font-size: 0.9em;
  color: #555;
  margin-bottom: 0;
}

.phase-label {
  font-size: 0.85em;
  font-weight: 600;
  color: #800000;
  text-transform: uppercase;
  letter-spacing: 0.05em;
  margin-bottom: 0.25rem;
  margin-top: 2rem;
  padding-bottom: 0.5rem;
  border-bottom: 2px solid #800000;
}

.action-link {
  display: inline-block;
  margin-top: 1.5rem;
  padding: 0.75rem 1.5rem;
  background-color: #800000;
  color: #fff;
  border-radius: 6px;
  text-decoration: none;
  font-weight: 600;
  transition: background-color 0.2s;
}
.action-link:hover {
  background-color: #5c0000;
  color: #fff;
  text-decoration: none;
}

.coverage-table {
  width: 100%;
  border-collapse: collapse;
  margin-top: 1rem;
}
.coverage-table th, .coverage-table td {
  padding: 0.5rem 1rem;
  border: 1px solid #ddd;
  text-align: left;
}
.coverage-table th {
  background-color: #800000;
  color: #fff;
}
.coverage-table tr:nth-child(even) {
  background-color: #f9f9f9;
}

.draft-banner {
  background-color: #fff3cd;
  border: 1px solid #ffc107;
  border-radius: 6px;
  padding: 1rem 1.5rem;
  margin-bottom: 1.5rem;
  font-size: 0.95em;
}
</style>

<div style="margin-top: 2rem;"></div>

This section contains draft policies and procedures developed to support the University of Chicago's Security Framework Assessment (SFA) for the DSI HPC Cluster, targeting NIST CSF 2.0 Tier 2 (Risk Informed) compliance.

<div class="draft-banner">
<strong>Note:</strong> These are <strong>DRAFT</strong> documents currently under review. They have not yet been formally approved and are subject to change as the SFA compliance process progresses.
</div>

---

## Policy Documents

<div class="phase-label">Phase 1 -- Foundation</div>

<div class="tile-grid">
  <a href="/sfa-policies/network-architecture/" class="tile">
    <h4>Network Architecture Description</h4>
    <p>Network topology, security zones, data flows, and firewall boundaries for the DSI cluster.</p>
  </a>
  <a href="/sfa-policies/asset-management/" class="tile">
    <h4>Asset Management Policy and Procedure</h4>
    <p>Hardware and software inventory tracking, lifecycle management, and accountability.</p>
  </a>
  <a href="/sfa-policies/access-management/" class="tile">
    <h4>Access Management Policy and Procedure</h4>
    <p>Account provisioning, authentication, authorization, and periodic access reviews.</p>
  </a>
  <a href="/sfa-policies/incident-response/" class="tile">
    <h4>Incident Response Plan</h4>
    <p>Detection, escalation, containment, eradication, and post-incident review procedures.</p>
  </a>
</div>

<div class="phase-label">Phase 2 -- Risk and Protection</div>

<div class="tile-grid">
  <a href="/sfa-policies/risk-assessment/" class="tile">
    <h4>Risk Assessment Policy and Procedure</h4>
    <p>Risk identification, analysis, evaluation, and treatment for cluster operations.</p>
  </a>
  <a href="/sfa-policies/data-protection/" class="tile">
    <h4>Data Protection Policy and Procedure</h4>
    <p>Data classification, encryption, backup, and handling requirements.</p>
  </a>
  <a href="/sfa-policies/monitoring-detection/" class="tile">
    <h4>Monitoring and Detection Policy and Procedure</h4>
    <p>Log collection, security monitoring, alerting, and anomaly detection.</p>
  </a>
  <a href="/sfa-policies/platform-security/" class="tile">
    <h4>Platform Security Policy and Procedure</h4>
    <p>Configuration baselines, patch management, hardening, and drift detection.</p>
  </a>
</div>

<div class="phase-label">Phase 3 -- Sustainability</div>

<div class="tile-grid">
  <a href="/sfa-policies/security-training/" class="tile">
    <h4>Security Awareness and Training Policy and Procedure</h4>
    <p>Cybersecurity training requirements for users and technical staff.</p>
  </a>
  <a href="/sfa-policies/infrastructure-resilience/" class="tile">
    <h4>Infrastructure Resilience Policy and Procedure</h4>
    <p>Power, cooling, capacity planning, and physical infrastructure protections.</p>
  </a>
  <a href="/sfa-policies/recovery-plan/" class="tile">
    <h4>Recovery Plan and Procedure</h4>
    <p>RTO/RPO targets, restoration procedures, and recovery communication plans.</p>
  </a>
  <a href="/sfa-policies/continuous-improvement/" class="tile">
    <h4>Continuous Improvement Policy and Procedure</h4>
    <p>Policy review cycles, lessons learned, and improvement tracking.</p>
  </a>
</div>

---

## Compliance Action Items

The policies above describe *what* the DSI cluster's security posture should be. Turning those policies into reality requires concrete action items -- tasks that must be completed to bring the cluster into full compliance.

<a href="/sfa-policies/compliance-actions/" class="action-link">View Compliance Action Items</a>

---

## Control Coverage Summary

The SFA compliance effort addresses **71 controls** across all five NIST CSF 2.0 core functions:

<table class="coverage-table">
  <thead>
    <tr>
      <th>NIST Function</th>
      <th>Description</th>
      <th>Controls</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><strong>Identify (ID)</strong></td>
      <td>Asset management, risk assessment, governance</td>
      <td>18</td>
    </tr>
    <tr>
      <td><strong>Protect (PR)</strong></td>
      <td>Access control, data security, platform security, training</td>
      <td>24</td>
    </tr>
    <tr>
      <td><strong>Detect (DE)</strong></td>
      <td>Monitoring, anomaly detection, continuous assessment</td>
      <td>10</td>
    </tr>
    <tr>
      <td><strong>Respond (RS)</strong></td>
      <td>Incident response, analysis, mitigation, communication</td>
      <td>11</td>
    </tr>
    <tr>
      <td><strong>Recover (RC)</strong></td>
      <td>Recovery planning, improvements, communication</td>
      <td>8</td>
    </tr>
    <tr>
      <td colspan="2"><strong>Total</strong></td>
      <td><strong>71</strong></td>
    </tr>
  </tbody>
</table>
