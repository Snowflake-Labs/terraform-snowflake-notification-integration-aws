output "notification_integration_name" {
  description = "Name of Storage integration."
  value       = module.my_notification_integration.notification_integration_name
}

output "integration_sns_topic_arn" {
  description = "Notification integration's SNS Topic ARN."
  value       = module.my_notification_integration.notification_integration_sns_topic_arn
}

output "notification_integration_sns_role_arn" {
  description = "The role arn the snowflake notification integration will assume."
  value       = module.my_notification_integration.notification_integration_sns_role_arn
}
