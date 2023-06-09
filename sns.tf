resource "random_string" "random" {
  count   = var.integration_type == "QUEUE" ? 1 : 0
  length  = 5
  special = false
}

resource "aws_sns_topic" "notification_integration_sns" {
  count = var.integration_type == "QUEUE" ? 1 : 0
  name  = "${local.notification_integration_sns_topic_name}-${random_string.random[0].result}"
}
