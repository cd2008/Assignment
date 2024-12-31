# part_1
Develop an HTTP service in any programming language of your choice. The service should  expose the following endpoint:
# S3 Bucket Content Listing Service

This project provides a simple HTTP service built using Flask to list the contents of an Amazon S3 bucket. The service uses the AWS SDK for Python (Boto3) to interact with Amazon S3 and list the objects and folders (prefixes) stored in the specified S3 bucket. The service exposes an API to retrieve the contents, which can be filtered by a specified path within the bucket.

## Features

- List the contents (files and directories) of an S3 bucket.
- Support for listing objects under a specific directory (prefix).
- Handles AWS credentials using the AWS CLI configuration (`aws configure`).
- Error handling for missing or invalid AWS credentials.
- Flexible API endpoints to list content at various levels of the S3 bucket hierarchy.

## Requirements

- Python 3.x
- AWS account with access to S3 and valid AWS credentials configured via AWS CLI (`aws configure`).
- Flask (`pip install Flask`)
- Boto3 (`pip install boto3`)
