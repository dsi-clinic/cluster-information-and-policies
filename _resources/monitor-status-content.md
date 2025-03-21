# Monitor Status information

The UChicago DSI Monitor, which can be found [here](https://cluster-status.ds.uchicago.edu/status/uchicago-dsi-cluster) contains information on different status information. They are organized in different sections below.

Note that this server is running [uptime kuma](https://github.com/louislam/uptime-kuma) which is a lightweight status monitor. This technology was chosen for ease of use.

### Login Node Access

This is a monitor that attempts to `ssh` into the login from a remote server. If the `ssh` fails to connect this will fail. It attempts to do this every two minutes.

### Root Filesystem space

These monitors verify that there is more than 30GB free on each of the root file systems. They check every two minutes.

### File listing from login nodes

From each node these attempt to list files within certain network drives, making sure that it takes less than 30 seconds to complete the `ls` command. These are done every two minutes. The prefix on each alert indicates the node attempting the file listing while the suffix represents the directory being listed.

### Curl from the login nodes

These alerts verify that the login nodes have access to the internet. Every two minutes it attempts to ping a website and, if the internet connection is working it will show okay.

