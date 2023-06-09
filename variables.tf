# Required Variables
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

variable "integration_enabled" {
  type        = bool
  description = "Boolean to indicate if the integration is enabled after creation."
  default     = true
}

variable "integration_type" {
  type        = string
  description = "QUEUE or EMAIL. Defaults to QUEUE"
  default     = "QUEUE"
}

variable "allowed_recepients" {
  type        = list(string)
  description = "Allow list of recepient email addresses for a EMAIL type notification integration."
  default     = []
}

variable "notification_integration_comment" {
  type        = string
  description = "A Snowflake object comment for your notification integration object."
  default     = "A Notification Integration."
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
