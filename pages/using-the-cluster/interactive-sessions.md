---
title: "Interactive Sessions (JupyterLab)"
permalink: /using-the-cluster/interactive-sessions/
excerpt: "How to launch and connect to an interactive JupyterLab session on a compute node."
---

While batch jobs are ideal for long-running, non-interactive tasks, you will often need direct, interactive access to a compute node for tasks like:
- Developing and debugging your code.
- Running applications with a graphical user interface (GUI), such as JupyterLab.
- Performing tasks that require real-time feedback.

Slurm provides the `srun` command to request an interactive session on one or more compute nodes.

## Requesting an Interactive Session with `srun`

To start an interactive session, you use `srun` with flags similar to `#SBATCH` directives in a batch script. The most important flag is `--pty /bin/bash`, which requests a pseudo-terminal and starts a bash shell on the compute node.

Here is a typical `srun` command to request an interactive session with 4 CPUs and 8GB of memory for 1 hour:

```bash
[user@login-node ~]$ srun --nodes=1 --ntasks-per-node=1 --cpus-per-task=4 --mem=8G --time=01:00:00 --pty /bin/bash
srun: job 12345 allocated
srun: job 12345 has been allocated resources
[user@compute-node-a1 ~]$ 
```

Once the resources are allocated, your command prompt will change, indicating that you are now on a compute node (e.g., `compute-node-a1`) instead of a login node. You can now run commands directly on this node.

To end your session, simply type `exit`. This will release the allocated resources.

## Running JupyterLab on a Compute Node

Running a web-based service like JupyterLab requires a few more steps to securely connect your local web browser to the service running on the compute node. This is accomplished using an **SSH tunnel**.

Here is the complete workflow:

### Step 1: Start an Interactive Job

From a DSI cluster **login node**, request an interactive session.

```bash
srun --nodes=1 --cpus-per-task=4 --mem=8G --time=02:00:00 --pty /bin/bash
```

### Step 2: Identify Your Compute Node and Start JupyterLab

Once your job starts, take note of the hostname of the compute node you've been assigned. Then, load the necessary modules and start JupyterLab.

```bash
# Note the hostname of your compute node
[user@cn-a42 ~]$ hostname
cn-a42.dsi.uchicago.edu

# Load Python/Jupyter module (e.g., anaconda)
[user@cn-a42 ~]$ module load anaconda

# Start JupyterLab on a specific port
[user@cn-a42 ~]$ jupyter lab --no-browser --ip=0.0.0.0 --port=8889
```

JupyterLab will start and print several lines of output. Look for a URL containing a token, like this:
`http://127.0.0.1:8889/?token=a1b2c3d4e5f6a7b8c9d0e1f2a3b4c5d6e7f8a9b0c1d2e3f4`

Keep this token handy. **Leave this terminal window open; closing it will terminate your Jupyter session.**

### Step 3: Create an SSH Tunnel from Your Local Machine

Open a **new terminal on your local computer** (not the cluster). Create an SSH tunnel that forwards a port on your local machine to the JupyterLab port on the compute node.

The command format is: `ssh -L <LOCAL_PORT>:<COMPUTE_NODE>:<REMOTE_PORT> <USER>@<CLUSTER_ADDRESS>`

Using our example:
- `LOCAL_PORT`: `8889` (can be any free port on your machine)
- `COMPUTE_NODE`: `cn-a42.dsi.uchicago.edu` (the hostname from Step 2)
- `REMOTE_PORT`: `8889` (the port you used for JupyterLab)
- `CLUSTER_ADDRESS`: `dsi-cluster.uchicago.edu` (the main cluster login address)

```bash
# This command is run on your local machine
ssh -L 8889:cn-a42.dsi.uchicago.edu:8889 your_username@dsi-cluster.uchicago.edu
```

Enter your password when prompted. This command logs you into the cluster's login node again, but it keeps the tunnel active in the background.

### Step 4: Access JupyterLab in Your Browser

Now, open a web browser **on your local machine** and navigate to:

`http://localhost:8889`

You should see the JupyterLab login page. Paste the token from Step 2 into the password/token field to access your session. All computations you perform in this JupyterLab instance will run on the compute node you allocated.

### Step 5: Shutting Down

1.  In the JupyterLab web interface, go to `File -> Shut Down`.
2.  Close the SSH tunnel terminal on your local machine.
3.  In the terminal on the compute node where Jupyter is running, press `Ctrl+C` and then type `exit` to end the interactive Slurm job and release the resources.