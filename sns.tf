resource "random_string" "random" {
  length  = 5
  special = false
}

resource "aws_sns_topic" "notification_integration_sns" {
  name = "${local.notification_integration_sns_topic_name}-${random_string.random.result}"
}
