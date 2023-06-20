#!/bin/bash

# Variables
GITHUB_API="https://api.github.com"
REPO_OWNER="HOS-OS"   # Replace with the GitHub repository owner
REPO_NAME="HOS-os"     # Replace with the GitHub repository name
CURRENT_COMMIT_FILE=".current_commit"
INSTALL_DIR="/home/hosos5x"   # Replace with the directory where you want to install the files

# Retrieve the latest commit hash from the default branch
LATEST_COMMIT=$(curl -s "$GITHUB_API/repos/$REPO_OWNER/$REPO_NAME/commits" | jq -r '.[0].sha')

# Check if the current commit file exists
if [ -f "$CURRENT_COMMIT_FILE" ]; then
  # Read the previous commit hash from the current commit file
  PREVIOUS_COMMIT=$(cat "$CURRENT_COMMIT_FILE")
  echo "Previous commit: $PREVIOUS_COMMIT"
  echo "Latest commit: $LATEST_COMMIT"

  # Compare the previous and latest commit hashes
  if [ "$PREVIOUS_COMMIT" == "$LATEST_COMMIT" ]; then
    echo "No changes in the repository."
    exit 0
  fi
fi

# Save the latest commit hash to the current commit file
echo "$LATEST_COMMIT" > "$CURRENT_COMMIT_FILE"

# Clone or pull the repository
if [ -d "$INSTALL_DIR/.git" ]; then
  echo "Repository already exists. Pulling updates..."
  cd "$INSTALL_DIR"
  git pull
else
  echo "Cloning repository..."
  git clone "https://github.com/$REPO_OWNER/$REPO_NAME.git" "$INSTALL_DIR"
  cd "$INSTALL_DIR"
fi

echo "Installation complete."
