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

To gain access to the DSI cluster, you must email the tech staff team directly. Please follow these steps:

1. Send an email to **[techstaff@cs.uchicago.edu](mailto:techstaff@cs.uchicago.edu)**.  
2. In your email, include:  
   - Your **CNetID**  
   - A brief description of your **access affiliation**  
   - If you are working under a PI, **CC your PI** on the email   
3. The tech staff will review your request and contact you once your account has been created.  


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