## FAQ

This document contains some frequently asked questions about the cluster and its abilities. This document does not contain support information.

## Table of Contents
<!-- do not change TOC, generated from script -->
<!-- `npx markdown-toc -i FAQ.md` -->
<!-- toc -->

- [Questions](#questions)
  * [What are the requirements for getting access to this cluster?](#what-are-the-requirements-for-getting-access-to-this-cluster)
  * [I want to install additional software.](#i-want-to-install-additional-software)
  * [Is there a way to use the cluster via a GUI?](#is-there-a-way-to-use-the-cluster-via-a-gui)
  * [The current time limit on jobs is too low for what I want to do. Can I increase the job time limit?](#the-current-time-limit-on-jobs-is-too-low-for-what-i-want-to-do-can-i-increase-the-job-time-limit)
  * [I am currently limited to eight concurrent jobs (on either CPU or GPU), my jobs are very small. Can I increase the job limit? (AKA The QOS which is applied to everyone is limited to 8 concurrent jobs).](#i-am-currently-limited-to-eight-concurrent-jobs-on-either-cpu-or-gpu-my-jobs-are-very-small-can-i-increase-the-job-limit-aka-the-qos-which-is-applied-to-everyone-is-limited-to-8-concurrent-jobs)
  * [I feel like the cluster isn't working for me. Can we set up any additional configurations to allow for my specific job?](#i-feel-like-the-cluster-isnt-working-for-me-can-we-set-up-any-additional-configurations-to-allow-for-my-specific-job)
  * [There are processes not owned by me running on the GPU that I reserved. Is this expected?](#there-are-processes-not-owned-by-me-running-on-the-gpu-that-i-reserved-is-this-expected)

<!-- tocstop -->

## Questions

### What are the requirements for getting access to this cluster?

Users of the DSI have to meet one of the following criteria:

1. Have a DSI-related grant.
2. Be in the DSI or a DSI affiliated faculty (with some exceptions).
3. Be a student with written approval by a DSI faculty mentor.

If you are looking for compute resources and are more generally affiliated with the University we recommend contacting [RCC](https://rcc.uchicago.edu/).


### I want to install additional software.

Please utilize MiniConda or MicroMamba to create a custom software environment tailored to your needs.

### Is there a way to use the cluster via a GUI?

You maybe able to set up X11 forwarding for using software that requires a GUI. This is not the intended use of the cluster and while users are allowed to access X11 forwarding, it is not supported behavior. You can find a brief "How-to" [here](https://github.com/dsi-clinic/the-clinic/blob/main/tutorials/X11.md).

### The current time limit on jobs is too low for what I want to do. Can I increase the job time limit? 

No. The current job limit is already quite high at 12 hours (many research groups enforce much lower limits). If you have a job that requires a longer time horizon to complete you need to use check pointing in order to break up your jobs.

### I am currently limited to eight concurrent jobs (on either CPU or GPU), my jobs are very small. Can I increase the job limit? (AKA The QOS which is applied to everyone is limited to 8 concurrent jobs).

No. The current concurrency limit is set to maximize the cluster's performance given the current mix of jobs that we see. We constantly evaluate this limit, but are not willing to change this for a single user or set of users. Occasionally, the cluster is given jobs that are very short and small and this becomes a significant bottleneck. In this case we recommend exploring alternative computing environments that are designed to facilitate this type of work.

### I feel like the cluster isn't working for me. Can we set up any additional configurations to allow for my specific job?

The cluster is designed to efficiently process the most common use cases. We constantly monitor cluster performance and think through ways to increase _overall_ performance. Given our limited resources we do not have the bandwidth to accommodate, implement and monitor additional configurations. If you have a specific use case which is not being efficiently handled by the current configuration there are two options:

  1. Use an alternative compute resources (such as [AWS](https://aws.amazon.com/), [GCP](https://cloud.google.com/) or [UChicago's RCC](https://rcc.uchicago.edu/)).
  2. Purchase specific compute within the guidelines listed [here]({{ site.baseurl }}/policies/purchasing/). For allocated resources we are able to implement alternative QOS policies.

### There are processes not owned by me running on the GPU that I reserved. Is this expected? 

Yes. In SLURM, this is called OverSubscribe. If a user is not utilizing a resource (GPU, CPU, or MEM) completely, then SLURM will assign jobs to the portion of your allocation that is unused.

### How do I check how much space I'm using in either a project or home directory? 

Users are only allowed a certain amount of space on different directors. If you would like to see how much space you are using in a specific location, refer to the [`dsiquota` tool]({% link _tools/dsiquota.md %}).