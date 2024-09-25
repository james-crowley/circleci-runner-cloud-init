# circleci-runner-cloud-init

## Overview
This repository contains automation scripts and CloudFormation templates designed to simplify the provisioning and management of CircleCI self-hosted runners across different operating systems. It aims to reduce the manual work required for deploying and maintaining CircleCI runners, providing a seamless experience for CircleCI users.

## Disclaimer
This repository is **not officially supported by CircleCI**. It has been created and maintained by CircleCI's Field Engineering team as a helpful resource for customers. While you are welcome to leverage the templates and code found here, **no support will be provided**.

## Problem Statement
CircleCI's self-hosted runners are a powerful solution for customers who need flexibility, control, and performance in their CI/CD pipelines. However, deploying and maintaining these runners manually can be time-consuming and error-prone, especially in large or complex environments.

The goal of this repository is to **eliminate the manual effort** involved in deploying and configuring CircleCI runners, providing automation that enables customers to easily manage their infrastructure while taking full advantage of CircleCI's capabilities.

## Technology
The repository leverages a combination of technologies to automate CircleCI runner deployments across Linux, Windows, and macOS environments:

- **Cloud-init**: Used to automate the setup and configuration of CircleCI runners on Linux and Windows EC2 instances.
- **macOS EC2 Init**: A specialized approach by AWS for automating installs of macOS.
- **PowerShell**: Integrated with cloud-init for Windows environments to automate runner installation and configuration.
- **CloudFormation Templates**: Wrapping these technologies in AWS CloudFormation templates for ease of deployment and management, enabling users to spin up runners with minimal effort.

## Repository Structure
The repository is organized into three main directories, each corresponding to one of the operating systems that CircleCI supports:

### 1. **Linux**
   - Contains CloudFormation templates and `cloud-init` scripts for automating the setup of CircleCI runners on Linux-based EC2 instances.
   - Includes instructions for supported distributions (Debian/Ubuntu and RHEL/CentOS).

### 2. **Windows** (WIP)
   - Includes `cloud-init` and PowerShell scripts to automate CircleCI runner installation on Windows-based EC2 instances.
   - Designed for seamless runner setup on Windows Server environments.

### 3. **macOS**
   - Contains templates and scripts for provisioning macOS-based EC2 instances, including ARM-based mac2.metal instances.
   - Supports Homebrew-based installations of CircleCI runners and management of Dedicated Hosts.

Each folder includes a `README.md` file with detailed instructions, usage tips, and configuration notes specific to that operating system.

## Usage
To get started, navigate to the folder that corresponds to your desired operating system, review the included `README.md`, and follow the instructions to deploy and configure your CircleCI runners using the provided templates and scripts.