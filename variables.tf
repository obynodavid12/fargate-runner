variable "RUNNER_ACCESS_TOKEN" {
  description = "GitHub personal access token"
  type        = string
  default     = ""
}

# variable "AWS_DEFAULT_REGION" {
#   description = "aws default region"
#   type        = string
#   default     = "us-east-2"
# }


# variable "AWS_SECRET_ACCESS_KEY" {
#   description = "aws secret access token"
#   type        = string
#   default     = ""
# }

# variable "AWS_ACCESS_KEY_ID" {
#   description = "aws access key"
#   type        = string
#   default     = ""
# }

variable "REPO_OWNER" {
  default = "obynodavid12"
}
variable "REPO_NAME" {
  default = "fargate-runner"
}

variable "prefix" {
  default = "ecs-runner"
}

variable "vpc_id" {
  description = "VPC ID"
  default     = "vpc-096711145f4fb2bd6"
}

variable "private_subnet_ids" {
  description = "Private Subnet"
  type = list(string)
  default     = ["subnet-0009935232387340e","subnet-0261ff6eaa616becb"]
}

# variable "public_subnet_cidr" {
#   description = "CIDR for the Public Subnet"
#   default     = "172.31.48.0/20"
# }

variable "security_group_id" {
  default = "sg-0b543d3055cffedfb"
}
# variable "fargate_cpu" {
#   description = "Fargate instance CPU units to provision"
#   type        = number
#   default     = "256"
# }

# variable "fargate_memory" {
#   description = "Fargate instance memory units to provision"
#   type        = number
#   default     = "512"
# }

# variable "ecr_repo_url" {
#   description = "Docker image to be run in the ECS cluster"
#   default     = "106878672844.dkr.ecr.us-east-2.amazonaws.com/ecs-runner:latest"
# }

