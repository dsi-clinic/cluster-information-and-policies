---
title: "Change CUDA Version"
layout: single
nav_order: 2
parent: Advanced Topics
category: advanced-topics
permalink: /advanced-topics/change-cuda-version/
classes: [wide, left-aligned]
hide_hero: True
---

# Change CUDA Version

This section contains information on how to use different versions of CUDA on the DSI Cluster. There are a few important concepts to keep in mind before starting:

*   While CUDA is installed on the login nodes, the compute nodes should be considered the source of truth for available CUDA versions.
*   CUDA versions are controlled via environment variables that are generally set using your `.bashrc` file..

The environment variables of interest are: `CUDA_HOME`, `LD_LIBRARY_PATH` and `PATH`.

If you want to change to a specific version of CUDA you will need to put something like the below into your `.bashrc` file.

```
cuda_version=12.1
export CUDA_HOME=/usr/local/cuda-${cuda_version}
export LD_LIBRARY_PATH=$CUDA_HOME/lib64:$LD_LIBRARY_PATH
export PATH=$CUDA_HOME/bin:$PATH
```

| Remember                                                                                    |
| :------------------------------------------------------------------------------------------ |
| When editing your `.bashrc` file you will need to run `source` on it before the changes take effect |

### What version am I currently using (bash)?

To test which version you are currently using run the command `nvcc --version` on _your compute node where you will be running CUDA_.

This will return something like

```
nvcc: NVIDIA (R) Cuda compiler driver
Copyright (c) 2005-2023 NVIDIA Corporation
Built on Mon_Apr__3_17:16:06_PDT_2023
Cuda compilation tools, release 12.1, V12.1.105
Build cuda_12.1.r12.1/compiler.32688072_0
```

Reading the above this is CUDA release 12.1.

### What version am I using (python)?

If you want to know what version your code is using you can run the following (assuming you are using `torch`, however most DL tools will have a similar system):

```
import torch
print(f"PyTorch version: {torch.__version__}")
print(f"CUDA available: {torch.cuda.is_available()}")
print(f"CUDA version: {torch.version.cuda}")
```

### What versions of CUDA are available?

To see which version are available you can run the following command which lists the versions which are available:

`ls -d /usr/local/cuda*`

Currently this returns:

```
/usr/local/cuda     /usr/local/cuda-11.8  /usr/local/cuda-12.1  /usr/local/cuda-12.4
/usr/local/cuda-11  /usr/local/cuda-12    /usr/local/cuda-12.3
```

which means that 11, 11.8, 12, 12.1, 12.3 and 12.4 are all useable on the cluster by changing the environment variables above.

### `nvidia-smi` shows something different!

When you run `nvidia-smi` you will see something like:

```
nvidia-smi
Thu Apr  3 21:21:21 2025
+-----------------------------------------------------------------------------------------+
| NVIDIA-SMI 550.127.08             Driver Version: 550.127.08     CUDA Version: 12.4     |
|-----------------------------------------+------------------------+----------------------+
| GPU  Name                 Persistence-M | Bus-Id          Disp.A | Volatile Uncorr. ECC |
| Fan  Temp   Perf          Pwr:Usage/Cap |           Memory-Usage | GPU-Util  Compute M. |
|                                         |                        |               MIG M. |
|=========================================+========================+======================|
|   0  NVIDIA A100 80GB PCIe          On  |   00000000:E1:00.0 Off |                    0 |
| N/A   34C    P0             54W /  300W |       1MiB /  81920MiB |      0%      Default |
```

where the version is in the upper right corner. This is the maximum allowable versions with the drivers and NOT the currently used version.

This is useful information to know, but to get the currently used version, type in `nvcc --version.`
