# Based on HashiCorp learn-terraform-sentinel (MPL-2.0, Copyright (c) 2020 HashiCorp, Inc.)
# https://github.com/hashicorp-education/learn-terraform-sentinel
# Modified: removed remote backend and unused random provider; pinned aws provider to the 6.x series.

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  required_version = ">= 1.3"
}
