---
title: "Asset Management"
layout: single
permalink: /sfa-policies/asset-management/
classes: [wide, left-aligned]
hide_hero: True
---

# Asset Management

This document defines the DSI cluster's policies and procedures for maintaining inventories of hardware assets, software and services, and managing asset lifecycles. Accurate asset inventories are foundational to risk management, vulnerability response, and capacity planning.

For hardware specifications and current resource counts, see [Current Cluster Information]({{ '/faq/cluster-information/' | relative_url }}). For purchasing and lifecycle terms, see [Purchasing Policies]({{ '/policies/purchasing/' | relative_url }}).

---

## Policy

### Hardware Inventory

The DSI Techstaff team shall maintain an accurate inventory of all cluster hardware assets. The inventory must include, at minimum:

- **Node name** and series designation
- **Role** (login, compute, storage, management)
- **CPU** model and core count
- **GPU** model, count, and memory per node
- **RAM** capacity
- **Local storage** type and capacity
- **Network interface** speed
- **Rack location**
- **Purchase date** and funding source (grant, DSI general, investor)
- **Warranty expiration date**
- **Criticality level** (high for login/management/storage nodes; standard for compute nodes)

The hardware inventory is currently maintained in the [Current Cluster Information]({{ '/faq/cluster-information/' | relative_url }}) page (summary level) and in Techstaff internal records (node-level detail).

### Software and Services Inventory

The DSI Techstaff team shall maintain an inventory of software and third-party services running on the cluster. The inventory must include:

| Category | Required Fields |
|:---------|:----------------|
| Operating system | Distribution, version, kernel version, per node or node group |
| Job scheduler | SLURM version, controller node |
| GPU stack | CUDA toolkit version(s), driver version(s), per node or node group |
| Configuration management | Tool name, version |
| Monitoring and logging | Tool names, versions |
| Storage services | Filesystem type, software version |
| Authentication | Method (CNetID/SSH keys), integration point |
| Third-party services | Name, vendor, version, purpose, criticality, contract/license status |

Software versions may differ across node groups (e.g., different CUDA versions on different GPU generations). The inventory must capture these differences.

### Asset Lifecycle Management

All cluster hardware shall be managed according to defined lifecycle policies:

- **Standard lifecycle:** Five years of supported operation from purchase date, consistent with the [Purchasing Policies]({{ '/policies/purchasing/' | relative_url }}).
- **End-of-life alignment:** GPU retirement timing shall consider NVIDIA's end-of-life schedule for each model.
- **Recall eligibility:** Hardware older than five years is subject to recall if it no longer meets cluster standards (power efficiency, driver compatibility, performance).
- **Warranty tracking:** Warranty expiration dates must be recorded and monitored. Out-of-warranty failures are handled on a best-effort basis.

### Pre-Addition Security Evaluation

Before any new hardware, software, or third-party service is added to the cluster, the DSI Techstaff team shall evaluate it for compatibility, security posture, and supportability. For hardware, this includes conformance with the minimum hardware requirements defined in the [Purchasing Policies]({{ '/policies/purchasing/' | relative_url }}). For software and services, this includes verifying vendor support status and known vulnerability exposure.

---

## Procedures

### Hardware Inventory Maintenance

| Item | Detail |
|:-----|:-------|
| **What** | Verify and update the hardware inventory |
| **Who** | DSI Techstaff |
| **When** | Within 5 business days of any hardware addition, removal, or change; and annually at the start of autumn quarter |
| **How** | 1. Compare inventory records against physical rack contents and system discovery tools (e.g., `sinfo`, `lshw`).<br>2. Update node-level records with any changes to hardware, location, or status.<br>3. Update the [Current Cluster Information]({{ '/faq/cluster-information/' | relative_url }}) page if summary totals change.<br>4. Record the review date in the review log below. |

### Software and Services Inventory Maintenance

| Item | Detail |
|:-----|:-------|
| **What** | Verify and update the software and services inventory |
| **Who** | DSI Techstaff |
| **When** | Within 5 business days of any software upgrade, new installation, or service change; and quarterly |
| **How** | 1. Collect current versions across all nodes. Useful commands include:<br>&nbsp;&nbsp;- `sinfo -V` (SLURM version)<br>&nbsp;&nbsp;- `cat /etc/os-release` (OS version)<br>&nbsp;&nbsp;- `nvidia-smi` (driver version)<br>&nbsp;&nbsp;- `nvcc --version` (CUDA version)<br>2. Compare collected versions against the inventory. Note any drift between node groups.<br>3. Update inventory records with current versions and the date verified.<br>4. Flag any software running past vendor end-of-support for remediation planning. |

### Lifecycle Review

| Item | Detail |
|:-----|:-------|
| **What** | Review hardware age, warranty status, and end-of-life alignment |
| **Who** | DSI Techstaff |
| **When** | Annually at the start of autumn quarter |
| **How** | 1. For each node, calculate age from purchase date.<br>2. Identify nodes approaching or past the 5-year lifecycle mark.<br>3. Check NVIDIA end-of-life announcements for installed GPU models.<br>4. Identify any out-of-warranty hardware.<br>5. Develop a recommendation for nodes to retire, replace, or continue operating, and communicate to DSI leadership.<br>6. Record the review in the log below. |

### New Asset Onboarding

When new hardware or software is added to the cluster:

1. **Hardware:** Record all required inventory fields before the node enters production. Verify rack power and cooling capacity. Confirm the hardware meets current [purchasing requirements]({{ '/policies/purchasing/' | relative_url }}).
2. **Software/services:** Record name, version, vendor, purpose, and criticality. Verify vendor support status and check for known vulnerabilities. Document any new firewall rules or access requirements.
3. **Update inventories** within 5 business days of the asset entering production.

### Review Log

| Date | Reviewer | Type | Summary |
|:-----|:---------|:-----|:--------|
| 2026-04-06 | DSI Techstaff | Initial | Initial policy and procedure creation |

---

## NIST CSF 2.0 Control Mapping

| Control ID | Control Name | How Addressed |
|:-----------|:-------------|:--------------|
| ID.AM-01.01 | Third-party System and Service Inventory | Software and services inventory policy requires tracking name, version, vendor, purpose, criticality, and license/contract status for all third-party systems and services. Quarterly review procedure ensures accuracy. Pre-addition evaluation covers new services. |
| ID.AM-02.01 | Hardware Asset Inventory | Hardware inventory policy requires comprehensive per-node records including model, location, purchase date, warranty, and criticality. Inventory is verified on change and annually. |
| ID.AM-08.01 | Asset Lifecycle Management | Lifecycle policy defines 5-year standard lifecycle, NVIDIA EOL alignment, warranty tracking, and recall eligibility. Annual lifecycle review procedure identifies aging and end-of-life assets for retirement planning. |
