variable "PERSONAL_ACCESS_TOKEN" {}
variable "REPO_OWNER" {}
variable "REPO_NAME" {}
variable "AWS_DEFAULT_REGION" {}
variable "AWS_SECRET_ACCESS_KEY" {}
variable "AWS_ACCESS_KEY_ID" {}

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