resource "random_string" "random" {
  length  = 5
  special = false
}

resource "aws_sns_topic" "notification_integration_sns" {
  name = "${local.notification_integration_sns_topic_name}-${random_string.random.result}"
}

# resource "aws_sns_topic_subscription" "notification_integration_lambda_sns_subscription" {
#   topic_arn = aws_sns_topic.sentry_integration_sns.arn
#   protocol  = "lambda"
#   endpoint  = aws_lambda_function.sentry_integration_lambda.arn
# }
