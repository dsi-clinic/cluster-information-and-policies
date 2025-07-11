---
title: "SSH Keys & VPN Access"
layout: single
nav_order: 3
parent: Quickstart
category: quickstart
permalink: /quickstart/ssh-vpn/
classes: [wide, left-aligned]
---

Secure Shell (SSH) keys are an access credential used for authenticating to the DSI compute cluster. They are more secure than traditional passwords and are the required method for logging in.

An SSH key pair consists of two parts:
- **Public Key**: This key is shared and placed on the servers you want to access. It acts like a lock.
- **Private Key**: This key is kept secret and secure on your local computer. It acts as the unique key to the lock.

You will generate a key pair on your own machine and provide the DSI team with your public key.

## Generating SSH Keys

The recommended SSH key algorithm is `Ed25519`. The following instructions will guide you through generating an Ed25519 key on your operating system.

### macOS & Linux

Open your terminal and run the following command. Replace `"your_cnetid@uchicago.edu"` with your own CNetID email address.

```bash
ssh-keygen -t ed25519 -C "your_cnetid@uchicago.edu"
```

You will be prompted for a few things:
1.  **Enter file in which to save the key**: Press **Enter** to accept the default location (`~/.ssh/id_ed25519`).
2.  **Enter passphrase (empty for no passphrase)**: Type a strong, memorable passphrase and press **Enter**. You will be asked to enter it again to confirm.

<div class="notice--info" markdown="1">
**Why use a passphrase?**

A passphrase adds an extra layer of security. If your private key is ever compromised, the attacker will still need the passphrase to use it. We strongly recommend using one.
</div>

### Windows 10 & 11

Modern versions of Windows include the OpenSSH client, which you can use in either PowerShell or the Command Prompt.

Open PowerShell and run the same command as for macOS/Linux:

```bash
ssh-keygen -t ed25519 -C "your_cnetid@uchicago.edu"
```

Follow the same prompts as above, accepting the default file location and setting a secure passphrase. The default location on Windows is typically `C:\Users\YourUsername\.ssh\id_ed25519`.

## Uploading Your Public Key

After generating your keys, you need to provide us with your **public key**.

<div class="notice--warning" markdown="1">
**Never share your private key!**

Your private key (`id_ed25519`) should never leave your machine. Only the public key (`id_ed25519.pub`) is safe to share.
</div>

1.  Display your public key by running the appropriate command for your system.

    **macOS / Linux:**
    ```bash
    cat ~/.ssh/id_ed25519.pub
    ```

    **Windows (PowerShell):**
    ```powershell
    Get-Content $env:USERPROFILE\.ssh\id_ed25519.pub
    ```

2.  Copy the entire output. It should be a single line of text starting with `ssh-ed25519` and ending with the email address you provided.

3.  Paste this public key into the appropriate field during your account setup process or email it to the cluster support team as instructed.

## VPN Access

To connect to the DSI cluster from an off-campus network, you **must** first be connected to the University of Chicago's VPN service (cVPN). The VPN encrypts your traffic and places you on the campus network, which is a security requirement for cluster access.

- **If you are on campus** and connected to the `uchicago-secure` Wi-Fi network, you do not need to use the VPN.
- **If you are off campus**, you must connect to the VPN first.

For instructions on how to download and configure the Cisco AnyConnect VPN client, please visit the IT Services cVPN Page.

## Troubleshooting

If you have trouble connecting via SSH, here are some common issues and solutions.

### Error: `Permission denied (publickey)`

This is the most common error and can have several causes:

1.  **You are not connected to the VPN**: If you are off-campus, ensure your cVPN client is connected and running.
2.  **Your public key is not correctly installed on the cluster**: Double-check that you have sent the correct public key and that it has been successfully added to your account.
3.  **Incorrect file permissions on your local machine**: SSH is very particular about file permissions to ensure your keys are secure. Your `.ssh` directory should be `700` and your private key file should be `600`.

    Run these commands on macOS or Linux to fix permissions:
    ```bash
    chmod 700 ~/.ssh
    chmod 600 ~/.ssh/id_ed25519
    ```

4.  **Your SSH client is offering the wrong key**: If you have multiple SSH keys, your client might be presenting the wrong one. You can force it to use the correct key with the `-i` flag:

    ```bash
    ssh -i ~/.ssh/id_ed25519 your_cnetid@cluster.dsi.uchicago.edu
    ```

    To make this permanent, you can create or edit a `config` file in your `.ssh` directory (`~/.ssh/config`) and add an entry for the cluster:

    ```
    Host dsi-cluster
        HostName cluster.dsi.uchicago.edu
        User your_cnetid
        IdentityFile ~/.ssh/id_ed25519
    ```
    With this configuration, you can simply connect by typing `ssh dsi-cluster`.

If you continue to experience issues, please contact the DSI support team for assistance.