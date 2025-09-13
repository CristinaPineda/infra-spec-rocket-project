# 1. Configura o Terraform para usar o S3 como backend
terraform {
  backend "s3" {
    bucket         = "rocket-project-statefiles"
    key            = "glue-catalog/terraform.tfstate"
    region         = "sa-east-1"
    encrypt        = true
    dynamodb_table = "rocket-project-terraform-lock" # Opcional, mas recomendado para bloqueio de estado
  }
}
