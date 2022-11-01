output "notification_integration_name" {
  description = "Name of Storage integration"
  value       = snowflake_notification_integration.pipe_errors_integration.name
}
