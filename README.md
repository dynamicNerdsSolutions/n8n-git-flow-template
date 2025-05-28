# n8n Development and Deployment Template

This repository provides a template for developing n8n workflows locally and deploying them through a CI/CD pipeline. It's designed to help teams maintain version control of their n8n workflows and automate their deployment process.

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
   - Start the local n8n instance using Docker Compose `docker compose up`
   - Create and test your workflows in the n8n interface
   - Use the `n8n-commit.sh` script to commit your workflows:
     ```bash
     ./n8n-commit.sh -m "Your commit message"
     ```

2. **Version Control**
   - Workflows are automatically exported to the `local-files` directory
   - Each workflow is saved as a separate JSON file
   - Commit and push changes to your GitHub repository

3. **CI/CD Pipeline**
   - Set up your CI/CD pipeline in your GitHub repository
   - Configure deployment to your production server by either calling `git pull` or any other way to import the workflows in its instance

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
<!-- 1. **Production Server Setup**
   - Clone this repository on your production server
   - Configure environment variables for production
   - Set up SSL certificates if needed -->

2. **CI/CD Configuration**
   - Configure your CI/CD pipeline to:
     - Pull the latest changes
     - Deploy workflows to production using n8n cli or a custom flow

3. **Backup Strategy**
   - Workflows are automatically backed up in the `local-files` directory
   - Consider setting up automated backup to a secure location

## Contributing
1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

