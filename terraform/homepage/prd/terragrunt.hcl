# ---------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# Terragrunt is a thin wrapper for Terraform that provides extra tools for working with multiple Terraform modules,
# remote state, and locking: https://github.com/gruntwork-io/terragrunt
# ---------------------------------------------------------------------------------------------------------------------

locals {
  # Automatically load account-level variables
  common_vars = read_terragrunt_config(find_in_parent_folders("terragrunt.hcl"))

  project = local.common_vars.locals.project
  stack   = local.common_vars.locals.stack
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  source = "../../modules//homepage"
}

inputs = {
  project        = local.project
  stack          = local.stack
  environment    = "prd"
  homepage_url   = "jameshaughey.net"
  domain_name    = local.common_vars.locals.domain_name
  terragrunt_dir = get_terragrunt_dir()
}
