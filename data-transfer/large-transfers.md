---
layout: single
title: "Best Practices for Large Data Transfers"
permalink: /advanced-topics/large-transfers/
excerpt: "Recommendations and tools for efficiently transferring large datasets to and from the cluster, including Globus and rsync."
---

Transferring large amounts of data—many gigabytes (GB) or terabytes (TB)—or a very large number of small files requires special consideration. Using the right tools and techniques will ensure your transfer is fast, reliable, and does not negatively impact the cluster's performance for other users.

## Use the Data Transfer Node (DTN)

The cluster has nodes specifically designated for data transfers, known as Data Transfer Nodes (DTNs). You should **always** perform large data transfers on a DTN, not on the main login nodes.

*   **Why?** Login nodes are a shared resource for compiling code, submitting jobs, and other lightweight interactive tasks. Large data transfers are network-intensive and can saturate the network connection of a login node, slowing it down for everyone. DTNs have faster network connections and are optimized for this purpose.
*   **How?** Connect to the DTN using its specific address, which is different from the main cluster login address.

    ```bash
    ssh your_cnetid@dtn.dsi.uchicago.edu
    ```

## Globus (Recommended for >100 GB)

For very large or critical data transfers, **Globus is the recommended method**.

Globus is a high-performance "fire-and-forget" data transfer service. You start a transfer through a web browser, and Globus manages the entire process in the background.

### Key Advantages of Globus:

*   **Reliability**: Automatically retries failed transfers and recovers from network interruptions.
*   **Performance**: Uses multiple parallel streams to achieve maximum throughput.
*   **Integrity**: Performs checksums to verify that your data arrived without corruption.
*   **Convenience**: Runs in the background. You can close your laptop, and the transfer will continue. Globus will email you upon completion.

### Getting Started with Globus:

1.  **Log In**: Go to [globus.org](https://www.globus.org) and log in by selecting "University of Chicago" from the organizational login list.
2.  **Set Up Endpoints**: A transfer occurs between two "endpoints."
    *   **Cluster Endpoint**: Search for the DSI Cluster's public endpoint (e.g., `DSI Cluster`).
    *   **Personal Endpoint**: To transfer files to/from your personal computer, you need to install **Globus Connect Personal**. This free application turns your machine into a Globus endpoint.
3.  **Start Transfer**: In the Globus web interface, open the two-panel view. Select the source endpoint and directory on one side, and the destination endpoint and directory on the other. Click "Start" to begin the transfer.

## Using `rsync` with `tmux` or `screen`

For transfers that are large but don't warrant using Globus, or for scripted transfers, `rsync` is an excellent tool. However, a long-running `rsync` process can be interrupted if your SSH connection drops. To prevent this, you should run it inside a terminal multiplexer like `tmux` or `screen`.

These tools create persistent terminal sessions on the server that continue to run even after you disconnect.

### `tmux` Workflow:

1.  **SSH into the DTN**:
    `ssh your_cnetid@dtn.dsi.uchicago.edu`

2.  **Start a new `tmux` session**: Give it a descriptive name.
    `tmux new -s my-transfer`

3.  **Run your `rsync` command**: Start the data transfer from within the `tmux` session.
    ```bash
    # Example: Pushing data from your local machine to the cluster's project space
    # This command is run from your local machine's terminal.
    rsync -av --progress /local/path/to/data/ your_cnetid@dtn.dsi.uchicago.edu:/project/cool-lab/data/
    ```
    *Note: The `-z` flag for compression is often omitted for large transfers, as it can be a bottleneck if the data is already compressed (e.g., images, videos, .gz files).*

4.  **Detach from the session**: Press `Ctrl+b`, then `d`. The session and your `rsync` process will continue running on the DTN. You can safely log out.

5.  **Re-attach later**: To check the progress, SSH back into the DTN and re-attach to your session.
    `tmux attach -t my-transfer`

## Summary of Recommendations

| Method | Best For | Pros | Cons |
| :--- | :--- | :--- | :--- |
| **Globus** | Very large files/datasets (>100GB), unreliable networks | Most reliable, "fire-and-forget", auto-retry, checksums | Requires one-time setup of Globus Connect |
| **`rsync` + `tmux`** | Large directories, scripted transfers, repeated syncs | Efficient (transfers diffs), scriptable, good control | Requires manual use of `tmux`/`screen` for reliability |
| **`scp`** | Single files, small directories | Simple, universally available | Inefficient for large/many files, no resume feature |
