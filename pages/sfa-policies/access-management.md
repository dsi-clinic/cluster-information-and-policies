---
title: "Access Management Policy and Procedure"
layout: single
permalink: /sfa-policies/access-management/
classes: [wide, left-aligned]
hide_hero: True
---

# Access Management Policy and Procedure

This document establishes the access management policies and procedures for the DSI HPC Cluster (29 nodes, 2720 cores, 140 GPUs, 1.5 PB storage) at the University of Chicago Data Science Institute. It addresses identity management, authentication, authorization, physical access, and access review in compliance with NIST CSF 2.0 Tier 2 (Risk Informed) requirements.

All access to the DSI Cluster is mediated through University of Chicago CNetID credentials, SSH key authentication, and SLURM job scheduling. DSI Techstaff administers cluster-level accounts; UChicago central IT manages the underlying identity infrastructure.

---

## Policy

### 1. Identity and Credential Management (PR.AA-01.01)

**Policy:** All identities and credentials for authorized users, services, and hardware on the DSI Cluster are managed throughout their lifecycle. Every cluster account is tied to a unique UChicago CNetID. Shared accounts are prohibited. Service accounts, where required for system operations, are created and managed exclusively by DSI Techstaff.

### 2. Identity Proofing (PR.AA-02.01)

**Policy:** Identities are proofed and bound to credentials based on the context of the interaction. The DSI Cluster delegates identity proofing to the University of Chicago's central IT identity management system. A valid CNetID, issued by the University after institutional identity verification, is a prerequisite for cluster access. DSI Techstaff verifies PI affiliation and eligibility but does not independently proof user identity.

### 3. Authentication (PR.AA-03.01)

**Policy:** Users, services, and hardware are authenticated using mechanisms commensurate with the risk of unauthorized access. SSH public key authentication is required for all user access to the DSI Cluster. Password-only SSH authentication is disabled. Users must not share private keys or store them unprotected.

### 4. Identity Assertion Protection (PR.AA-04.01)

**Policy:** Identity assertions (e.g., credentials, tokens, keys) are protected from unauthorized disclosure, modification, or replay. SSH private keys must remain under the sole control of the user who generated them. DSI Techstaff stores only the public key component in the user's `authorized_keys` file. No centralized credential store of private keys exists.

### 5. Access Permissions and Least Privilege (PR.AA-05.01)

**Policy:** Access permissions, entitlements, and authorizations are defined and managed following the principles of least privilege and separation of duties. Users receive only the access required for their approved research activities. Specifically:

- Users do not receive root or sudo access.
- Docker is not available to users due to the elevated privileges it requires.
- SLURM partitions, QOS limits, and storage quotas enforce resource boundaries.
- Home directories are private to the individual user. Project directories are scoped to the PI's research group.
- Users cannot modify system configurations, scheduling policies, or other users' data.

### 6. Physical Access Management (PR.AA-06.01)

**Policy:** Physical access to organizational assets is managed, monitored, and enforced commensurate with risk. The DSI Cluster is housed in a secured server room within the University of Chicago Data Science Institute building. Physical access is restricted to authorized DSI Techstaff. Building access is controlled by UChicago campus card systems.

---

## Procedures

### Identity Management and Credential Provisioning

1. A prospective user emails [techstaff@cs.uchicago.edu](mailto:techstaff@cs.uchicago.edu) with their CNetID, access affiliation, and (if applicable) their PI on CC.
2. DSI Techstaff verifies eligibility against one of the approved criteria:
   - DSI-related grant holder
   - DSI member or affiliated faculty
   - Student with written PI approval
3. Upon approval, Techstaff creates a local cluster account mapped to the user's CNetID.
4. The user is assigned a home directory (`/home/<cnetid>`, 50 GB quota) and added to the appropriate SLURM account and partition.
5. If the user is part of a PI's group, they are added to the corresponding project directory group with appropriate permissions.

### Identity Proofing

1. Identity proofing is performed by UChicago central IT during CNetID issuance. This includes verification of university affiliation (employee, student, or sponsored affiliate).
2. DSI Techstaff validates the CNetID is active and confirms PI sponsorship when required.
3. No additional identity proofing is performed at the cluster level; the University's identity assurance level is accepted as sufficient for HPC workloads on this cluster.

### Authentication -- SSH Key Setup

1. Users generate an SSH key pair on their local machine (Ed25519 or RSA 4096-bit minimum recommended).
2. Users submit their public key to DSI Techstaff or add it to their `~/.ssh/authorized_keys` file after initial account creation.
3. Password-based SSH login is disabled at the server level.
4. Users are advised to protect private keys with a passphrase and appropriate file permissions (`chmod 600`).
5. SSH key rotation: Users should rotate SSH keys annually. DSI Techstaff may remove keys that have not been used in 12 months and require the user to submit a new key.

### Identity Assertion Protection

1. SSH authorized_keys files are owned by the user and writable only by the user (`chmod 600`).
2. DSI Techstaff does not store, access, or transmit private keys.
3. If a user suspects their private key has been compromised, they must notify DSI Techstaff immediately. Techstaff will remove the compromised public key and require a new key to be submitted.
4. Automated service credentials (e.g., for monitoring or backup) are managed by Techstaff using dedicated service accounts with restricted permissions.

### Access Permissions and Least Privilege

1. **Default user permissions:** Standard POSIX user account. No sudo access. No ability to install system-wide packages.
2. **Software installation:** Users install software in their own environment using tools like MiniConda or MicroMamba.
3. **SLURM resource limits:** All users are subject to default QOS limits (maximum 8 concurrent jobs, 12-hour job time limit). Changes to QOS require Techstaff review and cluster committee approval.
4. **Storage quotas:** Enforced per the [Storage Allocation Policy]({{ '/policies/general/#storage-allocation-policy' | relative_url }}):
   - Home: 50 GB (non-negotiable)
   - Project: 500 GB default, up to 10 TB on request
   - Scratch: 50 GB per scratch filesystem, expandable on request
5. **Container restrictions:** Docker is not available. Alternative container runtimes (Podman, Singularity) may be available but are not formally supported.
6. **Separation of duties:** DSI Techstaff manages system administration. The DSI cluster oversight faculty committee governs policy decisions. Users operate only within their assigned accounts and resource allocations.

### Physical Access Management

1. The DSI Cluster hardware is located in a secured server room within the UChicago Data Science Institute building.
2. Physical access to the server room is restricted to DSI Techstaff with authorized card access.
3. Building access is managed by UChicago Facilities and controlled by campus ID card readers.
4. Visitors to the server room must be escorted by authorized Techstaff.
5. Hardware additions, removals, or physical maintenance are performed only by DSI Techstaff.

### Periodic Access Reviews

1. DSI Techstaff conducts an access review at least annually.
2. During the review, Techstaff:
   - Identifies accounts that have not logged in within the past 12 months.
   - Verifies that each account holder still meets the eligibility criteria (active university affiliation, active PI sponsorship if applicable).
   - Removes or disables accounts that are no longer eligible.
3. PI departures trigger a review of all accounts sponsored by that PI. Affected users are notified and given a transition period to migrate data before account deactivation.
4. Results of the annual access review are documented and retained.

### Account Deprovisioning

1. When a user leaves the university or no longer meets eligibility criteria, their account is disabled.
2. Upon notification of departure (from the user, PI, or university records), Techstaff:
   - Disables the user's SSH login.
   - Preserves the user's home and project data for a minimum of 90 days to allow data retrieval by the PI.
   - After the retention period, removes the account and associated data.
3. In cases of policy violation or security incident, accounts may be suspended immediately by Techstaff.

---

## Control Mapping

| Control ID   | Control Name                        | How Addressed |
|:-------------|:------------------------------------|:--------------|
| PR.AA-01.01  | Identity & credential management    | CNetID-based accounts, no shared accounts, Techstaff-managed lifecycle |
| PR.AA-02.01  | Identity proofing                   | Delegated to UChicago central IT via CNetID issuance |
| PR.AA-03.01  | Authentication                      | SSH public key authentication required; password login disabled |
| PR.AA-04.01  | Identity assertion protection       | Private keys user-controlled; authorized_keys file permissions enforced |
| PR.AA-05.01  | Access permissions & least privilege| No root/sudo, no Docker, SLURM QOS limits, storage quotas, POSIX permissions |
| PR.AA-06.01  | Physical access management          | Secured server room, card-controlled building access, Techstaff-only physical access |

---

*Document Owner:* DSI Techstaff
*Last Reviewed:* 2026-04-06
*Review Cycle:* Annual
