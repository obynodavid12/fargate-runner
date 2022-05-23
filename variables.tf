variable "PERSONAL_ACCESS_TOKEN" {
  description: "GitHub personal access token"  
  type = string
}
variable "REPO_OWNER" {
  default = "obynodavid12"
}
variable "REPO_NAME" {
  default = "fargate-runner"
}
variable "AWS_DEFAULT_REGION" {
  default = "us-east-2"
}

variable "AWS_SECRET_ACCESS_KEY" {
  default = ""
}

variable "AWS_ACCESS_KEY_ID" {
  default = ""
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

