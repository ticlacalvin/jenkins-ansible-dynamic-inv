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

resource "aws_key_pair" "realkeypair" {
 key_name = "realkeypair"
 public_key = "-----BEGIN RSA PRIVATE KEY-----
MIIEogIBAAKCAQEAvfqtvCKlBpH3obpTluhf4OrNdsIk/JbMS1xHdXLqN0SpHLSF
TRapJXz4oEZQSrmfnMbwQYNWsv77e8NJ50S0tsKnz/f2qXtiJhNiZLcEvkG9H0Mr
WXL0PxF6hA6kQNHkI681g66VLV4oG3u+6rfZ7C95eZlxrZYUPTzLbsJ2bRv3vzm7
pgcoWz3hn9qH3tUh/Tr3TROAcsZSiACRGYKK+/yICfoLZ5zTj4HHqGuMKHLeHb9Z
JhkvImdvp27ErjtLHeILN/zp0PtIEZDorTCFMYx954kltIh5xE3UOmkm7DZIKeB8
srtGzsR8hVkJGVKwdqDDCieRhSMn6q+k0iPZNwIDAQABAoIBAAluxu2Ocs8utDLt
g3T8uLX8MpNw9FEuU5pyTIICYKq52AO62tuHAoL//4BFvXrYWJp6Ljeyg72Dd40f
ly3KdYaVh6uFzlN/8tGdKMeDZtLjhLZmqWJZmNMA1Sp1Z6ZoRYGYE3okUvfbsvYa
YNJaqpFVkhx9h+1shDi+KgOn2CV2pfnx2ScO124wEUEdJFYX8wYxkD7GNsblGAZz
vMpT88MWzfFExIVLc5ZDncJ2Pm2j/59nAfz/JYiLaMucWzeZIghgbKofcql4PYB6
+3PN6cEJs08oumD8EZG/0upF4ocR4bYGyCa3i+jEompgVbEPyj+G0F8zphk+JaOW
EHxVIWECgYEA+I07Nhbyvc+bLpoPSTTUkXb022TpJ836xOlYo5U5Rto/2HYbwSri
JKC9Cs8fNRwAIsowmpylKhlTLPV2/7bG4yonAFFVVwcgbBHSEh1u4U4iNxifCK9F
gZU6LFj5f+ymUm+/rZ0I6pYiY6fn+CyN5wzaNuxHX86vLb7NG3NScG8CgYEAw6wb
i08yvs0hZ+BQjyCeItgMA6YzqjfsNWKRpPnDrF6VvZNXJbpzLe6sgTWAgiuRoRjR
gaTmNdYuvxMdyB36BVXguTIr1rBzkJL7a9HkIilRtBhkP9D86E5vpnT2bxDWi9db
AzSPYWOLqTpfmHI85Sjdr1xXC2hkBBrqPagDd7kCgYB7LYr9qGvOc7fFZaZTsnHy
UVDR9fWyu1sfAUHjeA21tm3TudzRY45Fdr+ZPsKJkIHku+1Qgnc8IOberhu2aP+y
Du7bMnOnuKlxxXclcR7FW/KK+ZG/PRWmPa1h0wp7Qm2/BxCoWt3TXGpYlxrYHESL
EAyJEZnhuk2IzzlY9FMT0wKBgAFipo9F8EYJjcL+g5N/157HiM49zv/VhYabPAy+
9/Owd77v3B4YQ9h/aBlCF7bUOCO72T/huv+GlK4lpIBWNf7zrLOi90x901OitsT8
p3DWeg2cXplVEXVTmNbE3TnMFLjIvYw4QwudeM+p6iNaK7Qzpd4n+TXLd2nQBviI
x/2BAoGADLZOK+yZ11UUkyajTM7qoiSm1sXGXViWdht2iegpttZhxLFsKlt1U3HG
JjZ7XMwUKKSb2uR4cKOW497G5ysAtLWfZGcBKuNW0AY2Wmf8iEDl2onReS7LCDZ7
pKkYxMaq8NyZzqA10ljTNQEnWqVw3VyKT7VcCEKMGcHyN8tUrjw=
-----END RSA PRIVATE KEY-----"
 //public_key = "${file("realkeypair.pub")}
 
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









