---
title: "Containerized Workflows (Singularity, Docker, podman)"
permalink: /using-the-cluster/containers/
excerpt: "A guide to using containers for portable and reproducible research workflows."
---

## Introduction to Containers

Containers are a lightweight form of virtualization that allow you to package up an application with all of its dependencies, libraries, and configuration files into a single, portable unit. This makes it easy to move your research workflows between different computing environments—from your laptop to the DSI cluster—without worrying about software conflicts or dependency issues.

Key benefits of using containers include:
- **Portability:** A container that runs on your laptop will run the same way on the cluster.
- **Reproducibility:** Containers encapsulate the exact software environment, ensuring that your analysis is reproducible by you or others in the future.
- **Dependency Management:** Avoids "dependency hell" by isolating your application's dependencies from the host system and other applications.

On the DSI cluster, the primary tool for working with containers is **Apptainer** (formerly known as Singularity).

## Apptainer (Singularity) on the Cluster

Due to security considerations on a shared, multi-user high-performance computing (HPC) system, you cannot run Docker or Podman daemons directly on the cluster nodes. Instead, we use Apptainer/Singularity, which is designed for HPC environments. It allows you to run containers without needing root privileges, ensuring a secure environment for all users.

You can use Apptainer to:
- Run containers built from Docker or Podman.
- Pull container images from various registries like Docker Hub, Quay.io, and the Apptainer Container Library.
- Run your containerized applications as part of a Slurm job.

### Getting Started with Apptainer

To start using Apptainer, you first need to load the corresponding module.

```bash
module load apptainer
```

This will make the `apptainer` (and `singularity`) command available in your shell.

### Pulling Container Images

You can pull container images from various sources. The most common is Docker Hub. To pull an image, use the `apptainer pull` command.

For example, to pull the latest Ubuntu image from Docker Hub:

```bash
apptainer pull docker://ubuntu:latest
```

This will download the image and create a Singularity Image File (`.sif`) in your current directory, named `ubuntu_latest.sif`.

### Running Containers

There are several ways to interact with a container using Apptainer.

#### `apptainer exec`

To execute a specific command inside a container without entering an interactive shell:

```bash
apptainer exec ubuntu_latest.sif cat /etc/os-release
```

This command runs `cat /etc/os-release` inside the `ubuntu_latest.sif` container and prints the output to your terminal.

#### `apptainer shell`

To start an interactive shell inside the container:

```bash
apptainer shell ubuntu_latest.sif
```

You will now be inside the container's environment. Your home directory is automatically mounted, so you can access your files.

```
Apptainer> ls /
bin   dev  home  lib    media  opt   root  sbin  sys  usr
boot  etc  lib64 mnt    proc  run   srv   tmp  var
Apptainer> exit
```

### Running Containers with Slurm

You can easily run your containerized workflow as a batch job using Slurm. Here is an example Slurm script (`run_container.slurm`) that executes a Python script inside a container.

```bash
#!/bin/bash
#SBATCH --job-name=container_job
#SBATCH --output=container_job.out
#SBATCH --error=container_job.err
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=4G
#SBATCH --time=01:00:00

# Load the apptainer module
module load apptainer

# Path to your container image
CONTAINER_IMAGE=/path/to/your/image.sif

# Command to run inside the container
apptainer exec ${CONTAINER_IMAGE} python /path/inside/container/to/your_script.py
```

Submit the job using `sbatch`:
```bash
sbatch run_container.slurm
```

### Data and Bind Mounts

By default, Apptainer automatically mounts your home directory (`/home/$USER`), the current working directory, and system temporary directories inside the container.

If you need to access data located elsewhere on the cluster's file system (e.g., in a project or scratch directory), you can use the `--bind` option to mount additional directories.

```bash
apptainer shell --bind /scratch/midway3/$USER:/data my_container.sif
```
This command mounts your scratch directory on the host to the `/data` directory inside the container.

## Building Your Own Containers

Building Apptainer/Singularity containers requires elevated privileges, which are not available to users on the cluster login or compute nodes. Therefore, you must build your containers elsewhere.

Options for building containers:
1.  **On your local machine:** If you have a Linux machine with Apptainer or Singularity installed, you can build containers locally. You can also use Docker or Podman to build a container and then pull it with Apptainer on the cluster.
2.  **Using Docker/Podman:** The most common workflow is to create a `Dockerfile`, build an image on your local machine using Docker or Podman, push it to a public or private registry (like Docker Hub), and then pull it onto the cluster using `apptainer pull`.

### Example: Building with Docker and Running with Apptainer

1.  **Create a `Dockerfile` on your local machine:**

    ```dockerfile
    # Use a base image
    FROM python:3.9-slim

    # Set working directory
    WORKDIR /app

    # Copy your application code
    COPY . .

    # Install dependencies
    RUN pip install --no-cache-dir numpy pandas

    # Command to run when the container starts
    CMD ["python", "./my_analysis.py"]
    ```

2.  **Build and push the Docker image:**

    ```bash
    # Build the image
    docker build -t your-dockerhub-username/my-analysis-app .

    # Log in to Docker Hub
    docker login

    # Push the image
    docker push your-dockerhub-username/my-analysis-app
    ```

3.  **Pull and run on the DSI Cluster:**

    ```bash
    # On the cluster, load apptainer
    module load apptainer

    # Pull the image from Docker Hub
    apptainer pull docker://your-dockerhub-username/my-analysis-app

    # This creates my-analysis-app_latest.sif
    # Run your analysis
    apptainer exec my-analysis-app_latest.sif python /app/my_analysis.py
    ```

This workflow allows you to create complex, reproducible software environments for your research on the cluster.