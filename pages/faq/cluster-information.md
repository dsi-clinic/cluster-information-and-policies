---
title: "Current Cluster Information"
layout: single
permalink: /faq/cluster-information/
parent: Troubleshooting & FAQ
nav_order: 2
classes: [wide, left-aligned]
---

# Current Cluster Information

As of September 2025, the following table summarizes the DSI cluster resources. Some resources are reserved for specific initiatives or grants.

## Total Cluster Resources

| Resource Type   | Number of Units |
|:----------------|----------------:|
| Number of Nodes | 29              |
| Total Cores     | 2,720            |
| Total Storage   | 1.5 PB          |
| GPUs            | 32 NVIDIA A40 48GB  <br/> 60  NVIDIA A100 80GB <br/> 12 NVIDIA L40S 48GB  <br/> 16 NVIDIA H100 80GB  <br/> 20 NVIDIA H200 140GB <br/> Total: 140  |



## Cluster Networking and Topology

The cluster is organized into a series of nodes and storage servers. Storage servers have a mix of different drives and types. 

<!-- Nodes are broken into series (denoted by their name):
- The `g` series has a 200GB SSD locally
- The `h` series has a 200GB SSD locally
- The `j` series has a 400GB SSD locally
- The `k` series has a 1TB SSD locally
- The `i` series has 400GB SSD locally
- The `m` series has 500GB SSD locally
- The `n` series has a 10TB SSD locally -->

Note that not all nodes are available on all SLURM partitions and queues. 

The cluster has a 1Gb/s line to the internet (with a potential upgrade date of July 2026).

The network between nodes and storage servers runs at 10 Gbps.

## Space Availability and Server Room

The server room is power-constrained. While each rack can hold 8 nodes physically, power typically supports 4 nodes per rack. With 8 open racks, we anticipate capacity for approximately 24 additional nodes (24 + 29 = 53 total), hardware-dependent.


