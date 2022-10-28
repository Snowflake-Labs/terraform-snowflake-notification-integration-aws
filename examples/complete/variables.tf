# Required Variables
variable "snowflake_account" {
  type      = string
  sensitive = true
}

variable "prefix" {
  type        = string
  description = "This will be the prefix used to name the Resources."
}

# Optional Variables
variable "aws_region" {
  description = "The AWS region in which the AWS infrastructure is created."
  type        = string
  default     = "us-west-2"
}

variable "env" {
  type        = string
  description = "Dev/Prod/Staging or any other custom environment name."
  default     = "dev"
}

variable "snowflake_notification_integration_owner_role" {
  type    = string
  default = "ACCOUNTADMIN"
}

variable "snowflake_integration_user_roles" {
  type = list(string)
  default = [
    "MONITORING_RL"
  ]
  description = "List of roles to which Sentry infra will GRANT USAGE ON INTEGRATION perms."
}

variable "arn_format" {
  type        = string
  description = "ARN format could be aws or aws-us-gov. Defaults to non-gov."
  default     = "aws"
}


data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
data "aws_partition" "current" {}


locals {
  account_id = data.aws_caller_identity.current.account_id
  aws_region = data.aws_region.current.name
}

locals {
  integration_prefix = "${var.prefix}-notification-integration"
}

locals {
  notification_integration_sns_role_name   = "${local.integration_prefix}-sns"
  notification_integration_sns_policy_name = "${local.integration_prefix}-sns-policy"
  notification_integration_sns_topic_name  = "${local.integration_prefix}-sns-topic"
}
