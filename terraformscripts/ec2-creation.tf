 variable "awsprops" {
    type = map
    default = {
    region = "us-east-1"
    vpc = "vpc-05e24a8891f346a4f" #vpc-05e24a8891f346a4f / devops-vpc
    ami = "ami-05723c3b9cf4bf4ff"
    itype = "t2.micro"
    subnet = "subnet-00711afa00bb04391" #subnet-00711afa00bb04391 / PubSN_Devops
    publicip = true
    keyname = "realkeypair"
    secgroupname = "Nexus-SGS"
  }
}  

provider "aws" {
  region = lookup(var.awsprops, "region")
}

resource "aws_security_group" "Nexus-SGS" {
  name = lookup(var.awsprops, "secgroupname")
  description = lookup(var.awsprops, "secgroupname")
  vpc_id = lookup(var.awsprops, "vpc")
 
  
  // To Allow SSH Transport
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
   
   // To Allow Port 80 Transport
  ingress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
   
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}
  
resource "aws_instance" "AWSEC2Instance" {
  ami = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  subnet_id = lookup(var.awsprops, "subnet")
  associate_public_ip_address = lookup(var.awsprops, "publicip")
  key_name = lookup(var.awsprops, "keyname")
 
tags = {
    Name ="tomcatserver"
  }
 
connection {
type        = "ssh"
host        = self.public_ip
user        = "ansible"
private_key = tls_private_key.deploy.realkeypair
    }
  }


/*resource "aws_key_pair" "realkeypair" {
 key_name = "realkeypair"
 public_key = ""

 //public_key = "${file("realkeypair.pub")}
 }
 */
 
 
/*output "instance_public_ip"{
 value = "${aws_instance.AWSEC2Instance.public_ip}"
 }
*/
 
 
 /*  
  root_block_device {
    delete_on_termination = true
    iops = 150
    volume_size = 10
    volume_type = "gp2"
  }
  
  depends_on = [ aws_security_group.AWSEC2Instance-Nexus-SGS ]
   
output "AWSEC2Instance" {
  value = aws_instance.AWSEC2Instance.public_ip
}
  */
 }









