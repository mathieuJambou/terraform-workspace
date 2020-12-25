data "terraform_remote_state" "shared_services" {
    backend = "azurerm"
    config = {
		resource_group_name	  = var.resource_group_name
		storage_account_name  = var.storage_account_name
		container_name        = "tstate"
		key                   = "terraform.common.tfstate"
    }
}