---
title: "Network Architecture"
layout: single
permalink: /sfa-policies/network-architecture/
classes: [wide, left-aligned]
hide_hero: True
---

# Network Architecture

This document describes the network architecture of the DSI HPC cluster. It serves as the authoritative reference for how network zones, boundaries, and data flows are organized. A current and accurate network architecture description is essential for risk assessment, incident response, and change management.

## Policy

### Network Architecture Documentation

The DSI Techstaff team shall maintain a current description of the cluster's network architecture, including all network zones, trust boundaries, external connections, and primary data flows. This documentation must be reviewed and updated whenever significant changes are made to the network (e.g., new node series, storage expansions, firewall rule changes) and at minimum annually.

### Network Segmentation

The cluster network shall be logically organized into distinct zones based on function and trust level. Traffic between zones and to external networks shall be controlled by firewalls and access controls appropriate to the sensitivity of each zone.

---

## Network Architecture Description

*[Network Architecture Diagram]*

*The diagram should depict the four zones below, their interconnections, the UChicago campus network boundary, the firewall, and the primary data flow path from external users through SSH to login nodes, through SLURM to compute nodes, and to/from shared storage. Include interface speeds (1 Gbps external, 10 Gbps internal) and the three login node hostnames.*

### Zone 1: Access Zone (Login Nodes)

The Access Zone is the only entry point for external users. Users connect from the UChicago campus network (or VPN) via SSH to one of three login/frontend nodes:

- **fe01.ds** -- frontend login node
- **fe02.ds** -- frontend login node
- **fe03.ds** -- frontend login node

Users authenticate with CNetID credentials and SSH keys. The login nodes are used for interactive session setup, job submission, file management, and lightweight development tasks. No compute jobs run directly on these nodes.

**Trust boundary:** A UChicago-managed firewall sits between the campus network and the Access Zone, restricting inbound traffic to SSH (port 22). Outbound access from login nodes to the internet is permitted for package downloads and data transfers.

### Zone 2: Management Zone (Cluster Services)

The Management Zone hosts infrastructure services that are not directly accessible to users:

- **SLURM controller** -- schedules and dispatches batch and interactive jobs across compute nodes
- **Configuration management** -- maintains consistent OS, driver, and software state across all nodes
- **Monitoring and logging** -- collects system metrics and logs from all nodes

Management services communicate with all other zones over the internal 10 Gbps network. User access to management services is restricted to the DSI Techstaff team.

### Zone 3: Computing Zone (Compute Nodes)

The Computing Zone contains the 29 GPU and CPU compute nodes (2,720 cores, 140 GPUs total). These nodes:

- Receive job assignments from the SLURM controller in the Management Zone
- Execute user workloads within SLURM-managed resource allocations
- Read and write data to shared storage in the Data Storage Zone
- Are not directly accessible from outside the cluster; users reach them only through SLURM job allocations originating from the login nodes

All inter-node communication runs over the internal 10 Gbps network.

### Zone 4: Data Storage Zone

The Data Storage Zone provides 1.5 PB of shared storage across three tiers:

| Tier | Mount Point | Default Quota | Backed Up | Purpose |
|:-----|:------------|:--------------|:----------|:--------|
| Home | `/home` | 50 GB per user | Yes | Personal configs, scripts, source code |
| Project | `/project` | 500 GB per group (up to 10 TB) | Yes | Shared research data, results |
| Scratch | `/scratch` | 50 GB per user per volume | No | Temporary job I/O (60-day purge) |

Storage servers are connected to compute and login nodes over the internal 10 Gbps network. Storage is not directly accessible from outside the cluster.

### External Connectivity

- **Uplink:** 1 Gbps connection to the UChicago campus network (upgrade anticipated July 2026)
- **Firewall:** UChicago central IT manages the perimeter firewall. Inbound access is restricted to SSH on the login nodes.
- **Physical security:** The cluster resides in a UChicago-managed data center with controlled physical access.

### Primary Data Flow

1. **User** connects via SSH through the campus network and firewall to a **login node** (Access Zone)
2. User submits a job via SLURM on the login node
3. The **SLURM controller** (Management Zone) schedules the job on one or more **compute nodes** (Computing Zone)
4. Compute nodes read input data from and write output data to **shared storage** (Data Storage Zone) over the 10 Gbps internal network
5. User retrieves results from shared storage via the login node

---

## Procedures

### Annual Architecture Review

| Item | Detail |
|:-----|:-------|
| **What** | Review the network architecture description for accuracy and completeness |
| **Who** | DSI Techstaff |
| **When** | Annually, aligned with the start of autumn quarter, or within 30 days of any significant network change |
| **How** | Compare this document against current infrastructure. Verify zone membership, node counts, interface speeds, firewall rules, and storage capacity. Update the description and diagram as needed. Record the review date below. |

### Change-Triggered Updates

When any of the following changes occur, the DSI Techstaff member performing the change is responsible for updating this document within 30 days:

- Addition or removal of compute nodes
- Changes to login node configuration or hostnames
- Storage tier additions, expansions, or retirements
- Firewall rule changes affecting cluster traffic
- Network speed upgrades or topology changes
- New external service integrations

### Review Log

| Date | Reviewer | Summary of Changes |
|:-----|:---------|:-------------------|
| 2026-04-06 | DSI Techstaff | Initial version |

---

## NIST CSF 2.0 Control Mapping

| Control ID | Control Name | How Addressed |
|:-----------|:-------------|:--------------|
| ID.AM-03 | Representations of the organization's authorized network communication and internal and external network data flows are maintained | This document provides the authoritative network architecture description, including zones, boundaries, data flows, and connectivity. Annual review and change-triggered update procedures ensure it remains current. |
