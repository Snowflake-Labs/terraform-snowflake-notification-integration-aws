output "notification_integration_name" {
  description = "Name of Storage integration."
  value       = var.integration_type == "QUEUE" ? snowflake_notification_integration.notification_integration[0].name : snowflake_email_notification_integration.email_notification_integration[0].name
}

output "notification_integration_sns_topic_arn" {
  description = "Notification integration's SNS Topic ARN."
  value       = var.integration_type == "QUEUE" ? aws_sns_topic.notification_integration_sns[0].arn : null
}

output "notification_integration_sns_role_arn" {
  description = "The role arn the snowflake notification integration will assume."
  value       = var.integration_type == "QUEUE" ? aws_iam_role.notification_integration_sns_role[0].arn : null
}

output "notification_integration_external_id" {
  description = "The external ID or the notification integration."
  value       = var.integration_type == "QUEUE" ? snowflake_notification_integration.notification_integration[0].aws_sns_external_id : null
}

output "notification_integration_user_arn" {
  description = "The user ARN of the notification integration."
  value       = var.integration_type == "QUEUE" ? snowflake_notification_integration.notification_integration[0].aws_sns_iam_user_arn : null
}

