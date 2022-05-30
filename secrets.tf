# Secrets
resource "aws_secretsmanager_secret" "PAT_ACCESS_TOKEN" {
  name                    = "${var.prefix}-PAT_ACCESS_TOKEN"
  recovery_window_in_days = var.secret_retention_days
}

resource "aws_secretsmanager_secret_version" "PAT_ACCESS_TOKEN" {
  secret_id     = aws_secretsmanager_secret.PAT_ACCESS_TOKEN.id
  secret_string = var.PAT_ACCESS_TOKEN
}


# Giving a Fargate access to the Secrets in the Secret Manager
resource "aws_iam_role_policy" "password_policy_secretsmanager" {
  name = "password-policy-secretsmanager"
  role = aws_iam_role.ecs_task_execution_role.id

  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": [
          "secretsmanager:GetSecretValue"
        ],
        "Effect": "Allow",
        "Resource": "${aws_secretsmanager_secret.PAT_ACCESS_TOKEN.arn}"
      }
    ]
  }
  EOF
}