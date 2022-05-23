variable "PERSONAL_ACCESS_TOKEN" {
  default = ""
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

variable "fargateapp_image" {
  description = "Docker image to run in the ECS cluster"
  default     = "106878672844.dkr.ecr.us-east-2.amazonaws.com/ecs-runner:latest"
}

variable "fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = "256"
}

variable "fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  default     = "512"
}

variable "demoapp_container_name" {
  description = "Application container name"
  default     = "demoapp-app"
}