---
title: "Shared Storage Overview"
layout: single
nav_order: 2
parent: Using the Cluster
category: using-the-cluster
permalink: /using-the-cluster/storage-overview/
classes: [wide, left-aligned]
hide_hero: True
---

# Shared Storage Overview

The cluster provides several types of shared storage, each designed for a specific purpose. Understanding the differences between these storage tiers is crucial for managing your data effectively and ensuring the smooth operation of your research workflows.

## Storage Tiers

There are three main storage tiers available to users on the cluster:

1.  **Home Directories (`/home`)**
2.  **Project Directories (`/project`)**
3.  **Scratch Space (`/scratch`)**

### Home Directories (`/home`)

Your home directory is your personal space on the cluster. It is located at `/home/your_cnetid`.

*   **Purpose**: Intended for storing personal configuration files (e.g., `.bashrc`, `.vimrc`), small scripts, and source code.
*   **Quotas**: Home directories have a relatively small storage quota. They are not designed for large datasets or computational output.
*   **Backups**: This storage is backed up regularly.
*   **Performance**: Not optimized for high-performance I/O required by parallel jobs. **You should not run jobs from your home directory.**

### Project Directories (`/project`)

Project directories are the primary location for shared research data.

*   **Purpose**: Designed for storing datasets, software installations, and results that need to be shared among members of a research group. This is the main workspace for your research data.
*   **Quotas**: Project spaces have much larger quotas than home directories, suitable for large-scale data.
*   **Backups**: This storage is also backed up regularly, ensuring your important research data is protected.
*   **Performance**: Offers good performance for a wide range of computational tasks.

### Scratch Space (`/scratch`)

The scratch filesystem is a large, high-performance storage space for temporary data.

*   **Purpose**: Intended for temporary files generated during job execution (e.g., intermediate results, large temporary datasets). It provides the best I/O performance, making it ideal for data-intensive computations.
*   **Quotas**: Scratch space is very large, but it is a shared resource for all users.
*   **Backups**: **Files on `/scratch` are NOT backed up.** You are responsible for moving any important data from `/scratch` to your `/project` directory.
*   **Purge Policy**: To ensure space is available for active jobs, files on `/scratch` are subject to a strict purge policy. Files that have not been accessed for a certain period (e.g., 30 days) will be automatically deleted.

## Summary of Storage Tiers

| Tier | Path | Purpose | Backups | Purge Policy |
| :--- | :--- | :--- | :--- | :--- |
| **Home** | `/home/<cnetid>` | Personal files, configs, source code | Yes | No |
| **Project** | `/project/<group>` | Shared research data, results | Yes | No |
| **Scratch** | `/scratch/` | Temporary files for active jobs | **No** | Yes (e.g., after 30 days of inactivity) |

## Best Practices for Storage Usage

1.  **Store Code in Home**: Keep your source code, scripts, and configuration files in your `/home` directory.
2.  **Keep Data in Project**: Store your primary datasets, important results, and shared files in your `/project` directory.
3.  **Use Scratch for Jobs**: When running jobs, write temporary and intermediate files to a directory you create within `/scratch`. Copy your final, important results back to your `/project` space upon job completion.
4.  **Check Your Usage**: Regularly monitor your disk space usage to avoid hitting your quotas. You can check your usage by following the instructions on the Checking Your Usage page.
5.  **Clean Up Regularly**: Be a good cluster citizen by regularly deleting files you no longer need, especially from the shared `/scratch` space.

By following these guidelines, you can make the most of the cluster's storage resources and contribute to a stable and efficient computing environment for everyone.