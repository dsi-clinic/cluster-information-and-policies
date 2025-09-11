---
title: "Transferring Data with rsync and scp"
layout: single
nav_order: 2
parent: Advanced Topics
category: advanced-topics
permalink: /advanced-topics/rsync-scp/
classes: [wide, left-aligned]
hide_hero: True
---
# Transferring Data with rsync and scp

Securely transferring data to and from the cluster is a fundamental task for any user. The two most common command-line tools for this are `scp` (Secure Copy) and `rsync` (Remote Sync). This guide provides an overview of both tools with practical examples.

## Choosing Between `scp` and `rsync`

*   **`scp`** is simple and effective for transferring single files or small directories. It copies files over an encrypted SSH connection.
*   **`rsync`** is more powerful and efficient, especially for large files, large numbers of files, or repeated transfers. It intelligently transfers only the differences between the source and destination, which can save significant time and bandwidth. For most data transfer tasks, **`rsync` is the recommended tool.**

## Using `scp` (Secure Copy)

`scp` works very much like the standard `cp` command, but it can copy files between different hosts on a network.

### `scp` Syntax

The basic syntax is:
`scp [options] <source> <destination>`

The source and destination can be local or remote paths. A remote path is specified as `user@host:/path/to/file`.

### `scp` Examples

**1. Transfer a file from your local machine to the cluster's home directory:**

```bash
scp /path/to/local/file.txt your_cnetid@fe01.ds.uchicago.edu:~/
```

Transfer a file from the cluster to your local machine:

```bash
scp your_cnetid@fe01.ds.uchicago.edu:/path/to/remote/file.txt /path/to/local/directory/
```

#### Using `rsync` (Recommended for large or repeated transfers)

Transfer a directory from your local machine to the cluster:

```bash
rsync -avz /path/to/local/directory/ your_cnetid@fe01.ds.uchicago.eduu:/path/to/remote/directory/
```

Transfer a directory from the cluster to your local machine:

```bash
rsync -avz your_cnetid@fe01.ds.uchicago.edu:/path/to/remote/directory/ /path/to/local/directory/
```

You can also use the --progress flag to monitor file transfer status:

```bash
rsync -avz --progress /path/to/local/ your_cnetid@fe01.ds.uchicago.edu:/remote/path/
```
