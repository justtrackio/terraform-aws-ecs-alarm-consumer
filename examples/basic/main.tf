module "cloudwatch_alarm" {
  source = "../../"

  alarm_description      = "Alarm when success rate drops below 95%"
  consumer_name          = "my-consumer"
  datapoints_to_alarm    = 1
  evaluation_periods     = 1
  period                 = 300
  success_rate_threshold = 95

  alarm_topic_arn       ="arn:aws:sns:us-east-1:123456789012:my-topic"
}
