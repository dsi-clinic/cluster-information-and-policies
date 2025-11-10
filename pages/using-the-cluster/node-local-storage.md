---
title: "Node-local Storage (`local` GRES)"
layout: single
nav_order: 3
parent: Using the Cluster
category: using-the-cluster
permalink: /using-the-cluster/node-local-storage/
classes: [wide, left-aligned]
hide_hero: True
---

# Node-local Storage (`local` GRES)

Some GPU and CPU nodes ship with fast NVMe or SSD devices that live physically on the node. We expose those disks through the `local` Generic Resource (GRES) so you can stage data close to the cores or accelerators that need it. Local storage is far faster than the shared `/net` filesystems, but it is also ephemeral—anything left behind is wiped as soon as the job releases the resource.

## Typical Workflow

1. **Stage inputs:** Copy the input dataset from `/net` (home, project, or scratch) into the path Slurm creates for you under `/local/scratch/<CNetID>_<JOBID>/`.
2. **Run locally:** Point your application at the node-local path to take advantage of high I/O throughput.
3. **Save results back to `/net`:** Before the job exits, copy every file you want to keep back to a durable filesystem.

> **Warning:** `/local/scratch` is automatically deleted when the job completes or the node is reallocated. There are no backups or grace periods.

## Requesting the `local` GRES

Request local space just like you request GPUs:

```bash
srun -p general --gres=local:200G --pty bash
```

* `local:SIZE` is the amount of disk you want in gigabytes. Slurm will place your job on a node that advertises at least that capacity.
* The scheduler creates a per-job directory, e.g. `/local/scratch/yourcnet_12345678/`, owned by you for the lifetime of the job.

You can inspect available capacity on a node with `scontrol show node`. The `Gres=` line now lists the local disk size alongside GPUs:

```text
NodeName=o001 Arch=x86_64 CoresPerSocket=64
   ...
   Gres=gpu:h200:4,local:disk:1500G
   ...
```

## Working Inside `/local/scratch`

Once the job starts you can check the path Slurm created and confirm free space:

```bash
$ ls /local/scratch
yourcnet_12345678

$ df -h /local/scratch/yourcnet_12345678
Filesystem      Size  Used Avail Use% Mounted on
/dev/nvme0n1p1  1.5T  8.0G  1.4T   1% /local/scratch/yourcnet_12345678
```

Use plain `cp`, `rsync`, or `tar` to move data in and out just as you would on `/scratch`.

## Node-local Capacity Reference

Local disks vary by node family. Recent `submitit` inventory for the `general` partition shows:

| Local Size | Nodes |
| --- | --- |
| 200G | `g002`, `g003`, `g004`, `g005`, `g006`, `g007` ... |
| 300G | `m001`, `m002` |
| 400G | `i001-ds` |
| 440G | `j001-ds`, `j002-ds`, `j003-ds`, `j004-ds`, `j005-ds` |
| 800G | `p001`, `p002`, `p003` |
| 1500G | `k001`, `k002`, `k003`, `l001`, `o001`, `q001` |
| 9500G | `n001` |

Always match the requested `local:` size to the smallest footprint you truly need so other jobs can still land on the node. For long-running workflows, consider wrapping your job script with pre/post copy steps to enforce the copy-in/copy-out pattern every time.

## See also

- [Shared Storage Overview]({{ '/using-the-cluster/storage-overview/' | relative_url }})
- [Checking Your Usage]({{ '/using-the-cluster/checking-usage/' | relative_url }})
