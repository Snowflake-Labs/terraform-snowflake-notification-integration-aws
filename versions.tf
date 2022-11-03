terraform {
  required_version = "~> 1.3.4"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.37.0"
    }

    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "~> 0.49.0"

      configuration_aliases = [
        snowflake.notification_integration_role
      ]
    }
  }
}
