---
title: "Account Creation & Permissions"
layout: single
nav_order: 2
parent: Quickstart
category: quickstart
permalink: /quickstart/accounts/
classes: [wide, left-aligned]
---

## Step 1: Requirements for Access

Users of the DSI cluster must meet one of the following criteria:

1.  Have a DSI-related grant.
2.  Be a member of the DSI or an affiliated faculty (with some exceptions).
3.  Be a student with written approval from a DSI faculty mentor.

If you are looking for compute resources and are more generally affiliated with the University, we recommend contacting [RCC](https://rcc.uchicago.edu/).

## Step 2: Requesting Access

To gain access to the DSI cluster, you must first submit an access request. Please follow these steps:

1.  Go to the [Cluster Access Request Form](https://example.com/access-request-form).
2.  Fill out all required fields, including your CNetID and the research group you'll be working with.
3.  You will be asked to provide your **public SSH key**. For instructions, see the [SSH Keys & VPN Access]({{ site.baseurl }}{% link pages/quickstart/ssh-vpn.md %}) page.
4.  Submit the form. You will receive an email confirmation once your request is processed.

<div class="notice--info" markdown="1">
**Note:** Access requests are typically reviewed within 2-3 business days. Please plan accordingly and submit your request well in advance of when you need cluster access.
</div>

## Step 3: Account Confirmation and Password

Once your access request is approved, you'll receive an email with instructions. While you will use your SSH key to log in, your account also has a password that is used for certain services (like `sudo` if you have permission).

To set or change your password, log in to the cluster and use the `passwd` command:
```bash
passwd
```
Follow the prompts to set a strong, unique password.

## Step 4: Understanding Permissions

Access to specific directories, software, or resources on the cluster is managed through permissions.

### Group Permissions
If you are part of a research group, you will be added to a Unix group that grants access to shared resources, such as a project directory in `/project`. Contact your group lead or the system administrators to be added to the appropriate group.

### Requesting Elevated Permissions
In rare cases, you may need elevated permissions (e.g., `sudo` access) for specific tasks. To request them:

1.  Prepare a detailed justification explaining why elevated permissions are necessary.
2.  Submit your request to the system administrators via email at `cluster-support@example.com`.
3.  Include your CNetID, the specific permissions needed, and a clear description of the tasks.

<div class="notice--info" markdown="1">
**Note:** Elevated permissions are granted on a case-by-case basis and require a strong justification.
</div>

## Managing User Roles

User roles define the level of access and permissions granted to a cluster user. The primary roles are:

-   **User:** Standard access for running jobs and accessing resources within their group.
-   **Group Lead:** Additional permissions to manage group resources and user access within the group.
-   **Administrator:** Full access to all cluster resources and configurations.

Contact your group lead or the system administrators if you need to change your user role or manage roles within your group.