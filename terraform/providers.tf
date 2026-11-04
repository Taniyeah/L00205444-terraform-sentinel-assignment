# Based on HashiCorp learn-terraform-sentinel (MPL-2.0, Copyright (c) 2020 HashiCorp, Inc.)
# https://github.com/hashicorp-education/learn-terraform-sentinel
# Modified: provider block moved into its own file.

provider "aws" {
  region = var.region
}
