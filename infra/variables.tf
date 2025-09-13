variable "project_name" {
  description = "The name of the project. Used for tagging resources."
  type        = string
}

variable "environment" {
  description = "The deployment environment (dev, prod, etc.)."
  type        = string
}

variable "aws_region" {
  description = "The AWS region to deploy the resources."
  type        = string
  default     = "sa-east-1"
}

variable "data_bucket_name" {
  description = "The name of the S3 bucket to store data files."
  type        = string
}