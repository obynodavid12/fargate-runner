# Secrets
resource "aws_secretsmanager_secret" "PAT" {
  name = "${var.prefix}-PAT"
}

resource "aws_secretsmanager_secret_version" "PAT_version" {
  secret_id     = aws_secretsmanager_secret.PAT.id
  secret_string = var.PAT
}

resource "aws_secretsmanager_secret" "REPO_OWNER" {
  name = "${var.prefix}-REPO_OWNER"
}

resource "aws_secretsmanager_secret_version" "REPO_OWNER_version" {
  secret_id     = aws_secretsmanager_secret.REPO_OWNER.id
  secret_string = var.REPO_OWNER
}

resource "aws_secretsmanager_secret" "REPO_NAME" {
  name = "${var.prefix}-REPO_NAME"
}

resource "aws_secretsmanager_secret_version" "REPO_NAME_version" {
  secret_id     = aws_secretsmanager_secret.REPO_NAME.id
  secret_string = var.REPO_NAME
}

resource "aws_secretsmanager_secret" "AWS_REGION" {
  name = "${var.prefix}-AWS_REGION"
}

resource "aws_secretsmanager_secret_version" "AWS_REGION_version" {
  secret_id     = aws_secretsmanager_secret.AWS_REGION.id
  secret_string = var.AWS_REGION
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