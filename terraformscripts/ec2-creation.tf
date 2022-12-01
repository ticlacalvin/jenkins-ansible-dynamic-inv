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

 variable "awsprops" {
    type = "map"
    default = {
    region = "us-east-1"
    vpc = "vpc-05e24a8891f346a4f"
    ami = "ami-05723c3b9cf4bf4ff"
    itype = "t2.micro"
    subnet = "subnet-00711afa00bb04391"
    publicip = true
    keyname = "realkeypair"
    secgroupname = "Nexus-SG"
  }
}  

provider "aws" {
  region = lookup(var.awsprops, "region")
}

resource "aws_security_group" "Nexus-SG" {
  name = lookup(var.awsprops, "secgroupname")
  description = lookup(var.awsprops, "secgroupname")
  vpc_id = lookup(var.awsprops, "vpc")
   
  // To Allow SSH Transport
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["10.0.0.0/16"]
  }
   
   // To Allow Port 80 Transport
  ingress {
    from_port = 80
    protocol = ""
    to_port = 80
    cidr_blocks = ["10.0.0.0/16"]
  }
   
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["10.0.0.0/16"]
  }

  lifecycle {
    create_before_destroy = true
  }
}
  
resource "aws_instance" "AWSEC2Instance" {
  ami = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  subnet_id = lookup(var.awsprops, "subnet") #FFXsubnet2
  associate_public_ip_address = lookup(var.awsprops, "publicip")
  key_name = lookup(var.awsprops, "keyname")
 
   
vpc_security_group_ids = [
    aws_security_group.AWSEC2Instance-Nexus-SG.id
  ]
  root_block_device {
    delete_on_termination = true
    iops = 150
    volume_size = 10
    volume_type = "gp2"
  }
   
tags = {
    Name ="tomcatserver"
  }
  
  depends_on = [ aws_security_group.AWSEC2Instance-Nexus-SG ]
   
output "ec2instance" {
  value = aws_instance.AWSEC2Instance.public_ip
}
   
 }









/*
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
  #subnet_id = aws_subnet.PubSN_Devops.id
  vpc_security_group_ids = [
   aws_security_group.Nexus-SG.id
  ]

  tags = {
    Name = "tomcatserver"
  }
}
*/
