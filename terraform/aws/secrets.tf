# AWS Access Key Secret
resource "aws_secretsmanager_secret" "aws_tf_access_key_id" {
  name        = "aws_tf_access_key_id"
  description = "AWS Access Key ID for Terraform"
}

resource "aws_secretsmanager_secret_version" "aws_tf_access_key_id_version" {
  secret_id     = aws_secretsmanager_secret.aws_tf_access_key_id.id
  secret_string = jsonencode({
    TF_VAR_aws_access_key_id = var.aws_access_key_id
  })
}

# AWS Secret Access Key Secret
resource "aws_secretsmanager_secret" "aws_tf_secret_access_key" {
  name        = "aws_tf_secret_access_key"
  description = "AWS Secret Access Key for Terraform"
}

resource "aws_secretsmanager_secret_version" "aws_tf_secret_access_key_version" {
  secret_id     = aws_secretsmanager_secret.aws_tf_secret_access_key.id
  secret_string = jsonencode({
    TF_VAR_aws_secret_access_key = var.aws_secret_access_key
  })
}

# RDS Postgres Username Secret
resource "aws_secretsmanager_secret" "aws_rds_postgres_username" {
  name        = "aws_rds_postgres_username"
  description = "RDS Postgres Username"
}

resource "aws_secretsmanager_secret_version" "aws_rds_postgres_username_version" {
  secret_id     = aws_secretsmanager_secret.aws_rds_postgres_username.id
  secret_string = jsonencode({
    DB_USERNAME = var.postgres_username
  })
}

# RDS Postgres Password Secret
resource "aws_secretsmanager_secret" "aws_rds_postgres_password" {
  name        = "aws_rds_postgres_password"
  description = "RDS Postgres Password"
}

resource "aws_secretsmanager_secret_version" "aws_rds_postgres_password_version" {
  secret_id     = aws_secretsmanager_secret.aws_rds_postgres_password.id
  secret_string = jsonencode({
    DB_PASS = var.postgres_password
  })
}

# MongoDB Username Secret
resource "aws_secretsmanager_secret" "aws_ddb_mongo_username" {
  name        = "aws_ddb_mongo_username"
  description = "MongoDB Username"
}

resource "aws_secretsmanager_secret_version" "aws_ddb_mongo_username_version" {
  secret_id     = aws_secretsmanager_secret.aws_ddb_mongo_username.id
  secret_string = jsonencode({
    MONGO_USERNAME = var.mongo_master_username
  })
}

# MongoDB Password Secret
resource "aws_secretsmanager_secret" "aws_ddb_mongo_password" {
  name        = "aws_ddb_mongo_password"
  description = "MongoDB Password"
}

resource "aws_secretsmanager_secret_version" "aws_ddb_mongo_password_version" {
  secret_id     = aws_secretsmanager_secret.aws_ddb_mongo_password.id
  secret_string = jsonencode({
    MONGO_PASSWORD = var.mongo_master_password
  })
}

# AWS CodeArtifact Domain Secret
resource "aws_secretsmanager_secret" "aws_codeartifact_domain" {
  name        = "aws_codeartifact_domain"
  description = "AWS CodeArtifact Domain"
}

resource "aws_secretsmanager_secret_version" "aws_codeartifact_domain_version" {
  secret_id     = aws_secretsmanager_secret.aws_codeartifact_domain.id
  secret_string = jsonencode({
    AWS_CODEARTIFACT_DOMAIN = var.codeartifact_domain
  })
}

# AWS Account ID Secret
resource "aws_secretsmanager_secret" "aws_account_id" {
  name        = "aws_account_id"
  description = "AWS Account ID"
}

resource "aws_secretsmanager_secret_version" "aws_account_id_version" {
  secret_id     = aws_secretsmanager_secret.aws_account_id.id
  secret_string = jsonencode({
    AWS_ACCOUNT_ID = var.aws_account_id
  })
}

# AWS Region Secret
resource "aws_secretsmanager_secret" "aws_region" {
  name        = "aws_region"
  description = "AWS Region"
}

resource "aws_secretsmanager_secret_version" "aws_region_version" {
  secret_id     = aws_secretsmanager_secret.aws_region.id
  secret_string = jsonencode({
    AWS_REGION = var.aws_region
  })
}

# AWS CodeArtifact Repo Secret
resource "aws_secretsmanager_secret" "aws_codeartifact_repo" {
  name        = "aws_codeartifact_repo"
  description = "AWS CodeArtifact Repository"
}

resource "aws_secretsmanager_secret_version" "aws_codeartifact_repo_version" {
  secret_id     = aws_secretsmanager_secret.aws_codeartifact_repo.id
  secret_string = jsonencode({
    AWS_CODEARTIFACT_REPO = var.codeartifact_repo
  })
}
