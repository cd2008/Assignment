# part_1
Develop an HTTP service in any programming language of your choice. The service should  expose the following endpoint:
# S3 Bucket Content Listing Service

This project provides a simple HTTP service built using Flask to list the contents of an Amazon S3 bucket. The service uses the AWS SDK for Python (Boto3) to interact with Amazon S3 and list the objects and folders (prefixes) stored in the specified S3 bucket. The service exposes an API to retrieve the contents, which can be filtered by a specified path within the bucket.

## Features

- List the contents (files and directories) of an S3 bucket.
- Support for listing objects under a specific directory (prefix).
- Handles AWS credentials using the AWS CLI configuration.
- Error handling for missing or invalid AWS credentials.
- Flexible API endpoints to list content at various levels of the S3 bucket hierarchy.

## Requirements

- Python 3.x
- AWS account with access to S3 and valid AWS credentials configured via AWS CLI.
- Flask 
- Boto3 
- Postman
  
--------------------------------------------------------------------------------------------------------------------------------------------------------------------

-  # part_2
-  AWS Infrastructure for HTTP Service with Flask App
This repository contains the Terraform code to set up the infrastructure required to deploy an HTTP service with a Flask app hosted on AWS. The infrastructure includes an EC2 instance, an S3 bucket, a security group, and IAM roles to allow the EC2 instance to interact with the S3 bucket.

Infrastructure Components
AWS S3 Bucket:

An S3 bucket is created to store and manage data for the application.
The bucket is named part1httpservice.
AWS EC2 Instance:

A small EC2 instance (t2.micro) is created and configured to run a Flask application.
The instance is provisioned with a user data script that installs dependencies such as Python, Git, and the necessary Python libraries, clones the Flask app repository, and starts the application on port 5000.
AWS Security Group:

A security group (http_service_sg) is created to allow HTTP traffic on port 80 from anywhere (0.0.0.0/0).
The security group allows inbound HTTP traffic on port 80 and unrestricted outbound traffic.
IAM Role and Policy:

An IAM role (ec2_s3_role) is created for the EC2 instance, allowing it to interact with S3.
A policy (AmazonS3FullAccess) is attached to the role, granting full access to S3 resources.
An IAM instance profile is created to attach the IAM role to the EC2 instance.
Prerequisites
Before running the Terraform code, ensure the following:

AWS Account: You need an AWS account with the necessary permissions to create EC2 instances, S3 buckets, IAM roles, and security groups.
SSH Key: Replace your-ssh-key-name in the Terraform script with the name of your existing SSH key pair for accessing the EC2 instance.
Flask App Repository: Ensure you have a valid Flask application repository URL for the git clone command in the user_data section.
