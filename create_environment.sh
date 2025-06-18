#!/bin/bash

# Prompt the user for their name
read -p "Enter your name: " username

# Create the main directory
main_dir="submission_reminder_${username}"
mkdir -p "${main_dir}"

# Create subdirectories
mkdir -p "${main_dir}/app"
mkdir -p "${main_dir}/modules"
mkdir -p "${main_dir}/assets"
mkdir -p "${main_dir}/config"

# Create files with their content
# 1. app/reminder.sh
cat > "${main_dir}/app/reminder.sh" << 'EOF'
#!/bin/bash

# Source environment variables and helper functions
source ./config/config.env
source ./modules/functions.sh

# Path to the submissions file
submissions_file="./assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions $submissions_file
EOF

# 2. modules/functions.sh
cat > "${main_dir}/modules/functions.sh" << 'EOF'
#!/bin/bash

# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"

    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        # Check if assignment matches and status is 'not submitted'
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file") # Skip the header
}
EOF

# 3. config/config.env
cat > "${main_dir}/config/config.env" << 'EOF'
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOF

# 4. assets/submissions.txt
cat > "${main_dir}/assets/submissions.txt" << 'EOF'
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
Emmanuel, Shell Navigation, submitted
Grace, Git, not submitted
Frank, Shell Basics, not submitted
Sarah, Shell Navigation, not submitted
David, Git, submitted
Linda, Shell Basics, submitted
EOF

# 5. Create startup.sh
cat > "${main_dir}/startup.sh" << 'EOF'
#!/bin/bash

# Change to the app directory and run the reminder script
cd "$(dirname "$0")" || exit
./app/reminder.sh
EOF

# Make all .sh files executable
find "${main_dir}" -type f -name "*.sh" -exec chmod +x {} \;

echo "Environment setup complete in ${main_dir}/"
echo "You can now run the application by executing: ./${main_dir}/startup.sh"
