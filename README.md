# UChicago DSI Cluster Information Site

This repository contains the Jekyll-based website for information regarding the DSI's GPU-based cluster. The site provides information about cluster resources, policies, and tools.

## Website Content

The website is organized into several sections:

- [Resources](https://dsi-clinic.github.io/cluster-information-and-policies/resources/): Information about the cluster's hardware and capabilities
- [Policies](https://dsi-clinic.github.io/cluster-information-and-policies/policies/): General usage and purchasing policies
- [Tools](https://dsi-clinic.github.io/cluster-information-and-policies/tools/): Useful tools and commands for interacting with the cluster
- [FAQ](https://dsi-clinic.github.io/cluster-information-and-policies/faq/): Frequently asked questions about the cluster

## Development

### Prerequisites

You can run this website using Docker. Make sure you have Docker installed on your system.

### Running Locally

To run the site locally, use the following commands:

```bash
# Build the Docker image
make build

# Run the site locally
make serve
```

The site will be available at http://localhost:4000.

### Interactive Shell

To get an interactive shell inside the Docker container:

```bash
make inter
```

### Debugging

For debugging with trace information:

```bash
make trace
```

### Cleaning

To clean up Docker resources:

```bash
make clean
```

### Full Rebuild

To perform a full rebuild and restart:

```bash
make rebuild
```

## Updating Content

Content is stored in Markdown files within the `documents/` directory. After updating content, rebuild and run the site to see your changes.

## Deployment

This site is configured to be deployed using GitHub Pages. When changes are pushed to the main branch, GitHub will automatically build and deploy the site.

## For Support

NOTE: This repository does not contain _support_ information or tutorials for using the cluster. 

For support information please start [here](https://github.com/dsi-clinic/the-clinic/blob/main/tutorials/slurm.md). 

If the document above does not answer your questions please contact the DSI techstaff either through slack or email.