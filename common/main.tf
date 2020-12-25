resource "azurerm_resource_group" "commonresourcegroup" {
    name     = "commonResourceGroup"
    location = var.azure_location

    tags = {
        environment = "Common"
    }
}