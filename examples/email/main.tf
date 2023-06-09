module "my_notification_integration" {
  source = "../../"

  prefix                           = var.prefix
  aws_region                       = var.aws_region
  env                              = var.env
  snowflake_integration_user_roles = var.snowflake_integration_user_roles
  arn_format                       = var.arn_format

  providers = {
    snowflake.notification_integration_role = snowflake.notification_integration_role
    aws                                     = aws
  }
}
