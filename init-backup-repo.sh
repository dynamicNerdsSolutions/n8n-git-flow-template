#!/bin/bash

# Vérifier si le dossier existe
if [ ! -d "local-files/backups" ]; then
    echo "The local-files/backups directory does not exist"
    echo "Creating it..."
    mkdir -p local-files/backups
fi

echo "Changin directory to local-files/backups"
cd local-files/backups

echo "Initializing git repository"
git init


echo "Git repository has been initialized into local-files/backups"
echo "Don't forget to setup remote repo with :"
echo "git remote add origin <URL_DE_VOTRE_REPO>" 