module "cloudwatch_label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  delimiter   = "/"
  label_order = var.label_orders.cloudwatch

  context = module.this.context
}

resource "aws_cloudwatch_metric_alarm" "success_rate" {
  count = module.this.enabled ? 1 : 0

  alarm_description   = var.alarm_description
  alarm_name          = "${module.this.id}-success-rate"
  datapoints_to_alarm = var.datapoints_to_alarm
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = var.evaluation_periods
  threshold           = var.success_rate_threshold
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

  alarm_actions = [var.alarm_topic_arn]
  ok_actions    = [var.alarm_topic_arn]

  tags = module.this.tags
}
