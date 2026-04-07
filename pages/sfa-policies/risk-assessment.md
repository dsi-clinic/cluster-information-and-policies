---
title: "Risk Assessment"
layout: single
permalink: /sfa-policies/risk-assessment/
classes: [wide, left-aligned]
hide_hero: True
---

# Risk Assessment Policy & Procedure

This document defines the DSI HPC cluster's approach to identifying vulnerabilities and threats, assessing risk, determining responses, and managing changes that could affect security posture. It applies to all cluster infrastructure (29 compute nodes, 3 login nodes, storage systems, SLURM controller, and supporting services) and to the DSI Techstaff team responsible for their operation.

## Policy

### Vulnerability Identification (ID.RA-01)

DSI Techstaff shall maintain awareness of vulnerabilities that could affect cluster infrastructure. Vulnerability information shall be gathered from:

- **Vendor advisories** -- security bulletins from OS vendors (Rocky Linux / RHEL), NVIDIA (GPU drivers, CUDA), SLURM, and other software in use on the cluster
- **CVE databases** -- NIST National Vulnerability Database (NVD) and MITRE CVE
- **UChicago IT Security** -- advisories distributed by central IT security staff
- **Mailing lists and feeds** -- relevant security mailing lists (e.g., oss-security, vendor-specific lists)

DSI Techstaff shall review new vulnerability disclosures at least monthly and assess applicability to cluster components.

### Vulnerability Scanning and Assessment (ID.RA-02)

Vulnerabilities in cluster systems shall be identified through a combination of automated and manual methods:

- **Automated scanning** -- OS-level vulnerability scanners (e.g., `dnf updateinfo`, OpenSCAP, or equivalent) shall be run against cluster nodes at least quarterly
- **Package auditing** -- installed packages shall be compared against known-vulnerable versions at least quarterly
- **Manual review** -- DSI Techstaff shall review configurations of critical services (SSH, SLURM, NFS/storage, firewall rules) at least annually for misconfigurations or deviations from security baselines
- **Penetration testing** -- UChicago IT Security performs network-level scans of university systems; DSI Techstaff shall cooperate with any such assessments and remediate findings

Vulnerabilities shall be classified by severity:

| Severity | Description | Remediation Target |
|:---------|:------------|:-------------------|
| **Critical** | Remotely exploitable, no authentication required, or active exploitation in the wild | 7 days |
| **High** | Remotely exploitable with some preconditions, or local privilege escalation | 30 days |
| **Medium** | Exploitable under limited conditions, moderate impact | 90 days |
| **Low** | Minor impact, difficult to exploit | Next scheduled maintenance window |

### Threat Identification (ID.RA-03)

DSI Techstaff shall maintain awareness of threats relevant to the cluster environment. Threat information sources include:

- **UChicago IT Security** -- threat intelligence shared by the university's central security team
- **REN-ISAC** -- advisories from the Research and Education Networks Information Sharing and Analysis Center
- **Vendor and community sources** -- threat reports from OS vendors, CISA, and HPC community channels
- **System logs and monitoring** -- anomalous activity detected through cluster monitoring tools

A threat review shall be conducted at least annually to identify current threat actors, attack vectors, and trends relevant to university HPC environments. The review shall consider threats including but not limited to: unauthorized SSH access, cryptomining, data exfiltration, supply chain compromise of software packages, and insider misuse.

### Risk Assessment (ID.RA-04)

DSI Techstaff shall conduct risk assessments to evaluate the likelihood and potential impact of identified threats exploiting known vulnerabilities. Risk assessments shall:

- Be performed at least annually as a comprehensive review
- Be performed on an ad hoc basis when significant new threats or vulnerabilities are identified, or when major changes are planned
- Consider the cluster's operating context: an open research network with no restricted data on general-purpose systems
- Be documented and retained for at least three years

### Risk Calculation (ID.RA-05)

Risk shall be evaluated by considering the combination of:

- **Threat likelihood** -- how probable is it that a threat actor will attempt to exploit a given vulnerability, considering the cluster's exposure and attractiveness as a target
- **Vulnerability severity** -- how easily exploitable is the vulnerability and what level of access does it grant
- **Impact** -- what is the consequence to research operations, data integrity, system availability, or university reputation

Risk shall be expressed qualitatively as **High**, **Medium**, or **Low**:

| Risk Level | Description |
|:-----------|:------------|
| **High** | Likely exploitation with significant impact to cluster availability, data integrity, or university reputation |
| **Medium** | Possible exploitation with moderate impact, or likely exploitation with limited impact |
| **Low** | Unlikely exploitation or minimal impact |

### Risk Response (ID.RA-06)

For each identified risk, DSI Techstaff shall determine and document an appropriate response:

- **Mitigate** -- apply technical or procedural controls to reduce the risk (e.g., patch, configuration change, access restriction)
- **Accept** -- acknowledge the risk and take no further action, with documented justification (appropriate for low risks or where mitigation cost is disproportionate)
- **Transfer** -- shift the risk to another party (e.g., by relying on UChicago central IT controls for perimeter security)
- **Avoid** -- eliminate the risk by removing the affected component or capability

Risk responses shall be prioritized based on risk level. High risks shall have a response plan within 7 days of identification. Medium risks shall have a response plan within 30 days.

### Change Management (ID.RA-07)

Changes to cluster infrastructure that could affect security posture shall be evaluated for risk before implementation. This includes:

- Operating system or kernel upgrades
- Addition or removal of compute nodes
- Changes to SLURM configuration or scheduling policies
- Firewall rule modifications
- New software installations on shared systems
- Storage system changes (new tiers, migrations, expansions)
- Network topology changes

For each change:

1. The Techstaff member proposing the change shall document what is being changed and why
2. The change shall be reviewed for potential security impact (could it introduce new vulnerabilities, alter access controls, or affect availability?)
3. A rollback plan shall be identified before the change is applied
4. Changes shall be tested in a non-production context when feasible
5. Changes shall be applied during scheduled maintenance windows when they may affect availability

Emergency changes (e.g., critical security patches) may bypass the standard review process but must be documented after the fact within 5 business days.

### Vulnerability Disclosure (ID.RA-08)

If DSI Techstaff discovers a vulnerability in third-party software used on the cluster, the following process shall be followed:

1. Document the vulnerability, including affected software, version, and reproduction steps
2. Report the vulnerability to the software vendor or upstream maintainer through their established disclosure channel
3. If no disclosure channel exists, report to CERT/CC or CISA
4. Do not publicly disclose the vulnerability until a fix is available or 90 days have elapsed, whichever comes first
5. Apply local mitigations (e.g., disable affected feature, restrict access) while awaiting a vendor fix

If a vulnerability is discovered in DSI-developed scripts or configurations that could affect other systems, DSI Techstaff shall notify UChicago IT Security.

### Supplier and Third-Party Assessment (ID.RA-10)

Before introducing new third-party software, hardware, or services into the cluster environment, DSI Techstaff shall conduct a lightweight assessment considering:

- **Provenance** -- is the software from a reputable source with an active maintenance community or vendor?
- **Security track record** -- does the software have a history of serious vulnerabilities? Is the vendor responsive to security reports?
- **Update cadence** -- does the vendor or community release timely security patches?
- **Licensing and support** -- is the software appropriately licensed for research use? Is support available if needed?
- **UChicago IT review** -- does the software or service require review under university procurement or IT security policies?

Hardware suppliers (e.g., for new compute nodes or storage) shall be evaluated through UChicago's standard procurement process, which includes supply chain risk considerations.

Software obtained from community repositories (e.g., EPEL, conda-forge, PyPI) is accepted based on the repository's community governance and vetting processes, but individual packages with elevated privileges or system-level access shall receive additional review.

---

## Procedures

### Monthly Vulnerability Review

| Item | Detail |
|:-----|:-------|
| **What** | Review new vulnerability disclosures for applicability to cluster components |
| **Who** | DSI Techstaff |
| **When** | Monthly, within the first two weeks of each month |
| **How** | 1. Check vendor security advisories (Rocky Linux, NVIDIA, SLURM) for new bulletins since last review. 2. Review NVD/CVE entries for software in the cluster software inventory. 3. Review any advisories forwarded by UChicago IT Security. 4. For each applicable vulnerability, classify severity per the table above and create a remediation ticket. 5. Record review completion in the review log below. |

### Quarterly Vulnerability Scan

| Item | Detail |
|:-----|:-------|
| **What** | Run automated vulnerability scans against cluster nodes |
| **Who** | DSI Techstaff |
| **When** | Quarterly, aligned with the start of each academic quarter |
| **How** | 1. Run `dnf updateinfo list security` (or equivalent) on representative nodes from each role (login, compute, storage). 2. Run OpenSCAP or equivalent configuration compliance scan if available. 3. Review results and classify findings by severity. 4. Create remediation tickets for any new findings. 5. Document scan results and retain for at least one year. |

### Annual Risk Assessment

| Item | Detail |
|:-----|:-------|
| **What** | Comprehensive review of threats, vulnerabilities, and risks to the cluster |
| **Who** | DSI Techstaff, with input from the cluster oversight faculty committee |
| **When** | Annually, aligned with the start of autumn quarter |
| **How** | 1. Update the cluster asset inventory (nodes, software, services, network components). 2. Review the current threat landscape using sources listed in the Threat Identification policy. 3. Review open vulnerability findings and remediation status. 4. For each significant threat-vulnerability pair, assess risk using the risk calculation methodology above. 5. Document risk levels and determine responses (mitigate, accept, transfer, avoid). 6. Present a summary of high and medium risks to the cluster oversight faculty committee. 7. Update the risk register and record the assessment date in the review log below. |

### Change Evaluation Checklist

Before applying a change to cluster infrastructure, the responsible Techstaff member shall answer:

1. What is being changed and why?
2. Which systems or services are affected?
3. Could this change introduce new vulnerabilities or alter existing access controls?
4. Has the change been tested outside production?
5. What is the rollback plan if the change causes problems?
6. Does this change require a maintenance window notification to users?
7. Has another Techstaff member reviewed the change (for high-impact changes)?

Answers shall be recorded in the change ticket or internal documentation system.

### Supplier Evaluation for New Software

| Item | Detail |
|:-----|:-------|
| **What** | Assess a new third-party software package or service before deployment on the cluster |
| **Who** | DSI Techstaff member requesting the addition |
| **When** | Before installation on any production cluster node |
| **How** | 1. Identify the software source, maintainer, and license. 2. Check for known vulnerabilities (NVD search, vendor advisories). 3. Verify update/patch availability and cadence. 4. Determine if the software requires elevated privileges or network access. 5. If the software requires root-level access or opens network ports, obtain review from a second Techstaff member. 6. If the software is a paid product or cloud service, follow UChicago procurement procedures. 7. Document the assessment outcome and retain with the installation record. |

### Review Log

| Date | Reviewer | Activity | Summary |
|:-----|:---------|:---------|:--------|
| 2026-04-06 | DSI Techstaff | Initial version | Policy and procedure document created |

---

## NIST CSF 2.0 Control Mapping

| Control ID | Control Name | How Addressed |
|:-----------|:-------------|:--------------|
| ID.RA-01.01 | Vulnerabilities in assets are identified, validated, and recorded | Monthly vulnerability review procedure monitors vendor advisories, CVE databases, and UChicago IT Security notifications. Applicable vulnerabilities are classified by severity and tracked through remediation. |
| ID.RA-02.01 | Cyber threat intelligence is received from information sharing forums and sources | Threat information is gathered from UChicago IT Security, REN-ISAC, vendor advisories, CISA, and HPC community channels. Quarterly vulnerability scans provide automated detection. |
| ID.RA-03.01 | Internal and external threats to the organization are identified and recorded | Annual threat review identifies relevant threat actors and attack vectors. System monitoring detects anomalous activity. Threat landscape is considered in the context of an open research HPC environment. |
| ID.RA-04.01 | Potential impacts and likelihoods of threats exploiting vulnerabilities are identified and recorded | Annual risk assessment evaluates threat-vulnerability pairs for likelihood and impact. Ad hoc assessments are triggered by significant new threats or planned changes. |
| ID.RA-05.01 | Threats, vulnerabilities, likelihoods, and impacts are used to understand inherent risk and inform risk response prioritization | Risk calculation methodology combines threat likelihood, vulnerability severity, and impact to produce qualitative risk levels (High/Medium/Low) that drive response prioritization. |
| ID.RA-06.01 | Risk responses are chosen, prioritized, planned, tracked, and communicated | Risk response policy defines four response options (mitigate, accept, transfer, avoid) with prioritization timelines based on risk level. Responses are documented and tracked. |
| ID.RA-07.01 | Changes and exceptions are managed, assessed for risk impact, recorded, and tracked | Change management policy requires risk evaluation before infrastructure changes, including documentation, testing, rollback planning, and post-implementation review. Emergency change process is defined. |
| ID.RA-08.01 | Processes for receiving, analyzing, and responding to vulnerability disclosures are established | Vulnerability disclosure policy defines the process for reporting discovered vulnerabilities to vendors, applying local mitigations, and coordinating with UChicago IT Security. |
| ID.RA-10.01 | Critical suppliers are assessed prior to acquisition | Supplier evaluation policy requires assessment of provenance, security track record, update cadence, and licensing before introducing new software or hardware. Hardware follows UChicago procurement. Community repository packages with elevated access receive additional review. |
