#
# DO NOT DELETE THESE LINES!
#
# Your AMI ID is:
#
#     ami-eea9f38e
#
# Your subnet ID is:
#
#     subnet-b30f9ceb
#
# Your security group ID is:
#
#     sg-834d35e4
#
# Your Identity is:
#
#     autodesk-wallaby
#

terraform {
  backend "atlas" {
    name = "johnbigby/training"
  }
}

variable "num_webs" {
  default = "3"
}

variable "aws_access_key" {}

variable "aws_secret_key" {}

variable {
  default = "2"
}

variable "aws_region" {
  default = "us-west-1"
}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

resource "aws_instance" "web" {
  count                  = "${var.num_webs}"
  ami                    = "ami-eea9f38e"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-b30f9ceb"
  vpc_security_group_ids = ["sg-834d35e4zzzz"]

  tags {
    Identity = "autodesk-wallaby"
    Country  = "autodesk-australia"
    Species  = "autodesk-marsupial"
    Name     = "web ${count.index+1}/${var.num_webs}"
  }
}

output "public_ip" {
  value = ["${aws_instance.web.*.public_ip}"]
}

output "public_dns" {
  value = ["${aws_instance.web.*.public_dns}"]
}
