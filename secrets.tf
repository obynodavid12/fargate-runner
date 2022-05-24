# Secrets
resource "aws_secretsmanager_secret" "PERSONAL_ACCESS_TOKEN" {
  name = "${var.prefix}-PERSONAL_ACCESS_TOKEN"
}

resource "aws_secretsmanager_secret_version" "PERSONAL_ACCESS_TOKEN_version" {
  secret_id     = aws_secretsmanager_secret.PERSONAL_ACCESS_TOKEN.id
  secret_string = var.PERSONAL_ACCESS_TOKEN
}

# resource "aws_secretsmanager_secret" "REPO_OWNER" {
#   name = "${var.prefix}-REPO_OWNER"
# }

# resource "aws_secretsmanager_secret_version" "REPO_OWNER_version" {
#   secret_id     = aws_secretsmanager_secret.REPO_OWNER.id
#   secret_string = var.REPO_OWNER
# }

# resource "aws_secretsmanager_secret" "REPO_NAME" {
#   name = "${var.prefix}-REPO_NAME"
# }

# resource "aws_secretsmanager_secret_version" "REPO_NAME_version" {
#   secret_id     = aws_secretsmanager_secret.REPO_NAME.id
#   secret_string = var.REPO_NAME
# }

resource "aws_secretsmanager_secret" "AWS_DEFAULT_REGION" {
  name = "${var.prefix}-AWS_DEFAULT_REGION"
}

resource "aws_secretsmanager_secret_version" "AWS_DEFAULT_REGION_version" {
  secret_id     = aws_secretsmanager_secret.AWS_DEFAULT_REGION.id
  secret_string = var.AWS_DEFAULT_REGION
}

resource "aws_secretsmanager_secret" "AWS_SECRET_ACCESS_KEY" {
  name = "${var.prefix}-AWS_SECRET_ACCESS_KEY"
}

resource "aws_secretsmanager_secret_version" "AWS_SECRET_ACCESS_KEY_version" {
  secret_id     = aws_secretsmanager_secret.AWS_SECRET_ACCESS_KEY.id
  secret_string = var.AWS_SECRET_ACCESS_KEY
}

resource "aws_secretsmanager_secret" "AWS_ACCESS_KEY_ID" {
  name = "${var.prefix}-AWS_ACCESS_KEY_ID"
}

resource "aws_secretsmanager_secret_version" "AWS_ACCESS_KEY_ID_version" {
  secret_id     = aws_secretsmanager_secret.AWS_ACCESS_KEY_ID.id
  secret_string = var.AWS_ACCESS_KEY_ID
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
        "Resource": "*"
      }
    ]
  }
  EOF
}