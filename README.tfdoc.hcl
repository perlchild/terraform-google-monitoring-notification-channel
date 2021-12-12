header {
  image = "https://raw.githubusercontent.com/mineiros-io/brand/3bffd30e8bdbbde32c143e2650b2faa55f1df3ea/mineiros-primary-logo.svg"
  url   = "https://mineiros.io/?ref=terraform-google-billing-budget"

  badge "build" {
    image = "https://github.com/mineiros-io/terraform-google-billing-budget/workflows/Tests/badge.svg"
    url   = "https://github.com/mineiros-io/terraform-google-billing-budget/actions"
    text  = "Build Status"
  }

  badge "semver" {
    image = "https://img.shields.io/github/v/tag/mineiros-io/terraform-google-billing-budget.svg?label=latest&sort=semver"
    url   = "https://github.com/mineiros-io/terraform-google-billing-budget/releases"
    text  = "GitHub tag (latest SemVer)"
  }

  badge "terraform" {
    image = "https://img.shields.io/badge/Terraform-1.x-623CE4.svg?logo=terraform"
    url   = "https://github.com/hashicorp/terraform/releases"
    text  = "Terraform Version"
  }

   badge "tf-gcp-provider" {
     image = "https://img.shields.io/badge/google-3-1A73E8.svg?logo=terraform"
     url   = "https://github.com/terraform-providers/terraform-provider-google/releases"
     text  = "Google Provider Version"
   }

  badge "slack" {
    image = "https://img.shields.io/badge/slack-@mineiros--community-f32752.svg?logo=slack"
    url   = "https://mineiros.io/slack"
    text  = "Join Slack"
  }
}

section {
  title   = "terraform-google-monitoring-notification-channel"
  toc     = true
  content = <<-END
    A [Terraform] module to manage [notification channels](https://cloud.google.com/monitoring/support/notification-options)
    on [Google Cloud Platform (GCP)](https://cloud.google.com).

    A NotificationChannel is a medium through which an alert is delivered when
    a policy violation is detected. Examples of channels include email, SMS,
    and third-party messaging applications.

    **_This module supports Terraform version 1
    and is compatible with the Terraform Google Cloud Provider version 3._**

    This module is part of our Infrastructure as Code (IaC) framework
    that enables our users and customers to easily deploy and manage reusable,
    secure, and production-grade cloud infrastructure.
  END

  section {
    title   = "Module Features"
    content = <<-END
      This module implements the following Terraform resources

      - `google_monitoring_notification_channel`
    END
  }

  section {
    title   = "Getting Started"
    content = <<-END
      Create a slack notification channel:

      ```hcl
      module "terraform-google-billing-budget" {
        source = "git@github.com:mineiros-io/terraform-google-monitoring-notification-channel.git?ref=v0.0.1"

        type        = "slack"

        display_name = "slack-alert"
        description  = "An example Slack notification channel."

        labels       = {
          channel_name = "#alerts"
        }

        sensitive_labels = {
          auth_token = "XXX"
        }
      ```
    END
  }

  section {
    title   = "Module Argument Reference"
    content = <<-END
      See [variables.tf] and [examples/] for details and use-cases.
    END

    section {
      title = "Top-level Arguments"

      section {
        title = "Main Resource Configuration"

        variable "type" {
          required    = true
          type        = string
          description = <<-END
            The type of the notification channel. Valid values are `email`, `slack`, `sms`, `webhook_basicauth` and `pagerduty`.
          END
        }

        variable "project" {
          type        = string
          description = <<-END
            The ID of the project in which the resource belongs. If it is not set, the provider project is used.
          END
          default = null
        }

        variable "display_name" {
          type        = string
          description = <<-END
            An human-readable name for this notification channel. It is recommended that you specify a non-empty and unique name in order to make it easier to identify the channels in your project, though this is not enforced. The display name is limited to 512 Unicode characters.
          END
          default = null
        }

        variable "description" {
          type        = string
          description = <<-END
            An optional human-readable description of this notification channel. This description may provide additional details, beyond the display name, for the channel. This may not exceed 1024 Unicode characters.
          END
          default = "Notification managed by the mineiros-io/terraform-google-monitoring-notification-channel Terraform module."
        }

        variable "enabled" {
          type        = bool
          description = <<-END
            Whether notifications are forwarded to the described channel. This makes it possible to disable delivery of notifications to a particular channel without removing the channel from all alerting policies that reference the channel. This is a more convenient approach when the change is temporary and you want to receive notifications from the same set of alerting policies on the channel at some point in the future.
          END
          default = true
        }

        variable "labels" {
          type        = string
          description = <<-END
            Configuration fields that define the channel and its behavior. Labels with sensitive data should be configured via the 'sensitive_labels' block.
          END
          readme_example = <<-END
            labels = {
              email_address = "address@example.com"
            }
          END
          default     = {}
        }

        variable "user_labels" {
          type        = string
          description = <<-END
            User-supplied key/value data that does not need to conform to the corresponding notification channel schema, unlike the `labels` field. The field can contain up to 64 entries. Each key and value is limited to 63 Unicode characters or 128 bytes, whichever is smaller. Labels and values can contain only lowercase letters, numerals, underscores, and dashes. Keys must begin with a letter.
          END
          default     = {}
        }

        variable "sensitive_labels" {
          type        = any
          description = <<-END
            Different notification type behaviors are configured primarily using the the labels field on this resource. This block contains the labels which contain secrets or passwords so that they can be marked sensitive and hidden from plan output. The name of the field, eg: password, will be the key in the labels map in the api request. Credentials may not be specified in both locations and will cause an error. Changing from one location to a different credential configuration in the config will require an apply to update state.
          END
          readme_type = "object(sensitive_labels)"
          default     = null
          readme_example = <<-END
            sensitive_labels = {
              auth_token = "example-token"
            }
          END

          attribute "auth_token" {
            type        = string
            description = <<-END
              An authorization token for a notification channel. Channel types that support this field include: `slack` Note: This property is sensitive and will not be displayed in the plan.
            END
          }

          attribute "password" {
            type        = string
            description = <<-END
              An password for a notification channel. Channel types that support this field include: `webhook_basicauth` Note: This property is sensitive and will not be displayed in the plan.
            END
          }

          attribute "service_key" {
            type        = string
            description = <<-END
              An servicekey token for a notification channel. Channel types that support this field include: `pagerduty` Note: This property is sensitive and will not be displayed in the plan.
            END
          }
        }
      }
 
      section {
        title = "Module Configuration"

        variable "module_enabled" {
          type        = bool
          description = <<-END
            Specifies whether resources in the module will be created.
          END
          default     = true
        }

        variable "module_timeouts" {
          type        = any
          readme_type = "object(google_monitoring_notification_channel)"
          description = <<-END
            How long certain operations (per resource type) are allowed to take before being considered to have failed.
          END
          default = {}
          readme_example = <<-END
            module_timeouts = {
              google_monitoring_notification_channel = {
                create = "4m"
                update = "4m"
                delete = "4m"
              }
            }
          END

          attribute "google_monitoring_notification_channel" {
            type        = any
            readme_type = "object(timeouts)"
            description = <<-END
              Timeout for the `google_monitoring_notification_channel` resource.
            END

            attribute "create" {
              type        = string
              description = <<-END
                Timeout for `create` operations.
              END
            }

            attribute "update" {
              type        = string
              description = <<-END
                Timeout for `update` operations.
              END
            }

            attribute "delete" {
              type        = string
              description = <<-END
                Timeout for `delete` operations.
              END
            }
          }
        }

        variable "module_depends_on" {
          type        = any
          readme_type = "list(dependencies)"
          description = <<-END
            A list of dependencies. Any object can be _assigned_ to this list to define a hidden external dependency.
          END
          readme_example = <<-END
            module_depends_on = [
              google_monitoring_alert_policy.alert-policy 
            ]
          END
        }
      }
    }
  }

  section {
    title   = "Module Attributes Reference"
    content = <<-END
      The following attributes are exported in the outputs of the module:

      - **`module_enabled`**

        Whether this module is enabled.
    END
  }

  section {
    title = "External Documentation"

    section {
      title   = "GCP Billing Budgets Documentation"
      content = <<-END
        - https://cloud.google.com/monitoring/support/notification-options 
      END
    }

    section {
      title   = "Terraform GCP Provider Documentation"
      content = <<-END
        - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/monitoring_notification_channel
      END
    }
  }

  section {
    title   = "Module Versioning"
    content = <<-END
      This Module follows the principles of [Semantic Versioning (SemVer)].

      Given a version number `MAJOR.MINOR.PATCH`, we increment the:

      1. `MAJOR` version when we make incompatible changes,
      2. `MINOR` version when we add functionality in a backwards compatible manner, and
      3. `PATCH` version when we make backwards compatible bug fixes.
    END

    section {
      title   = "Backwards compatibility in `0.0.z` and `0.y.z` version"
      content = <<-END
        - Backwards compatibility in versions `0.0.z` is **not guaranteed** when `z` is increased. (Initial development)
        - Backwards compatibility in versions `0.y.z` is **not guaranteed** when `y` is increased. (Pre-release)
      END
    }
  }

  section {
    title   = "About Mineiros"
    content = <<-END
      [Mineiros][homepage] is a remote-first company headquartered in Berlin, Germany
      that solves development, automation and security challenges in cloud infrastructure.

      Our vision is to massively reduce time and overhead for teams to manage and
      deploy production-grade and secure cloud infrastructure.

      We offer commercial support for all of our modules and encourage you to reach out
      if you have any questions or need help. Feel free to email us at [hello@mineiros.io] or join our
      [Community Slack channel][slack].
    END
  }

  section {
    title   = "Reporting Issues"
    content = <<-END
      We use GitHub [Issues] to track community reported issues and missing features.
    END
  }

  section {
    title   = "Contributing"
    content = <<-END
      Contributions are always encouraged and welcome! For the process of accepting changes, we use
      [Pull Requests]. If you'd like more information, please see our [Contribution Guidelines].
    END
  }

  section {
    title   = "Makefile Targets"
    content = <<-END
      This repository comes with a handy [Makefile].
      Run `make help` to see details on each available target.
    END
  }

  section {
    title   = "License"
    content = <<-END
      [![license][badge-license]][apache20]

      This module is licensed under the Apache License Version 2.0, January 2004.
      Please see [LICENSE] for full details.

      Copyright &copy; 2020-2022 [Mineiros GmbH][homepage]
    END
  }
}

references {
  ref "homepage" {
    value = "https://mineiros.io/?ref=terraform-google-billing-budget"
  }
  ref "hello@mineiros.io" {
    value = " mailto:hello@mineiros.io"
  }
  ref "badge-license" {
    value = "https://img.shields.io/badge/license-Apache%202.0-brightgreen.svg"
  }
  ref "releases-terraform" {
    value = "https://github.com/hashicorp/terraform/releases"
  }
  ref "apache20" {
    value = "https://opensource.org/licenses/Apache-2.0"
  }
  ref "slack" {
    value = "https://mineiros.io/slack"
  }
  ref "terraform" {
    value = "https://www.terraform.io"
  }
  ref "gcp" {
    value = "https://cloud.google.com"
  }
  ref "semantic versioning (semver)" {
    value = "https://semver.org/"
  }
  ref "variables.tf" {
    value = "https://github.com/mineiros-io/terraform-google-billing-budget/blob/main/variables.tf"
  }
  ref "examples/" {
    value = "https://github.com/mineiros-io/terraform-google-billing-budget/blob/main/examples"
  }
  ref "issues" {
    value = "https://github.com/mineiros-io/terraform-google-billing-budget/issues"
  }
  ref "license" {
    value = "https://github.com/mineiros-io/terraform-google-billing-budget/blob/main/LICENSE"
  }
  ref "makefile" {
    value = "https://github.com/mineiros-io/terraform-google-billing-budget/blob/main/Makefile"
  }
  ref "pull requests" {
    value = "https://github.com/mineiros-io/terraform-google-billing-budget/pulls"
  }
  ref "contribution guidelines" {
    value = "https://github.com/mineiros-io/terraform-google-billing-budget/blob/main/CONTRIBUTING.md"
  }
}
