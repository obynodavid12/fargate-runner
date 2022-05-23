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

data "template_file" "fargate_app" {
  template = file("./templates/fargateapp.json.tpl")

  vars = {
    PERSONAL_ACCESS_TOKEN = "${var.PERSONAL_ACCESS_TOKEN}" # its env variable
    REPO_OWNER            = var.REPO_OWNER
    REPO_NAME             = var.REPO_NAME
    AWS_DEFAULT_REGION    = var.AWS_DEFAULT_REGION
    AWS_SECRET_ACCESS_KEY = var.AWS_SECRET_ACCESS_KEY
    AWS_ACCESS_KEY_ID     = var.AWS_ACCESS_KEY_ID
    prefix                = var.prefix
    fargate_cpu           = var.fargate_cpu
    fargate_memory        = var.fargate_memory
  }
}


resource "aws_ecs_task_definition" "task_definition" {
  family                   = "${var.prefix}-task-def"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 512
  memory                   = "1024"
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  container_definitions    = data.template_file.fargate_app.rendered

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
}

# Autoscaling
resource "aws_appautoscaling_target" "dev_to_target" {
  max_capacity       = 2
  min_capacity       = 1
  resource_id        = "service/${aws_ecs_cluster.ecs_cluster.name}/${aws_ecs_service.ecs_service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "dev_to_memory" {
  name               = "dev-to-memory"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.dev_to_target.resource_id
  scalable_dimension = aws_appautoscaling_target.dev_to_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.dev_to_target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }

    target_value = 80
  }
}

resource "aws_appautoscaling_policy" "dev_to_cpu" {
  name               = "dev-to-cpu"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.dev_to_target.resource_id
  scalable_dimension = aws_appautoscaling_target.dev_to_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.dev_to_target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }

    target_value = 60
  }
}

