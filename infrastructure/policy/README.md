# Azure NoOps Mission Enclave Policy Terraform Modules

This folder contains the Terraform Modules for deploying Mission Enclave Policy Starter. See the [Deployment Guide for Terraform](https://azurenoops.github.io/terraform-overlays-baseline/deployment/policy/policy-manual/) for detailed instructions on how to use the Modules.

> Please refer to [Policy Driven Governance](https://learn.microsoft.com/en-gb/azure/cloud-adoption-framework/ready/landing-zone/design-principles#policy-driven-governance) for further information.

> **IMPORTANT NOTE:** Azure NoOps Mission Enclave Policy starter is Zero Trust aligned by default, and occasionally we will rely on `-preview` policies in default assignments to meet core objectives. These preview policies are maintained by the Azure product owners and versioning is not in our control, however, we feel they are sufficiently important to be included in our releases. If the inclusion of preview policies is of concern, please review all default initiative assignments and remove any `-preview` policies that you are not comfortable with.

## FAQ

- We have added a dedicated [Azure NoOps Mission Enclave Policy starter FAQ](https://azurenoops.github.io/terraform-overlays-baseline/deployment/policy/policy-faq/) based on common issues raised or questions asked by customers and partners. Please review this section before raising an issue.

## Mission Enclave landing zones policies (Custom & Built-in)

As part of a default deployment configuration, policy and policy set definitions are deployed at multiple levels within the Mission Enclave landing zone Management Group hierarchy as depicted within the below diagram.

![Policy Assignment](../../docs/images/policy-assignment.png)

The subsequent sections will provide a summary of policy sets and policy set definitions applied at each level of the Management Group hierarchy.

>NOTE: Although the below sections will define which policy definitions/sets are applied at specific scopes, please remember that policy will inherit within your management group hierarchy.

## Policies included

There are around 12 custom Azure Policy Definitions included that are used from the [Azure NoOps Policy Overlay module](https://github.com/azurenoops/terraform-azurerm-overlays-policy) and around 12 Custom Azure Policy Initiatives included as part of the Azure NoOps Mission Enclave Policy starter implementation that adds on to those already built-in within each Azure customers tenant.

> Our goal is always to try and use built-in policies where available and also work with product teams to adopt our custom policies and make them built-in, which takes time. This means there will always be a requirement for custom policies.