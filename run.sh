#!/bin/bash

WEBSITE_FILE="websites.txt"
SCREENSHOT_DIR="screenshots"

SMTP_SERVER="smtp.gmail.com"
SMTP_PORT="587"
SMTP_USER="nuwanovitigala@gmail.com"
SMTP_PASS="zwvxmkcboebmvpjx"

TO_EMAIL="receiver@gmail.com"

mkdir -p $SCREENSHOT_DIR

while true
do
    while IFS= read -r WEBSITE
    do
        if [ -z "$WEBSITE" ]; then
            continue
        fi

        TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

        SAFE_NAME=$(echo "$WEBSITE" | sed 's|https\?://||g' | sed 's|/|_|g')

        IMAGE_FILE="${SCREENSHOT_DIR}/${SAFE_NAME}_${TIMESTAMP}.png"

        echo "Taking screenshot of $WEBSITE"

        node screenshot.js "$WEBSITE" "$IMAGE_FILE"

        echo "Sending email..."

        python3 send_mail.py "$WEBSITE" "$IMAGE_FILE"

        echo "Waiting 5 minutes..."
        sleep 300

    done < "$WEBSITE_FILE"
done
