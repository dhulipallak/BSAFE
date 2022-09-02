
# Main VPC Test

resource "aws_vpc" "main_vpc" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true
    tags = {
        Name = "terraform-aws-vpc"
    }
}

resource "aws_subnet" "us-east-1a-public" {
    vpc_id = "${aws_vpc.main_vpc.id}"

    cidr_block = "${var.public_subnet_cidr}"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = "true"


    tags = {
        Name = "Public Subnet"
    }
}

# Security group

resource "aws_security_group" "allow-ssh" {
  vpc_id      = "${aws_vpc.main_vpc.id}"
  name        = "allow-ssh"
  description = "security group that allows ssh and all egress traffic"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow-ssh"
  }
}

# Internet Gateway

resource "aws_internet_gateway" "ig-main" {
    vpc_id = "${aws_vpc.main_vpc.id}"
}

# Route Table

resource "aws_route_table" "us-east-1a-public" {
    vpc_id = "${aws_vpc.main_vpc.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.ig-main.id}"
    }

    tags = {
        Name = "Public Subnet"
    }
}

# Route table association

resource "aws_route_table_association" "us-east-1a-public" {
    subnet_id = "${aws_subnet.us-east-1a-public.id}"
    route_table_id = "${aws_route_table.us-east-1a-public.id}"
}

# Web Server & Remote-Exec

resource "aws_instance" "worker-1" {
    #instance = "${aws_instance.web-1.id}"
    ami = "ami-09e67e426f25ce0d7"
    instance_type = "t2.micro"
    key_name = "capstone_project"
    subnet_id = "${aws_subnet.us-east-1a-public.id}"
    user_data ="${data.template_file.install_expect.rendered}"
    vpc_security_group_ids = [aws_security_group.allow-ssh.id]

provisioner "file" {
    source      = "/home/ankitchanpuriag/capstone_project/ec2_instance/expect_script.sh"
    destination = "/tmp/expect_script.sh"
  }

provisioner "file" {
    source      = "/home/ankitchanpuriag/capstone_project/ec2_instance/jenkins_worker_setup.sh"
    destination = "/tmp/jenkins_worker_setup.sh"
  }

  provisioner "local-exec" {
    command = "./scp_to_target.sh ${aws_instance.worker-1.public_ip}"
  }

  provisioner "remote-exec" {
    inline = [
	  "sudo chmod 700 /home/jenkins/.ssh",
      "sudo chown jenkins:jenkins /home/jenkins/.ssh/authorized_keys",
    ]
  }

connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu"
    private_key = file("/home/ankitchanpuriag/capstone_project/ec2_instance/capstone_project.pem")
    # Default timeout is 5 minutes
    timeout     = "4m"
  }

tags = {
    Name ="captstone_worker1"
    Environment = "DEVOPS"
    OS = "UBUNTU"
    Managed = "IAC"
  }
}

data "template_file" "install_expect" {
template = file("install_expect.sh")
}

