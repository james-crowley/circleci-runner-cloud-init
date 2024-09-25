# CircleCI Runner Cloud Init - macOS

## Overview
This directory contains automation scripts and CloudFormation templates for deploying CircleCI self-hosted runners on macOS EC2 instances. The provided resources aim to simplify the process of setting up macOS-based CircleCI runners in AWS by using `ec2-macos-init` and `cloud-init`.

## Structure
The `macos` directory contains the following files:

### 1. **userdata.sh**
   - This script is a **cloud-init** compatible script designed to install and configure CircleCI runners on macOS EC2 instances during the boot process.
   - The script is executed automatically when a macOS VM instance is started and handles the full installation and setup of the CircleCI runner, ensuring it is ready for use without manual intervention.

### 2. **macos-template.yml**
   - This is the **CloudFormation template** that automates the provisioning of macOS EC2 instances with the CircleCI runner pre-configured.
   - The template leverages `ec2-macos-init` for bootstrapping the macOS instances, and it integrates the `userdata.sh` script for the CircleCI runner installation.
## Usage

### Using the `userdata.sh` Script
- The `userdata.sh` script should be used in combination with the `ec2-macos-init` tool provided by AWS. When launching a macOS EC2 instance, this script is passed as **user data** to automatically install and configure the CircleCI runner during the instance's startup.

For more information on using `ec2-macos-init` and passing user data to macOS instances, refer to the [AWS EC2 macOS Init Documentation](https://github.com/aws/ec2-macos-init).