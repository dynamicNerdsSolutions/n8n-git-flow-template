# n8n Development and Deployment Template

This repository provides a template for developing n8n workflows locally and deploying them through a CI/CD pipeline. It's designed to help teams version control of their n8n workflows and automate their deployment process.

The root directory of this repo is used to start a basic dockerized n8n instance that you can use to start working. You will see in the instructions below that we will create another repo in a subfolder. This nested repo is your actual project repo where workflows will be stored and pushed. Going this way allows to use one instance per project, thus allowing to export only the workflows related to a project. No playing with tags.

## Why a nested repo ?
We don't all have the same server setup, but we all use the same tool. I chose to go with a separate repo to avoid forcing a specific docker setup on server. I, for instance, often use the [n8n-blue-green-docker-compose](https://github.com/dynamicNerdsSolutions/n8n-blue-green-docker-compose) on server but don't want to use it when developing.
Not exaclty respecting the Continuous delivery principles, I know...


## Table of Contents
- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
- [Development Workflow](#development-workflow)
- [Project Structure](#project-structure)
- [Environment Setup](#environment-setup)
- [Deployment](#deployment)
- [Contributing](#contributing)

## Overview
This template helps you:
- Develop n8n workflows locally
- Version control your workflows using Git
- Automatically deploy workflows to production using CI/CD
- Maintain workflow backups
- Collaborate with team members on workflow development

## Prerequisites
- Docker and Docker Compose
- Git
- GitHub account (for repository hosting)
- Basic understanding of n8n workflows

## Getting Started
1. Clone this repository
2. Copy `.env.example` to `.env` and configure your environment variables
3. Run `docker-compose up -d`
4. Access n8n at http://localhost

## Development Workflow
1. **Local Development**
I recommend using this current repo as a template to start development, but the actual workflows are in a separate repo, located in the local-files/backups repository. Allowing more flexibility in production.
   - Initialize a repo in the `local-files/backups` directory by running `./init-backup-repo.sh`.
   - Set up git remote as explained from the previous command.
   - Start the local n8n instance using Docker Compose `docker compose up`
   - Create and test your workflows in the n8n interface
   - Use the `n8n-commit.sh` script to export your workflows. They will be exported in local-files/backups
    - Export only:
        ```bash
        ./n8n-commit.sh
        ```   
     -  Export and commit : 
        ```bash
        ./n8n-commit.sh -m "Your commit message"
        ```
     - Export, commit and push :
        ```
        ./n8n-commit.sh -m "Your commit message" -p
        ```

2. **Version Control**
   - Workflows are automatically exported to the `local-files/backups` directory
   - Each workflow is saved as a separate JSON file
   - Commit and push changes to your GitHub repository

## Project Structure
```
.
├── compose.yaml          # Docker Compose configuration for local development
├── n8n-commit.sh        # Script for committing n8n workflows
├── n8n_data/           # Persistent n8n data and database
├── local-files/        # Local file storage and workflow backups
└── .gitignore         # Git ignore rules
```

## Environment Setup
Required environment variables:
- `DOCKER_CONTAINER_NAME`: Name of the n8n container
- `SSL_EMAIL`: Email for SSL certificate
- `GENERIC_TIMEZONE`: Timezone for n8n

## Deployment
1. **Production cli based deployment** (no example yet)
   - Have n8n ready on your server, either with npm or docker. See [Self-Hosting n8n](https://docs.n8n.io/hosting/) for more details
   - Clone your repository (the one initialised in `local-files/backups`) on your server
   - follow the instructions in ./local-files/backups/readme.md#pull.sh 

2. **Webhook-Based Deployment (Currently implemented)**
   - An example deployment workflow is provided in the `.github/workflows` directory
   - The deployment is triggered via a webhook from GitHub to n8n
   - To set up the webhook-based deployment:
     1. Copy the workflow from `importFromGithub.workflow.json` into your production n8n instance (copy paste the json in the visual builder) and activate it
     2. Create the required github credentials in your n8n instance
     3. Set up the following GitHub secrets in your repository:
       - `WEBHOOK_URL`: The webhook URL from your n8n instance
       - `WEBHOOK_USERNAME`: The username created in the basic auth credential for the webhook
       - `WEBHOOK_PASSWORD`: The password created in the basic auth credential for the webhook
     
   - This setup allows for automatic deployment whenever changes are pushed to your repository. It reimport **ALL** workflows in that state that it was in development.


## Contributing
1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

