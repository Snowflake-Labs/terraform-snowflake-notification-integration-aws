resource "snowflake_notification_integration" "notification_integration" {
  provider = snowflake.notification_integration_role
  count    = var.integration_type == "QUEUE" ? 1 : 0

  name    = "${upper(replace(var.prefix, "-", "_"))}_NOTIFICATION_INTEGRATION"
  comment = var.notification_integration_comment

  enabled = var.integration_enabled
  type    = var.integration_type

  # QUEUE
  direction             = var.integration_type == "QUEUE" ? "OUTBOUND" : null
  notification_provider = var.integration_type == "QUEUE" ? "AWS_SNS" : null
  aws_sns_topic_arn     = var.integration_type == "QUEUE" ? aws_sns_topic.notification_integration_sns.arn : null
  aws_sns_role_arn      = var.integration_type == "QUEUE" ? "arn:${var.arn_format}:iam::${local.account_id}:role/${local.notification_integration_sns_role_name}" : null
}

resource "snowflake_email_notification_integration" "email_notification_integration" {
  provider = snowflake.notification_integration_role
  count    = var.integration_type == "EMAIL" ? 1 : 0

  name    = "${upper(replace(var.prefix, "-", "_"))}_NOTIFICATION_INTEGRATION"
  comment = var.notification_integration_comment
  enabled = var.integration_enabled

  # EMAIL
  allowed_recipients = var.integration_type == "EMAIL" ? var.allowed_recipients : null
}

resource "snowflake_integration_grant" "notification_integration_grant" {
  provider = snowflake.notification_integration_role
  count    = var.integration_type == "QUEUE" ? 1 : 0

  integration_name  = snowflake_notification_integration.notification_integration[0].name
  privilege         = "USAGE"
  roles             = var.snowflake_integration_user_roles
  with_grant_option = false
}

resource "snowflake_integration_grant" "email_notification_integration_grant" {
  provider = snowflake.notification_integration_role
  count    = var.integration_type == "EMAIL" ? 1 : 0

  integration_name  = snowflake_email_notification_integration.email_notification_integration[0].name
  privilege         = "USAGE"
  roles             = var.snowflake_integration_user_roles
  with_grant_option = false
}
