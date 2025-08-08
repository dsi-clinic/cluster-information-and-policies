---
title: "Common Error Messages & Resolutions"
layout: single
nav_order: 2
parent: FAQ
category: faq
permalink: /faq/common-errors/
classes: [wide, left-aligned]
hide_hero: True
---

# Common Error Messages & Resolutions



This page lists common error messages you might encounter while using the cluster, along with their causes and solutions.

### Error: `sbatch: error: (QOSMaxJobsPerUserLimit)` or `(JobArrayLimit)`

**Cause:** You have submitted a job that would cause you to exceed your limit of concurrently running jobs (the default is 8). This limit is in place to ensure fair usage of the cluster for all users.

**Resolution:** You cannot increase your concurrent job limit. You should wait for some of your currently running jobs to finish before submitting new ones. If you have many small, short tasks, consider using a job array with a limited number of concurrent tasks. For example, `sbatch --array=1-100%10 ...` will run a 100-task array, but only 10 tasks will run at any given time.

---

### Error: `slurmstepd: error: *** JOB ... CANCELLED AT ... DUE TO TIME LIMIT ***`

**Cause:** Your job ran for longer than the maximum allowed time for the partition it was running in. The default time limit is 12 hours.

**Resolution:** You cannot increase the time limit for a single job. If your job requires more than 12 hours to run, you must implement **checkpointing**. This involves saving the state of your application periodically and then submitting a new job that resumes from the last saved checkpoint.

---

### Error: `Disk quota exceeded`

**Cause:** You have used up all of your allocated storage space in your home (`/home/user`) or scratch (`/scratch/user`) directory.

**Resolution:** You need to free up space by deleting unnecessary files.

1.  Use the `dsiquota` command to check your current usage and see which filesystem is full. See the DSI Quota Tool documentation for more details.
2.  Navigate to the directory and use commands like `du -sh * | sort -h` to find large files and directories that can be removed.

If you require more storage for a project, please see the policy on purchasing resources.

---

### Error: `sbatch: error: Batch script contains DOS line endings`

**Cause:** You edited your submission script on a Windows machine, which uses different line endings (`\r\n`) than Linux/macOS (`\n`). The SLURM scheduler cannot parse scripts with Windows line endings.

**Resolution:** You need to convert the line endings to Unix format. You can do this on the cluster by running the `dos2unix` command on your script:

```bash
dos2unix your_script.sbatch
```

After running this command, you can resubmit your job.

---

### Error: `module: command not found`

**Cause:** You are trying to use the `module` command in a non-interactive shell script (e.g., a script run by `sbatch`) or in a context where the environment is not set up correctly. The `module` command is a function, not a binary, and may not be defined in all shell environments.

**Resolution:** To ensure the `module` command is available in your scripts, you should source the system-wide profile script at the beginning of your sbatch script. Add the following line before you try to use `module`:

```bash
#!/bin/bash
#SBATCH ...

# Source the environment setup script to make 'module' command available
source /etc/profile.d/modules.sh

# Now you can use module commands
module load anaconda
...
```

---

### Still Have Questions?

If your error isn't listed here or you need further assistance, please visit our [Contact Us]({{ '/contact/' | relative_url }}) page.
