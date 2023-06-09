# This file contains the following IAM resources:
# 1. Role, Role Policy and Policy attachment for the role notification integration
# 2. SNS Topic Policy, SNS Topic Policy Attachment.

# -----------------------------------------------------------------------------------------------
# 1. Role, Role Policy and Policy attachment for the role notification integration
# -----------------------------------------------------------------------------------------------
resource "aws_iam_role" "notification_integration_sns_role" {
  name = local.notification_integration_sns_role_name
  path = "/"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Condition = {
          StringEquals = {
            "sts:ExternalId" = snowflake_notification_integration.notification_integration[0].aws_sns_external_id
          }
        }
        Effect = "Allow"
        Principal = {
          AWS = snowflake_notification_integration.notification_integration[0].aws_sns_iam_user_arn
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "notification_integration_sns_role_policy" {
  name = local.notification_integration_sns_policy_name
  role = aws_iam_role.notification_integration_sns_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "sns:Publish"
        Resource = aws_sns_topic.notification_integration_sns.arn
      }
    ]
  })
}

# -------------------------------------------------
# 2. SNS Topic Policy, SNS Topic Policy Attachment.
# -------------------------------------------------
data "aws_iam_policy_document" "notification_integration_sns_topic_policy_doc" {
  policy_id = local.notification_integration_sns_policy_name

  statement {
    sid       = "SNSPublish"
    effect    = "Allow"
    resources = [aws_sns_topic.notification_integration_sns.arn]
    actions   = ["SNS:Publish"]

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

  }

  statement {
    sid       = "SNSSubscribe"
    effect    = "Allow"
    resources = [aws_sns_topic.notification_integration_sns.arn]
    actions   = ["sns:Subscribe"]

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
  }
}

resource "aws_sns_topic_policy" "notification_integration_sns_topic_policy" {
  arn    = aws_sns_topic.notification_integration_sns.arn
  policy = data.aws_iam_policy_document.notification_integration_sns_topic_policy_doc.json
}
