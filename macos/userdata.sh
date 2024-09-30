#!/bin/bash

# Set variables
RUNNER_AUTH_TOKEN="your-runner-auth-token"  # Replace this with your actual auth token
USER_NAME="ec2-user"  # Replace this with your actual user
USER_HOME=$(eval echo "~$USER_NAME")  # Dynamically fetch the home directory of the specified user

# Fetch the AWS instance ID securely using a generated token
TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
INSTANCE_NAME=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/instance-id)

# Run Homebrew commands as the specified user
sudo -u $USER_NAME -i <<EOF

brew install coreutils
brew tap circleci-public/circleci
brew install circleci-runner

EOF

# Update config file with actual instance name and runner auth token
sed -i '' "s/\[\[RUNNER_NAME\]\]/$INSTANCE_NAME/g; s/\[\[RESOURCE_CLASS_TOKEN\]\]/$RUNNER_AUTH_TOKEN/g" "$USER_HOME/Library/Preferences/com.circleci.runner/config.yaml"

# Remove the quarantine attribute to accept the notarization of the CircleCI runner
spctl -a -vvv -t install "/opt/homebrew/bin/circleci-runner"
sudo xattr -r -d com.apple.quarantine "/opt/homebrew/bin/circleci-runner"

# Move the CircleCI launch agent to the correct location
sudo mv "$USER_HOME/Library/LaunchAgents/com.circleci.runner.plist" "/Library/LaunchAgents/"

# Enable and start the CircleCI runner service using updated launchctl commands
launchctl bootstrap user/$(id -u "$USER_NAME") /Library/LaunchAgents/com.circleci.runner.plist
launchctl enable user/$(id -u "$USER_NAME")/com.circleci.runner
launchctl kickstart -k user/$(id -u "$USER_NAME")/com.circleci.runner
launchctl print user/$(id -u "$USER_NAME")/com.circleci.runner  # Verify that the service is running

echo "CircleCI runner setup complete!"