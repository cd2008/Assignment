import boto3
from flask import Flask, jsonify, request
from botocore.exceptions import NoCredentialsError, PartialCredentialsError
import os

app = Flask(__name__)

# Use AWS CLI credentials automatically (credentials stored via 'aws configure')
s3 = boto3.client(
    's3',
    region_name='ap-southeast-1'  # Replace with your AWS region if needed
)

# Define the name of your S3 bucket
BUCKET_NAME = 'part1httpservice'

# Function to list content in S3 for the given path
def list_s3_content(path=''):
    try:
        # If path is provided, list the objects within that path
        if path:
            response = s3.list_objects_v2(Bucket=BUCKET_NAME, Prefix=path, Delimiter='/')
        else:
            # If no path is specified, list the top-level contents
            response = s3.list_objects_v2(Bucket=BUCKET_NAME, Delimiter='/')

        contents = []
        if 'CommonPrefixes' in response:
            for prefix in response['CommonPrefixes']:
                contents.append(prefix['Prefix'].split('/')[-2])  
        if 'Contents' in response:
            for obj in response['Contents']:
                contents.append(obj['Key'].split('/')[-1])  

        return {"content": contents}

    except (NoCredentialsError, PartialCredentialsError):
        return {"error": "AWS credentials not found. Please ensure AWS CLI is configured correctly."}
    except Exception as e:
        return {"error": str(e)}

@app.route('/list-bucket-content', methods=['GET'])
@app.route('/list-bucket-content/<path>', methods=['GET'])
def list_bucket_content(path=''):
    """Endpoint to list S3 bucket content for a given path."""
    result = list_s3_content(path)
    return jsonify(result)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)

