resource "random_id" "randomId" {
    keepers = {
        # Generate a new ID only when a new resource group is defined
        rg = azurerm_resource_group.commonresourcegroup.id
    }

    byte_length = 8
}

resource "azurerm_storage_account" "storageaccount" {
    name                        = "diag${random_id.randomId.hex}"
    resource_group_name         = azurerm_resource_group.commonresourcegroup.name
    location                    = var.azure_location
    account_replication_type    = "LRS"
    account_tier                = "Standard"

    tags = {
        environment = "Common"
    }
}
