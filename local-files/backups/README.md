# n8n Workflows Backup

This repository is a way to store historic modifications of n8n workflows and allow automated deployments between environments.


## Structure
- .json files contain exported workflows
- Each file represents a complete workflow

# Deployment


## Webhook based

   - A working example deployment workflow is provided in the `.github/workflows` directory
   - The deployment is triggered via a webhook from GitHub to n8n
   - To set up the webhook-based deployment:
     1. Copy the workflow from `importFromGithub.workflow.json` into your production n8n instance (copy paste the json in the visual builder) and activate it
     2. Create the required github credentials in your n8n instance
     3. Set up the following GitHub secrets in your repository:
        - `N8N_WEBHOOK_URL`: The webhook URL from your n8n instance
        - `N8N_API_KEY`: Your n8n API key
        - `N8N_BASE_URL`: Your n8n instance base URL
     
   - This setup allows for automatic deployment whenever changes are pushed to your repository. It reimport **ALL** workflows in that state that it was in development.


## Script based

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