/*provider "aws" {
   region  = "us-east-1" 
}

resource "aws_instance" "AWSEC2Instance"{
     count   = 1
     ami = "ami-05723c3b9cf4bf4ff"
     instance_type = "t2.micro"
     security_groups = ["Nexus-SG"]
     key_name        = "realkeypair"
     tags = {
        Name = "tomcatserver"
     }
}
*/
   
provider "aws" {
  region = "us-east-1"
}


resource "aws_security_group" "Nexus-SG" {

  description = "Allow ssh inbound traffic"

  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.0.0/16"]
  }

}

resource "aws_vpc" "devops-vpc" {  
   cidr_block           = "10.0.0.0/16"
   instance_tenancy     = "default"  
   enable_dns_support   = "true"
   enable_dns_hostnames = "true"  
   enable_classiclink   = "false"
     tags = {    
        Name = "devops-vpc"  
  }
}
   

resource "aws_instance" "AWSEC2Instance" {
  ami           = "ami-05723c3b9cf4bf4ff"
  instance_type =  "t2.micro"
  key_name      = "realkeypair"
  subnet_id = aws_subnet.PubSN_Devops.id
  vpc_security_group_ids = [
   aws_security_group.Nexus-SG.id
  ]

  tags = {
    Name = "tomcatserver"
  }
}

