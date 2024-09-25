# CircleCI Runner Cloud Init - Linux

## Overview
This directory contains CloudFormation templates and `cloud-init` scripts designed to automate the installation and configuration of CircleCI self-hosted runners on Linux-based environments. The scripts and templates are intended to provide a simple and scalable solution for deploying CircleCI runners across various Linux distributions.

## Structure
The `linux` directory is organized into subfolders that target different installation methods and Linux distributions. Here’s a breakdown of each folder and its purpose:

### 1. **deb**
   - Contains a `cloud-init` script specifically designed for **Debian**-based systems like Ubuntu and Debian.
   - The script automates the process of installing and configuring CircleCI runners using the `apt` package manager.

### 2. **rpm**
   - Contains a `cloud-init` script targeted at **RPM**-based systems, such as RHEL and CentOS.
   - It handles the installation and setup of CircleCI runners using the `yum` package manager.

### 3. **universal**
   - This folder contains a universal `cloud-init` script that can handle both **RPM**-based and **DEB**-based systems automatically.
   - It detects the package manager available on the system and installs CircleCI runners accordingly. It supports **Ubuntu**, **Debian**, **RHEL**, and **CentOS** out of the box.
   - Recommended for most users who want a flexible solution without worrying about distro-specific scripts.

### 4. **other** (WIP)
   - This folder is a work in progress and is intended for **manual installation** of the CircleCI runner on systems that support `cloud-init` but are not covered by the other scripts (e.g., less common or customized Linux distributions).
   - Currently, this script is not fully implemented, but will eventually serve as a more flexible, generic installation method.

### 5. **linux-template.yml**
   - This is the **CloudFormation template** that wraps the `cloud-init` scripts, making it easy to deploy CircleCI runners on Linux EC2 instances through AWS.
   - The template supports different instance types, security groups, and allows customization of the `cloud-init` script used for provisioning.

## Usage

### Using Cloud Init Scripts
- **Universal (Recommended)**: For most common Linux distributions, you can use the `cloud-init` script found in the `universal` folder. This script will automatically detect the correct package manager (APT or YUM) and install the CircleCI runner.
- **DEB-based Systems**: If you are specifically targeting Ubuntu or Debian, you can use the script in the `deb` folder.
- **RPM-based Systems**: For RHEL or CentOS, use the `cloud-init` script in the `rpm` folder.

For more information on how to use `cloud-init` with AWS, check out the official AWS documentation [here](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/user-data.html).

### Deploying with CloudFormation
You can quickly deploy a CircleCI runner on a Linux EC2 instance using the CloudFormation template. Simply click [this link to launch the template](https://us-east-1.console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/quickcreate?templateURL=https%3A%2F%2Faws-ambassador-labs.s3.amazonaws.com%2Flinux-template.yml&stackName=CircleCI-Runner-Linux&param_AMIId=ami-0e86e20dae9224db8&param_VpcID=&param_EC2Name=&param_SubnetID=&param_InstanceType=t2.micro&param_EC2KeyPair=), fill in the required parameters, and hit "Create Stack" to get started with a pre-configured runner.