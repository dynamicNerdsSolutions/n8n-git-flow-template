# n8n Workflows Backup

This directory contains n8n workflow backups.
Files are automatically exported and versioned here.

## Structure
- .json files contain exported workflows
- Each file represents a complete workflow

## Scripts

### pull.sh
The `pull.sh` script is used to pull and import n8n workflows from the backup repository.

#### Basic Usage
```bash
./pull.sh [options]
```

#### Options
- `-d` or `--docker`: Specify the Docker container name where n8n is running
  - Example: `./pull.sh -d n8n-container`
  - If not provided, the script will attempt to use n8n CLI directly on your host machine

#### What the Script Does
1. Pulls the latest changes from the remote repository
2. Then either:
   - If Docker container name is provided: Copies the backup files to the container and imports them using n8n CLI inside the container
   - If no Docker container name: Uses n8n CLI directly on your host machine to import the workflows

#### Important Notes
1. The script requires Git to be initialized in the directory

#### Example Usage
```bash
# Using with Docker
./pull.sh -d my-n8n-container

# Using without Docker (direct n8n CLI)
./pull.sh
```
