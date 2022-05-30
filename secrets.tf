# Secrets
resource "aws_secretsmanager_secret" "PAT" {
  name = "${var.prefix}-PAT"
}

resource "aws_secretsmanager_secret_version" "PAT" {
  secret_id     = aws_secretsmanager_secret.PAT.id
  secret_string = var.PAT
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
        "Resource": "${aws_secretsmanager_secret.PAT.arn}"
      }
    ]
  }
  EOF
}