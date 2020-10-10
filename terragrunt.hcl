locals {
  aws_region  = "eu-west-1"
  project     = "suspicious-tesla"
  stack       = "homepage"
  domain_name = "jameshaughey.net"
}

# Generate a Terraform versions block
generate "terraform" {
  path      = "terraform.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.1"
    }
  }
  required_version = ">= 0.13"
}
EOF
}

# Generate an AWS provider block
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  region  = "${local.aws_region}"
}
EOF
}



# Configure Terragrunt to automatically store tfstate files in an S3 bucket
remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    bucket = "cirrius-backend-tfstate-global"

    key            = "${local.project}/${path_relative_to_include()}/terraform.tfstate"
    region         = local.aws_region
    encrypt        = true
    dynamodb_table = "cirrius-backend-locks-global"
  }
}
