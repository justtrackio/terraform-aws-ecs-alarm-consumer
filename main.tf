locals {
  alarm_topic_arn = var.alarm_topic_arn != null ? var.alarm_topic_arn : "arn:aws:sns:${module.this.aws_region}:${module.this.aws_account_id}:${module.this.environment}-alarms"

  alarm_levels = {
    warning = {
      alarm_priority      = var.alarm_priority_warning
      datapoints_to_alarm = var.datapoints_to_alarm
      evaluation_periods  = var.evaluation_periods
    }
    high = {
      alarm_priority      = var.alarm_priority_high
      datapoints_to_alarm = floor(3600 / var.period)
      evaluation_periods  = floor(3600 / var.period)
    }
  }
}

module "cloudwatch_label" {
  source  = "justtrackio/label/null"
  version = "0.26.0"

  delimiter   = "/"
  label_order = var.label_orders.cloudwatch

  context = module.this.context
}

resource "aws_cloudwatch_metric_alarm" "default" {
  for_each = module.this.enabled ? local.alarm_levels : {}

  alarm_description = jsonencode(merge({
    Priority = each.value.alarm_priority
  }, jsondecode(var.alarm_description)))
  alarm_name          = "${module.this.id}-${var.consumer_name}-success-rate-${each.value.alarm_priority}"
  datapoints_to_alarm = each.value.datapoints_to_alarm
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = each.value.evaluation_periods
  threshold           = var.threshold
  treat_missing_data  = "notBreaching"

  metric_query {
    id          = "messages"
    return_data = false

    metric {
      dimensions = {
        Consumer = var.consumer_name
      }
      metric_name = "ProcessedCount"
      namespace   = module.cloudwatch_label.id
      period      = var.period
      stat        = "Sum"
    }
  }

  metric_query {
    id          = "errors"
    return_data = false

    metric {
      metric_name = "Error"
      dimensions = {
        Consumer = var.consumer_name
      }
      namespace = module.cloudwatch_label.id
      period    = var.period
      stat      = "Sum"
    }
  }

  metric_query {
    expression  = "IF(messages == 0 OR errors == 0, 100, 100-100*(errors/messages))"
    id          = "e1"
    label       = "success rate"
    return_data = true
  }

  alarm_actions = [local.alarm_topic_arn]
  ok_actions    = [local.alarm_topic_arn]

  tags = module.this.tags
}
