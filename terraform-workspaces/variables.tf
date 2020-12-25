variable "project_name" {
  type        = map
  description = "Name of the project."
  default     = {
    dev  = "ga-terraform-dev"
    prod = "ga-terraform-prod"
  }
}

variable "azure_location" {
}

variable "storage_account_name" {}

variable "resource_group_name" {}

variable "environment" {
  description = "env: dev or prod"
}


variable "linux_vm_size" {
  type        = map
  description = "size of the VM."
  default     = {
    dev  = "Standard_DS1_v2"
    prod = "Standard_DS2_v2"
  }
}

