output "cloudwatch_alarm_arn" {
  description = "The ARN of the CloudWatch alarm"
  value       = aws_cloudwatch_metric_alarm.success_rate[0].arn
}

output "cloudwatch_alarm_name" {
  description = "The name of the CloudWatch alarm"
  value       = aws_cloudwatch_metric_alarm.success_rate[0].alarm_name
}
