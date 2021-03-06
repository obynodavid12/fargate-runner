variable "PAT_ACCESS_TOKEN" {}
variable "RUNNER_NAME" {}
variable "RUNNER_LABELS" {}
variable "RUNNER_REPOSITORY_URL" {}

variable "region" {
  description = "aws default region"
  type        = string
  default     = "us-east-2"
}

variable "profile" {
  default = "default"
}

variable "secret_retention_days" {
  default     = 0
  description = "Number of days before secret is actually deleted. Increasing this above 0 will result in Terraform errors if you redeploy to the same workspace."
}

variable "prefix" {
  default = "ecs-runner"
}

variable "vpc_cidr" {
  description = "CIDR for the VPC"
  default     = "172.31.0.0/16"
}

variable "private_subnet_cidr" {
  description = "CIDR for the Private Subnet"
  default     = "172.31.32.0/20"
}

variable "public_subnet_cidr" {
  description = "CIDR for the Public Subnet"
  default     = "172.31.48.0/20"
}

variable "fargate_cpu" {
  description = "Fargate instance CPU units to provision"
  type        = number
  default     = "256"
}

variable "fargate_memory" {
  description = "Fargate instance memory units to provision"
  type        = number
  default     = "512"
}

variable "ecr_repo_url" {
  description = "Docker image to be run in the ECS cluster"
  default     = "106878672844.dkr.ecr.us-east-2.amazonaws.com/ecs-runner:latest"
}
