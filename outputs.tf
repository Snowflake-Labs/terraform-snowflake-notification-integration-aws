output "notification_integration_name" {
  description = "Name of Storage integration."
  value       = snowflake_notification_integration.error_integration.name
}

output "integration_sns_topic_arn" {
  description = "Notification integration's SNS Topic ARN."
  value       = aws_sns_topic.notification_integration_sns.arn
}

output "notification_integration_sns_role_arn" {
  description = "The role arn the snowflake notification integration will assume."
  value       = aws_iam_role.notification_integration_sns_role.arn
}
