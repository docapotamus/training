#
# DO NOT DELETE THESE LINES!
#
# Your AMI ID is:
#
#     ami-b87299c1
#
# Your subnet ID is:
#
#     subnet-1db13054
#
# Your security group ID is:
#
#     sg-b2a021ca
#
# Your Identity is:
#
#     Idol-training-human
#

terraform {
  backend "atlas" {
    name = "docapotamus/state"
  }
}

variable "aws_access_key" {}

variable "aws_secret_key" {}

variable "aws_region" {
  default = "eu-west-1"
}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

resource "aws_instance" "web" {
  ami                    = "ami-b87299c1"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-1db13054"
  vpc_security_group_ids = ["sg-b2a021ca"]

  count = 2

  tags {
    Identity = "Idol-training-human"
    Name     = "Joe's machine"
    Company  = "theidol"
    Index    = "${count.index}"
  }
}

output "public_dns" {
  value = "${aws_instance.web.*.public_dns}"
}

output "public_ip" {
  value = "${aws_instance.web.*.public_ip}"
}

output "index_counts" {
  value = "${aws_instance.web.*.tags.Index}"
}
