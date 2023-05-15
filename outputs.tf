output "alarm_name" {
  value       = try(aws_cloudwatch_metric_alarm.default[0].alarm_name)
  description = "The name of the CloudWatch metric alarm"
}

output "arn" {
  value       = try(aws_cloudwatch_metric_alarm.default[0].arn)
  description = "The ARN of the CloudWatch metric alarm"
}

output "id" {
  value       = try(aws_cloudwatch_metric_alarm.default[0].id)
  description = "The ID of the CloudWatch metric alarm"
}
