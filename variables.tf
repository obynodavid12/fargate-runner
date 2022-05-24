variable "PERSONAL_ACCESS_TOKEN" {
  description = "GitHub personal access token"
  type        = string
  default     = ""
}

variable "AWS_DEFAULT_REGION" {
  description = "aws default region"
  type        = string
  default     = ""
}

variable "AWS_SECRET_ACCESS_KEY" {
  description = "aws secret access token"
  type        = string
  default     = ""
}

variable "AWS_ACCESS_KEY_ID" {
  description = "aws access key"
  type        = string
  default     = ""
}

variable "REPO_OWNER" {
  default = "obynodavid12"
}
variable "REPO_NAME" {
  default = "fargate-runner"
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
  default     = 256
}

variable "fargate_memory" {
  description = "Fargate instance memory units to provision"
  type        = number
  default     = 512
}

variable "ecr_repo_url" {
  description = "Docker image to be run in the ECS cluster"
  default     = "106878672844.dkr.ecr.us-east-2.amazonaws.com/ecs-runner:latest"
}

