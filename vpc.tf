# VPC
# 
data "aws_vpc" "selected" {
  id = var.vpc_id
}

data "aws_security_group" "selected" {
  id = var.security_group_id
  filter {
    name = "vpc-id"
    values = [var.vpc_id]
  }
}