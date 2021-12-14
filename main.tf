resource "google_monitoring_notification_channel" "notification_channel" {
  count = var.module_enabled ? 1 : 0

  project = var.project

  # NOTE: We explicitly set the display_name if none is provided since otherwise
  # GCP will set it a to a specific labels value depending on the chosen type.
  display_name = var.display_name != null ? var.display_name : "${upper(var.type)} Notification Channel"

  description = var.description
  type        = var.type
  enabled     = var.enabled

  labels      = var.labels
  user_labels = var.user_labels

  dynamic "sensitive_labels" {
    for_each = var.sensitive_labels != null ? [var.sensitive_labels] : []

    content {
      auth_token  = try(sensitive_labels.value.auth_token, null)
      password    = try(sensitive_labels.value.password, null)
      service_key = try(sensitive_labels.value.service_key, null)
    }
  }

  dynamic "timeouts" {
    for_each = try([var.module_timeouts.google_monitoring_notification_channel], [])

    content {
      create = try(timeouts.value.create, null)
      update = try(timeouts.value.update, null)
      delete = try(timeouts.value.delete, null)
    }
  }

  depends_on = [var.module_depends_on]
}
