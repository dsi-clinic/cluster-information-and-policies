---
title: "Best Practices for Large Transfers"
layout: single
nav_order: 2
parent: Advanced Topics
category: advanced-topics
permalink: /advanced-topics/large-transfers/
classes: [wide, left-aligned]
hide_hero: True
---

# Best Practices for Large Transfers


Transferring large datasets, especially those in the multi-terabyte range, presents unique challenges. A simple `scp` or `rsync` command might be slow, unreliable over long distances, and can fail midway through, forcing you to start over. This guide outlines best practices and recommended tools for efficiently and reliably moving large amounts of data to and from the cluster.

## Key Principles for Large Transfers

When dealing with large data transfers, keep these principles in mind:

*   **Use the Right Tool:** Standard tools like `scp` are not designed for high-performance, large-scale transfers. Use tools built for this purpose.
*   **Use Dedicated Transfer Nodes (DTNs):** DTNs are servers specifically configured and optimized for wide-area data transfers. They have faster network connections and are tuned for high-throughput.
*   **Parallelism is Key:** To maximize bandwidth, transfers should be broken into multiple parallel streams.
*   **Verify Integrity:** Always verify that your data has arrived intact and uncorrupted using checksums.

## Recommended Tool: Globus

For most large data transfer needs, **Globus is the strongly recommended solution.** It is a robust, high-performance, and reliable data management service used by research institutions worldwide.

### Why Use Globus?

*   **"Fire-and-Forget" Transfers:** Once you start a transfer, Globus manages the entire process. It will monitor the transfer, retry any failed files, and notify you upon completion. You can close your laptop, and the transfer will continue.
*   **High Performance:** Globus automatically optimizes transfer settings, including using multiple parallel TCP streams to saturate high-bandwidth network links.
*   **Data Integrity:** Globus performs checksum verification on every file to ensure data integrity.
*   **Ease of Use:** It provides a user-friendly web interface to manage transfers between different systems (called "endpoints").
*   **Sharing:** You can easily share data with collaborators at other institutions via Globus.

### Getting Started with Globus

1.  **Log in:** Go to globus.org and log in using your university credentials.
2.  **Find Endpoints:** Use the "File Manager" tab. You will need to specify two endpoints: the source and the destination. Our cluster's Globus endpoint is `[Name of Your Cluster's Globus Endpoint]`. You may also need to install Globus Connect Personal on your local machine to make it an endpoint.
3.  **Start the Transfer:** Browse to your source directory on one endpoint and your destination directory on the other. Select the files/folders you want to move and click the "Start" button.

For detailed instructions, please refer to the official Globus documentation.

## Optimizing `rsync`

While Globus is preferred, `rsync` can still be a viable tool, especially for transfers within the same local network or when Globus is not available. For large transfers, a basic `rsync` command is often insufficient.

### `rsync` Flags for Large Transfers

A good starting point for a robust `rsync` command is:

```bash
rsync -avhP --checksum /path/to/source/ user@remote-host:/path/to/destination/
```

*   `-a` (archive): A meta-flag that preserves permissions, ownership, timestamps, etc. It's equivalent to `-rlptgoD`.
*   `-v` (verbose): Shows you what's happening.
*   `-h` (human-readable): Displays sizes in a friendly format (e.g., MB, GB).
*   `-P`: Combines `--progress` (shows transfer progress per file) and `--partial` (keeps partially transferred files, allowing you to resume).
*   `--checksum` or `-c`: Forces `rsync` to perform a checksum on every file. This is more CPU-intensive but ensures data integrity, which is crucial for large transfers. By default, `rsync` only checks for differences in file size or modification time.

### Parallel `rsync`

A single `rsync` process may not be able to fully utilize a high-speed network connection. You can achieve parallelism by running multiple `rsync` processes simultaneously on different subsets of your data.

There are third-party wrapper scripts like `parallel-rsync` or you can write a simple shell script to achieve this. For example, to transfer multiple subdirectories in parallel:

```bash
#!/bin/bash
SOURCE_DIR="/path/to/large_dataset/"
DEST_DIR="user@remote-host:/path/to/destination/"

# Ensure the top-level destination directory exists
ssh user@remote-host "mkdir -p $DEST_DIR"

# Find all subdirectories in the source and transfer them in parallel
find "$SOURCE_DIR" -mindepth 1 -maxdepth 1 -type d | xargs -I {} -P 4 rsync -avhP --checksum {} "$DEST_DIR"
```
This script uses `xargs -P 4` to run up to 4 `rsync` jobs in parallel. Adjust the `-P` value based on your system's capabilities and network bandwidth.

## Data Integrity and Checksumming

For scientific data, ensuring bit-for-bit correctness is non-negotiable.

1.  **Generate Checksums at the Source:** Before transferring, generate a list of checksums for your files.

    ```bash
    # On the source machine, inside your data directory
    find . -type f -print0 | xargs -0 sha256sum > checksums.sha256
    ```
    This command creates a file `checksums.sha256` containing the SHA256 hash for every file in the directory.

2.  **Transfer the Data and the Checksum File:** Use Globus or `rsync` to transfer your data *and* the `checksums.sha256` file.

3.  **Verify Checksums at the Destination:** After the transfer is complete, run the checksum tool in verification mode.

    ```bash
    # On the destination machine, inside the transferred data directory
    sha256sum -c checksums.sha256
    ```
    This will read the `checksums.sha256` file and verify each file against its recorded hash. It will report `OK` for each matching file and print errors for any mismatches or missing files.

Using a robust transfer tool like Globus (which does this automatically) or manually verifying with `rsync` and checksums is critical for ensuring your large data transfers are successful and your data remains uncorrupted.