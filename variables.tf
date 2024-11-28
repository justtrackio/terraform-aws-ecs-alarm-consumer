variable "alarm_description" {
  type        = any
  description = "The description for the alarm"
  default     = null
}

variable "alarm_levels" {
  type        = list(string)
  description = "List of alarm levels to enable (e.g., ['info', 'warning', 'high', 'critical'])"
  default     = ["warning", "high"]
}

variable "alarm_topic_arn" {
  type        = string
  description = "The ARN of the SNS topic to receive the alerts"
  default     = null
}

variable "consumer_name" {
  type        = string
  description = "The name of the consumer"
}

variable "datapoints_to_alarm" {
  type        = number
  default     = 3
  description = "The number of datapoints that must be breaching to trigger the alarm"
}

variable "evaluation_periods" {
  type        = number
  default     = 3
  description = "The number of periods over which data is compared to the specified threshold"
}

variable "label_orders" {
  type = object({
    cloudwatch = optional(list(string))
  })
  default     = {}
  description = "Overrides the `labels_order` for the different labels to modify ID elements appear in the `id`"
}

variable "period" {
  type        = number
  default     = 60
  description = "The period in seconds over which the specified statistic is applied"
}

variable "threshold" {
  type        = number
  default     = 99
  description = "Required percentage of successful requests"
}
