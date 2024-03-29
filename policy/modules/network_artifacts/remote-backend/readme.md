# How to Create a Remote Backend for Terraform

## Overview

For simple test scripts or for development, a local state file will work. However, if we are working in a team, deploying our infrastructure from a CI/CD tool or developing a Terraform using multiple layers, we need to store the state file in a remote backend and lock the file to avoid mistakes or damage the existing infrastructure.

We can use remote backends, such as Azure Storage, Google Cloud Storage, Amazon S3, and HashiCorp Terraform Cloud & Terraform Enterprise, to keep our files safe and share between multiple users.

## Creating a Service Principal and a Client Secret

Using a Service Principal, also known as SPN, is a best practice for DevOps or CI/CD environments and is one of the most popular ways to set up a remote backend and later move to CI/CD, such as Azure DevOps.

First, we need to authenticate to Azure. To authenticate using Azure CLI, we type:

```bash
az login
```

The process will launch the browser and after the authentication is complete we are ready to go.

We will use the following command to get the list of Azure subscriptions:

```bash
az account list --output table
```

We can select the subscription using the following command (both subscription id and subscription name are accepted):

```bash
az account set --subscription <Azure-SubscriptionId>
```

Then create the service principal account using the following command:

We need to create a service principal and a client secret to access the remote backend. We can use the Azure CLI to create the service principal and the client secret.

```bash
az ad sp create-for-rbac --name "terraform" --role contributor --scopes /subscriptions/<subscription_id> --sdk-auth
```
These values will be mapped to these Terraform variables:

- appId (Azure) → client_id (Terraform).
- password (Azure) → client_secret (Terraform).
- tenant (Azure) → tenant_id (Terraform).

## Configuring the Remote Backend to use Azure Storage in Azure CLI

We need to create a storage account and a container to store the Terraform state file. We can use the Azure CLI to create the storage account and the container.

```bash
az storage account create --name <storage-account-name> --resource-group <resource-group-name> --sku Standard_LRS --encryption-services blob
```

```bash
az storage container create --name <container-name> --account-name <storage-account-name>
```

or

You can use the bash script "az-remote-backend.sh" to create the storage account and the container.

## Configuring the Remote Backend to use Azure Storage with Terraform

We can also use Terraform to create the storage account in Azure Storage.

We will start using a files called az-remote-backend-*.tf to create the storage account and the container.

## Authenticating to Azure using a Service Principal (SPN) to use State Files in Remote Backend

If we want to use shared state files in a remote backend with SPN, we can configure Terraform using the following procedure:

We will create a configuration file with the credentials information. For this example, I called the file azurecreds.conf. This is the content of the file:

```bash
ARM_SUBSCRIPTION_ID="0000000-0000-0000-0000-000000000000"
ARM_CLIENT_ID = "0000000-0000-0000-0000-000000000000"
ARM_CLIENT_SECRET="0000000-0000-0000-0000-000000000000"
ARM_TENANT_ID="0000000-0000-0000-0000-000000000000"
```
then we create the file provider-main.tf and add the code to manage the Terraform and the Azure providers:

```hcl
# Define Terraform provider
terraform {
  required_version = ">= 0.12"
  backend "azurerm" {
    resource_group_name  = "mpe-tfstate-rg"
    storage_account_name = "mpetfstate"
    container_name       = "core-tfstate"
    key                  = "core.mpe.tfstate"
  }
}
# Configure the Azure provider
provider "azurerm" { 
  environment = "public"
}
```

Finally, we initialize the Terraform configuration using this command:

```hcl
terraform init -backend-config=azurecreds.conf
```

Then, we launch the stack as usual:

```hcl
terraform apply -auto-approve
```