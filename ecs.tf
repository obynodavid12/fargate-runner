# ECR repository
resource "aws_ecr_repository" "ECR_repository" {
  name                 = var.prefix
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

# ECS cluster
resource "aws_ecs_cluster" "ecs_cluster" {
  name = "${var.prefix}-cluster"
  capacity_providers = [
  "FARGATE"]
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

# Task execution role for used for ECS
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "${var.prefix}_ecs_task_execution_role"

  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "ecs-tasks.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF
}

# Attach policy to task execution role
resource "aws_iam_role_policy_attachment" "ecs-task-execution-role-policy-attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy_attachment" "admin-policy-attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}


# Task definition
resource "aws_cloudwatch_log_group" "ecs-log-group" {
  name = "/ecs/${var.prefix}-task-def"

}

resource "aws_ecs_task_definition" "task_definition" {
  family                   = "${var.prefix}-task-def"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 512
  memory                   = "1024"
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  container_definitions    = <<TASK_DEFINITION
  [
    {
      "name": "ecs-runner",
      "image": "${var.ecr_repo_url}",
      "cpu": ${var.fargate_cpu},
      "memory": ${var.fargate_memory},
      "essential": true,
      "network_mode": "awsvpc",
      "portMappings": [],
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
            "awslogs-region": "us-east-2",
            "awslogs-group": "/ecs/${var.prefix}-task-def",
            "awslogs-stream-prefix": "ecs" 
        
        }
      },
      "entryPoint": ["/entrypoint.sh"],
      "command": ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"],
      "secrets": [
        {"name": "PAT", "valueFrom": "${aws_secretsmanager_secret.PAT.arn}"}
      ],
      "environment": [
        {"name": "RUNNER_REPOSITORY_URL", "value": "${var.RUNNER_REPOSITORY_URL}"},
        {"name": "RUNNER_NAME", "value": "${var.RUNNER_NAME}"},
        {"name": "RUNNER_LABELS", "value": "${var.RUNNER_LABELS}"}
      ]
       
    }
  ]
  TASK_DEFINITION
}

# A security group for ECS
resource "aws_security_group" "ecs_sg" {
  name        = "${var.prefix}-ecs-sg"
  description = "Allow incoming traffic for ecs"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.prefix}_ecs_sg"
  }
}

resource "aws_ecs_service" "ecs_service" {
  name            = "${var.prefix}-ecs-service"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.task_definition.arn
  desired_count   = "1"
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [aws_security_group.ecs_sg.id]
    subnets          = [aws_subnet.private_subnet.id]
    assign_public_ip = false
  }

  tags = {
    Name = "${var.prefix}_ecs_service"
  }
}