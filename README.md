[<img src="https://raw.githubusercontent.com/mineiros-io/brand/3bffd30e8bdbbde32c143e2650b2faa55f1df3ea/mineiros-primary-logo.svg" width="400"/>](https://mineiros.io/?ref=terraform-google-billing-budget)

[![Build Status](https://github.com/mineiros-io/terraform-google-billing-budget/workflows/Tests/badge.svg)](https://github.com/mineiros-io/terraform-google-billing-budget/actions)
[![GitHub tag (latest SemVer)](https://img.shields.io/github/v/tag/mineiros-io/terraform-google-billing-budget.svg?label=latest&sort=semver)](https://github.com/mineiros-io/terraform-google-billing-budget/releases)
[![Terraform Version](https://img.shields.io/badge/Terraform-1.x-623CE4.svg?logo=terraform)](https://github.com/hashicorp/terraform/releases)
[![Google Provider Version](https://img.shields.io/badge/google-3-1A73E8.svg?logo=terraform)](https://github.com/terraform-providers/terraform-provider-google/releases)
[![Join Slack](https://img.shields.io/badge/slack-@mineiros--community-f32752.svg?logo=slack)](https://mineiros.io/slack)

# terraform-google-monitoring-notification-channel

A [Terraform] module to manage [notification channels](https://cloud.google.com/monitoring/support/notification-options)
on [Google Cloud Platform (GCP)](https://cloud.google.com).

A NotificationChannel is a medium through which an alert is delivered when
a policy violation is detected. Examples of channels include email, SMS,
and third-party messaging applications.

**_This module supports Terraform version 1
and is compatible with the Terraform Google Cloud Provider version 4._** and 5._**

This module is part of our Infrastructure as Code (IaC) framework
that enables our users and customers to easily deploy and manage reusable,
secure, and production-grade cloud infrastructure.


- [Module Features](#module-features)
- [Getting Started](#getting-started)
- [Module Argument Reference](#module-argument-reference)
  - [Top-level Arguments](#top-level-arguments)
    - [Main Resource Configuration](#main-resource-configuration)
    - [Module Configuration](#module-configuration)
- [Module Attributes Reference](#module-attributes-reference)
- [Module Outputs](#module-outputs)
- [External Documentation](#external-documentation)
  - [GCP Billing Budgets Documentation](#gcp-billing-budgets-documentation)
  - [Terraform GCP Provider Documentation](#terraform-gcp-provider-documentation)
- [Module Versioning](#module-versioning)
  - [Backwards compatibility in `0.0.z` and `0.y.z` version](#backwards-compatibility-in-00z-and-0yz-version)
- [About Mineiros](#about-mineiros)
- [Reporting Issues](#reporting-issues)
- [Contributing](#contributing)
- [Makefile Targets](#makefile-targets)
- [License](#license)

## Module Features

This module implements the following Terraform resources

- `google_monitoring_notification_channel`

## Getting Started

Create a slack notification channel:

```hcl
module "terraform-google-monitoring-notification-channel" {
  source  = "mineiros-io/monitoring-notification-channel/google"
  version = "0.0.3"

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

## Module Argument Reference

See [variables.tf] and [examples/] for details and use-cases.

### Top-level Arguments

#### Main Resource Configuration

- [**`type`**](#var-type): *(**Required** `string`)*<a name="var-type"></a>

  The type of the notification channel. Valid values are `email`, `slack`, `sms`, `webhook_basicauth` and `pagerduty`.

- [**`project`**](#var-project): *(Optional `string`)*<a name="var-project"></a>

  The ID of the project in which the resource belongs. If it is not set, the provider project is used.

  Default is `null`.

- [**`display_name`**](#var-display_name): *(Optional `string`)*<a name="var-display_name"></a>

  An human-readable name for this notification channel. It is recommended that you specify a non-empty and unique name in order to make it easier to identify the channels in your project, though this is not enforced. The display name is limited to 512 Unicode characters.

  Default is `null`.

- [**`description`**](#var-description): *(Optional `string`)*<a name="var-description"></a>

  An optional human-readable description of this notification channel. This description may provide additional details, beyond the display name, for the channel. This may not exceed 1024 Unicode characters.

  Default is `"Notification managed by the mineiros-io/terraform-google-monitoring-notification-channel Terraform module."`.

- [**`enabled`**](#var-enabled): *(Optional `bool`)*<a name="var-enabled"></a>

  Whether notifications are forwarded to the described channel. This makes it possible to disable delivery of notifications to a particular channel without removing the channel from all alerting policies that reference the channel. This is a more convenient approach when the change is temporary and you want to receive notifications from the same set of alerting policies on the channel at some point in the future.

  Default is `true`.

- [**`labels`**](#var-labels): *(Optional `map(string)`)*<a name="var-labels"></a>

  Configuration fields that define the channel and its behavior. Labels with sensitive data should be configured via the 'sensitive_labels' block.

  Default is `{}`.

  Example:

  ```hcl
  labels = {
    email_address = "address@example.com"
  }
  ```

- [**`user_labels`**](#var-user_labels): *(Optional `map(string)`)*<a name="var-user_labels"></a>

  User-supplied key/value data that does not need to conform to the corresponding notification channel schema, unlike the `labels` field. The field can contain up to 64 entries. Each key and value is limited to 63 Unicode characters or 128 bytes, whichever is smaller. Labels and values can contain only lowercase letters, numerals, underscores, and dashes. Keys must begin with a letter.

  Default is `{}`.

- [**`sensitive_labels`**](#var-sensitive_labels): *(Optional `any`)*<a name="var-sensitive_labels"></a>

  Different notification type behaviors are configured primarily using the the labels field on this resource. This block contains the labels which contain secrets or passwords so that they can be marked sensitive and hidden from plan output. The name of the field, eg: password, will be the key in the labels map in the api request. Credentials may not be specified in both locations and will cause an error. Changing from one location to a different credential configuration in the config will require an apply to update state.

  Default is `null`.

  Example:

  ```hcl
  sensitive_labels = {
    auth_token = "example-token"
  }
  ```

  The object accepts the following attributes:

  - [**`auth_token`**](#attr-sensitive_labels-auth_token): *(Optional `string`)*<a name="attr-sensitive_labels-auth_token"></a>

    An authorization token for a notification channel. Channel types that support this field include: `slack` Note: This property is sensitive and will not be displayed in the plan.

  - [**`password`**](#attr-sensitive_labels-password): *(Optional `string`)*<a name="attr-sensitive_labels-password"></a>

    An password for a notification channel. Channel types that support this field include: `webhook_basicauth` Note: This property is sensitive and will not be displayed in the plan.

  - [**`service_key`**](#attr-sensitive_labels-service_key): *(Optional `string`)*<a name="attr-sensitive_labels-service_key"></a>

    An servicekey token for a notification channel. Channel types that support this field include: `pagerduty` Note: This property is sensitive and will not be displayed in the plan.

#### Module Configuration

- [**`module_enabled`**](#var-module_enabled): *(Optional `bool`)*<a name="var-module_enabled"></a>

  Specifies whether resources in the module will be created.

  Default is `true`.

- [**`module_timeouts`**](#var-module_timeouts): *(Optional `any`)*<a name="var-module_timeouts"></a>

  How long certain operations (per resource type) are allowed to take before being considered to have failed.

  Default is `{}`.

  Example:

  ```hcl
  module_timeouts = {
    google_monitoring_notification_channel = {
      create = "4m"
      update = "4m"
      delete = "4m"
    }
  }
  ```

  The object accepts the following attributes:

  - [**`google_monitoring_notification_channel`**](#attr-module_timeouts-google_monitoring_notification_channel): *(Optional `any`)*<a name="attr-module_timeouts-google_monitoring_notification_channel"></a>

    Timeout for the `google_monitoring_notification_channel` resource.

    The object accepts the following attributes:

    - [**`create`**](#attr-module_timeouts-google_monitoring_notification_channel-create): *(Optional `string`)*<a name="attr-module_timeouts-google_monitoring_notification_channel-create"></a>

      Timeout for `create` operations.

    - [**`update`**](#attr-module_timeouts-google_monitoring_notification_channel-update): *(Optional `string`)*<a name="attr-module_timeouts-google_monitoring_notification_channel-update"></a>

      Timeout for `update` operations.

    - [**`delete`**](#attr-module_timeouts-google_monitoring_notification_channel-delete): *(Optional `string`)*<a name="attr-module_timeouts-google_monitoring_notification_channel-delete"></a>

      Timeout for `delete` operations.

- [**`module_depends_on`**](#var-module_depends_on): *(Optional `any`)*<a name="var-module_depends_on"></a>

  A list of dependencies. Any object can be _assigned_ to this list to define a hidden external dependency.

  Example:

  ```hcl
  module_depends_on = [
    google_monitoring_alert_policy.alert-policy 
  ]
  ```

## Module Attributes Reference

The following attributes are exported in the outputs of the module:

- **`module_enabled`**

  Whether this module is enabled.

## Module Outputs

The following attributes are exported in the outputs of the module:

- [**`module_enabled`**](#output-module_enabled): *(`bool`)*<a name="output-module_enabled"></a>

  Whether this module is enabled.

- [**`notification_channel`**](#output-notification_channel): *(`object(notification_channel)`)*<a name="output-notification_channel"></a>

  All attributes of the created `google_monitoring_notification_channel` resource.

## External Documentation

### GCP Billing Budgets Documentation

- https://cloud.google.com/monitoring/support/notification-options

### Terraform GCP Provider Documentation

- https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/monitoring_notification_channel

## Module Versioning

This Module follows the principles of [Semantic Versioning (SemVer)].

Given a version number `MAJOR.MINOR.PATCH`, we increment the:

1. `MAJOR` version when we make incompatible changes,
2. `MINOR` version when we add functionality in a backwards compatible manner, and
3. `PATCH` version when we make backwards compatible bug fixes.

### Backwards compatibility in `0.0.z` and `0.y.z` version

- Backwards compatibility in versions `0.0.z` is **not guaranteed** when `z` is increased. (Initial development)
- Backwards compatibility in versions `0.y.z` is **not guaranteed** when `y` is increased. (Pre-release)

## About Mineiros

[Mineiros][homepage] is a remote-first company headquartered in Berlin, Germany
that solves development, automation and security challenges in cloud infrastructure.

Our vision is to massively reduce time and overhead for teams to manage and
deploy production-grade and secure cloud infrastructure.

We offer commercial support for all of our modules and encourage you to reach out
if you have any questions or need help. Feel free to email us at [hello@mineiros.io] or join our
[Community Slack channel][slack].

## Reporting Issues

We use GitHub [Issues] to track community reported issues and missing features.

## Contributing

Contributions are always encouraged and welcome! For the process of accepting changes, we use
[Pull Requests]. If you'd like more information, please see our [Contribution Guidelines].

## Makefile Targets

This repository comes with a handy [Makefile].
Run `make help` to see details on each available target.

## License

[![license][badge-license]][apache20]

This module is licensed under the Apache License Version 2.0, January 2004.
Please see [LICENSE] for full details.

Copyright &copy; 2020-2022 [Mineiros GmbH][homepage]


<!-- References -->

[homepage]: https://mineiros.io/?ref=terraform-google-billing-budget
[hello@mineiros.io]: mailto:hello@mineiros.io
[badge-license]: https://img.shields.io/badge/license-Apache%202.0-brightgreen.svg
[releases-terraform]: https://github.com/hashicorp/terraform/releases
[apache20]: https://opensource.org/licenses/Apache-2.0
[slack]: https://mineiros.io/slack
[terraform]: https://www.terraform.io
[gcp]: https://cloud.google.com
[semantic versioning (semver)]: https://semver.org/
[variables.tf]: https://github.com/mineiros-io/terraform-google-billing-budget/blob/main/variables.tf
[examples/]: https://github.com/mineiros-io/terraform-google-billing-budget/blob/main/examples
[issues]: https://github.com/mineiros-io/terraform-google-billing-budget/issues
[license]: https://github.com/mineiros-io/terraform-google-billing-budget/blob/main/LICENSE
[makefile]: https://github.com/mineiros-io/terraform-google-billing-budget/blob/main/Makefile
[pull requests]: https://github.com/mineiros-io/terraform-google-billing-budget/pulls
[contribution guidelines]: https://github.com/mineiros-io/terraform-google-billing-budget/blob/main/CONTRIBUTING.md
