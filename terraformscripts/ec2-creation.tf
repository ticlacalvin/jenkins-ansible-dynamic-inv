provider "aws"{
   region  = "us-east-1" 
}

resource "aws_instance" "AWSEC2Instance"{
     count   = 1
     ami = "ami-050c88925ffb2bb50"
     instance_type = "t2.micro"
     security_groups = ["Nexus-SG"]
     key_name        = "realkeypair"
     tags = {
        Name = "tomcatserver"
     }
}

