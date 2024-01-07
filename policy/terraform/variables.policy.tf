# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

/*
  PARAMETERS
  Here are all the variables a user can override.
*/

###########
# Policy ##
###########

variable "securityContactsEmail" {
  type        = string
  description = "If specified, identifies the email address to send security alerts to."
  default     = "anoa@contoso.com"
  validation {
    condition     = can(regex("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$", var.securityContactsEmail)) || var.securityContactsEmail == ""
    error_message = "Value must be a valid email address format."
  }
  sensitive = true
}

variable "securityContactsPhone" {
  type        = string
  description = "If specified, identifies the phone to send security alerts to."
  default     = "5555555555"
  validation {
    condition     = can(regex("^[0-9]{10}$", var.securityContactsPhone)) || var.securityContactsPhone == ""
    error_message = "Value must be a valid phone number format."
  }
  sensitive = true
}

variable "listOfAllowedLocations" {
  type        = list(string)
  description = "If specified, identifies the list of allowed locations for resources."
  default     = []
}

variable "listOfAllowedResourceTypes" {
  type        = list(string)
  description = "If specified, identifies the list of allowed resource types."
  default     = []
}

variable "listOfAllowedSKUs" {
  type        = list(string)
  description = "If specified, identifies the list of allowed SKUs."
  default     = []
}
