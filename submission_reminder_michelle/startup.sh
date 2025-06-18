#!/bin/bash

# Change to the app directory and run the reminder script
cd "$(dirname "$0")" || exit
./app/reminder.sh
