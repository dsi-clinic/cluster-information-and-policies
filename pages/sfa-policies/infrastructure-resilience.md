---
title: "Infrastructure Resilience"
layout: single
permalink: /sfa-policies/infrastructure-resilience/
classes: [wide, left-aligned]
hide_hero: True
---

# Infrastructure Resilience

This document establishes policies and procedures for maintaining the resilience of the DSI HPC cluster infrastructure. Resilience encompasses network protection, environmental safeguards, redundancy mechanisms, and capacity planning. Together these measures ensure the cluster can withstand disruptions, recover from failures, and continue to meet research computing demands.

## Policy

### Network Protection (PR.IR-01)

The DSI HPC cluster network shall be protected through layered security controls to prevent unauthorized access and limit the impact of network-based threats:

- **Perimeter firewall** -- UChicago central IT manages the perimeter firewall between the campus network and the cluster. Inbound access is restricted to SSH (port 22) on login nodes only.
- **Network segmentation** -- The cluster is organized into distinct network zones (Access, Management, Computing, and Data Storage) as described in the [Network Architecture](/sfa-policies/network-architecture/) document. Traffic between zones is controlled and restricted to necessary protocols.
- **Compute node isolation** -- Compute nodes are not directly accessible from outside the cluster. Users reach compute resources only through SLURM job allocations originating from login nodes.
- **Internal network** -- All inter-node communication runs over a dedicated [internal network](/faq/cluster-information/#cluster-networking-and-topology) that is not routable from the campus network or internet.

DSI Techstaff shall coordinate with UChicago central IT on firewall rule changes and review network protection controls annually.

### Environmental Protection (PR.IR-02)

The physical infrastructure supporting the DSI HPC cluster shall be protected against environmental threats. The cluster resides in the **Hinds data center**, a UChicago-managed facility, where all physical infrastructure is the responsibility of the Hinds data center operations team:

- **Power** -- The data center is served by building power with uninterruptible power supply (UPS) systems to handle brief power interruptions.
- **Cooling** -- The data center maintains climate-controlled cooling appropriate for high-density computing equipment.
- **Fire suppression** -- The data center is equipped with fire detection and suppression systems managed by the Hinds data center.
- **Physical access** -- Physical access to the data center is controlled through card-access and building security managed by the Hinds data center.

DSI Techstaff shall verify that environmental conditions appear normal during routine data center visits and report any concerns to Hinds data center management promptly.

### Resilience Mechanisms (PR.IR-03)

The cluster shall employ resilience mechanisms to minimize the impact of hardware failures and service disruptions:

- **Redundant storage** -- The `/home` and `/project` storage tiers are backed up. Storage systems use redundant configurations (e.g., RAID) to tolerate disk failures without data loss.
- **SLURM job resilience** -- SLURM is configured to requeue jobs affected by node failures when possible, minimizing lost compute time for users.
- **Node failover** -- The loss of individual compute nodes does not affect the overall cluster. SLURM automatically removes failed nodes from the scheduling pool and redistributes workloads to healthy nodes.
- **Login node redundancy** -- Three login nodes (fe01.ds, fe02.ds, fe03.ds) provide redundant user access points. The loss of one login node does not prevent cluster access.
- **Service recovery** -- Critical services (SLURM controller, storage servers, monitoring) have documented recovery procedures to restore service after failures.

### Capacity Planning and Monitoring (PR.IR-04)

DSI Techstaff shall monitor cluster resource utilization and plan capacity to meet current and anticipated research computing needs:

- **Resource monitoring** -- GPU utilization, CPU utilization, memory usage, and storage capacity across all tiers shall be monitored continuously.
- **SLURM queue monitoring** -- Job queue depth, wait times, and scheduling efficiency shall be monitored to identify resource bottlenecks.
- **Storage capacity management** -- Storage utilization across `/home`, `/project`, and `/scratch` shall be tracked. Alerts shall be configured to notify Techstaff when storage tiers approach capacity thresholds.
- **Capacity planning** -- Techstaff shall review utilization trends at least annually and provide capacity projections to the faculty committee to inform procurement and resource allocation decisions.

---

## Procedures

### Firewall Rule Review

| Item | Detail |
|:-----|:-------|
| **What** | Review firewall rules and network access controls for the cluster |
| **Who** | DSI Techstaff, in coordination with UChicago central IT |
| **When** | Annually, aligned with the start of autumn quarter, or after any significant network change |
| **How** | Techstaff reviews the current firewall rules with UChicago central IT to verify that only necessary ports and protocols are permitted. Any rules that are no longer needed are removed. Changes are documented. The review is recorded in the log below. |

### Network Segmentation Verification

| Item | Detail |
|:-----|:-------|
| **What** | Verify that network zone boundaries and access controls are functioning as intended |
| **Who** | DSI Techstaff |
| **When** | Annually, or after significant infrastructure changes |
| **How** | Techstaff verifies that compute nodes remain unreachable from outside the cluster, that management services are restricted to authorized personnel, and that inter-zone traffic is limited to expected protocols. Any deviations are remediated and documented. |

### Environmental Controls Verification

| Item | Detail |
|:-----|:-------|
| **What** | Verify that data center environmental protections are operational |
| **Who** | DSI Techstaff |
| **When** | During routine data center visits (at least quarterly) |
| **How** | During physical visits to the data center, Techstaff performs a visual check of power systems (UPS indicators), cooling systems (temperature readings), and general physical conditions. Any anomalies (unusual temperatures, warning lights, physical damage) are reported to Hinds data center management. Observations are noted in the Techstaff operational log. |

### Storage Health and Backup Verification

| Item | Detail |
|:-----|:-------|
| **What** | Verify storage system health and backup integrity |
| **Who** | DSI Techstaff |
| **When** | Monthly for health checks; quarterly for backup verification |
| **How** | Techstaff reviews storage system health indicators (disk status, RAID health, capacity utilization). Quarterly, Techstaff performs a test restoration of a sample file from `/home` and `/project` backups to verify backup integrity. Results are recorded. |

### SLURM Resilience Verification

| Item | Detail |
|:-----|:-------|
| **What** | Verify SLURM job requeue and node failover behavior |
| **Who** | DSI Techstaff |
| **When** | After SLURM upgrades or configuration changes; annually at minimum |
| **How** | Techstaff verifies that SLURM is configured to drain failed nodes, requeue eligible jobs, and properly report node states. This may be done through configuration review or controlled testing during scheduled maintenance windows. Results are documented. |

### Capacity Monitoring and Alerting

| Item | Detail |
|:-----|:-------|
| **What** | Monitor resource utilization and maintain alerting thresholds |
| **Who** | DSI Techstaff |
| **When** | Monitoring is continuous; alerting thresholds are reviewed annually |
| **How** | Techstaff maintains monitoring dashboards for CPU/GPU utilization, memory usage, storage capacity, and SLURM queue metrics. Alerts are configured to notify Techstaff when: storage tiers exceed 85% capacity, nodes become unresponsive, or SLURM controller health degrades. Alert thresholds are reviewed annually and adjusted based on operational experience. |

### Annual Capacity Planning Review

| Item | Detail |
|:-----|:-------|
| **What** | Review utilization trends and develop capacity projections |
| **Who** | DSI Techstaff, with input from faculty committee |
| **When** | Annually, aligned with budget planning cycle |
| **How** | Techstaff compiles utilization data (average and peak GPU/CPU usage, storage growth rates, queue wait times) and prepares a capacity summary. The summary includes current utilization, growth trends, and projections for the next 12 months. This is presented to the faculty committee to inform decisions about hardware procurement, storage expansion, or policy changes (e.g., quota adjustments). |

---

## Technical Details

### Physical Infrastructure

The DSI HPC cluster is housed in the **Hinds data center**, which is managed by UChicago. All physical infrastructure — power, cooling, fire suppression, and physical access — is the responsibility of the Hinds data center operations team. DSI does not manage any physical infrastructure directly.

DSI Techstaff verifies that environmental conditions appear normal during routine data center visits (at least quarterly) and reports any concerns to Hinds data center management.

#### Power and UPS (Action Item 9.1)

- Power, UPS, and generator systems are provided and managed by the Hinds data center.
- DSI does not manage or have detailed specifications for these systems; they are maintained by the data center operations team in accordance with UChicago facility standards.
- The data center is **power-constrained**, which limits the density of GPU nodes per rack and is the primary limiting factor for cluster growth. Available space and power are contingent on the university's overall use of the Hinds data center. See [Space Availability and Server Room](/faq/cluster-information/#space-availability-and-server-room) for current details.

#### Cooling and Environmental Controls (Action Item 9.2)

- Cooling and environmental control systems are provided and managed by the Hinds data center.
- The data center is climate-controlled for high-density GPU computing equipment.
- DSI Techstaff monitors ambient conditions during quarterly visits and reports any anomalies to Hinds data center management.

#### Fire Suppression (Action Item 9.3)

- Fire detection and suppression systems are provided, managed, and inspected by the Hinds data center in accordance with applicable fire codes and university safety standards.
- DSI does not manage these systems. DSI Techstaff visually confirms that fire suppression equipment appears operational (no warning indicators, no visible damage) during quarterly data center visits.

### Capacity Planning Model (Action Item 9.4)

DSI Techstaff maintains a capacity planning model to project when additional resources will be needed and to inform procurement decisions.

**Current inventory:** See the [Current Cluster Information](/faq/cluster-information/) page for up-to-date node counts, GPU inventory, and storage totals.

**Physical constraints:** The cluster's physical footprint in the Hinds data center is contingent on the university's overall use of that facility. Power capacity is the primary constraint on cluster growth, limiting the density of GPU nodes per rack.

**Annual review:** The capacity planning model is reviewed and updated annually as part of the capacity planning review procedure (see Procedures section above). Growth projections and procurement recommendations are presented to the faculty oversight committee.

### SLURM Resilience and Cluster Purpose (Action Item 9.5)

The DSI HPC cluster is designed for **ephemeral data storage and computational experiments**. Users should treat the cluster as a platform for running experiments, not as long-term or archival storage. In the event of an operational failure, data loss may occur on local and scratch storage.

DSI Techstaff strives to restore cluster services as quickly as possible following any disruption. SLURM provides built-in resilience features — including job requeue capabilities, automatic draining of failed nodes, and workload redistribution across healthy nodes — that help minimize the impact of hardware failures on running jobs. Multiple login nodes provide redundant user access points so that no single node failure prevents cluster access.

For recovery procedures and backup details, see the [Recovery Plan](/sfa-policies/recovery-plan/).

### Review Log

| Date | Reviewer | Summary of Changes |
|:-----|:---------|:-------------------|
| 2026-04-14 | DSI Techstaff | Added Technical Details section (physical infrastructure, capacity planning, SLURM resilience) |
| 2026-04-06 | DSI Techstaff | Initial version |

---

## NIST CSF 2.0 Control Mapping

| Control ID | Control Name | How Addressed |
|:-----------|:-------------|:--------------|
| PR.IR-01.01 | Networks and environments are protected from unauthorized logical access and usage | Perimeter firewall managed by UChicago central IT restricts inbound access to SSH on login nodes. Network segmentation isolates compute, management, and storage zones. Compute nodes are not directly accessible externally. Annual firewall and segmentation reviews are conducted. |
| PR.IR-02.01 | The organization's technology assets are protected from environmental threats | Cluster resides in the Hinds data center (UChicago-managed) with UPS power, climate-controlled cooling, fire suppression, and card-access physical security. All physical infrastructure is managed by the Hinds data center operations team. Techstaff verifies environmental conditions during routine data center visits. |
| PR.IR-03.01 | Mechanisms are implemented to achieve resilience requirements in normal and adverse situations | Redundant storage with backups, SLURM job requeue on node failure, automatic node draining, three redundant login nodes, and documented service recovery procedures provide resilience across the cluster. |
| PR.IR-04.01 | Adequate resource capacity to ensure availability is maintained | Continuous monitoring of CPU/GPU utilization, memory, storage capacity, and SLURM queue metrics. Automated alerting at capacity thresholds. Annual capacity planning review with faculty committee to inform procurement decisions. |
