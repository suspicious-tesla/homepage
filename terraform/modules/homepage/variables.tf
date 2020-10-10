variable "project" {
  description = "The project name"
  type        = string
}

variable "stack" {
  description = "The stack name"
  type        = string
  default     = "skill_matrix"
}

variable "environment" {
  description = "The environment name ['dev', 'prd']"
  type        = string
}

variable "homepage_url" {
  description = "The url to deploy the homepage to"
  type        = string
}

variable "domain_name" {
  description = "The url to deploy the homepage to"
  type        = string
}

variable "terragrunt_dir" {
  description = "The directory Terragrunt is running in for relative paths"
  type        = string
}
