# Based on HashiCorp learn-terraform-sentinel (MPL-2.0, Copyright (c) 2020 HashiCorp, Inc.)
# https://github.com/hashicorp-education/learn-terraform-sentinel
# Modified: default region changed to eu-west-1 (Ireland).

variable "region" {
  description = "AWS region"
  default     = "eu-west-1"
}

variable "instance_type" {
  description = "Type of EC2 instance to provision"
  default     = "t2.micro"
}

variable "instance_name" {
  description = "EC2 instance name"
  default     = "Provisioned by Terraform"
}
