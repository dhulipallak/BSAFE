variable "aws_access_key" {
    default = "ASIARIWUZPUV25RLN3HS"
}
variable "aws_secret_key" {
    default = "xzgQy6dfKxiw1wYZhTXZIrh3hMP30dKoK2FWYflv"
}
variable "aws_key_path" {
    default = "/home/ankitchanpuriag/capstone_project/ec2_instance/capstone_project.pem"
}
variable "aws_key_name" {
    default = "capstone_project.pem"
}
variable "aws_security_token" {
    default = "FwoGZXIvYXdzEJj//////////wEaDBJHyrb4Ssa44BNKviK5AZsz7IQ/HuoIYhzmBw1J3OYy2PEb3nnZOUWpeqJ75Kp/EL9B75xJrzLZAFh9dOAsWdG0Q8JPeTIHhmmoG7XZQiRsCIjDtoeM+Nxj5VGxPxN7+h+UFD4FfzL/QxX17hnN0fcdvuRsEHYkVeHmaEiBc84GUd9FjIHIVhhuMJ3ZNxF4tFHdhDPEmRqo4mKcZeyGsoSuxC1curRTX4viRY/tWrLke6ifz5MNdYdm5rkjqBQm8Q8G7mS+/y+jKMGSrJgGMi1snYYG4NYYG2T1DOQEuvrX6RoZsnIN2/hF5hzq57SuKg+Yk1i9BhexWasenhg="
}

variable "aws_region" {
    description = "EC2 Region for the VPC"
    default = "us-east-1"
}

variable "amis" {
    description = "AMIs by region"
    default = {
        us-east-1 = "ami-09e67e426f25ce0d7"
    }
}

variable "vpc_cidr" {
    description = "CIDR for the whole VPC"
    default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
    description = "CIDR for the Public Subnet"
    default = "10.0.0.0/24"
}

variable "private_subnet_cidr" {
    description = "CIDR for the Private Subnet"
    default = "10.0.1.0/24"
}

variable "jenkins_server_private_ip" {
  default = "172.31.18.230"
}
