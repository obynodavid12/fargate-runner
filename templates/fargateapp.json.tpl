[
    {
      "name": "ecs-runner",
      "image": "${ecr_repo_url}",
      "cpu": ${fargate_cpu},
      "memory": ${fargate_memory},
      "essential": true,
      "network_mode": "awsvpc",
      "portMappings": [
        {
          "containerPort": 80
        } 
      ],
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
            "awslogs-region": "us-east-2",
            "awslogs-group": "/ecs/${var.prefix}-task-def",
            "awslogs-stream-prefix": "ecs" 
        
        }
      },
      "command": ["./start.sh"],
      "secrets": [
        {"name": "PERSONAL_ACCESS_TOKEN", "valueFrom": "${aws_secretsmanager_secret.PERSONAL_ACCESS_TOKEN.arn}"},
        {"name": "AWS_SECRET_ACCESS_KEY", "valueFrom": "${aws_secretsmanager_secret.AWS_SECRET_ACCESS_KEY.arn}"},
        {"name": "AWS_ACCESS_KEY_ID", "valueFrom": "${aws_secretsmanager_secret.AWS_ACCESS_KEY_ID.arn}"},
        {"name": "AWS_DEFAULT_REGION", "valueFrom": "${aws_secretsmanager_secret.AWS_DEFAULT_REGION.arn}"}
      ],
      "environment": [
        {"name": "REPO_OWNER", "value": "${var.REPO_OWNER}"},
        {"name": "REPO_NAME", "value": "${var.REPO_NAME}"}
      ]
       
    }
  ]
  