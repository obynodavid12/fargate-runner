[
    {
      "name": "ecs-runner",
      "image": "${fargateapp_image}",
      "cpu": "${fargate_cpu}",
      "memory": "${fargate_memory}",
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
            "awslogs-region" : "us-east-2",
            "awslogs-group" : "/ecs/${var.prefix}-task-def",
            "awslogs-stream-prefix" : "ecs"
        }
      },
      "command": ["./start.sh"],
      "environment": [{
        "name": "PERSONAL_ACCESS_TOKEN",
        "value": "${var.PERSONAL_ACCESS_TOKEN}"
      },
      {
        "name": "REPO_OWNER",
        "value": "${var.REPO_OWNER}"
      },
      {
        "name": "REPO_NAME",
        "value": "${var.REPO_NAME}"
      },
      {
        "name": "AWS_DEFAULT_REGION",
        "value": "${var.AWS_DEFAULT_REGION}"
      },
      {
        "name": "AWS_SECRET_ACCESS_KEY",
        "value": "${var.AWS_SECRET_ACCESS_KEY}"
      },
      {
        "name": "AWS_ACCESS_KEY_ID",
        "value": "${var.AWS_ACCESS_KEY_ID}"
      }]
    }
  ]
  
