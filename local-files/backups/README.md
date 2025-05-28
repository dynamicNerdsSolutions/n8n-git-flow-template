# n8n Workflows Backup

This directory contains n8n workflow backups.
Files are automatically exported and versioned here.

## Structure
- .json files contain exported workflows
- Each file represents a complete workflow

## Usage
Workflows can be imported into n8n using the command:
```
n8n import:workflow --separate --input=.
```

Or, if using docker:

1. First, copy the backup files to the container:
```
docker cp . YOUR_DOCKER_CONTAINER_NAME:/tmp/n8n-backups
```

2. Then, connect to the container and import the workflows:
```
docker exec -it YOUR_DOCKER_CONTAINER_NAME sh -c "cd /tmp/n8n-backups && n8n import:workflow --separate --input=."
```

Note: Replace `YOUR_DOCKER_CONTAINER_NAME` with your actual n8n container name.
