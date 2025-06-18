provider "aws" {
  region = "us-east-1"

}

resource "aws_instance" "ec2_instance" {
  ami           = "ami-0f88e80871fd81e91"
  instance_type = "t2.micro"
  tags = {
    Name = "chitti_robo"
  }
}

resource "aws_instance" "docker_host" {
  ami           = "ami-0f88e80871fd81e91" # Use the latest Amazon Linux 2 AMI
  instance_type = "t2.micro"

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo amazon-linux-extras install docker -y
              sudo service docker start
              sudo usermod -aG docker ec2-user
              sudo chkconfig docker on
              echo "Docker installed and started."
            EOF

  tags = {
    Name = "chitti_robo"
  }
}

