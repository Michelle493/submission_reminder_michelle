# Submission Reminder App

This application helps track student assignment submissions and sends reminders for pending submissions.

## How to Run

1. First, make the script runnable:
```bash
chmod +x create_environment.sh
```
2. Then, run the script
```bash
./create_envionment.sh
```
3. Go to the created folder:
```bash
cd submission_reminder_michelle
```
4. Start the script:
```bash
./startup.sh
```

## Folders

```
submission_reminder_michelle/
├── app/
│   └── reminder.sh
├── modules/
│   └── functions.sh
├── assets/
│   └── submissions.txt
├── config/
│   └── config.env
└── startup.sh
```

## Files Description

- `reminder.sh`: Main application logic for checking submissions and sending reminders
- `startup.sh`: Script to start the application and handle periodic execution
- `config.env`: Configuration settings for the application
- `functions.sh`: Helper functions used by the application
- `submissions.txt`: Database of student submissions and their status
