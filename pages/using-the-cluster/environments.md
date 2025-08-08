---
title: "Environment management (Conda, venv)"
layout: single
nav_order: 2
parent: Using the Cluster
category: using-the-cluster
permalink: /using-the-cluster/environments/
classes: [wide, left-aligned]
hide_hero: True
---

# Environment management (Conda, venv)

The DSI cluster provides a baseline set of software, but for most research projects, you will need to install specific packages and libraries. To ensure a stable and reproducible environment without interfering with system-wide installations, we require users to manage their own software using environment management tools.

We strongly recommend using either **MiniConda** or **MicroMamba** to create isolated software environments for your projects. This approach prevents conflicts with system libraries and makes your research more reproducible.

## Using MiniConda

MiniConda is a free, minimal installer for the `conda` package manager. It allows you to create and manage isolated environments containing specific versions of Python and the packages you need.

### Installation

1.  Log in to the cluster.
2.  Download the latest MiniConda installer for Linux.
    ```bash
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
    ```
3.  Run the installer script. Accept the license terms and default location.
    ```bash
    bash Miniconda3-latest-Linux-x86_64.sh
    ```
4.  When asked, `Do you wish the installer to initialize Miniconda3 by running conda init?`, answer `yes`.
5.  Close and reopen your terminal session for the changes to take effect. You should see `(base)` at the beginning of your command prompt.

### Creating an Environment

Once MiniConda is installed, you can create a new environment.

```bash
# Create an environment named 'my-project' with Python 3.9
conda create --name my-project python=3.9

# Activate the new environment
conda activate my-project

# Install packages into your active environment
conda install numpy pandas matplotlib

# When you are finished, deactivate the environment
conda deactivate
```

<div class="notice--warning" markdown="1">
**Best Practice: Avoid the Base Environment**

Do not install packages directly into your `(base)` conda environment. Always create a separate environment for each project to avoid dependency conflicts.
</div>

## Using MicroMamba

MicroMamba is a fast, lightweight, and standalone reimplementation of the `conda` package manager written in C++. It is significantly faster at installing packages and resolving dependencies, making it our top recommendation.

### Installation

You can install MicroMamba with a single command.

```bash
"$(curl -Ls https://micro.mamba.pm/install.sh)"
```
Follow the on-screen prompts to complete the installation and initialize it for your shell. You may need to close and reopen your terminal session for the changes to take effect.

### Creating an Environment

The commands for MicroMamba are very similar to `conda`.

```bash
# Create an environment named 'my-fast-project' with Python 3.9 from the conda-forge channel
micromamba create --name my-fast-project python=3.9 -c conda-forge

# Activate the new environment
micromamba activate my-fast-project

# Install packages (it's much faster!)
micromamba install jupyterlab scikit-learn -c conda-forge

# Deactivate when you are done
micromamba deactivate
```