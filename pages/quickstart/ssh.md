---
title: "Using the Cluster (ssh)"
layout: single
nav_order: 3
parent: Quickstart
category: quickstart
permalink: /quickstart/ssh/
classes: [wide, left-aligned]
hide_hero: True
toc: true
toc_sticky: true
---

# Connecting to the Cluster with SSH

Accessing the DSI cluster securely requires the use of **SSH keys**. This guide walks
through generating keys, configuring your SSH client, and authenticating to both the
cluster and GitHub.

You must have a DSI Cluster account before you can connect — see
[Getting Access]({{ "/quickstart/accounts/" | relative_url }}). You connect through the
load balancer at `login.ds.uchicago.edu`, which routes you to an available login node;
see [Login Nodes & the Load Balancer]({{ "/using-the-cluster/login-nodes/" | relative_url }}).

## Do I already have access?

If you're not sure whether you're set up, try these two checks:

```bash
ssh -T git@github.com                       # GitHub SSH auth
ssh <cnetid>@login.ds.uchicago.edu          # cluster login
```

- A GitHub greeting (`Hi <username>! You've successfully authenticated…`) means your
  GitHub SSH key is working.
- A shell prompt on a login node (`fe01`, `fe02`, or `fe03`) means your cluster access
  is working.

If either fails, continue below. Replace `<cnetid>` with your UChicago CNetID everywhere
in this guide.

## SSH background & prerequisites

SSH authenticates you with a **key pair**: a *private* key that never leaves your
machine and a *public* key you register with the cluster and with GitHub. You'll also
use an **ssh-agent** to hold your unlocked private key in memory so you aren't prompted
for its passphrase on every connection.

- **macOS / Linux:** OpenSSH and `ssh-agent` are built in.
- **Windows 10/11:** use the built-in OpenSSH client, or — recommended for a Unix-like
  workflow — [WSL2](https://learn.microsoft.com/en-us/windows/wsl/install).

## Set up SSH

### Step 1 — Verify your ssh-agent

**macOS / Linux** — check the agent is reachable, and start one if needed:

```bash
echo $SSH_AUTH_SOCK        # prints a path if an agent is running
eval $(ssh-agent)          # start one for the current shell if it isn't
```

**Windows (PowerShell, as Administrator)** — enable and start the OpenSSH agent:

```powershell
Get-Service ssh-agent | Set-Service -StartupType Automatic
Start-Service ssh-agent
Get-Service ssh-agent      # Status should be "Running"
```

### Step 2 — Create an SSH key

Generate a modern key (Ed25519 recommended):

```bash
ssh-keygen -t ed25519
```

If you need an alternative algorithm:

```bash
ssh-keygen -t ecdsa -b 521
```

Accept the default location (`~/.ssh/id_ed25519`) and set a passphrase when prompted.
See the [ssh-keygen reference](https://www.ssh.com/academy/ssh/keygen) for details.

### Step 3 — Add your key to the agent

```bash
ssh-add ~/.ssh/id_ed25519     # use your key's path
ssh-add -l                    # list keys the agent is holding
```

#### Windows + WSL2: share your keys into WSL

If you generated keys in Windows but work inside WSL2, copy them in and fix permissions
(SSH refuses keys that are too open). See this
[walkthrough](https://devblogs.microsoft.com/commandline/sharing-ssh-keys-between-windows-and-wsl-2/).

```bash
mkdir -p ~/.ssh
cp -r /mnt/c/Users/<your-windows-user>/.ssh/* ~/.ssh/
chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_ed25519
chmod 644 ~/.ssh/id_ed25519.pub
```

### Step 4 — Save your SSH configuration

A `~/.ssh/config` entry lets you type `ssh login.ds` instead of the full command, and
turns on agent forwarding (used for GitHub below).

Create/open the file:

```bash
touch ~/.ssh/config && open ~/.ssh/config     # macOS
code C:\Users\<your-windows-user>\.ssh\config # Windows (VS Code)
```

Add:

```sshconfig
Host login.ds
  HostName login.ds.uchicago.edu
  IdentityFile ~/.ssh/id_ed25519
  ForwardAgent yes
  User <cnetid>
```

Now `ssh login.ds` connects you through the load balancer.

> **Reaching compute nodes:** you do **not** SSH directly to compute nodes. Request one
> through Slurm with an [interactive session]({{ "/using-the-cluster/interactive-sessions/" | relative_url }})
> (`salloc` / `srun`), or submit a [batch job]({{ "/using-the-cluster/batch-jobs/" | relative_url }}).

> **Windows note:** if your connection fails during MAC negotiation (seen on some older
> Windows OpenSSH builds), add a line `MACs hmac-sha2-512` to the `Host login.ds` block.
> Most users don't need it.

### Step 5 — Authenticate

#### GitHub

1. Copy your **public** key:

   ```bash
   cat ~/.ssh/id_ed25519.pub                       # macOS / Linux
   type C:\Users\<your-windows-user>\.ssh\id_ed25519.pub   # Windows
   ```

2. Add it at [github.com/settings/keys](https://github.com/settings/keys) → **New SSH key**.
3. Test:

   ```bash
   ssh -T git@github.com
   ```

Because your `Host login.ds` block sets `ForwardAgent yes`, your local agent's keys are
available **on the login node** too — so you can `git clone`/`pull`/`push` over SSH from
the cluster without ever copying your private key there. After logging in, confirm with:

```bash
ssh -T git@github.com     # run this on a login node
```

#### The cluster

Install your public key on the cluster. The first connection authenticates with your
**CNet password**; afterward your key takes over.

**macOS / Linux:**

```bash
ssh-copy-id -i ~/.ssh/id_ed25519.pub <cnetid>@login.ds.uchicago.edu
```

**Windows** (no `ssh-copy-id`): log in with your password, then append your key by hand:

```bash
ssh <cnetid>@login.ds.uchicago.edu
# once on the login node:
mkdir -p ~/.ssh && chmod 700 ~/.ssh
echo "<paste-your-public-key-here>" >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
exit
```

## Verification

```bash
ssh login.ds                 # or: ssh <cnetid>@login.ds.uchicago.edu
```

You should land on a login node without being asked for your CNet password (your key is
now doing the work). From there:

```bash
ssh -T git@github.com        # succeeds via your forwarded agent
```

If you get stuck, email [techstaff@cs.uchicago.edu](mailto:techstaff@cs.uchicago.edu) —
mention this is about the **DSI** cluster, since there are several clusters on campus.
