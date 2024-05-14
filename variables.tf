# ----------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# These variables must be set when using this module.
# ----------------------------------------------------------------------------------------------------------------------

variable "type" {
  type        = string
  description = "(Required) The type of the notification channel. Valid values are `email`, `slack`, `sms`, `webhook_basicauth` and `pagerduty`."
}

# ----------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These variables have defaults, but may be overridden.
# ----------------------------------------------------------------------------------------------------------------------

variable "project" {
  type        = string
  description = "(Optional) The ID of the project in which the resource belongs. If it is not set, the provider project is used."
  default     = null
}

variable "display_name" {
  type        = string
  description = "(Optional) An optional human-readable name for this notification channel. It is recommended that you specify a non-empty and unique name in order to make it easier to identify the channels in your project, though this is not enforced. The display name is limited to 512 Unicode characters."
  default     = null
}

variable "description" {
  type        = string
  description = "(Optional) An optional human-readable description of this notification channel. This description may provide additional details, beyond the display name, for the channel. This may not exceed 1024 Unicode characters."
  default     = "Notification managed by the mineiros-io/terraform-google-monitoring-notification-channel Terraform module."
}

variable "enabled" {
  type        = bool
  description = "(Optional) Whether notifications are forwarded to the described channel. This makes it possible to disable delivery of notifications to a particular channel without removing the channel from all alerting policies that reference the channel. This is a more convenient approach when the change is temporary and you want to receive notifications from the same set of alerting policies on the channel at some point in the future."
  default     = true
}

variable "labels" {
  type        = map(string)
  description = "(Optional) Configuration fields that define the channel and its behavior. Labels with sensitive data should be configured via the 'sensitive_labels' block."
  default     = {}
}

variable "user_labels" {
  type        = map(string)
  description = "(Optional) User-supplied key/value data that does not need to conform to the corresponding notification channel schema, unlike the `labels` field. The field can contain up to 64 entries. Each key and value is limited to 63 Unicode characters or 128 bytes, whichever is smaller. Labels and values can contain only lowercase letters, numerals, underscores, and dashes. Keys must begin with a letter."
  default     = {}
}

variable "sensitive_labels" {
  # type = object({
  #   # (Optional) An authorization token for a notification channel. Channel types that support this field include: `slack` Note: This property is sensitive and will not be displayed in the plan.
  #   auth_token = optional(string)
  #   # (Optional) An password for a notification channel. Channel types that support this field include: `webhook_basicauth` Note: This property is sensitive and will not be displayed in the plan.
  #   password = optional(string)
  #   # (Optional) An servicekey token for a notification channel. Channel types that support this field include: `pagerduty` Note: This property is sensitive and will not be displayed in the plan.
  #   service_key = optional(string)
  # })
  type        = any
  description = "(Optional) Different notification type behaviors are configured primarily using the the labels field on this resource. This block contains the labels which contain secrets or passwords so that they can be marked sensitive and hidden from plan output. The name of the field, eg: password, will be the key in the labels map in the api request. Credentials may not be specified in both locations and will cause an error. Changing from one location to a different credential configuration in the config will require an apply to update state."
  default     = null
}

# ----------------------------------------------------------------------------------------------------------------------
# MODULE CONFIGURATION PARAMETERS
# These variables are used to configure the module.
# ----------------------------------------------------------------------------------------------------------------------

variable "module_enabled" {
  type        = bool
  description = "(Optional) Whether to create resources within the module or not."
  default     = true
}

variable "module_timeouts" {
  description = "(Optional) How long certain operations (per resource type) are allowed to take before being considered to have failed."
  type        = any
  # type = object({
  #   google_monitoring_notification_channel = optional(object({
  #     create = optional(string)
  #     update = optional(string)
  #     delete = optional(string)
  #   }))
  # })
  default = {}
}

variable "module_depends_on" {
  type        = any
  description = "(Optional) A list of external resources the module depends on."
  default     = []
}

