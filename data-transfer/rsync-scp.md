---
layout: single
title: rsync, scp examples
permalink: /data-transfer/rsync-scp/
---

### Data Transfer Examples

Data can be securely transferred to and from the DSI cluster using tools like `scp` and `rsync`. Below are commonly used examples:

---

#### Using `scp` (Secure Copy)

Transfer a file **from your local machine to the cluster**:

```bash
scp /path/to/local/file.txt your_cnetid@cluster.dsi.uchicago.edu:/path/to/remote/directory/

```

Transfer a file from the cluster to your local machine:

```bash
scp your_cnetid@cluster.dsi.uchicago.edu:/path/to/remote/file.txt /path/to/local/directory/
```

#### Using `rsync` (Recommended for large or repeated transfers)

Transfer a directory from your local machine to the cluster:

```bash
rsync -avz /path/to/local/directory/ your_cnetid@cluster.dsi.uchicago.edu:/path/to/remote/directory/
```

Transfer a directory from the cluster to your local machine:

```bash
rsync -avz your_cnetid@cluster.dsi.uchicago.edu:/path/to/remote/directory/ /path/to/local/directory/
```

You can also use the --progress flag to monitor file transfer status:

```bash
rsync -avz --progress /path/to/local/ your_cnetid@cluster.dsi.uchicago.edu:/remote/path/
```

