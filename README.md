# UChicago DSI Cluster Information Site

This repository contains the Jekyll-based website for information regarding the DSI's GPU-based cluster. The site provides information about cluster resources, policies, and tools.

## Development

### Prerequisites

You can run this website using Docker (and `make`). Make sure you have Docker installed on your system.

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
