# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

#  
variable "provider_azurerm_features_resource_group" {
  default = {
    prevent_deletion_if_contains_resources = true
  }
}
