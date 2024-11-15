output "alarm_arns" {
  value = {
    for level, alarm in aws_cloudwatch_metric_alarm.default :
    level => alarm.arn
  }
  description = "A map of CloudWatch metric alarm ARNs keyed by alarm level"
}

output "alarm_ids" {
  value = {
    for level, alarm in aws_cloudwatch_metric_alarm.default :
    level => alarm.id
  }
  description = "A map of CloudWatch metric alarm IDs keyed by alarm level"
}

output "alarm_names" {
  value = {
    for level, alarm in aws_cloudwatch_metric_alarm.default :
    level => alarm.alarm_name
  }
  description = "A map of CloudWatch metric alarm names keyed by alarm level"
}
