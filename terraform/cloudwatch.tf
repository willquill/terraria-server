resource "aws_cloudwatch_metric_alarm" "account_billing_alarm" {
  alarm_name          = "account-billing-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "EstimatedCharges"
  namespace           = "AWS/Billing"
  period              = "600" # 5 minutes
  statistic           = "Sum"
  threshold           = "1" # 1 dollar
  alarm_description   = "Billing alarm by account"
  alarm_actions       = ["<your-sns-topic-arn-for-notification>"]

  dimensions {
    Currency      = "USD"
    LinkedAccount = data.aws_ssm_parameter.aws_account_id.value
  }
}

resource "aws_sns_topic" "user_updates" {
  name            = "user-updates-topic"
  delivery_policy = <<EOF
{
  "http": {
    "defaultHealthyRetryPolicy": {
      "minDelayTarget": 20,
      "maxDelayTarget": 20,
      "numRetries": 3,
      "numMaxDelayRetries": 0,
      "numNoDelayRetries": 0,
      "numMinDelayRetries": 0,
      "backoffFunction": "linear"
    },
    "disableSubscriptionOverrides": false,
    "defaultThrottlePolicy": {
      "maxReceivesPerSecond": 1
    }
  }
}
EOF
}