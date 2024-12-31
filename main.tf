provider "aws" {
  region = "ap-southeast-1"
}


resource "aws_s3_bucket" "http_service_bucket" {
  bucket = "part1httpservice"  
}


resource "aws_security_group" "http_service_sg" {
  name        = "http_service_sg"
  description = "Allow HTTP traffic"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "http-service-sg"
  }
}


resource "aws_iam_role" "ec2_s3_role" {
  name = "ec2_s3_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}


resource "aws_iam_policy_attachment" "ec2_s3_policy_attachment" {
  name       = "ec2-s3-policy-attachment"
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  roles      = [aws_iam_role.ec2_s3_role.name]
}


resource "aws_instance" "http_service_instance" {
  ami           = "ami-0c55b159cbfafe1f0" 
  instance_type = "t2.micro"              
  key_name      = "your-ssh-key-name"     


  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update
              sudo apt-get install -y python3-pip
              sudo apt-get install -y python3-dev
              sudo apt-get install -y git
              git clone https://github.com/your-repository/your-flask-app.git
              cd your-flask-app
              pip3 install -r requirements.txt
              FLASK_APP=app.py flask run --host=0.0.0.0 --port=5000
              EOF

  tags = {
    Name = "http-service-instance"
  }
}


resource "aws_iam_instance_profile" "ec2_s3_profile" {
  name = "ec2_s3_profile"
  role = aws_iam_role.ec2_s3_role.name
}

output "http_service_public_ip" {
  value = aws_instance.http_service_instance.public_ip
}
