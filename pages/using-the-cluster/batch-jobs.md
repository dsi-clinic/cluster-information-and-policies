---
title: "Submitting Batch Jobs (Slurm Examples)"
permalink: /using-the-cluster/batch-jobs/
excerpt: "A guide to writing Slurm submission scripts and managing batch jobs."
---

For any task that is computationally intensive or expected to run for more than a few minutes, you should not run it directly on a login node. Instead, you must submit it to the Slurm workload manager as a **batch job**.

A batch job runs non-interactively in the background on one or more compute nodes. You define the resources your job needs (CPUs, memory, time, GPUs) and the commands to execute in a special shell script called a submission script. The Slurm scheduler then finds the appropriate resources and runs your job when they become available.

## The Slurm Submission Script

A Slurm submission script is a standard shell script (e.g., `bash`) that contains special directives starting with `#SBATCH`. These directives tell Slurm about the resources your job requires.

Here are some of the most common `#SBATCH` directives:

| Directive           | Description                                                              | Example                          |
| ------------------- | ------------------------------------------------------------------------ | -------------------------------- |
| `--job-name`        | The name of your job, which appears in queue listings.                   | `--job-name=my_analysis`         |
| `--output`          | File to which standard output will be written.                           | `--output=my_job_%j.out`         |
| `--error`           | File to which standard error will be written.                            | `--error=my_job_%j.err`          |
| `--nodes`           | Number of compute nodes to request.                                      | `--nodes=1`                      |
| `--ntasks-per-node` | Number of tasks (processes) to run on each node.                         | `--ntasks-per-node=1`            |
| `--cpus-per-task`   | Number of CPU cores for each task.                                       | `--cpus-per-task=8`              |
| `--mem`             | Memory required per node.                                                | `--mem=16G`                      |
| `--time`            | The maximum wall-clock time for the job. (Format: `D-HH:MM:SS`)          | `--time=0-02:30:00` (2.5 hours)  |
| `--partition`       | The partition (queue) to submit the job to.                              | `--partition=cpu`                |
| `--gpus-per-node`   | The number of GPUs to request per node (on a GPU partition).             | `--gpus-per-node=1`              |

**Note:** The `%j` in the output/error file names is a wildcard that Slurm automatically replaces with the Job ID.

## Submitting and Managing Jobs

### Submitting a Job (`sbatch`)
To submit your script to the queue, use the `sbatch` command.
```bash
sbatch my_job_script.slurm
```
If successful, Slurm will respond with the assigned Job ID.

### Cancelling a Job (`scancel`)
If you need to stop a job that is running or pending in the queue, use the `scancel` command with the Job ID.
```bash
scancel <JOB_ID>
```

### Monitoring Jobs (`squeue`)
To see the status of your jobs, use the `squeue` command. For a more detailed guide on monitoring jobs and the cluster, please see the **Cluster Status page**.

## Example 1: Simple Single-Core Job

This is a basic "hello world" script that runs a single command on a single CPU core.

`simple_job.slurm`:
```bash
#!/bin/bash
#SBATCH --job-name=simple_job
#SBATCH --output=simple_job_%j.out
#SBATCH --error=simple_job_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1G
#SBATCH --time=00:05:00

echo "Hello, World!"
echo "I am running on host: $(hostname)"
```

## Example 2: Multi-Core Job (Single Node)

This script requests 8 CPU cores on a single node, suitable for a multi-threaded application.

`multicore_job.slurm`:
```bash
#!/bin/bash
#SBATCH --job-name=multicore_job
#SBATCH --output=multicore_job_%j.out
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=8G
#SBATCH --time=01:00:00

# Load any necessary software modules
module load python

# Your multi-threaded application command
python my_threaded_script.py --threads $SLURM_CPUS_PER_TASK
```

## Example 3: GPU Job

This script requests one GPU on a node in the `gpu` partition. It runs `nvidia-smi` to confirm the GPU is allocated.

`gpu_job.slurm`:
```bash
#!/bin/bash
#SBATCH --job-name=gpu_job
#SBATCH --output=gpu_job_%j.out
#SBATCH --partition=gpu
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=16G
#SBATCH --gpus-per-node=1
#SBATCH --time=01:00:00

# Load CUDA module if required by your application
module load cuda

echo "Checking for GPU..."
nvidia-smi

echo "Running GPU application..."
python my_gpu_code.py
```

## Example 4: Job Arrays

Job arrays are the most efficient way to run the same script thousands of times on different inputs. The `--array` directive creates a set of tasks, each with a unique `$SLURM_ARRAY_TASK_ID`.

This example submits an array of 100 tasks. Each task processes a different input file named `data_1.txt`, `data_2.txt`, etc.

`array_job.slurm`:
```bash
#!/bin/bash
#SBATCH --job-name=array_job
#SBATCH --output=array_job_%A_%a.out  # %A is Job ID, %a is Task ID
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2G
#SBATCH --time=00:20:00
#SBATCH --array=1-100

echo "This is array task ${SLURM_ARRAY_TASK_ID}"

# Define the input file based on the task ID
INPUT_FILE="data_${SLURM_ARRAY_TASK_ID}.txt"

# Run the analysis on the specific input file
./my_program --input ${INPUT_FILE}
```