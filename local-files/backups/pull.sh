#!/bin/bash

## Arguments
# -d|--docker: docker container name. If not provided, will attempt to use n8n cli directly.
##

echo "When exporting workflows and credentials, n8n also exports their IDs. If you have workflows and credentials with the same IDs in your existing database, they will be overwritten. To avoid this, delete or change the IDs before importing. Continue? (y/N)"
read -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 0
fi


while [ $# -gt 0 ]; do
  case "$1" in
    --docker*|-d*)
      if [[ "$1" != *=* ]]; then shift; fi # Value is next arg if no `=`
      docker_container_name="${1#*=}"
      ;;
    --help|-h)
      printf "Usage: $0 -d \"Docker container name\"\n"
      exit 0
      ;;
    *)
      >&2 printf "Error: Invalid argument\n"
      exit 1
      ;;
  esac
  shift
done
# Check if this is a Git repository
if [ ! -d ".git" ]; then
    echo "This directory is not a Git repository. Please run init-backup-repo.sh first"
    exit 1
fi

# Pull latest changes from remote repository
echo "Pulling latest changes from remote repository"
git pull

# Check if docker container name is provided
if [ -z "$docker_container_name" ]; then
    echo "Docker container name is not provided. Using n8n cli directly."
    n8n import:workflow --separate --input=.
    exit 0
fi

# Copy the backup files to the container
echo "Copying backup files to the container"
docker cp . $docker_container_name:/tmp/n8n-backups

# Connect to the container and import the workflows
echo "Importing workflows"
docker exec -it $docker_container_name sh -c "cd /tmp/n8n-backups && n8n import:workflow --separate --input=."
