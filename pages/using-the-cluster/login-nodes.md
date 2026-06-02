---
title: "Login Nodes & the Load Balancer"
layout: single
nav_order: 1
parent: Using the Cluster
category: using-the-cluster
permalink: /using-the-cluster/login-nodes/
classes: [wide, left-aligned]
hide_hero: True
---
# Login Nodes & the Load Balancer

**Coming Monday, June 8, 2026.** This page describes changes that take effect on that date. Until then, you can continue connecting the way you do today.
{: .notice--warning}

Starting **June 8, 2026**, we are making two changes to the login (frontend) nodes to improve stability and quality of life:

1. **A load balancer** sits in front of the login nodes. You will connect to a single hostname, `login.ds.uchicago.edu`, and be routed automatically to the least-loaded node. Direct SSH to the individual nodes (`fe01`, `fe02`, `fe03`) will be retired.
2. **Per-user resource limits** on the login nodes: **1 CPU**, **8&nbsp;GB RAM**, and a **12-hour** wall-time limit per process.

These changes address the "noisy neighbor" problem, where heavy activity by one user destabilizes the login node for everyone else. The login nodes are passthroughs for *reaching and submitting work* to the compute nodes — not for running computation themselves.

## Connecting through the load balancer

Today, you may have to log in and out of individual nodes by hand to find one that isn't saturated. The load balancer does this for you: it directs each connection to the login node with the most available resources.

After June 8, connect to:

```bash
ssh <cnetid>@login.ds.uchicago.edu
```

Direct connections to `fe01.ds.uchicago.edu`, `fe02.ds.uchicago.edu`, and `fe03.ds.uchicago.edu` will no longer be available.

## Action required: update your SSH config

If you have a `Host` entry in your `~/.ssh/config` that points at an individual login node, update its `HostName` to `login.ds.uchicago.edu`. Most users have something like this:

```sshconfig
# Before
Host fe.ds
  HostName fe01.ds.uchicago.edu
  IdentityFile ~/.ssh/id_ecdsa
  ForwardAgent yes
  User <cnetid>
```

Change it to:

```sshconfig
# After
Host login.ds
  HostName login.ds.uchicago.edu
  IdentityFile ~/.ssh/id_ecdsa
  ForwardAgent yes
  User <cnetid>
```

The only line that *must* change is `HostName`. The `Host` line is just a local nickname you type after `ssh` (e.g. `ssh login.ds`) — you can keep it as `fe.ds` or rename it to whatever you like. Replace `<cnetid>` with your CNetID and `IdentityFile` with the path to your key.

New to SSH config? See [Using the Cluster (ssh)]({{ "/quickstart/ssh/" | relative_url }}).

## Staying on the same node (tmux / screen)

If you run long-lived sessions in `tmux` or `screen`, you need to land on the same node every time so you can reattach. The load balancer is configured for this: **once it places you on a node, it keeps routing you back to that same node**, so your `tmux` and `screen` sessions are there when you reconnect. Your initial placement still accounts for congestion, so you start on a node with capacity.

This mapping lasts **one week from your last connection**. If you don't connect for more than a week, the mapping expires and your next login may be placed on a different node — so reattach to anything you want to keep within that window.

## Login node resource limits

After June 8, each user is limited on a login node to:

| Resource | Limit |
| --- | --- |
| CPU | 1 core |
| Memory | 8&nbsp;GB RAM |
| Process wall time | 12 hours |

The 12-hour limit applies to processes, not to your `tmux` or `screen` session itself — the multiplexer keeps running so you can reconnect to it. Anything you actually run, including processes you launch *inside* `tmux`, is subject to the 12-hour limit.

This is sufficient for what the login nodes are meant for:

* **Fine on the login nodes:** file operations and transfers, light file editing, and requesting, submitting, and monitoring jobs.
* **Not appropriate on the login nodes:** computationally intensive work, IDE remote/backend servers that scan or index all of shared storage, code agents (such as Claude or Codex) that spawn many processes, and any long-running process. These belong on the compute nodes. See also the [login node usage policy]({{ "/policies/general/#login-node-usage-and-limits" | relative_url }}).

## What to do instead: move work to the compute nodes

These limits do not stop you from running heavy or agentic workflows — you just run them on the compute nodes rather than on a login node:

* **Long or compute-intensive work** → submit a [batch job]({{ "/using-the-cluster/batch-jobs/" | relative_url }}).
* **Interactive development, notebooks, or running a code agent** → start an [interactive session]({{ "/using-the-cluster/interactive-sessions/" | relative_url }}) on a compute node.
* **Moving data** → `scp`/`rsync` through the same hostname; see [Transferring Data with rsync and scp]({{ "/advanced-topics/rsync-scp/" | relative_url }}).

## If a login node is full

Based on historical peak usage, the resource limits should leave plenty of headroom to log in. In the rare case that every login node is saturated, you'll receive a message at login asking you to try again shortly. We don't expect this to happen with any regularity.

## Questions

If you hit a workflow these changes disrupt, [reach out]({{ "/contact/" | relative_url }}) — we'd rather hear about it than have you blocked.
