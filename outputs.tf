output "alarm_id" {
  value       = try(aws_cloudwatch_metric_alarm.success_rate[0].id)
  description = "The ID of the CloudWatch metric alarm"
}

output "alarm_arn" {
  value       = try(aws_cloudwatch_metric_alarm.success_rate[0].arn)
  description = "The ARN of the CloudWatch metric alarm"
}

output "alarm_name" {
  value       = try(aws_cloudwatch_metric_alarm.success_rate[0].alarm_name)
  description = "The name of the CloudWatch metric alarm"
}
