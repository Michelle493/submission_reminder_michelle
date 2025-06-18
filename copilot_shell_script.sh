#!/bin/bash

# Check if the environment directory exists
if [ ! -d "submission_reminder_michelle" ]; then
    echo "Error: Environment directory not found. Please run create_environment.sh first."
    exit 1
fi

# Prompt user for new assignment name
read -p "Enter the new assignment name: " new_assignment

# Update the config.env file
config_file="submission_reminder_michelle/config/config.env"
sed -i "s/ASSIGNMENT=.*/ASSIGNMENT=\"${new_assignment}\"/" "$config_file"

echo "Assignment name updated to: ${new_assignment}"
echo "You can now check submissions for the new assignment by running: ./submission_reminder_michelle/startup.sh"
