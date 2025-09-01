---
title: Cluster Storage Space
layout: single
permalink: /resources/cluster-storage/
excerpt: "Information about the DSI cluster storage and best practices"
header:
  overlay_color: "#800000"
  overlay_filter: "0.5"
toc: true
toc_sticky: true
toc_label: "Contents"
---

This page contains information on the cluster storage backend and how to best use it. There is an FAQ at the bottom of this page for additional information.

To see your current usage across any of the storage entities, refer to the [`dsiquota` tool]({% link _tools/dsiquota.md %}).

# Backend description

The current cluster backend can be thought of as 3 distinct entities: Home, Project, and Scratch folders.

The current file system uses NFS/ZFS which has some blocking elements that affect sharing performance. Files that are frequently accessed by multiple users will experience lower read performance.


## Home folders:
  - Limited to 50GB
  - Mirrored across all of the login nodes
  - Can be found at `/home/[cnet-id]`
  - Personal R/W permissions
  - Accessed by all login nodes
  - Cannot be shared  
  - Backups will be implemented in the near future
  - Not considered "archival" storage 

## Project folders:
  - Found at `/project/[some-name]`
  - Group RW permissions
  - Can contain very large amounts of data (many TBs)
  - Is purchased storage so quotas depend on the buyer
  - Folder quota can be viewed with [`dsiquota`]({% link _tools/dsiquota.md %})
  - Project folders are not currently backed up and will not be
  - Accessed from all login/compute nodes

## Scratch folders:  
  - High speed local disk found at `/scratch`
  - Can contain very large amounts of data (many TBs)
  - **Purged frequently** (less than 30 days). 
    - Do not use as long term storage
  - Accessed from all login/compute nodes
  - **IS NOT BACKED UP**
  
**Note:** The scratch folders have a 30 day purge policy, which means that files that have not been accessed (regardless of creation or modification time) in the last 30 days will be automatically deleted. If you are not done with the work for more than 30 days make sure to access files more often or move them to project storage.

It should be noted that the various storage entities all support SLURM job scheduling where `/scratch` provides the highest performance and `/project` the most capacity.

# Frequently Asked Questions

### What happens if I exceed my home or project quotas?

If you exceed the soft quotas (typically set a little below the hard quota) you will receive warning messages when you log in. If you exceed your hard quotas, writes will fail and you will not be able to create any new files until you reduce your usage.

### Is there a way to get more storage?

Home storage capacity is fixed and cannot be expanded. If you need additional storage you should request a project folder or increase your existing project folder allocation.

### What happens to my data if I lose access to the cluster?

Your data will remain on the cluster for 180 days after your access expires. After that period, it will be permanently deleted. You are responsible for backing up any important data before your access expires.

### How is storage usage calculated?

Storage usage is calculated by examining the total disk space occupied by your files, including any filesystem overhead. This is why the space reported by `ls -lh` might differ slightly from what you see with [`dsiquota`]({% link _tools/dsiquota.md %}).

### Can I share my project folder with collaborators at other institutions?

Yes, project folders can be shared with external collaborators, but this requires coordination with the system administrators. Contact support to discuss your collaboration needs.

### What types of backups are available?

Currently, only home folders are planned for backup implementation. Project and scratch storage are not backed up, so you are responsible for maintaining copies of important data stored in these locations.

### What is the best practice for organizing data?

We recommend:

1. **Use home folders** for configuration files, small scripts, and personal documentation
2. **Use project folders** for active datasets, analysis results, and long-term storage of important data  
3. **Use scratch space** only for temporary files, intermediate processing steps, and high-performance I/O operations
4. **Regular cleanup**: Periodically review and clean up your storage usage to maintain good performance for all users